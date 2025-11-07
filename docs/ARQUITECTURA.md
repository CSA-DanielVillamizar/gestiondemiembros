# Documentación de Arquitectura - L.A.M.A. Medellín

## Visión General

Este documento describe la arquitectura técnica del Sistema de Gestión de Miembros del capítulo L.A.M.A. Medellín.

## Arquitectura de Alto Nivel

```
┌─────────────┐         ┌──────────────┐         ┌─────────────┐
│   Cliente   │────────▶│  Azure AD    │────────▶│  Frontend   │
│  (Browser)  │◀────────│     B2C      │◀────────│   (React)   │
└─────────────┘         └──────────────┘         └─────────────┘
                                                         │
                                                         │ HTTPS
                                                         │ JWT Token
                                                         ▼
                                                  ┌─────────────┐
                                                  │   Backend   │
                                                  │  (ASP.NET   │
                                                  │    Core)    │
                                                  └─────────────┘
                                                         │
                                                         │
                                                         ▼
                                                  ┌─────────────┐
                                                  │  Azure SQL  │
                                                  │  Database   │
                                                  └─────────────┘
```

## Clean Architecture - Backend

### Capas

#### 1. Domain Layer (Núcleo)
**Propósito:** Contiene la lógica de negocio y las entidades del dominio.

**Componentes:**
- `Entities/`: Clases de entidad (Miembro, Comité)
- `Interfaces/`: Contratos de repositorios
- Sin dependencias externas

**Responsabilidades:**
- Definir modelos de dominio
- Reglas de negocio core
- Enums y constantes del dominio

#### 2. Application Layer
**Propósito:** Orquesta la lógica de la aplicación.

**Componentes:**
- `DTOs/`: Objetos de transferencia de datos
- `Services/`: Servicios de aplicación
- `Interfaces/`: Contratos de servicios
- `Mappings/`: Configuración de AutoMapper
- `Validators/`: Validadores con FluentValidation

**Responsabilidades:**
- Implementar casos de uso
- Transformar datos (Entity ↔ DTO)
- Validación de negocio
- Coordinación de operaciones

#### 3. Infrastructure Layer
**Propósito:** Implementaciones concretas de tecnologías.

**Componentes:**
- `Data/`: DbContext, configuración EF Core
- `Repositories/`: Implementaciones de repositorios
- `Identity/`: Configuración de autenticación

**Responsabilidades:**
- Acceso a datos (EF Core)
- Migraciones de base de datos
- Integración con servicios externos

#### 4. Presentation Layer (API)
**Propósito:** Expone la funcionalidad vía HTTP.

**Componentes:**
- `Controllers/`: Endpoints REST
- `Middleware/`: Manejo de errores, logging
- `Program.cs`: Configuración y DI

**Responsabilidades:**
- Endpoints HTTP
- Validación de entrada
- Autenticación/Autorización
- Serialización JSON

### Flujo de Datos

```
Request (HTTP) → Controller → Service → Repository → Database
                     ↓           ↓          ↓
                   DTO    →   Entity  →   SQL
```

## Arquitectura Frontend - React

### Estructura

```
src/
├── components/       # Componentes reutilizables
│   ├── Layout/      # Layout, navegación
│   ├── common/      # Botones, inputs, etc.
│   └── miembros/    # Componentes específicos
├── pages/           # Vistas completas
├── services/        # Comunicación con API
├── hooks/           # Custom React hooks
├── contexts/        # Context API para estado global
├── types/           # Tipos TypeScript
├── utils/           # Utilidades
└── config/          # Configuración
```

### Patrones de Diseño

#### 1. Container/Presentational Components
- **Containers:** Lógica y estado
- **Presentational:** Solo UI

#### 2. Custom Hooks
- Reutilización de lógica
- Separación de concerns

#### 3. Service Layer
- Encapsula llamadas HTTP
- Manejo de errores centralizado

## Base de Datos

### Modelo de Datos

```sql
┌─────────────┐         ┌──────────────────┐         ┌─────────────┐
│   Miembros  │◀───────▶│ MiembroComites   │◀───────▶│   Comites   │
└─────────────┘         └──────────────────┘         └─────────────┘
      1:N                      N:M                          1:N
```

### Esquema Principal

**Miembros**
- Id (PK, uniqueidentifier)
- NumeroIdentificacion (unique)
- Nombres, Apellidos
- Email (unique)
- FechaNacimiento
- Estado (enum)
- TipoMembresia (enum)
- ... más campos

**Comites**
- Id (PK)
- Nombre (unique)
- Descripcion
- Activo

**MiembroComites** (tabla de unión)
- MiembroId (FK)
- ComiteId (FK)
- Rol
- EsCoordinador

### Índices

```sql
-- Performance optimizations
CREATE INDEX IX_Miembros_Email ON Miembros(Email);
CREATE INDEX IX_Miembros_Estado ON Miembros(Estado);
CREATE INDEX IX_Miembros_NumeroIdentificacion ON Miembros(NumeroIdentificacion);
```

## Seguridad

### Autenticación y Autorización

#### Azure AD B2C Flow

```
1. Usuario inicia login
2. Redirect a Azure AD B2C
3. Usuario autentica (email/social)
4. Azure AD B2C emite token JWT
5. Frontend almacena token
6. Cada request incluye token en header
7. Backend valida token
8. Procesa request si es válido
```

#### JWT Token Structure

```json
{
  "header": {
    "alg": "RS256",
    "typ": "JWT"
  },
  "payload": {
    "sub": "user-id",
    "email": "user@example.com",
    "name": "Juan Pérez",
    "exp": 1234567890,
    "roles": ["Member", "Admin"]
  },
  "signature": "..."
}
```

### Protección de Datos

- **En tránsito:** HTTPS/TLS 1.3
- **En reposo:** Encriptación transparente Azure SQL
- **Secrets:** Azure Key Vault (producción)
- **Validación:** Input validation en ambos lados

## Escalabilidad

### Horizontal Scaling

- **Backend:** Azure App Service con múltiples instancias
- **Frontend:** CDN global con Azure Static Web Apps
- **Database:** Azure SQL con réplicas de lectura

### Caching Strategy

```
┌──────────┐
│  Redis   │  ← Caché de sesiones, datos frecuentes
└──────────┘
     ↑
     │
┌──────────┐
│ Backend  │  ← Caché en memoria (IMemoryCache)
└──────────┘
     ↑
     │
┌──────────┐
│ Database │
└──────────┘
```

## Monitoreo y Observabilidad

### Application Insights

- **Telemetría:** Requests, dependencies, exceptions
- **Custom Events:** Acciones de usuario importantes
- **Performance:** Tiempo de respuesta, throughput
- **Availability:** Health checks cada 5 minutos

### Logging

**Niveles:**
- `Error`: Errores críticos
- `Warning`: Problemas no críticos
- `Information`: Eventos importantes
- `Debug`: Información de desarrollo

**Destinos:**
- Consola (desarrollo)
- Archivos (todos los ambientes)
- Application Insights (producción)

## CI/CD Pipeline

### Flujo de Deployment

```
Developer → Git Push → GitHub Actions
                           ↓
                    Run Tests
                           ↓
                    Build Artifacts
                           ↓
              ┌─────────────┴─────────────┐
              ↓                           ↓
      Deploy Backend              Deploy Frontend
      (Azure App Service)         (Static Web Apps)
              ↓                           ↓
      Run Integration Tests
              ↓
      Production Ready
```

### GitHub Actions Workflow

```yaml
name: Deploy
on:
  push:
    branches: [main]
jobs:
  build-backend:
    runs-on: ubuntu-latest
    steps:
      - Checkout code
      - Setup .NET
      - Restore dependencies
      - Build
      - Test
      - Publish
      - Deploy to Azure
  
  build-frontend:
    runs-on: ubuntu-latest
    steps:
      - Checkout code
      - Setup Node.js
      - Install dependencies
      - Build
      - Deploy to Static Web Apps
```

## Decisiones Técnicas

### ¿Por qué Clean Architecture?

**Ventajas:**
- ✅ Testabilidad mejorada
- ✅ Independencia de frameworks
- ✅ Mantenibilidad a largo plazo
- ✅ Separación clara de responsabilidades

### ¿Por qué React + TypeScript?

**Ventajas:**
- ✅ Type safety en desarrollo
- ✅ Mejor experiencia de desarrollo
- ✅ Menos errores en runtime
- ✅ Gran ecosistema y comunidad

### ¿Por qué Azure?

**Ventajas:**
- ✅ Integración nativa con .NET
- ✅ Azure AD B2C para autenticación
- ✅ Escalabilidad automática
- ✅ Servicios PaaS gestionados

## Performance Considerations

### Backend Optimizations

- **Async/Await:** Operaciones I/O asíncronas
- **Connection Pooling:** Reutilización de conexiones DB
- **Query Optimization:** Índices apropiados
- **Pagination:** Evitar cargar datos masivos

### Frontend Optimizations

- **Code Splitting:** Carga bajo demanda
- **Lazy Loading:** Componentes diferidos
- **Memoization:** React.memo, useMemo
- **Virtual Scrolling:** Listas grandes

## Disaster Recovery

### Backup Strategy

- **Database:** Backups automáticos diarios
- **Retention:** 30 días
- **Point-in-time restore:** Últimos 35 días
- **Geo-replication:** Réplica en región secundaria

### Recovery Time Objectives

- **RTO:** < 1 hora
- **RPO:** < 15 minutos

---

**Última actualización:** 2025-01

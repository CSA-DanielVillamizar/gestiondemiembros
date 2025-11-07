# 🚀 Inicio Rápido - L.A.M.A. Medellín

Guía rápida para poner en marcha el proyecto en minutos.

Nota: Si ves errores de TypeScript/"Cannot find module" en el editor o avisos de imports rojos, son esperados hasta instalar las dependencias (frontend: npm install) y restaurar paquetes (backend: dotnet restore).

## ⚡ Instalación Rápida (Desarrollo Local)

### 1. Prerequisitos Rápidos

```bash
# Verificar instalaciones
dotnet --version    # Requiere 8.0+
node --version      # Requiere 18+
npm --version
git --version
```

### 2. Clonar y Configurar

```bash
# Clonar repositorio
git clone <url-repo>
cd "Miembros del capítulo"
```

### 3. Backend (2 minutos)

```bash
# Navegar al backend
cd backend

# Restaurar paquetes
dotnet restore

# Aplicar migraciones
cd src/LAMAMedellin.API
dotnet ef database update

# Ejecutar
dotnet run
```

✅ **Backend corriendo en:** `https://localhost:7001`
📚 **Swagger UI:** `https://localhost:7001/swagger`

### 4. Frontend (2 minutos)

```bash
# Navegar al frontend (desde raíz)
cd frontend

# Instalar dependencias
npm install

# Crear variables de entorno
cp .env.example .env.local

# Ejecutar
npm run dev
```

✅ **Frontend corriendo en:** `http://localhost:3000`

## 🎯 Verificación Rápida

### Backend Health Check

```bash
curl https://localhost:7001/health
```

Respuesta esperada:
 
```json
{"status":"Healthy","timestamp":"2025-01-05T..."}
```

### Verificación del Frontend

Abrir navegador en `http://localhost:3000` - deberías ver la página de login.

## 🔧 Comandos Útiles

### Backend

```bash
# Build
dotnet build

# Run con watch (auto-reload)
dotnet watch run

# Crear nueva migración
dotnet ef migrations add NombreMigracion --project ../LAMAMedellin.Infrastructure

# Ver conexiones activas
dotnet ef dbcontext info
```

### Frontend

```bash
# Development con hot-reload
npm run dev

# Build para producción
npm run build

# Preview build de producción
npm run preview

# Lint
npm run lint
```

## 📦 Estructura Rápida

```text
Miembros del capítulo/
├── backend/                    # ASP.NET Core API
│   └── src/
│       ├── Domain/            # Entidades de negocio
│       ├── Application/       # Lógica de aplicación
│       ├── Infrastructure/    # Acceso a datos
│       └── API/              # Controllers y endpoints
│
├── frontend/                  # React + TypeScript
│   └── src/
│       ├── components/       # Componentes React
│       ├── pages/           # Páginas/vistas
│       ├── services/        # API clients
│       └── types/           # Tipos TypeScript
│
└── docs/                     # Documentación
    ├── ARQUITECTURA.md       # Detalles técnicos
    ├── INSTALACION.md        # Guía completa
    └── DESPLIEGUE_AZURE.md   # Deploy a Azure
```

## 🐛 Soluciones Rápidas

### Puerto en uso

**Backend:**

```bash
# Cambiar en launchSettings.json
"applicationUrl": "https://localhost:7002"
```

**Frontend:**

```bash
# Cambiar en vite.config.ts
server: { port: 3001 }
```

### Base de datos no conecta

```bash
# Verificar SQL Server LocalDB
sqllocaldb info
sqllocaldb start mssqllocaldb

# Recrear base de datos
dotnet ef database drop --force
dotnet ef database update
```

### npm install falla

```bash
npm cache clean --force
rm -rf node_modules package-lock.json
npm install
```

## 📝 Próximos Pasos

1. **Sin Autenticación (Desarrollo Inicial):**
   - Comentar `[Authorize]` en MiembrosController
   - Probar endpoints directamente desde Swagger

2. **Con Autenticación:**
   - Configurar Azure AD B2C (ver `docs/INSTALACION.md`)
   - Actualizar variables de entorno

3. **Explorar Código:**
   - Backend: Revisar `MiembrosController.cs`
   - Frontend: Revisar `App.tsx` y `pages/`

4. **Crear Datos de Prueba:**
   - Usar Swagger UI en `https://localhost:7001/swagger`
   - POST a `/api/miembros` con datos de ejemplo

## 💡 Tips de Desarrollo

### Hot Reload Automático

**Backend:**
 
```bash
dotnet watch run
```

**Frontend:**
 
```bash
npm run dev  # Ya incluye hot-reload
```

### Debugging en VS Code

1. Abrir workspace en VS Code
2. Ir a "Run and Debug" (Ctrl+Shift+D)
3. Seleccionar "Launch Backend API"
4. Presionar F5

### Ver Logs en Tiempo Real

**Backend:**

```bash
# Los logs aparecen en la consola donde ejecutaste dotnet run
# O en: backend/src/LAMAMedellin.API/logs/
```

**Frontend:**

```bash
# Consola del navegador (F12)
```

## 🎓 Recursos de Aprendizaje

- **Clean Architecture:** [Microsoft Docs](https://docs.microsoft.com/aspnet/core/fundamentals/architecture)
- **React + TypeScript:** [TypeScript Handbook](https://www.typescriptlang.org/docs/handbook/react.html)
- **Material-UI:** [MUI Docs](https://mui.com/material-ui/getting-started/)
- **Entity Framework:** [EF Core Docs](https://docs.microsoft.com/ef/core/)

## 🆘 Ayuda

**Problemas comunes:** Ver `docs/INSTALACION.md` sección "Solución de Problemas"

**Documentación completa:**

- `README.md` - Visión general
- `docs/ARQUITECTURA.md` - Arquitectura técnica
- `docs/INSTALACION.md` - Instalación detallada
- `docs/DESPLIEGUE_AZURE.md` - Deploy a producción

---

**¿Todo funcionando?** ✅ ¡Comienza a desarrollar!

**¿Algo no funciona?** 🔧 Revisa `docs/INSTALACION.md` para más detalles.

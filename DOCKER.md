# 🐳 Guía de Docker para L.A.M.A. Medellín

Esta guía explica cómo ejecutar el sistema L.A.M.A. Medellín usando Docker y Docker Compose.

## 📋 Prerequisitos

- [Docker Desktop](https://www.docker.com/products/docker-desktop) instalado
- Al menos 4 GB de RAM disponible para Docker
- Puertos 1433, 3000 y 5000 disponibles

## 🚀 Inicio Rápido

### 1. Ejecutar todo el sistema con Docker Compose

```bash
# Construir y ejecutar todos los servicios
docker-compose up --build

# O en modo detached (segundo plano)
docker-compose up -d --build
```

Esto iniciará:
- **SQL Server 2022** en `localhost:1433`
- **Backend API** en `http://localhost:5000`
- **Frontend React** en `http://localhost:3000`

### 2. Acceder a la aplicación

Una vez que todos los servicios estén saludables (puede tomar 1-2 minutos):

- **Frontend**: http://localhost:3000
- **API Swagger**: http://localhost:5000/swagger
- **Health Check**: http://localhost:5000/health

### 3. Detener los servicios

```bash
# Detener servicios
docker-compose down

# Detener y eliminar volúmenes (limpieza completa)
docker-compose down -v
```

## 🏗️ Construcción Individual

### Backend (.NET 8)

```bash
# Construir imagen
docker build -t lama-backend -f backend/Dockerfile .

# Ejecutar (requiere SQL Server)
docker run -p 5000:8080 \
  -e ConnectionStrings__DefaultConnection="Server=host.docker.internal;Database=LAMAMedellin;User Id=sa;Password=YourStrong@Password123;TrustServerCertificate=True;" \
  -e ASPNETCORE_ENVIRONMENT=Development \
  lama-backend
```

### Frontend (React + Nginx)

```bash
# Construir imagen
docker build -t lama-frontend \
  --build-arg VITE_API_BASE_URL=http://localhost:5000/api \
  -f frontend/Dockerfile .

# Ejecutar
docker run -p 3000:80 lama-frontend
```

### SQL Server

```bash
# Ejecutar SQL Server directamente
docker run -e "ACCEPT_EULA=Y" \
  -e "MSSQL_SA_PASSWORD=YourStrong@Password123" \
  -e "MSSQL_PID=Express" \
  -p 1433:1433 \
  -d mcr.microsoft.com/mssql/server:2022-latest
```

## 🔧 Configuración

### Variables de Entorno

Puedes personalizar el comportamiento editando `docker-compose.yml`:

#### Backend
```yaml
environment:
  - ASPNETCORE_ENVIRONMENT=Development  # Development, Staging, Production
  - ConnectionStrings__DefaultConnection=...
  - Cors__AllowedOrigins__0=http://localhost:3000
```

#### Frontend
```yaml
build:
  args:
    - VITE_API_BASE_URL=http://localhost:5000/api
    - VITE_DEV_MODE=false
```

#### SQL Server
```yaml
environment:
  - MSSQL_SA_PASSWORD=YourStrong@Password123  # Cambiar en producción
  - MSSQL_PID=Express  # Express, Developer, Standard, Enterprise
```

### Puertos

Modifica los puertos mapeados en `docker-compose.yml`:

```yaml
ports:
  - "HOST_PORT:CONTAINER_PORT"
```

## 📊 Health Checks

Todos los servicios tienen health checks configurados:

```bash
# Ver estado de servicios
docker-compose ps

# Ver logs de health checks
docker-compose logs backend
```

Endpoints de health check:
- Backend: `http://localhost:5000/health`
- Frontend: `http://localhost:3000/health`
- SQL Server: Verifica con `sqlcmd`

## 🗄️ Persistencia de Datos

Los datos de SQL Server se almacenan en un volumen Docker:

```bash
# Ver volúmenes
docker volume ls

# Eliminar volumen (CUIDADO: elimina todos los datos)
docker volume rm miembros-del-capítulo_sqlserver-data

# Hacer backup del volumen
docker run --rm -v miembros-del-capítulo_sqlserver-data:/data -v $(pwd):/backup \
  ubuntu tar czf /backup/sqlserver-backup.tar.gz /data
```

## 🔍 Troubleshooting

### El backend no se conecta a SQL Server

**Problema**: Error de conexión a la base de datos

**Solución**:
```bash
# Verificar que SQL Server esté corriendo
docker-compose logs sqlserver

# Esperar a que SQL Server esté listo (puede tomar 30-60 segundos)
docker-compose up sqlserver

# Reiniciar backend
docker-compose restart backend
```

### Error de memoria en SQL Server

**Problema**: SQL Server se detiene inesperadamente

**Solución**:
- Incrementar memoria disponible en Docker Desktop
- Usar `MSSQL_PID=Express` para menor uso de memoria

### Puerto ya en uso

**Problema**: `Error: bind: address already in use`

**Solución**:
```bash
# Windows PowerShell - Encontrar proceso usando puerto
netstat -ano | findstr :5000

# Terminar proceso (reemplazar PID)
taskkill /PID <PID> /F

# O cambiar puerto en docker-compose.yml
```

### Frontend no se actualiza

**Problema**: Cambios en código no se reflejan

**Solución**:
```bash
# Reconstruir sin caché
docker-compose build --no-cache frontend
docker-compose up -d frontend
```

## 📝 Comandos Útiles

```bash
# Ver logs en tiempo real
docker-compose logs -f

# Ver logs de un servicio específico
docker-compose logs -f backend

# Reiniciar un servicio
docker-compose restart backend

# Ejecutar comando en contenedor
docker-compose exec backend bash

# Ver recursos usados
docker stats

# Limpiar imágenes no usadas
docker system prune

# Limpiar todo (CUIDADO)
docker system prune -a --volumes
```

## 🚢 Deployment en Producción

### Recomendaciones

1. **Cambiar contraseñas**: No usar contraseñas de desarrollo
2. **HTTPS**: Configurar certificados SSL
3. **Secretos**: Usar Docker secrets o variables de entorno seguras
4. **Límites de recursos**: Configurar memory/CPU limits
5. **Logging**: Configurar logging centralizado
6. **Monitoreo**: Implementar health checks en load balancer

### Ejemplo con límites de recursos

```yaml
services:
  backend:
    deploy:
      resources:
        limits:
          cpus: '1.0'
          memory: 512M
        reservations:
          cpus: '0.5'
          memory: 256M
```

## 🔗 Referencias

- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Reference](https://docs.docker.com/compose/compose-file/)
- [SQL Server on Docker](https://learn.microsoft.com/sql/linux/quickstart-install-connect-docker)
- [.NET Docker Images](https://hub.docker.com/_/microsoft-dotnet)
- [Nginx Docker](https://hub.docker.com/_/nginx)

---

**Última actualización**: Noviembre 2025

# Guía de Instalación y Configuración Local

Esta guía te ayudará a configurar el entorno de desarrollo local.

## 📋 Requisitos del Sistema

### Software Requerido

- **Windows 10/11**, **macOS**, o **Linux**
- **Visual Studio 2022** (Community, Professional, o Enterprise)
  - O **Visual Studio Code** con extensiones de C#
- **.NET 8.0 SDK** - [Descargar](https://dotnet.microsoft.com/download/dotnet/8.0)
- **Node.js 18+** y **npm** - [Descargar](https://nodejs.org/)
- **SQL Server** (una de las siguientes opciones):
  - SQL Server LocalDB (incluido con Visual Studio)
  - SQL Server Express
  - Docker con imagen de SQL Server
- **Git** - [Descargar](https://git-scm.com/)

### Verificar Instalaciones

```bash
# Verificar .NET
dotnet --version
# Debe mostrar: 8.0.x

# Verificar Node.js
node --version
# Debe mostrar: v18.x.x o superior

# Verificar npm
npm --version
# Debe mostrar: 9.x.x o superior

# Verificar Git
git --version
```

## 🚀 Instalación Paso a Paso

### 1. Clonar el Repositorio

```bash
git clone <url-del-repositorio>
cd "Miembros del capítulo"
```

### 2. Configurar Backend

#### 2.1 Abrir Solución en Visual Studio

```bash
cd backend
# Abrir LAMAMedellin.sln en Visual Studio 2022
```

O con dotnet CLI:

```bash
dotnet restore LAMAMedellin.sln
```

#### 2.2 Configurar Base de Datos

**Opción A: SQL Server LocalDB (Recomendado para desarrollo)**

1. Verificar que LocalDB esté instalado:
```bash
sqllocaldb info
```

2. Editar `backend/src/LAMAMedellin.API/appsettings.Development.json`:
```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Server=(localdb)\\mssqllocaldb;Database=LAMAMedellinDB;Trusted_Connection=True;MultipleActiveResultSets=true"
  }
}
```

**Opción B: Docker con SQL Server**

```bash
# Iniciar contenedor SQL Server
docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=YourPassword123!" \
  -p 1433:1433 --name sql-lama \
  -d mcr.microsoft.com/mssql/server:2022-latest

# Connection string:
"Server=localhost,1433;Database=LAMAMedellinDB;User Id=sa;Password=YourPassword123!;TrustServerCertificate=True"
```

#### 2.3 Aplicar Migraciones

```bash
cd backend/src/LAMAMedellin.API

# Crear migración inicial
dotnet ef migrations add InitialCreate --project ../LAMAMedellin.Infrastructure

# Aplicar migración a la base de datos
dotnet ef database update
```

Si tienes errores, asegúrate de tener instalado:
```bash
dotnet tool install --global dotnet-ef
```

#### 2.4 Configurar Azure AD B2C (Opcional para desarrollo)

Para desarrollo local, puedes omitir temporalmente la autenticación o configurar un tenant de prueba:

1. Ir a [Azure Portal](https://portal.azure.com)
2. Crear un tenant B2C de prueba (gratis)
3. Seguir pasos en `docs/DESPLIEGUE_AZURE.md` sección 2.2-2.3

Editar `appsettings.Development.json`:
```json
{
  "AzureAdB2C": {
    "Instance": "https://<your-tenant>.b2clogin.com",
    "ClientId": "<your-client-id>",
    "Domain": "<your-tenant>.onmicrosoft.com",
    "SignUpSignInPolicyId": "B2C_1_signupsignin"
  }
}
```

**Alternativa:** Comentar temporalmente `[Authorize]` en controllers para pruebas.

#### 2.5 Ejecutar Backend

**Desde Visual Studio:**
1. Configurar `LAMAMedellin.API` como proyecto de inicio
2. Presionar F5

**Desde línea de comandos:**
```bash
cd backend/src/LAMAMedellin.API
dotnet run
```

La API estará disponible en:
- HTTPS: `https://localhost:7001`
- HTTP: `http://localhost:5001`
- Swagger UI: `https://localhost:7001/swagger`

### 3. Configurar Frontend

#### 3.1 Instalar Dependencias

```bash
cd frontend
npm install
```

Si encuentras errores, intenta:
```bash
npm cache clean --force
npm install
```

#### 3.2 Configurar Variables de Entorno

Crear archivo `.env.local` en la raíz de `frontend/`:

```env
VITE_API_BASE_URL=https://localhost:7001/api
VITE_AZURE_AD_B2C_CLIENT_ID=your-client-id-here
VITE_AZURE_AD_B2C_AUTHORITY=https://your-tenant.b2clogin.com/your-tenant.onmicrosoft.com/B2C_1_signupsignin
VITE_AZURE_AD_B2C_KNOWN_AUTHORITY=your-tenant.b2clogin.com
VITE_API_SCOPE=https://your-tenant.onmicrosoft.com/api/access_as_user
VITE_REDIRECT_URI=http://localhost:3000
VITE_POST_LOGOUT_REDIRECT_URI=http://localhost:3000
```

Para desarrollo sin autenticación (temporal):
```env
VITE_API_BASE_URL=https://localhost:7001/api
# Dejar las demás variables vacías
```

#### 3.3 Ejecutar Frontend

```bash
npm run dev
```

La aplicación estará disponible en: `http://localhost:3000`

## 🔧 Configuración de Visual Studio Code (Alternativa a VS 2022)

### Extensiones Requeridas

Instalar las siguientes extensiones:
- **C#** (ms-dotnettools.csharp)
- **C# Dev Kit** (ms-dotnettools.csdevkit)
- **ESLint** (dbaeumer.vscode-eslint)
- **Prettier** (esbenp.prettier-vscode)
- **TypeScript Vue Plugin (Volar)** (Vue.volar)

### Configuración de VS Code

Crear `.vscode/launch.json`:

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Launch Backend API",
      "type": "coreclr",
      "request": "launch",
      "preLaunchTask": "build",
      "program": "${workspaceFolder}/backend/src/LAMAMedellin.API/bin/Debug/net8.0/LAMAMedellin.API.dll",
      "args": [],
      "cwd": "${workspaceFolder}/backend/src/LAMAMedellin.API",
      "stopAtEntry": false,
      "serverReadyAction": {
        "action": "openExternally",
        "pattern": "\\bNow listening on:\\s+(https?://\\S+)"
      },
      "env": {
        "ASPNETCORE_ENVIRONMENT": "Development"
      }
    }
  ]
}
```

Crear `.vscode/tasks.json`:

```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "build",
      "command": "dotnet",
      "type": "process",
      "args": [
        "build",
        "${workspaceFolder}/backend/LAMAMedellin.sln"
      ],
      "problemMatcher": "$msCompile"
    }
  ]
}
```

## 🧪 Verificar Instalación

### Backend

1. **Health Check:**
```bash
curl https://localhost:7001/health
```

Debe retornar:
```json
{
  "status": "Healthy",
  "timestamp": "2025-01-05T..."
}
```

2. **Swagger UI:**
Abrir en navegador: `https://localhost:7001/swagger`

3. **Probar endpoint:**
```bash
# Sin autenticación (si la comentaste temporalmente)
curl https://localhost:7001/api/miembros?pageNumber=1&pageSize=10
```

### Frontend

1. Abrir `http://localhost:3000`
2. Deberías ver la página de login
3. Verificar console del navegador (F12) - no debe haber errores críticos

## 🐛 Solución de Problemas Comunes

### Error: "Unable to resolve service for type 'LAMADbContext'"

**Solución:**
```bash
# Verificar que las migraciones existan
cd backend/src/LAMAMedellin.Infrastructure/Migrations

# Si está vacía, crear migración
cd ../LAMAMedellin.API
dotnet ef migrations add InitialCreate --project ../LAMAMedellin.Infrastructure
```

### Error: "Cannot connect to SQL Server"

**Solución:**
```bash
# Verificar que SQL Server esté corriendo
sqllocaldb info
sqllocaldb start mssqllocaldb

# O reiniciar servicio SQL Server
# Windows: services.msc > SQL Server (MSSQLSERVER) > Restart
```

### Error: "CORS policy blocking"

**Solución:**
Verificar que en `Program.cs` backend esté configurado CORS:
```csharp
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowReactApp", policy =>
    {
        policy.WithOrigins("http://localhost:3000")
            .AllowAnyMethod()
            .AllowAnyHeader();
    });
});
```

### Error: "npm install failed"

**Solución:**
```bash
# Limpiar caché
npm cache clean --force

# Eliminar node_modules y package-lock.json
rm -rf node_modules package-lock.json

# Reinstalar
npm install
```

### Error: "Port already in use"

**Backend:**
```bash
# Cambiar puerto en launchSettings.json o appsettings.json
"applicationUrl": "https://localhost:7002;http://localhost:5002"
```

**Frontend:**
```bash
# Cambiar puerto en vite.config.ts
server: {
  port: 3001
}
```

## 📚 Siguientes Pasos

1. **Explorar el código:**
   - Revisar estructura de Clean Architecture en backend
   - Ver componentes React en frontend

2. **Crear datos de prueba:**
   - Usar Swagger para crear miembros de prueba
   - O ejecutar seed data script

3. **Configurar autenticación:**
   - Seguir guía en `docs/DESPLIEGUE_AZURE.md` sección 2

4. **Leer documentación:**
   - `docs/ARQUITECTURA.md` - Entender la arquitectura
   - `README.md` - Visión general del proyecto

## 🆘 Obtener Ayuda

Si encuentras problemas:
1. Revisar logs en consola
2. Verificar este documento de troubleshooting
3. Contactar al equipo de desarrollo

---

¡Configuración completa! Ya puedes comenzar a desarrollar. 🚀

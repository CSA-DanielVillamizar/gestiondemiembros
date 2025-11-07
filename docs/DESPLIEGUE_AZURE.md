# Guía de Despliegue en Azure

Esta guía proporciona instrucciones paso a paso para desplegar la aplicación en Azure.

## Prerrequisitos

- Cuenta de Azure activa
- Azure CLI instalado
- .NET 8.0 SDK
- Node.js 18+
- Git

> Nota para Windows PowerShell
>
> - Los comandos abajo están escritos en Bash. En Windows PowerShell:
>   - No uses `\` para dividir líneas; coloca el comando en una sola línea o usa el acento grave (backtick) ` para continuación.
>   - Reemplaza usos de `$(openssl rand -hex 4)` por un sufijo fijo o genera uno en PowerShell:
>     `$RANDOM_SUFFIX = -join ((48..57)+(97..102) | Get-Random -Count 8 | ForEach-Object { [char]$_ })`
>   - Ejemplo (PowerShell):
>
>   - Crear grupo de recursos:
>
>     ```powershell
>     az group create --name rg-lama-medellin --location eastus
>     ```
>
>   - Crear WebApp con sufijo aleatorio:
>
>     ```powershell
>     $RANDOM_SUFFIX = -join ((48..57)+(97..102) | Get-Random -Count 8 | ForEach-Object { [char]$_ });
>     $WEBAPP = "api-lama-medellin-$RANDOM_SUFFIX";
>     az webapp create --name $WEBAPP --resource-group rg-lama-medellin --plan plan-lama-api --runtime "DOTNET:8.0"
>     ```

## Paso 1: Crear Recursos en Azure

### 1.1 Iniciar Sesión en Azure

```bash
az login
az account set --subscription "Nombre-de-tu-Suscripción"
```

### 1.2 Crear Grupo de Recursos

```bash
az group create \
  --name rg-lama-medellin \
  --location eastus
```

### 1.3 Crear Azure SQL Database

```bash
# Crear SQL Server
az sql server create \
  --name sql-lama-medellin-$(openssl rand -hex 4) \
  --resource-group rg-lama-medellin \
  --location eastus \
  --admin-user sqladmin \
  --admin-password 'TuPassword123!'

# Crear Base de Datos
az sql db create \
  --resource-group rg-lama-medellin \
  --server sql-lama-medellin \
  --name LAMAMedellinDB \
  --service-objective S0 \
  --backup-storage-redundancy Local

# Configurar firewall (permitir servicios Azure)
az sql server firewall-rule create \
  --resource-group rg-lama-medellin \
  --server sql-lama-medellin \
  --name AllowAzureServices \
  --start-ip-address 0.0.0.0 \
  --end-ip-address 0.0.0.0
```

### 1.4 Crear App Service (Backend)

```bash
# Crear App Service Plan
az appservice plan create \
  --name plan-lama-api \
  --resource-group rg-lama-medellin \
  --sku B1 \
  --is-linux

# Crear Web App
az webapp create \
  --name api-lama-medellin-$(openssl rand -hex 4) \
  --resource-group rg-lama-medellin \
  --plan plan-lama-api \
  --runtime "DOTNET:8.0"

# Habilitar HTTPS only
az webapp update \
  --name api-lama-medellin \
  --resource-group rg-lama-medellin \
  --https-only true
```

### 1.5 Crear Static Web App (Frontend)

```bash
az staticwebapp create \
  --name swa-lama-frontend \
  --resource-group rg-lama-medellin \
  --location eastus
```

## Paso 2: Configurar Azure AD B2C

### 2.1 Crear Tenant B2C

1. Ir al [Azure Portal](https://portal.azure.com)
2. Buscar "Azure AD B2C"
3. Clic en "Create a B2C tenant"
4. Completar:
   - Nombre de organización: `lama-medellin`
   - Nombre de dominio inicial: `lamamedellin`
   - País: Colombia

### 2.2 Registrar Aplicación Backend (API)

1. En el tenant B2C, ir a "App registrations"
2. Clic "New registration"
3. Configurar:
   - Name: `LAMA Medellin API`
   - Supported account types: Accounts in any identity provider...
   - Redirect URI: (dejar vacío por ahora)
4. Clic "Register"
5. Copiar "Application (client) ID" y "Directory (tenant) ID"

6. En la app registrada:
   - Ir a "Expose an API"
   - Clic "Add a scope"
   - Application ID URI: `api://lama-medellin-api`
   - Scope name: `access_as_user`
   - Admin consent display name: `Access API as user`
   - Clic "Add scope"

### 2.3 Registrar Aplicación Frontend (SPA)

1. "New registration"
2. Name: `LAMA Medellin Frontend`
3. Supported account types: Accounts in any identity provider...
4. Redirect URI (SPA): `http://localhost:3000`
5. Clic "Register"
6. Copiar "Application (client) ID"
7. Ir a "Authentication"
8. Agregar redirect URI de producción: `https://your-static-web-app.azurestaticapps.net`
9. Habilitar "ID tokens" y "Access tokens"
10. Guardar

### 2.4 Crear User Flow

1. En B2C, ir a "User flows"
2. Clic "New user flow"
3. Seleccionar "Sign up and sign in"
4. Versión: Recommended
5. Name: `signupsignin`
6. Identity providers:
   - Email signup
7. User attributes and claims:
   - Collect: Email Address, Display Name, Given Name, Surname
   - Return: Email Addresses, Display Name, User's Object ID
8. Clic "Create"

### 2.5 Configurar Proveedores Sociales

#### Google

1. Ir a [Google Cloud Console](https://console.cloud.google.com/)
2. Crear proyecto
3. Habilitar "Google+ API"
4. Crear credenciales OAuth 2.0
5. Configurar redirect URI: `https://lamamedellin.b2clogin.com/lamamedellin.onmicrosoft.com/oauth2/authresp`
6. Copiar Client ID y Client Secret

En Azure AD B2C:

1. Ir a "Identity providers"
2. Clic "Google"
3. Configurar:
   - Client ID: (de Google)
   - Client secret: (de Google)
4. Guardar

#### Facebook

1. Ir a [Facebook Developers](https://developers.facebook.com/)
2. Crear app
3. Agregar "Facebook Login"
4. Configurar redirect URI: `https://lamamedellin.b2clogin.com/lamamedellin.onmicrosoft.com/oauth2/authresp`
5. Copiar App ID y App Secret

En Azure AD B2C:

1. Ir a "Identity providers"
2. Clic "Facebook"
3. Configurar:
   - Client ID: (App ID de Facebook)
   - Client secret: (App Secret de Facebook)
4. Guardar

## Paso 3: Configurar Connection Strings y Settings

### 3.1 Obtener Connection String de SQL

```bash
az sql db show-connection-string \
  --name LAMAMedellinDB \
  --server sql-lama-medellin \
  --client ado.net
```

### 3.2 Configurar App Service

```bash
# Connection String
az webapp config connection-string set \
  --name api-lama-medellin \
  --resource-group rg-lama-medellin \
  --connection-string-type SQLAzure \
  --settings DefaultConnection="Server=tcp:sql-lama-medellin.database.windows.net,1433;Initial Catalog=LAMAMedellinDB;Persist Security Info=False;User ID=sqladmin;Password=TuPassword123!;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"

# Azure AD B2C Settings
az webapp config appsettings set \
  --name api-lama-medellin \
  --resource-group rg-lama-medellin \
  --settings \
    AzureAdB2C__Instance="https://lamamedellin.b2clogin.com" \
    AzureAdB2C__ClientId="<backend-client-id>" \
    AzureAdB2C__Domain="lamamedellin.onmicrosoft.com" \
    AzureAdB2C__SignUpSignInPolicyId="B2C_1_signupsignin" \
    ASPNETCORE_ENVIRONMENT="Production"
```

## Paso 4: Desplegar Backend

### 4.1 Preparar para Despliegue

```bash
cd backend/src/LAMAMedellin.API

# Publicar aplicación
dotnet publish -c Release -o ./publish
```

### 4.2 Crear Archivo ZIP

```bash
# Windows (PowerShell)
Compress-Archive -Path ./publish/* -DestinationPath ./publish.zip

# Linux/Mac
cd publish && zip -r ../publish.zip . && cd ..
```

### 4.3 Desplegar

```bash
az webapp deployment source config-zip \
  --resource-group rg-lama-medellin \
  --name api-lama-medellin \
  --src ./publish.zip
```

### 4.4 Aplicar Migraciones de Base de Datos

```bash
# Desde máquina local (con firewall configurado)
cd backend/src/LAMAMedellin.API
dotnet ef database update --connection "Server=tcp:sql-lama-medellin.database.windows.net,1433;..."
```

## Paso 5: Desplegar Frontend

### 5.1 Configurar Variables de Entorno

Crear `.env.production`:

```env
VITE_API_BASE_URL=https://api-lama-medellin.azurewebsites.net/api
VITE_AZURE_AD_B2C_CLIENT_ID=<frontend-client-id>
VITE_AZURE_AD_B2C_AUTHORITY=https://lamamedellin.b2clogin.com/lamamedellin.onmicrosoft.com/B2C_1_signupsignin
VITE_AZURE_AD_B2C_KNOWN_AUTHORITY=lamamedellin.b2clogin.com
VITE_API_SCOPE=https://lamamedellin.onmicrosoft.com/api/access_as_user
VITE_REDIRECT_URI=https://your-static-web-app.azurestaticapps.net
VITE_POST_LOGOUT_REDIRECT_URI=https://your-static-web-app.azurestaticapps.net
```

### 5.2 Build y Deploy

```bash
cd frontend

# Instalar dependencias
npm install

# Build para producción
npm run build

# Desplegar con SWA CLI
npm install -g @azure/static-web-apps-cli

swa deploy ./dist \
  --resource-group rg-lama-medellin \
  --app-name swa-lama-frontend \
  --env production
```

## Paso 6: Verificación

### 6.1 Verificar Backend

```bash
# Health check
curl https://api-lama-medellin.azurewebsites.net/health

# Swagger UI
# Abrir en navegador: https://api-lama-medellin.azurewebsites.net/swagger
```

### 6.2 Verificar Frontend

```bash
# Abrir en navegador
# https://your-static-web-app.azurestaticapps.net
```

### 6.3 Probar Autenticación

1. Abrir frontend
2. Clic en "Iniciar Sesión"
3. Intentar login con email
4. Intentar login con Google
5. Intentar login con Facebook

## Paso 7: Configurar CI/CD (Opcional)

### 7.1 GitHub Actions para Backend

Crear `.github/workflows/backend-deploy.yml`:

```yaml
name: Deploy Backend

on:
  push:
    branches: [ main ]
    paths:
      - 'backend/**'

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup .NET
        uses: actions/setup-dotnet@v3
        with:
          dotnet-version: '8.0.x'
      
      - name: Restore dependencies
        run: dotnet restore ./backend/LAMAMedellin.sln
      
      - name: Build
        run: dotnet build ./backend/LAMAMedellin.sln --configuration Release
      
      - name: Test
        run: dotnet test ./backend/LAMAMedellin.sln --no-build --verbosity normal
      
      - name: Publish
        run: dotnet publish ./backend/src/LAMAMedellin.API/LAMAMedellin.API.csproj -c Release -o ./publish
      
      - name: Deploy to Azure Web App
        uses: azure/webapps-deploy@v2
        with:
          app-name: 'api-lama-medellin'
          publish-profile: ${{ secrets.AZURE_WEBAPP_PUBLISH_PROFILE }}
          package: ./publish
```

### 7.2 GitHub Actions para Frontend

Azure Static Web Apps genera automáticamente el workflow.

## Troubleshooting

### Backend no responde

```bash
# Ver logs
az webapp log tail \
  --name api-lama-medellin \
  --resource-group rg-lama-medellin
```

### Error de conexión a base de datos

```bash
# Verificar firewall
az sql server firewall-rule list \
  --resource-group rg-lama-medellin \
  --server sql-lama-medellin
```

### Frontend no puede autenticar

1. Verificar redirect URIs en Azure AD B2C
2. Verificar CORS en backend
3. Verificar variables de entorno en frontend

## Comandos Útiles

```bash
# Ver recursos del grupo
az resource list --resource-group rg-lama-medellin --output table

# Ver logs de App Service
az webapp log tail --name api-lama-medellin --resource-group rg-lama-medellin

# Restart App Service
az webapp restart --name api-lama-medellin --resource-group rg-lama-medellin

# Ver configuración de App Service
az webapp config appsettings list --name api-lama-medellin --resource-group rg-lama-medellin
```

## Costos Estimados (USD/mes)

- **Azure SQL Database (S0):** ~$15
- **App Service (B1):** ~$13
- **Static Web Apps (Free tier):** $0
- **Azure AD B2C (50,000 auths/mes):** $0

**Total estimado:** ~$28/mes

---

¡Despliegue completado! 🎉

---

## Anexo: Despliegue completo en Windows PowerShell (paso a paso)

Esta sección traduce el flujo de despliegue a comandos PowerShell para Windows. Está pensada para que cualquier persona pueda seguirla de principio a fin.

Importante y seguro:

- Estos comandos crean recursos en Azure y pueden generar costos. Valida tu suscripción y región antes de ejecutarlos.
- Usa nombres únicos por suscripción. Aquí generamos un sufijo aleatorio para evitar colisiones.
- No pegues contraseñas en texto plano en entornos compartidos.

### A. Prerrequisitos

1) Azure CLI instalado: <https://aka.ms/azure-cli>
2) .NET 8 SDK y Node.js 18+
3) Una suscripción de Azure con permisos de “Contributor” en un grupo de recursos

Verifica que Azure CLI esté disponible y versión:

```powershell
az --version
```

Inicia sesión e identifica/subscripción:

```powershell
az login
az account list --output table
az account set --subscription "<TU-SUSCRIPCION-NOMBRE-O-ID>"
az account show --output table
```

### B. Variables (edita según tu contexto)

```powershell
$LOCATION      = "eastus"
$RG            = "rg-lama-medellin"

# Sufijo aleatorio hexadecimal (8 chars)
$SUFFIX = -join ((48..57)+(97..102) | Get-Random -Count 8 | ForEach-Object { [char]$_ })

# SQL
$SQL_SERVER    = "sql-lama-medellin-$SUFFIX"
$SQL_ADMIN     = "sqladmin"
$SQL_PASSWORD  = "TuPassword123!"   # Reemplázala; respeta complejidad de Azure SQL
$DB_NAME       = "LAMAMedellinDB"

# App Service
$PLAN          = "plan-lama-api"
$WEBAPP        = "api-lama-medellin-$SUFFIX"

# Static Web Apps
$SWA           = "swa-lama-frontend-$SUFFIX"

# Azure AD B2C (placeholders)
$B2C_DOMAIN    = "lamamedellin.onmicrosoft.com"
$B2C_INSTANCE  = "https://lamamedellin.b2clogin.com"
$B2C_CLIENT_ID = "<backend-client-id>"
$B2C_POLICY    = "B2C_1_signupsignin"
```

### C. Grupo de recursos

```powershell
az group create --name $RG --location $LOCATION
```

### D. Azure SQL (servidor + base de datos + firewall)

```powershell
# Servidor SQL
az sql server create `
  --name $SQL_SERVER `
  --resource-group $RG `
  --location $LOCATION `
  --admin-user $SQL_ADMIN `
  --admin-password $SQL_PASSWORD

# Base de datos
az sql db create `
  --resource-group $RG `
  --server $SQL_SERVER `
  --name $DB_NAME `
  --service-objective S0 `
  --backup-storage-redundancy Local

# Permitir servicios de Azure
az sql server firewall-rule create `
  --resource-group $RG `
  --server $SQL_SERVER `
  --name AllowAzureServices `
  --start-ip-address 0.0.0.0 `
  --end-ip-address 0.0.0.0
```

### E. App Service plan + Web App (.NET 8)

```powershell
az appservice plan create `
  --name $PLAN `
  --resource-group $RG `
  --sku B1 `
  --is-linux

az webapp create `
  --name $WEBAPP `
  --resource-group $RG `
  --plan $PLAN `
  --runtime "DOTNET:8.0"

az webapp update `
  --name $WEBAPP `
  --resource-group $RG `
  --https-only true
```

### F. Connection string y app settings (B2C)

```powershell
$CONN = "Server=tcp:$($SQL_SERVER).database.windows.net,1433;Initial Catalog=$DB_NAME;Persist Security Info=False;User ID=$SQL_ADMIN;Password=$SQL_PASSWORD;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"

az webapp config connection-string set `
  --name $WEBAPP `
  --resource-group $RG `
  --connection-string-type SQLAzure `
  --settings DefaultConnection="$CONN"

az webapp config appsettings set `
  --name $WEBAPP `
  --resource-group $RG `
  --settings `
    AzureAdB2C__Instance="$B2C_INSTANCE" `
    AzureAdB2C__ClientId="$B2C_CLIENT_ID" `
    AzureAdB2C__Domain="$B2C_DOMAIN" `
    AzureAdB2C__SignUpSignInPolicyId="$B2C_POLICY" `
    ASPNETCORE_ENVIRONMENT="Production"
```

### G. Publicar y desplegar Backend

Desde la carpeta del API (`backend/src/LAMAMedellin.API`):

```powershell
dotnet publish -c Release -o ./publish
Compress-Archive -Path ./publish/* -DestinationPath ./publish.zip -Force

az webapp deployment source config-zip `
  --resource-group $RG `
  --name $WEBAPP `
  --src ./publish.zip
```

Aplicar migraciones directamente apuntando a Azure SQL:

```powershell
$env:ConnectionStrings__DefaultConnection = $CONN
dotnet ef database update
Remove-Item Env:\ConnectionStrings__DefaultConnection
```

### H. Crear y desplegar Static Web App (Frontend)

```powershell
az staticwebapp create `
  --name $SWA `
  --resource-group $RG `
  --location $LOCATION

# Preparar build (desde la carpeta frontend)
npm install
npm run build

# Desplegar (requiere @azure/static-web-apps-cli)
npm install -g @azure/static-web-apps-cli
swa deploy ./dist `
  --resource-group $RG `
  --app-name $SWA `
  --env production
```

### I. Verificación y diagnósticos

```powershell
# Health del API
curl https://$WEBAPP.azurewebsites.net/health

# Swagger
Start-Process https://$WEBAPP.azurewebsites.net/swagger

# Logs del App Service en vivo
az webapp log tail --name $WEBAPP --resource-group $RG

# Recursos del grupo
az resource list --resource-group $RG --output table
```

Consejos:

- Si un comando falla por permisos, valida la suscripción en uso con `az account show`.
- Si el despliegue del ZIP no toma cambios, reinicia la app: `az webapp restart --name $WEBAPP --resource-group $RG`.
- Para ver configuración actual: `az webapp config appsettings list --name $WEBAPP --resource-group $RG`.

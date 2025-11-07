# 🔐 Guía de Configuración de Secretos para GitHub Actions

Esta guía explica cómo configurar los secretos necesarios para habilitar deployments automáticos y otras funcionalidades avanzadas.

## 📋 Índice

- [Secretos Requeridos](#secretos-requeridos)
- [Configuración de Azure](#configuración-de-azure)
- [Configuración de Codecov](#configuración-de-codecov)
- [Configuración en GitHub](#configuración-en-github)
- [Verificación](#verificación)

---

## 🔑 Secretos Requeridos

### Para Deployment de Backend (Azure App Service)

| Secreto | Descripción | Requerido |
|---------|-------------|-----------|
| `AZURE_WEBAPP_PUBLISH_PROFILE_STAGING` | Perfil de publicación del App Service de staging | ✅ |
| `AZURE_WEBAPP_PUBLISH_PROFILE_PRODUCTION` | Perfil de publicación del App Service de producción | ✅ |

### Para Deployment de Frontend (Azure Static Web Apps)

| Secreto | Descripción | Requerido |
|---------|-------------|-----------|
| `AZURE_STATIC_WEB_APPS_API_TOKEN_STAGING` | Token de API de Static Web App de staging | ✅ |
| `AZURE_STATIC_WEB_APPS_API_TOKEN_PRODUCTION` | Token de API de Static Web App de producción | ✅ |
| `VITE_API_BASE_URL_STAGING` | URL del backend en staging | ✅ |
| `VITE_API_BASE_URL_PRODUCTION` | URL del backend en producción | ✅ |

### Para Code Coverage

| Secreto | Descripción | Requerido |
|---------|-------------|-----------|
| `CODECOV_TOKEN` | Token de Codecov para reportes de cobertura | ⚠️ Opcional |

---

## ☁️ Configuración de Azure

### 1. Backend - Azure App Service

#### Crear App Service

```bash
# Login a Azure
az login

# Crear Resource Group (si no existe)
az group create --name lama-medellin-rg --location eastus

# Crear App Service Plan
az appservice plan create \
  --name lama-medellin-plan \
  --resource-group lama-medellin-rg \
  --sku B1 \
  --is-linux

# Crear App Service para Staging
az webapp create \
  --name lama-medellin-api-staging \
  --resource-group lama-medellin-rg \
  --plan lama-medellin-plan \
  --runtime "DOTNET|8.0"

# Crear App Service para Production
az webapp create \
  --name lama-medellin-api \
  --resource-group lama-medellin-rg \
  --plan lama-medellin-plan \
  --runtime "DOTNET|8.0"
```

#### Obtener Publish Profile

**Opción 1: Azure Portal**

1. Ve a [Azure Portal](https://portal.azure.com)
2. Navega a tu App Service
3. En el menú lateral, click en **"Deployment Center"** → **"Manage publish profile"**
4. Click en **"Download publish profile"**
5. Abre el archivo `.PublishSettings` descargado

**Opción 2: Azure CLI**

```bash
# Staging
az webapp deployment list-publishing-profiles \
  --name lama-medellin-api-staging \
  --resource-group lama-medellin-rg \
  --xml

# Production
az webapp deployment list-publishing-profiles \
  --name lama-medellin-api \
  --resource-group lama-medellin-rg \
  --xml
```

Copia todo el contenido XML.

### 2. Frontend - Azure Static Web Apps

#### Crear Static Web App

**Opción 1: Azure Portal**

1. Ve a [Azure Portal](https://portal.azure.com)
2. Click en **"Create a resource"** → **"Static Web App"**
3. Rellena los campos:
   - **Resource Group**: lama-medellin-rg
   - **Name**: lama-medellin-frontend-staging (o production)
   - **Region**: East US 2
   - **Source**: Other (manual deployment)
4. Click en **"Review + Create"**

**Opción 2: Azure CLI**

```bash
# Staging
az staticwebapp create \
  --name lama-medellin-frontend-staging \
  --resource-group lama-medellin-rg \
  --location eastus2

# Production
az staticwebapp create \
  --name lama-medellin-frontend \
  --resource-group lama-medellin-rg \
  --location eastus2
```

#### Obtener API Token

**Azure Portal:**

1. Ve a tu Static Web App en Azure Portal
2. En el menú lateral, click en **"Manage deployment token"**
3. Copia el token mostrado

**Azure CLI:**

```bash
# Staging
az staticwebapp secrets list \
  --name lama-medellin-frontend-staging \
  --resource-group lama-medellin-rg \
  --query "properties.apiKey" -o tsv

# Production
az staticwebapp secrets list \
  --name lama-medellin-frontend \
  --resource-group lama-medellin-rg \
  --query "properties.apiKey" -o tsv
```

### 3. Configurar URLs de API

Obtén las URLs de tus App Services:

```bash
# Staging
az webapp show \
  --name lama-medellin-api-staging \
  --resource-group lama-medellin-rg \
  --query "defaultHostName" -o tsv

# Production
az webapp show \
  --name lama-medellin-api \
  --resource-group lama-medellin-rg \
  --query "defaultHostName" -o tsv
```

Las URLs serán:
- Staging: `https://lama-medellin-api-staging.azurewebsites.net/api`
- Production: `https://lama-medellin-api.azurewebsites.net/api`

---

## 📊 Configuración de Codecov

### 1. Crear cuenta en Codecov

1. Ve a [codecov.io](https://codecov.io)
2. Sign in con tu cuenta de GitHub
3. Autoriza el acceso al repositorio

### 2. Obtener Token

1. En Codecov, ve a tu repositorio
2. Click en **Settings** → **General**
3. Copia el **Repository Upload Token**

### 3. ¿Por qué Codecov?

- ✅ Visualización de cobertura de código
- ✅ Seguimiento de tendencias de cobertura
- ✅ Comentarios automáticos en PRs
- ✅ Badges para README
- ✅ Gratis para proyectos open source

---

## 🔧 Configuración en GitHub

### 1. Agregar Secretos

1. Ve a tu repositorio en GitHub
2. Click en **Settings** → **Secrets and variables** → **Actions**
3. Click en **"New repository secret"**
4. Agrega cada secreto:

#### Backend Secrets

**AZURE_WEBAPP_PUBLISH_PROFILE_STAGING**
```
Pega todo el contenido XML del publish profile de staging
```

**AZURE_WEBAPP_PUBLISH_PROFILE_PRODUCTION**
```
Pega todo el contenido XML del publish profile de production
```

#### Frontend Secrets

**AZURE_STATIC_WEB_APPS_API_TOKEN_STAGING**
```
Pega el token de Static Web App de staging
```

**AZURE_STATIC_WEB_APPS_API_TOKEN_PRODUCTION**
```
Pega el token de Static Web App de production
```

**VITE_API_BASE_URL_STAGING**
```
https://lama-medellin-api-staging.azurewebsites.net/api
```

**VITE_API_BASE_URL_PRODUCTION**
```
https://lama-medellin-api.azurewebsites.net/api
```

#### Coverage Secret

**CODECOV_TOKEN**
```
Pega el token de Codecov
```

### 2. Configurar Environments (Opcional pero Recomendado)

Para agregar protección a deployments de producción:

1. Ve a **Settings** → **Environments**
2. Click en **"New environment"**
3. Nombre: `production`
4. Click en **"Configure environment"**
5. Habilita **"Required reviewers"** y agrega reviewers
6. Habilita **"Wait timer"** (opcional, ej: 5 minutos)
7. Click en **"Save protection rules"**

Repite para `staging` si quieres.

---

## ✅ Verificación

### 1. Verificar Secretos

```bash
# Listar secretos configurados (solo nombres, no valores)
gh secret list
```

Deberías ver:
```
AZURE_STATIC_WEB_APPS_API_TOKEN_PRODUCTION
AZURE_STATIC_WEB_APPS_API_TOKEN_STAGING
AZURE_WEBAPP_PUBLISH_PROFILE_PRODUCTION
AZURE_WEBAPP_PUBLISH_PROFILE_STAGING
CODECOV_TOKEN
VITE_API_BASE_URL_PRODUCTION
VITE_API_BASE_URL_STAGING
```

### 2. Probar Deployment

#### Backend

1. Haz un cambio en `backend/`
2. Commit y push a `main`
3. Ve a **Actions** → **Deploy Backend to Azure App Service**
4. Verifica que el workflow se ejecute correctamente

O manualmente:

1. Ve a **Actions** → **Deploy Backend to Azure App Service**
2. Click en **"Run workflow"**
3. Selecciona environment (staging/production)
4. Click en **"Run workflow"**

#### Frontend

1. Haz un cambio en `frontend/`
2. Commit y push a `main`
3. Ve a **Actions** → **Deploy Frontend to Azure Static Web Apps**
4. Verifica que el workflow se ejecute correctamente

### 3. Verificar Coverage

1. Haz un push que modifique código de backend
2. Espera a que el workflow termine
3. Ve a [codecov.io](https://codecov.io) y verifica tu repositorio
4. Verifica que aparezca el badge en el README

---

## 🎨 Agregar Badges al README

### Backend Deployment

```markdown
[![Backend Deployment](https://github.com/CSA-DanielVillamizar/gestiondemiembros/actions/workflows/deploy-backend.yml/badge.svg)](https://github.com/CSA-DanielVillamizar/gestiondemiembros/actions/workflows/deploy-backend.yml)
```

### Frontend Deployment

```markdown
[![Frontend Deployment](https://github.com/CSA-DanielVillamizar/gestiondemiembros/actions/workflows/deploy-frontend.yml/badge.svg)](https://github.com/CSA-DanielVillamizar/gestiondemiembros/actions/workflows/deploy-frontend.yml)
```

### Code Coverage

```markdown
[![codecov](https://codecov.io/gh/CSA-DanielVillamizar/gestiondemiembros/branch/main/graph/badge.svg)](https://codecov.io/gh/CSA-DanielVillamizar/gestiondemiembros)
```

---

## 🔒 Seguridad

### Buenas Prácticas

✅ **Hacer**:
- Rotar secretos regularmente
- Usar environments para producción con required reviewers
- Limitar permisos de tokens al mínimo necesario
- Usar Azure Key Vault para secretos en producción

❌ **No Hacer**:
- Nunca commitear secretos en el código
- No compartir tokens en mensajes o documentos
- No usar los mismos secretos para staging y production
- No deshabilitar la protección de environments sin razón

### Rotación de Secretos

Para rotar un secreto:

1. Genera un nuevo token/profile en Azure
2. Actualiza el secreto en GitHub
3. Verifica que el deployment funcione
4. Revoca el token/profile antiguo en Azure

---

## 🆘 Troubleshooting

### Error: "Secret not found"

- Verifica que el nombre del secreto sea exactamente igual (case-sensitive)
- Verifica que hayas agregado el secreto en el nivel correcto (repository, no organization)

### Error: "Invalid publish profile"

- Verifica que hayas copiado todo el contenido XML, sin espacios adicionales
- Descarga un nuevo publish profile y actualiza el secreto

### Error: "Invalid API token"

- Genera un nuevo token en Azure Static Web Apps
- Actualiza el secreto en GitHub
- Verifica que no haya espacios al inicio/final del token

### Deployment falla silenciosamente

- Revisa los logs del workflow en GitHub Actions
- Verifica los logs en Azure Portal (App Service → Log stream)
- Verifica que las URL de API sean correctas

---

## 📚 Referencias

- [Azure App Service Deployment](https://learn.microsoft.com/azure/app-service/deploy-github-actions)
- [Azure Static Web Apps Deployment](https://learn.microsoft.com/azure/static-web-apps/github-actions-workflow)
- [GitHub Actions Secrets](https://docs.github.com/actions/security-guides/encrypted-secrets)
- [Codecov Documentation](https://docs.codecov.com/)

---

**Última actualización**: Noviembre 2025

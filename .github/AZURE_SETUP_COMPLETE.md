# ✅ Azure Deployment Setup - COMPLETADO

## 📋 Recursos Creados

### Resource Group
- **Nombre**: `lama-medellin-rg`
- **Región**: East US

### App Service Plan
- **Nombre**: `lama-medellin-plan`
- **SKU**: B1 (Basic)
- **Sistema**: Linux

### Backend - App Service
- **Staging**: `lama-medellin-api-staging`
  - **URL**: https://lama-medellin-api-staging.azurewebsites.net
  - **Runtime**: .NET Core 8.0
  - **Swagger**: https://lama-medellin-api-staging.azurewebsites.net/swagger

### Frontend - Static Web App
- **Staging**: `lama-medellin-frontend-staging`
  - **URL**: https://icy-water-0eb2dd50f.3.azurestaticapps.net

## 🔐 GitHub Secrets Configurados

Los siguientes secrets fueron configurados en el repositorio:

### Staging
- ✅ `AZURE_WEBAPP_PUBLISH_PROFILE_STAGING` - Credenciales para deploy del backend
- ✅ `AZURE_STATIC_WEB_APPS_API_TOKEN_STAGING` - Token para deploy del frontend  
- ✅ `VITE_API_BASE_URL_STAGING` - URL del backend para el frontend

### Production (Pendiente)
Los secrets de producción se configurarán cuando se decida crear el ambiente de producción.

## 🚀 Workflows de Deployment

### Backend Deploy
- **Archivo**: `.github/workflows/deploy-backend.yml`
- **Trigger**: Push a `main` (cambios en `/backend`) o manual
- **Environments**: staging, production
- **Proceso**:
  1. Build con .NET 8.0
  2. Run tests
  3. Publish
  4. Deploy a Azure App Service

### Frontend Deploy
- **Archivo**: `.github/workflows/deploy-frontend.yml`
- **Trigger**: Push a `main` (cambios en `/frontend`) o manual
- **Environments**: staging, production
- **Proceso**:
  1. Install dependencies (npm ci)
  2. Lint código
  3. Build con Vite (configura VITE_API_BASE_URL)
  4. Deploy a Azure Static Web App

## 📝 Cómo Hacer Deploy

### Opción 1: Automático (Push)
```bash
# Cualquier cambio en backend/ o frontend/ triggeará deployment automático
git add .
git commit -m "feat: nueva funcionalidad"
git push origin main
```

### Opción 2: Manual
```bash
# Backend
gh workflow run deploy-backend.yml -f environment=staging

# Frontend  
gh workflow run deploy-frontend.yml -f environment=staging
```

### Monitorear Deployment
```bash
# Ver workflows activos
gh run list

# Ver logs del último run
gh run view --log

# Seguir en tiempo real
gh run watch
```

## 🛠️ Scripts de Automatización

Se crearon scripts PowerShell para automatizar la configuración:

### setup-azure-simple.ps1
Crea recursos de Azure:
```powershell
.\\.github\\scripts\\setup-azure-simple.ps1 -Env staging
```

### get-azure-secrets.ps1
Extrae secrets de Azure y los configura en GitHub:
```powershell
.\\.github\\scripts\\get-azure-secrets.ps1 -Env staging
```

## 🔄 Próximos Pasos

### 1. Primer Deployment
- [ ] Hacer un cambio en backend o frontend
- [ ] Push a main
- [ ] Monitorear workflows en GitHub Actions
- [ ] Verificar que staging esté funcionando

### 2. Configurar Producción (Opcional)
```powershell
# Crear recursos de producción
.\\.github\\scripts\\setup-azure-simple.ps1 -Env production

# Configurar secrets de producción
.\\.github\\scripts\\get-azure-secrets.ps1 -Env production
```

### 3. Configurar Environment Protection (Opcional)
En GitHub Settings → Environments → production:
- [x] Required reviewers (aprobar antes de deploy)
- [x] Wait timer (esperar X minutos)
- [x] Deployment branches (solo desde main)

### 4. Configurar Custom Domain (Opcional)
```bash
# Backend
az webapp config hostname add --webapp-name lama-medellin-api-staging --resource-group lama-medellin-rg --hostname api-staging.tudominio.com

# Frontend  
az staticwebapp hostname set --name lama-medellin-frontend-staging --resource-group lama-medellin-rg --hostname staging.tudominio.com
```

## 📊 Monitoreo y Logs

### Ver logs del Backend
```bash
# Stream en tiempo real
az webapp log tail --name lama-medellin-api-staging --resource-group lama-medellin-rg

# Descargar logs
az webapp log download --name lama-medellin-api-staging --resource-group lama-medellin-rg --log-file logs.zip
```

### Ver métricas
- Azure Portal → App Service → Monitoring
- Requests/sec, Response time, Errors, CPU, Memory

### Application Insights (Opcional)
Para monitoreo avanzado, crear Application Insights resource y linkear al App Service.

## 💰 Costos Estimados

### Configuración Actual (Staging)
- App Service Plan (B1): ~$13.14/mes
- Static Web App (Free tier): $0/mes
- **Total estimado**: ~$13-15/mes

### Con Producción
- App Service Plan compartido entre staging y production: ~$13.14/mes
- 2 Static Web Apps (Free tier): $0/mes
- **Total estimado**: ~$13-15/mes

### Optimización de Costos
- Free tier de Static Web App incluye 100GB bandwidth
- Apagar staging cuando no se usa: `az webapp stop`
- Usar slots de deployment en vez de recursos separados

## 🆘 Troubleshooting

### Deployment falla
```bash
# Ver logs del workflow
gh run view --log-failed

# Ver logs del App Service
az webapp log tail --name lama-medellin-api-staging --resource-group lama-medellin-rg
```

### API no responde
1. Verificar que el App Service esté corriendo: Azure Portal → App Service → Overview
2. Verificar configuración: Settings → Configuration
3. Revisar logs: Monitoring → Log stream

### Frontend no se conecta al backend
1. Verificar `VITE_API_BASE_URL_STAGING` en secrets
2. Verificar CORS en el backend
3. Revisar Network tab en DevTools del browser

## 📚 Documentación

- [Azure App Service](https://learn.microsoft.com/azure/app-service/)
- [Azure Static Web Apps](https://learn.microsoft.com/azure/static-web-apps/)
- [GitHub Actions para Azure](https://github.com/Azure/actions)

---

**Fecha de Setup**: 2025-11-07  
**Configurado por**: @CSA-DanielVillamizar

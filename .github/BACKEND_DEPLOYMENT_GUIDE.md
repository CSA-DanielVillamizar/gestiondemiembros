# 🔧 Pasos para Completar Backend Deployment

## Problema Actual
El publish profile obtenido vía Azure CLI tiene problemas debido a errores de certificado SSL (ambiente corporativo/proxy).

## ✅ Solución: Obtener Publish Profile desde Azure Portal

### Opción 1: Azure Portal (Recomendado)

1. **Ir a Azure Portal**
   - URL: https://portal.azure.com
   - Buscar: `lama-medellin-api-staging`

2. **Descargar Publish Profile**
   - En el App Service, click en **"Download publish profile"** (parte superior)
   - Se descargará un archivo XML: `lama-medellin-api-staging.PublishSettings`

3. **Configurar Secret en GitHub**
   ```powershell
   # Opción A: Usando archivo
   gh secret set AZURE_WEBAPP_PUBLISH_PROFILE_STAGING < "C:\Users\...\lama-medellin-api-staging.PublishSettings"
   
   # Opción B: Desde portapapeles (copia el contenido del archivo primero)
   Get-Clipboard | gh secret set AZURE_WEBAPP_PUBLISH_PROFILE_STAGING
   ```

4. **Triggear Deployment**
   ```powershell
   gh workflow run deploy-backend.yml -f environment=staging
   ```

5. **Monitorear**
   ```powershell
   gh run watch
   ```

### Opción 2: Usar Azure CLI con Certificado Corporativo

Si conoces el certificado del proxy corporativo:

```powershell
# Desactivar verificación (temporal, no recomendado en producción)
$env:AZURE_CLI_DISABLE_CONNECTION_VERIFICATION=1

# O agregar certificado al bundle
az config set core.ca_bundle_path="C:\path\to\corporate-cert.pem"
```

### Opción 3: Deploy Manual desde VS Code

1. **Instalar extensión Azure App Service**
   - ID: ms-azuretools.vscode-azureappservice

2. **Sign in to Azure**
   - Command Palette (Ctrl+Shift+P)
   - "Azure: Sign In"

3. **Deploy**
   - Click derecho en `/backend/src/LAMAMedellin.API`
   - "Deploy to Web App"
   - Seleccionar `lama-medellin-api-staging`

## 🔍 Verificar Deployment Exitoso

```powershell
# Ver logs del deployment
gh run view --log

# Verificar App Service está corriendo
az webapp show --name lama-medellin-api-staging --resource-group lama-medellin-rg --query "state"

# Probar endpoint
curl https://lama-medellin-api-staging.azurewebsites.net/swagger
```

## 📊 URLs Importantes

- **Backend Staging**: https://lama-medellin-api-staging.azurewebsites.net
- **Swagger UI**: https://lama-medellin-api-staging.azurewebsites.net/swagger
- **Azure Portal**: https://portal.azure.com/#view/HubsExtension/BrowseResource/resourceType/Microsoft.Web%2Fsites
- **GitHub Actions**: https://github.com/CSA-DanielVillamizar/gestiondemiembros/actions

## 🆘 Troubleshooting

### Error: "Deployment Failed, Error: No credentials found"
- El publish profile está corrupto o no es válido
- Solución: Descargar nuevo desde Portal

### Error: "Invalid publish profile"
- El archivo descargado no corresponde al App Service correcto
- Verificar nombre del App Service: `lama-medellin-api-staging`

### Backend no responde después de deployment
```powershell
# Ver logs en tiempo real
az webapp log tail --name lama-medellin-api-staging --resource-group lama-medellin-rg

# Reiniciar App Service
az webapp restart --name lama-medellin-api-staging --resource-group lama-medellin-rg
```

## ✨ Después del Deployment Exitoso

1. Verificar Swagger UI funciona
2. Probar endpoints desde frontend
3. Configurar CORS si es necesario
4. Considerar crear ambiente de producción
5. Setup Application Insights para monitoreo

---

**Estado Actual**:
- ✅ Frontend: Deployado y funcionando
- ⏳ Backend: Pendiente configuración de publish profile
- ✅ Infraestructura: 100% lista
- ✅ Secrets: Configurados (excepto publish profile corrupto)

# 📚 Índice Maestro de Documentación - Gestión de Miembros L.A.M.A. Medellín

## 🎯 Para Empezar - Lee Esto Primero

Si eres nuevo en este proyecto o vas a configurar el deployment, **empieza aquí**:

1. **[RESUMEN_EJECUTIVO.md](RESUMEN_EJECUTIVO.md)** - Visión general del proyecto
2. **[AZURE_SETUP_COMPLETE.md](AZURE_SETUP_COMPLETE.md)** - Setup de Azure completado
3. **[BACKEND_DEPLOYMENT_GUIDE.md](BACKEND_DEPLOYMENT_GUIDE.md)** - Siguiente paso a completar

## 🔐 Suscripción de Azure Utilizada

**⚠️ IMPORTANTE**: Este proyecto usa la siguiente suscripción de Azure:

- **Nombre**: `Argus`
- **ID**: `f4adbcf7-c2db-48ba-8165-3217f77ef8c7`
- **Estado**: Enabled
- **Recursos creados en**: `East US` region

### Recursos Creados en Esta Suscripción

```
Resource Group: lama-medellin-rg
├── App Service Plan: lama-medellin-plan (B1 - ~$13/mes)
├── Backend Staging: lama-medellin-api-staging
└── Frontend Staging: lama-medellin-frontend-staging (Free)
```

**Costo estimado**: ~$13-15/mes

### Para Verificar Tu Suscripción

```powershell
# Ver suscripción actual
az account show

# Cambiar suscripción si es necesario
az account set --subscription "nombre-o-id"

# Listar recursos en la suscripción
az resource list --resource-group lama-medellin-rg -o table
```

## 📋 Documentación por Categoría

### 🚀 Deployment y Azure

| Documento | Descripción | Estado |
|-----------|-------------|--------|
| [AZURE_SETUP_COMPLETE.md](AZURE_SETUP_COMPLETE.md) | Configuración completa de Azure | ✅ Completado |
| [BACKEND_DEPLOYMENT_GUIDE.md](BACKEND_DEPLOYMENT_GUIDE.md) | Guía paso a paso para backend | ⏳ Pendiente ejecutar |
| [SECRETS_SETUP.md](SECRETS_SETUP.md) | Configuración de GitHub Secrets | ✅ Completado |

**Estado actual**:
- ✅ Infraestructura Azure: 100% creada
- ✅ Frontend: Deployado y funcionando
- ⏳ Backend: Pendiente (publish profile desde Portal)

**URLs**:
- Frontend: https://icy-water-0eb2dd50f.3.azurestaticapps.net
- Backend (pendiente): https://lama-medellin-api-staging.azurewebsites.net

### 🛠️ Scripts de Automatización

Todos los scripts están en `.github/scripts/`:

| Script | Propósito | Cuándo Usar |
|--------|-----------|-------------|
| `setup-azure-simple.ps1` | Crear recursos Azure | Primera vez o nuevos ambientes |
| `get-azure-secrets.ps1` | Extraer y configurar secrets | Después de crear recursos |
| `setup-branch-protection.ps1` | Configurar protección de branches | Setup inicial del repo |
| `setup-discussions.ps1` | Activar GitHub Discussions | Opcional - comunidad |
| `setup-github-pages.ps1` | Configurar GitHub Pages | Opcional - documentación |
| `complete-setup.ps1` | Setup completo automatizado | Una sola vez |

#### Ejemplos de Uso

```powershell
# Setup Azure staging
.\.github\scripts\setup-azure-simple.ps1 -Env staging

# Extraer secrets
.\.github\scripts\get-azure-secrets.ps1 -Env staging

# Setup completo (requiere permisos admin)
.\.github\scripts\complete-setup.ps1
```

### 🔒 Seguridad y Configuración

| Documento | Descripción |
|-----------|-------------|
| [BRANCH_PROTECTION.md](BRANCH_PROTECTION.md) | Configuración de protección de ramas |
| [SECRETS_SETUP.md](SECRETS_SETUP.md) | Setup de secrets en GitHub |

**Secrets configurados**:
- ✅ `AZURE_WEBAPP_PUBLISH_PROFILE_STAGING`
- ✅ `AZURE_STATIC_WEB_APPS_API_TOKEN_STAGING`
- ✅ `VITE_API_BASE_URL_STAGING`

### 💬 Comunidad (Opcional)

| Documento | Descripción |
|-----------|-------------|
| [GITHUB_DISCUSSIONS.md](GITHUB_DISCUSSIONS.md) | Guía para configurar Discussions |
| [DISCUSSION_CONTENT.md](DISCUSSION_CONTENT.md) | Contenido de bienvenida |
| [TODO_DISCUSSIONS.md](TODO_DISCUSSIONS.md) | Pasos pendientes |

### 📊 Estado del Proyecto

| Documento | Descripción |
|-----------|-------------|
| [IMPLEMENTATION_CHECKLIST.md](IMPLEMENTATION_CHECKLIST.md) | Checklist completo |
| [OPTIONAL_STEPS_COMPLETED.md](OPTIONAL_STEPS_COMPLETED.md) | Pasos opcionales |
| [STATUS_OPCIONALES.md](STATUS_OPCIONALES.md) | Estado de opcionales |

## 🎯 Guías de Inicio Rápido

### Para Desarrolladores Nuevos

1. Clonar el repositorio
2. Leer [RESUMEN_EJECUTIVO.md](RESUMEN_EJECUTIVO.md)
3. Seguir [IMPLEMENTATION_CHECKLIST.md](IMPLEMENTATION_CHECKLIST.md)
4. Ver workflows en `.github/workflows/`

### Para Deployment

1. Leer [AZURE_SETUP_COMPLETE.md](AZURE_SETUP_COMPLETE.md)
2. Seguir [BACKEND_DEPLOYMENT_GUIDE.md](BACKEND_DEPLOYMENT_GUIDE.md)
3. Usar scripts en `.github/scripts/`
4. Verificar en Azure Portal

### Para Configuración de Producción

```powershell
# 1. Crear recursos de producción
.\.github\scripts\setup-azure-simple.ps1 -Env production

# 2. Extraer secrets
.\.github\scripts\get-azure-secrets.ps1 -Env production

# 3. Configurar Environment Protection en GitHub
# Settings → Environments → production → Protection rules
```

## 🗺️ Arquitectura del Proyecto

```
gestiondemiembros/
├── backend/                    # .NET 8 API
│   └── src/LAMAMedellin.API/
├── frontend/                   # React + Vite
│   ├── dist/                   # Build output (deployado)
│   ├── .staticwebapp.config.json
│   └── .staticwebappignore
├── .github/
│   ├── workflows/              # GitHub Actions
│   │   ├── backend-ci.yml      # ✅ Funcionando
│   │   ├── frontend-ci.yml     # ✅ Funcionando
│   │   ├── deploy-backend.yml  # ⏳ Pendiente publish profile
│   │   └── deploy-frontend.yml # ✅ Funcionando
│   ├── scripts/                # Scripts de automatización
│   │   ├── setup-azure-simple.ps1
│   │   ├── get-azure-secrets.ps1
│   │   └── ...
│   └── ISSUE_TEMPLATE/         # Templates de issues
└── docs/                       # GitHub Pages (opcional)
```

## 📈 Próximos Pasos Recomendados

### 1. Backend Deployment (5 min) - PRIORITARIO
Sigue [BACKEND_DEPLOYMENT_GUIDE.md](BACKEND_DEPLOYMENT_GUIDE.md):
- Descargar publish profile desde Azure Portal
- Configurar secret: `gh secret set AZURE_WEBAPP_PUBLISH_PROFILE_STAGING`
- Triggear workflow: `gh workflow run deploy-backend.yml -f environment=staging`

### 2. Verificar Aplicación Completa (5 min)
- Frontend: ✅ https://icy-water-0eb2dd50f.3.azurestaticapps.net
- Backend: ⏳ https://lama-medellin-api-staging.azurewebsites.net/swagger

### 3. Opcional - Configurar Codecov (5 min)
```powershell
# 1. Crear cuenta en codecov.io
# 2. Agregar repositorio
# 3. Configurar token
gh secret set CODECOV_TOKEN --body "tu-token-aqui"
```

### 4. Opcional - GitHub Discussions (10 min)
```powershell
.\.github\scripts\setup-discussions.ps1
```

### 5. Opcional - Ambiente de Producción (15 min)
```powershell
# Crear recursos
.\.github\scripts\setup-azure-simple.ps1 -Env production

# Configurar secrets
.\.github\scripts\get-azure-secrets.ps1 -Env production
```

## 🆘 Solución de Problemas

### Azure CLI Issues

```powershell
# Verificar login
az account show

# Problemas de certificado (ambiente corporativo)
$env:AZURE_CLI_DISABLE_CONNECTION_VERIFICATION=1

# Ver recursos creados
az resource list --resource-group lama-medellin-rg -o table
```

### GitHub Actions Issues

```powershell
# Ver workflows
gh run list --limit 10

# Ver logs
gh run view --log

# Triggear workflow
gh workflow run <workflow-name> -f environment=staging
```

### Deployment Issues

Ver sección "Troubleshooting" en:
- [BACKEND_DEPLOYMENT_GUIDE.md](BACKEND_DEPLOYMENT_GUIDE.md#-troubleshooting)
- [AZURE_SETUP_COMPLETE.md](AZURE_SETUP_COMPLETE.md#-troubleshooting)

## 📞 Contacto y Recursos

- **Azure Portal**: https://portal.azure.com
- **GitHub Repository**: https://github.com/CSA-DanielVillamizar/gestiondemiembros
- **GitHub Actions**: https://github.com/CSA-DanielVillamizar/gestiondemiembros/actions
- **Azure Docs**: https://learn.microsoft.com/azure/

## 🔄 Historial de Cambios Importantes

- **2025-11-07**: Azure deployment setup completado
  - Frontend deployado exitosamente
  - Backend pendiente publish profile
  - Scripts de automatización creados
  - Documentación completa generada

- **2025-11-06**: Configuración inicial del repositorio
  - Branch protection configurado
  - Workflows CI/CD creados
  - Issue templates agregados
  - Dependabot configurado

## ✅ Checklist de Verificación

Antes de considerar el proyecto completamente configurado:

- [x] Infraestructura Azure creada
- [x] Frontend deployado y funcionando
- [ ] Backend deployado y funcionando
- [x] GitHub Secrets configurados
- [x] CI/CD workflows funcionando
- [x] Documentación completa
- [x] Scripts de automatización creados
- [ ] Codecov configurado (opcional)
- [ ] GitHub Discussions activo (opcional)
- [ ] Ambiente de producción (opcional)

---

**Última actualización**: 2025-11-07  
**Mantenedor**: @CSA-DanielVillamizar  
**Suscripción Azure**: Argus (f4adbcf7-c2db-48ba-8165-3217f77ef8c7)

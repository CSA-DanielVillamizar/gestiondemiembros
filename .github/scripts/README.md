# 🚀 Scripts de Configuración Automatizada

Esta carpeta contiene scripts PowerShell para automatizar la configuración del proyecto LAMA Medellín.

## 📋 Requisitos Previos

Antes de ejecutar cualquier script, asegúrate de tener instalado:

1. **Azure CLI**: [Descargar aquí](https://docs.microsoft.com/cli/azure/install-azure-cli)
2. **GitHub CLI**: [Descargar aquí](https://cli.github.com/)
3. **PowerShell 5.1+** (incluido en Windows)

## 🌟 Scripts Principales de Azure

### 🔵 `setup-azure-simple.ps1` - Configuración de Azure (PASO 1)

**✨ Funcionalidades Clave:**
- ✅ **Login interactivo** - Funciona con cualquier cuenta de Azure
- ✅ **Multi-tenant** - Soporta diferentes organizaciones
- ✅ **Multi-suscripción** - Selecciona la suscripción que prefieras
- ✅ **Creación automatizada** - Todos los recursos de Azure en minutos

**Uso básico:**

```powershell
# Para crear recursos de Staging (recomendado para empezar)
.\.github\scripts\setup-azure-simple.ps1 -Env staging

# Para crear recursos de Production
.\.github\scripts\setup-azure-simple.ps1 -Env production

# Para crear ambos ambientes
.\.github\scripts\setup-azure-simple.ps1 -Env both
```

**Uso avanzado:**

```powershell
# Personalizar nombres y ubicación
.\.github\scripts\setup-azure-simple.ps1 `
    -RG "mi-resource-group" `
    -Location "westus2" `
    -Env staging
```

**¿Qué hace el script?**

1. **Login Interactivo**: 
   - Detecta si no hay sesión activa
   - Abre el navegador para autenticarte
   - Funciona con cuentas personales y corporativas

2. **Selección de Suscripción**:
   - Lista todas tus suscripciones disponibles
   - Muestra nombre, ID y estado de cada una
   - Te permite elegir la suscripción a usar
   - Marca la suscripción actual con "(actual)"

3. **Creación de Recursos**:
   - Resource Group
   - App Service Plan (B1, ~$13 USD/mes)
   - App Service para Backend (.NET 8.0)
   - Static Web App para Frontend (gratis)

**Ejemplo de ejecución:**

```
=== AZURE SETUP - LAMA MEDELLIN ===

PASO 1: Verificando Azure login...
No hay sesión activa. Iniciando login interactivo...

Se abrirá una ventana del navegador para autenticarte.
Inicia sesión con tu cuenta de Microsoft/Azure.

OK: Login exitoso

PASO 2: Seleccionando suscripción...

Suscripciones disponibles:

  [1] Mi Suscripción Personal
      ID: 12345678-1234-1234-1234-123456789012
      Estado: Enabled

  [2] Suscripción Corporativa
      ID: 87654321-4321-4321-4321-210987654321
      Estado: Enabled (actual)

Selecciona el número de la suscripción a usar [1-2]: 1

Configurando suscripción: Mi Suscripción Personal...
OK: Suscripción configurada
   Nombre: Mi Suscripción Personal
   ID: 12345678-1234-1234-1234-123456789012

PASO 3: Creando Resource Group...
   Nombre: lama-medellin-rg
   Ubicación: eastus
OK: Resource Group creado
...
```

---

### 🔑 `get-azure-secrets.ps1` - Configuración de GitHub Secrets (PASO 2)

Extrae credenciales de Azure y las configura automáticamente en GitHub.

**⚠️ IMPORTANTE**: Ejecuta este script DESPUÉS de `setup-azure-simple.ps1`

**Uso:**

```powershell
# PRIMERO: Autentícate en GitHub CLI
gh auth login

# LUEGO: Configura los secrets para Staging
.\.github\scripts\get-azure-secrets.ps1 -Env staging

# Para Production
.\.github\scripts\get-azure-secrets.ps1 -Env production

# Personalizar repositorio
.\.github\scripts\get-azure-secrets.ps1 `
    -Repo "usuario/repo" `
    -Env staging
```

**¿Qué hace el script?**

1. Verifica sesión de Azure (usa la misma del script anterior)
2. Verifica sesión de GitHub CLI
3. Verifica que el Resource Group exista
4. Extrae credenciales de Azure:
   - Publish Profile del backend
   - API Token del frontend
   - URL del backend
5. Configura los GitHub Secrets automáticamente

**Secrets configurados:**
- `AZURE_WEBAPP_PUBLISH_PROFILE_STAGING` - Para deployment del backend
- `AZURE_STATIC_WEB_APPS_API_TOKEN_STAGING` - Para deployment del frontend
- `VITE_API_BASE_URL_STAGING` - URL del API para el frontend

---

## 🌍 Soporte Multi-Tenant y Multi-Suscripción

Los scripts están diseñados para funcionar con **cualquier tenant y suscripción de Azure**. Esto significa que:

### ✅ Funciona con:

- 🏢 **Cuentas Corporativas** - Usa suscripciones de tu organización
- 👤 **Cuentas Personales** - Usa tu propia suscripción de Azure
- 🔄 **Múltiples Tenants** - Cambia entre diferentes organizaciones
- 📊 **Múltiples Suscripciones** - Selecciona cualquier suscripción disponible

### 🔄 Cambiar de Suscripción:

```powershell
# Ver suscripción actual
az account show

# Listar todas tus suscripciones
az account list -o table

# Cambiar de suscripción manualmente (opcional)
az account set --subscription "Nombre o ID"

# O simplemente ejecuta setup-azure-simple.ps1
# El script te permitirá seleccionar la suscripción
.\.github\scripts\setup-azure-simple.ps1 -Env staging
```

### 🔐 Cambiar de Tenant:

```powershell
# Cerrar sesión actual
az logout

# Login en un tenant específico
az login --tenant "ID-del-tenant"

# O login general (muestra todos los tenants disponibles)
az login

# Luego ejecuta el script
.\.github\scripts\setup-azure-simple.ps1 -Env staging
```

---

## 📋 Scripts Adicionales

### 💬 `setup-discussions.ps1` - GitHub Discussions

Configura GitHub Discussions con categorías y discusiones iniciales.

```powershell
.\.github\scripts\setup-discussions.ps1
```

**Acciones**:
- Abre VS Code con archivos de referencia
- Abre GitHub Discussions en el navegador
- Guía paso a paso para crear categorías
- Templates listos para copiar y pegar

---

### 📚 `setup-github-pages.ps1` - GitHub Pages

Habilita y configura GitHub Pages para la documentación con MkDocs.

```powershell
.\.github\scripts\setup-github-pages.ps1
```

**Acciones**:
- Abre configuración de Pages en GitHub
- Instrucciones para habilitar Source: GitHub Actions
- Guía para trigger del primer deploy

**Prerequisitos**: MkDocs ya está configurado (✅)

---

## 📁 Archivos de Referencia

### `setup-discussions.md`
Guía completa paso a paso para configurar GitHub Discussions.

### `welcome-discussion-content.txt`
Contenido listo para copiar y pegar en la discusión de bienvenida.

---

## 🎯 Uso Recomendado

### Opción 1: Configuración Completa (30 min)

```powershell
# Navega al directorio del repositorio
cd "c:\Users\TuUsuario\Miembros del capítulo"

# Ejecuta el script maestro
.\.github\scripts\setup-all.ps1
```

El script te guiará por cada paso y abrirá automáticamente:
- Archivos de referencia en VS Code
- Páginas de configuración en el navegador
- Documentación relevante

### Opción 2: Configuración Individual

Ejecuta solo los pasos que necesites:

```powershell
# Solo Discussions
.\.github\scripts\setup-discussions.ps1

# Solo GitHub Pages
.\.github\scripts\setup-github-pages.ps1
```

---

## 📊 Progreso Visual

El script maestro muestra progreso en tiempo real:

```
📊 Progreso: 2 de 5 pasos completados
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
████████████████████░░░░░░░░░░░░░░░░░░░░░░░░░░ 40%
```

---

## ✅ Checklist de Configuración

Después de ejecutar los scripts, verifica:

- [ ] GitHub Discussions habilitado con 6 categorías
- [ ] Discusión de bienvenida creada y pinned
- [ ] FAQ creado en Q&A
- [ ] GitHub Pages habilitado (Source: GitHub Actions)
- [ ] Documentación deployada y accesible
- [ ] 7 secretos de Azure configurados (si aplica)
- [ ] Branch Protection activo en main
- [ ] Codecov integrado y badge funcionando

---

## 🔧 Troubleshooting

### Script no se ejecuta

```powershell
# Habilitar ejecución de scripts (una vez)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### VS Code no se abre

Asegúrate de que `code` esté en el PATH:
```powershell
# Probar comando
code --version
```

### Navegador no se abre

Los scripts usan `Start-Process` que debería funcionar con el navegador predeterminado. Si falla, copia las URLs manualmente del output del script.

---

## 📚 Documentación Relacionada

- [OPTIONAL_STEPS_COMPLETED.md](../OPTIONAL_STEPS_COMPLETED.md) - Resumen completo
- [SECRETS_SETUP.md](../SECRETS_SETUP.md) - Configuración de Azure
- [BRANCH_PROTECTION.md](../BRANCH_PROTECTION.md) - Protección de ramas
- [GITHUB_DISCUSSIONS.md](../GITHUB_DISCUSSIONS.md) - Guía completa de Discussions

---

## 🎉 Resultado Final

Después de ejecutar todos los scripts, tu repositorio tendrá:

✅ **14 badges** en README  
✅ **6 workflows** (3 CI + 3 Deploy)  
✅ **GitHub Discussions** con comunidad activa  
✅ **GitHub Pages** con documentación profesional  
✅ **Azure Deployment** listo (staging + production)  
✅ **Branch Protection** para código seguro  
✅ **Code Coverage** con Codecov integrado  

**🎯 Nivel alcanzado**: Enterprise-Level Repository

---

## 💡 Tips

1. **Ejecuta en horario tranquilo**: Algunos pasos requieren recursos de Azure
2. **Ten credenciales listas**: Azure CLI autenticado
3. **Lee las guías primero**: Entiende cada paso antes de ejecutar
4. **Toma capturas**: Documenta tu configuración para referencia futura
5. **Pide ayuda en Discussions**: Si algo falla, pregunta a la comunidad

---

**Creado por**: Sistema automatizado de DevOps  
**Última actualización**: Noviembre 2025  
**Mantenedor**: @CSA-DanielVillamizar

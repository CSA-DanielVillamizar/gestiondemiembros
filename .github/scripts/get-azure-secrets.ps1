# Script para extraer secrets de Azure y configurarlos en GitHub
# Este script debe ejecutarse DESPUÉS de setup-azure-simple.ps1
#
# Uso:
#   .\get-azure-secrets.ps1 -Env staging
#   .\get-azure-secrets.ps1 -RG "mi-resource-group" -Repo "usuario/repo" -Env production

param(
    [string]$RG = "lama-medellin-rg",
    [string]$Repo = "CSA-DanielVillamizar/gestiondemiembros",
    [ValidateSet("staging","production","both")]
    [string]$Env = "staging"
)

Write-Host "`n=== EXTRAYENDO SECRETS DE AZURE ===" -ForegroundColor Cyan
Write-Host ""

# Verificar que el usuario está logueado en Azure
Write-Host "Verificando sesión de Azure..." -ForegroundColor Yellow
$currentAccount = az account show --query "{Name:name, ID:id}" -o json 2>$null | ConvertFrom-Json

if (-not $currentAccount) {
    Write-Host "ERROR: No hay sesión activa de Azure" -ForegroundColor Red
    Write-Host "Ejecuta primero: .\setup-azure-simple.ps1" -ForegroundColor Yellow
    exit 1
}

Write-Host "OK: Conectado a suscripción '$($currentAccount.Name)'" -ForegroundColor Green
Write-Host "   ID: $($currentAccount.ID)" -ForegroundColor Gray
Write-Host ""

# Verificar que el usuario está logueado en GitHub CLI
Write-Host "Verificando sesión de GitHub CLI..." -ForegroundColor Yellow
$ghStatus = gh auth status 2>&1

if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: No hay sesión activa de GitHub CLI" -ForegroundColor Red
    Write-Host "Ejecuta: gh auth login" -ForegroundColor Yellow
    exit 1
}

Write-Host "OK: GitHub CLI autenticado" -ForegroundColor Green
Write-Host ""

# Verificar que el Resource Group existe
Write-Host "Verificando Resource Group '$RG'..." -ForegroundColor Yellow
$rgExists = az group exists --name $RG

if ($rgExists -eq "false") {
    Write-Host "ERROR: El Resource Group '$RG' no existe" -ForegroundColor Red
    Write-Host "Ejecuta primero: .\setup-azure-simple.ps1" -ForegroundColor Yellow
    exit 1
}

Write-Host "OK: Resource Group encontrado" -ForegroundColor Green
Write-Host ""

# Función para configurar secret en GitHub
function Set-GitHubSecret {
    param($Name, $Value)

    if (-not $Value) {
        Write-Host "ERROR: Secret $Name está vacío" -ForegroundColor Red
        return $false
    }

    $tempFile = [System.IO.Path]::GetTempFileName()
    Set-Content -Path $tempFile -Value $Value -NoNewline

    try {
        gh secret set $Name --repo $Repo --body $Value 2>$null
        if ($LASTEXITCODE -eq 0) {
            Write-Host "OK: Secret $Name configurado" -ForegroundColor Green
            return $true
        } else {
            Write-Host "ERROR: No se pudo configurar $Name" -ForegroundColor Red
            return $false
        }
    } finally {
        Remove-Item $tempFile -ErrorAction SilentlyContinue
    }
}

# STAGING
if ($Env -eq "staging" -or $Env -eq "both") {
    Write-Host ""
    Write-Host "=== CONFIGURANDO SECRETS DE STAGING ===" -ForegroundColor Yellow
    Write-Host ""

    # 1. Publish Profile - Backend Staging
    Write-Host "1. Extrayendo publish profile (backend staging)..." -ForegroundColor Yellow
    Write-Host "   Recurso: lama-medellin-api-staging" -ForegroundColor Gray
    
    $publishProfile = az webapp deployment list-publishing-profiles --name "lama-medellin-api-staging" --resource-group $RG --xml 2>$null
    
    if ($LASTEXITCODE -ne 0 -or -not $publishProfile) {
        Write-Host "ERROR: No se pudo extraer el publish profile" -ForegroundColor Red
        Write-Host "NOTA: Si hay problemas con certificados SSL, descarga el perfil desde Azure Portal" -ForegroundColor Yellow
    } else {
        Set-GitHubSecret -Name "AZURE_WEBAPP_PUBLISH_PROFILE_STAGING" -Value $publishProfile
    }

    # 2. API Token - Frontend Staging
    Write-Host "2. Extrayendo API token (frontend staging)..." -ForegroundColor Yellow
    Write-Host "   Recurso: lama-medellin-frontend-staging" -ForegroundColor Gray
    
    $apiToken = az staticwebapp secrets list --name "lama-medellin-frontend-staging" --resource-group $RG --query "properties.apiKey" -o tsv 2>$null
    
    if ($LASTEXITCODE -ne 0 -or -not $apiToken) {
        Write-Host "ERROR: No se pudo extraer el API token" -ForegroundColor Red
    } else {
        Set-GitHubSecret -Name "AZURE_STATIC_WEB_APPS_API_TOKEN_STAGING" -Value $apiToken
    }

    # 3. Backend URL
    Write-Host "3. Configurando backend URL..." -ForegroundColor Yellow
    
    $backendUrl = az webapp show --name "lama-medellin-api-staging" --resource-group $RG --query "defaultHostName" -o tsv 2>$null
    
    if ($LASTEXITCODE -ne 0 -or -not $backendUrl) {
        Write-Host "ERROR: No se pudo obtener la URL del backend" -ForegroundColor Red
    } else {
        Write-Host "   URL: https://$backendUrl/api" -ForegroundColor Gray
        Set-GitHubSecret -Name "VITE_API_BASE_URL_STAGING" -Value "https://$backendUrl/api"
    }
}

# PRODUCTION
if ($Env -eq "production" -or $Env -eq "both") {
    Write-Host ""
    Write-Host "=== CONFIGURANDO SECRETS DE PRODUCTION ===" -ForegroundColor Green
    Write-Host ""

    # 1. Publish Profile - Backend Production
    Write-Host "1. Extrayendo publish profile (backend production)..." -ForegroundColor Yellow
    Write-Host "   Recurso: lama-medellin-api" -ForegroundColor Gray
    
    $publishProfile = az webapp deployment list-publishing-profiles --name "lama-medellin-api" --resource-group $RG --xml 2>$null
    
    if ($LASTEXITCODE -ne 0 -or -not $publishProfile) {
        Write-Host "ERROR: No se pudo extraer el publish profile" -ForegroundColor Red
        Write-Host "NOTA: Si hay problemas con certificados SSL, descarga el perfil desde Azure Portal" -ForegroundColor Yellow
    } else {
        Set-GitHubSecret -Name "AZURE_WEBAPP_PUBLISH_PROFILE_PRODUCTION" -Value $publishProfile
    }

    # 2. API Token - Frontend Production
    Write-Host "2. Extrayendo API token (frontend production)..." -ForegroundColor Yellow
    Write-Host "   Recurso: lama-medellin-frontend" -ForegroundColor Gray
    
    $apiToken = az staticwebapp secrets list --name "lama-medellin-frontend" --resource-group $RG --query "properties.apiKey" -o tsv 2>$null
    
    if ($LASTEXITCODE -ne 0 -or -not $apiToken) {
        Write-Host "ERROR: No se pudo extraer el API token" -ForegroundColor Red
    } else {
        Set-GitHubSecret -Name "AZURE_STATIC_WEB_APPS_API_TOKEN_PRODUCTION" -Value $apiToken
    }

    # 3. Backend URL
    Write-Host "3. Configurando backend URL..." -ForegroundColor Yellow
    
    $backendUrl = az webapp show --name "lama-medellin-api" --resource-group $RG --query "defaultHostName" -o tsv 2>$null
    
    if ($LASTEXITCODE -ne 0 -or -not $backendUrl) {
        Write-Host "ERROR: No se pudo obtener la URL del backend" -ForegroundColor Red
    } else {
        Write-Host "   URL: https://$backendUrl/api" -ForegroundColor Gray
        Set-GitHubSecret -Name "VITE_API_BASE_URL_PRODUCTION" -Value "https://$backendUrl/api"
    }
}

Write-Host ""
Write-Host "=== COMPLETADO ===" -ForegroundColor Green
Write-Host ""
Write-Host "Secrets configurados en el repositorio: $Repo" -ForegroundColor White
Write-Host ""
Write-Host "VERIFICAR SECRETS:" -ForegroundColor Cyan
Write-Host "   gh secret list --repo $Repo" -ForegroundColor Yellow
Write-Host ""
Write-Host "SIGUIENTE PASO:" -ForegroundColor Cyan
Write-Host "   Ejecuta los workflows de GitHub Actions para deployar" -ForegroundColor White
Write-Host "   gh workflow run deploy-backend.yml -f environment=staging" -ForegroundColor Yellow
Write-Host "   gh workflow run deploy-frontend.yml -f environment=staging" -ForegroundColor Yellow
Write-Host ""

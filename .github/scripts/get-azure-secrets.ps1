# Script para extraer secrets de Azure
param(
    [string]$RG = "lama-medellin-rg",
    [string]$Repo = "CSA-DanielVillamizar/gestiondemiembros",
    [ValidateSet("staging","production","both")]
    [string]$Env = "staging"
)

Write-Host "=== EXTRAYENDO SECRETS DE AZURE ===" -ForegroundColor Cyan

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
    Write-Host "=== STAGING ===" -ForegroundColor Yellow

    # 1. Publish Profile - Backend Staging
    Write-Host "1. Extrayendo publish profile (backend)..." -ForegroundColor Yellow
    $publishProfile = az webapp deployment list-publishing-profiles --name "lama-medellin-api-staging" --resource-group $RG --xml 2>$null
    Set-GitHubSecret -Name "AZURE_WEBAPP_PUBLISH_PROFILE_STAGING" -Value $publishProfile

    # 2. API Token - Frontend Staging
    Write-Host "2. Extrayendo API token (frontend)..." -ForegroundColor Yellow
    $apiToken = az staticwebapp secrets list --name "lama-medellin-frontend-staging" --resource-group $RG --query "properties.apiKey" -o tsv 2>$null
    Set-GitHubSecret -Name "AZURE_STATIC_WEB_APPS_API_TOKEN_STAGING" -Value $apiToken

    # 3. Backend URL
    Write-Host "3. Configurando backend URL..." -ForegroundColor Yellow
    $backendUrl = az webapp show --name "lama-medellin-api-staging" --resource-group $RG --query "defaultHostName" -o tsv 2>$null
    Set-GitHubSecret -Name "VITE_API_BASE_URL_STAGING" -Value "https://$backendUrl/api"
}

# PRODUCTION
if ($Env -eq "production" -or $Env -eq "both") {
    Write-Host ""
    Write-Host "=== PRODUCTION ===" -ForegroundColor Green

    # 1. Publish Profile - Backend Production
    Write-Host "1. Extrayendo publish profile (backend)..." -ForegroundColor Yellow
    $publishProfile = az webapp deployment list-publishing-profiles --name "lama-medellin-api" --resource-group $RG --xml 2>$null
    Set-GitHubSecret -Name "AZURE_WEBAPP_PUBLISH_PROFILE_PRODUCTION" -Value $publishProfile

    # 2. API Token - Frontend Production
    Write-Host "2. Extrayendo API token (frontend)..." -ForegroundColor Yellow
    $apiToken = az staticwebapp secrets list --name "lama-medellin-frontend" --resource-group $RG --query "properties.apiKey" -o tsv 2>$null
    Set-GitHubSecret -Name "AZURE_STATIC_WEB_APPS_API_TOKEN_PRODUCTION" -Value $apiToken

    # 3. Backend URL
    Write-Host "3. Configurando backend URL..." -ForegroundColor Yellow
    $backendUrl = az webapp show --name "lama-medellin-api" --resource-group $RG --query "defaultHostName" -o tsv 2>$null
    Set-GitHubSecret -Name "VITE_API_BASE_URL_PRODUCTION" -Value "https://$backendUrl/api"
}

Write-Host ""
Write-Host "=== COMPLETADO ===" -ForegroundColor Green
Write-Host "Verifica los secrets con: gh secret list --repo $Repo" -ForegroundColor Cyan

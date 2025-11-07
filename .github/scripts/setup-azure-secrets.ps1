# Script para obtener los secrets/tokens de Azure y configurarlos en GitHub
# Ejecutar DESPUÉS de setup-azure-resources.ps1

param(
    [string]$ResourceGroup = "lama-medellin-rg",
    [string]$EnvironmentType = "both" # staging, production, o both
)

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  AZURE SECRETS EXTRACTOR" -ForegroundColor Green
Write-Host "========================================`n" -ForegroundColor Cyan

# Verificar que gh CLI esté instalado
Write-Host "1. Verificando GitHub CLI..." -ForegroundColor Cyan
$ghVersion = gh --version 2>&1 | Select-String "gh version"
if ($LASTEXITCODE -ne 0) {
    Write-Host "   ✗ GitHub CLI no está instalado" -ForegroundColor Red
    Write-Host "   Instala desde: https://cli.github.com/`n" -ForegroundColor Yellow
    exit 1
}
Write-Host "   ✓ $ghVersion`n" -ForegroundColor Green

# Crear directorio temporal para secrets
$tempDir = Join-Path $env:TEMP "lama-azure-secrets"
if (-not (Test-Path $tempDir)) {
    New-Item -ItemType Directory -Path $tempDir | Out-Null
}

Write-Host "2. Extrayendo secrets de Azure...`n" -ForegroundColor Cyan

$secrets = @{}

# Backend - Publish Profiles
if ($EnvironmentType -eq "staging" -or $EnvironmentType -eq "both") {
    Write-Host "   → Backend Staging Publish Profile..." -ForegroundColor White
    $profile = az webapp deployment list-publishing-profiles --name "lama-medellin-api-staging" --resource-group $ResourceGroup --xml 2>&1
    
    if ($LASTEXITCODE -eq 0) {
        $secrets["AZURE_WEBAPP_PUBLISH_PROFILE_STAGING"] = $profile
        Write-Host "   ✓ Obtenido" -ForegroundColor Green
    } else {
        Write-Host "   ✗ Error al obtener publish profile" -ForegroundColor Red
    }
}

if ($EnvironmentType -eq "production" -or $EnvironmentType -eq "both") {
    Write-Host "   → Backend Production Publish Profile..." -ForegroundColor White
    $profile = az webapp deployment list-publishing-profiles --name "lama-medellin-api" --resource-group $ResourceGroup --xml 2>&1
    
    if ($LASTEXITCODE -eq 0) {
        $secrets["AZURE_WEBAPP_PUBLISH_PROFILE_PRODUCTION"] = $profile
        Write-Host "   ✓ Obtenido" -ForegroundColor Green
    } else {
        Write-Host "   ✗ Error al obtener publish profile" -ForegroundColor Red
    }
}

# Frontend - Static Web App Tokens
if ($EnvironmentType -eq "staging" -or $EnvironmentType -eq "both") {
    Write-Host "   → Frontend Staging API Token..." -ForegroundColor White
    $token = az staticwebapp secrets list --name "lama-medellin-frontend-staging" --resource-group $ResourceGroup --query "properties.apiKey" -o tsv 2>&1
    
    if ($LASTEXITCODE -eq 0) {
        $secrets["AZURE_STATIC_WEB_APPS_API_TOKEN_STAGING"] = $token
        Write-Host "   ✓ Obtenido" -ForegroundColor Green
    } else {
        Write-Host "   ✗ Error al obtener token" -ForegroundColor Red
    }
}

if ($EnvironmentType -eq "production" -or $EnvironmentType -eq "both") {
    Write-Host "   → Frontend Production API Token..." -ForegroundColor White
    $token = az staticwebapp secrets list --name "lama-medellin-frontend" --resource-group $ResourceGroup --query "properties.apiKey" -o tsv 2>&1
    
    if ($LASTEXITCODE -eq 0) {
        $secrets["AZURE_STATIC_WEB_APPS_API_TOKEN_PRODUCTION"] = $token
        Write-Host "   ✓ Obtenido" -ForegroundColor Green
    } else {
        Write-Host "   ✗ Error al obtener token" -ForegroundColor Red
    }
}

# Backend URLs
if ($EnvironmentType -eq "staging" -or $EnvironmentType -eq "both") {
    Write-Host "   → Backend Staging URL..." -ForegroundColor White
    $url = az webapp show --name "lama-medellin-api-staging" --resource-group $ResourceGroup --query "defaultHostName" -o tsv 2>&1
    
    if ($LASTEXITCODE -eq 0) {
        $secrets["VITE_API_BASE_URL_STAGING"] = "https://$url/api"
        Write-Host "   ✓ URL: https://$url/api" -ForegroundColor Green
    } else {
        Write-Host "   ✗ Error al obtener URL" -ForegroundColor Red
    }
}

if ($EnvironmentType -eq "production" -or $EnvironmentType -eq "both") {
    Write-Host "   → Backend Production URL..." -ForegroundColor White
    $url = az webapp show --name "lama-medellin-api" --resource-group $ResourceGroup --query "defaultHostName" -o tsv 2>&1
    
    if ($LASTEXITCODE -eq 0) {
        $secrets["VITE_API_BASE_URL_PRODUCTION"] = "https://$url/api"
        Write-Host "   ✓ URL: https://$url/api" -ForegroundColor Green
    } else {
        Write-Host "   ✗ Error al obtener URL" -ForegroundColor Red
    }
}

Write-Host ""

# Configurar secrets en GitHub
Write-Host "3. Configurando secrets en GitHub...`n" -ForegroundColor Cyan

$successCount = 0
$failCount = 0

foreach ($secretName in $secrets.Keys) {
    Write-Host "   → Configurando $secretName..." -ForegroundColor White
    
    # Guardar en archivo temporal
    $secretFile = Join-Path $tempDir "$secretName.txt"
    $secrets[$secretName] | Out-File -FilePath $secretFile -NoNewline -Encoding utf8
    
    # Configurar en GitHub
    $result = Get-Content $secretFile | gh secret set $secretName 2>&1
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "   ✓ Configurado" -ForegroundColor Green
        $successCount++
    } else {
        Write-Host "   ✗ Error: $result" -ForegroundColor Red
        $failCount++
    }
    
    # Eliminar archivo temporal
    Remove-Item $secretFile -Force
}

# Limpiar directorio temporal
Remove-Item $tempDir -Recurse -Force

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  RESUMEN" -ForegroundColor Green
Write-Host "========================================`n" -ForegroundColor Cyan

Write-Host "✅ Secrets configurados: $successCount" -ForegroundColor Green
if ($failCount -gt 0) {
    Write-Host "✗ Secrets fallidos: $failCount" -ForegroundColor Red
}

Write-Host "`n📋 Secrets configurados:" -ForegroundColor Cyan
foreach ($secretName in $secrets.Keys) {
    Write-Host "   ✓ $secretName" -ForegroundColor Green
}

Write-Host "`n========================================`n" -ForegroundColor Cyan

if ($failCount -eq 0) {
    Write-Host "🎉 ¡Configuración completada!" -ForegroundColor Green
    Write-Host "`nSiguientes pasos:" -ForegroundColor Cyan
    Write-Host "   1. Verifica los secrets: gh secret list" -ForegroundColor White
    Write-Host "   2. Haz un push para triggerar deployment" -ForegroundColor White
    Write-Host "   3. Monitorea en: GitHub Actions → Deploy workflows`n" -ForegroundColor White
} else {
    Write-Host "⚠️ Algunos secrets no se configuraron correctamente" -ForegroundColor Yellow
    Write-Host "   Revisa los errores y configura manualmente si es necesario`n" -ForegroundColor White
}

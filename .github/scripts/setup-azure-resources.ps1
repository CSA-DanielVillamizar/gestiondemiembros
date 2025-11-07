# Script de configuración de recursos de Azure para L.A.M.A. Medellín
# Este script crea todos los recursos necesarios para el deployment

param(
    [string]$ResourceGroup = "lama-medellin-rg",
    [string]$Location = "eastus",
    [string]$EnvironmentType = "both" # staging, production, o both
)

Write-Host ""
Write-Host "========================================"  -ForegroundColor Cyan
Write-Host "  AZURE RESOURCES SETUP" -ForegroundColor Green
Write-Host "========================================"  -ForegroundColor Cyan
Write-Host ""

# Verificar login
Write-Host "1. Verificando login de Azure..." -ForegroundColor Cyan
$account = az account show --query "name" -o tsv 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "   ✗ No estás logueado en Azure" -ForegroundColor Red
    Write-Host "   Ejecuta: az login" -ForegroundColor Yellow
    Write-Host ""
    exit 1
}
Write-Host "   ✓ Cuenta: $account" -ForegroundColor Green
Write-Host ""

# Crear Resource Group
Write-Host "2. Creando Resource Group..." -ForegroundColor Cyan
$rgExists = az group exists --name $ResourceGroup
if ($rgExists -eq "true") {
    Write-Host "   ℹ Resource Group ya existe: $ResourceGroup" -ForegroundColor Yellow
} else {
    az group create --name $ResourceGroup --location $Location --output none
    if ($LASTEXITCODE -eq 0) {
        Write-Host "   ✓ Resource Group creado: $ResourceGroup" -ForegroundColor Green
    } else {
        Write-Host "   ✗ Error al crear Resource Group" -ForegroundColor Red
        exit 1
    }
}
Write-Host ""

# Crear App Service Plan
Write-Host "3. Creando App Service Plan..." -ForegroundColor Cyan
$planName = "lama-medellin-plan"
$planExists = az appservice plan show --name $planName --resource-group $ResourceGroup 2>&1
if ($LASTEXITCODE -eq 0) {
    Write-Host "   ℹ App Service Plan ya existe: $planName" -ForegroundColor Yellow
} else {
    az appservice plan create --name $planName --resource-group $ResourceGroup --sku B1 --is-linux --output none
    if ($LASTEXITCODE -eq 0) {
        Write-Host "   ✓ App Service Plan creado: $planName (B1 - Linux)" -ForegroundColor Green
    } else {
        Write-Host "   ✗ Error al crear App Service Plan" -ForegroundColor Red
        exit 1
    }
}
Write-Host ""

# Función para crear App Service
function Create-AppService {
    param($Name, $Runtime)

    $exists = az webapp show --name $Name --resource-group $ResourceGroup 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "   ℹ App Service ya existe: $Name" -ForegroundColor Yellow
        return $true
    } else {
        Write-Host "   → Creando App Service: $Name..." -ForegroundColor White
        az webapp create --name $Name --resource-group $ResourceGroup --plan $planName --runtime $Runtime --output none

        if ($LASTEXITCODE -eq 0) {
            Write-Host "   ✓ App Service creado: $Name" -ForegroundColor Green
            return $true
        } else {
            Write-Host "   ✗ Error al crear App Service: $Name" -ForegroundColor Red
            return $false
        }
    }
}

# Crear Backend App Services
Write-Host "4. Creando Backend App Services..." -ForegroundColor Cyan

if ($EnvironmentType -eq "staging" -or $EnvironmentType -eq "both") {
    $success = Create-AppService -Name "lama-medellin-api-staging" -Runtime "DOTNET:8.0"
    if (-not $success) { exit 1 }
}

if ($EnvironmentType -eq "production" -or $EnvironmentType -eq "both") {
    $success = Create-AppService -Name "lama-medellin-api" -Runtime "DOTNET:8.0"
    if (-not $success) { exit 1 }
}
Write-Host ""

# Función para crear Static Web App
function Create-StaticWebApp {
    param($Name)

    $exists = az staticwebapp show --name $Name --resource-group $ResourceGroup 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "   ℹ Static Web App ya existe: $Name" -ForegroundColor Yellow
        return $true
    } else {
        Write-Host "   → Creando Static Web App: $Name..." -ForegroundColor White
        az staticwebapp create --name $Name --resource-group $ResourceGroup --location "eastus2" --output none

        if ($LASTEXITCODE -eq 0) {
            Write-Host "   ✓ Static Web App creada: $Name" -ForegroundColor Green
            return $true
        } else {
            Write-Host "   ✗ Error al crear Static Web App: $Name" -ForegroundColor Red
            return $false
        }
    }
}

# Crear Frontend Static Web Apps
Write-Host "5. Creando Frontend Static Web Apps..." -ForegroundColor Cyan

if ($EnvironmentType -eq "staging" -or $EnvironmentType -eq "both") {
    $success = Create-StaticWebApp -Name "lama-medellin-frontend-staging"
    if (-not $success) { exit 1 }
}

if ($EnvironmentType -eq "production" -or $EnvironmentType -eq "both") {
    $success = Create-StaticWebApp -Name "lama-medellin-frontend"
    if (-not $success) { exit 1 }
}
Write-Host ""


Write-Host "========================================"  -ForegroundColor Cyan
Write-Host "  ✅ RECURSOS CREADOS" -ForegroundColor Green
Write-Host "========================================"  -ForegroundColor Cyan
Write-Host ""

Write-Host "📦 Resource Group:" -ForegroundColor Cyan
Write-Host "   $ResourceGroup ($Location)" -ForegroundColor White
Write-Host ""

Write-Host "🖥️ App Service Plan:" -ForegroundColor Cyan
Write-Host "   $planName (B1 - Linux)" -ForegroundColor White
Write-Host ""

if ($EnvironmentType -eq "staging" -or $EnvironmentType -eq "both") {
    Write-Host "🔧 Staging:" -ForegroundColor Yellow
    Write-Host "   Backend:  lama-medellin-api-staging" -ForegroundColor White
    Write-Host "   Frontend: lama-medellin-frontend-staging" -ForegroundColor White
    Write-Host ""
}

if ($EnvironmentType -eq "production" -or $EnvironmentType -eq "both") {
    Write-Host "🚀 Production:" -ForegroundColor Green
    Write-Host "   Backend:  lama-medellin-api" -ForegroundColor White
    Write-Host "   Frontend: lama-medellin-frontend" -ForegroundColor White
    Write-Host ""
}

Write-Host "========================================"  -ForegroundColor Cyan
Write-Host ""
Write-Host "✅ Recursos creados exitosamente!" -ForegroundColor Green
Write-Host ""
Write-Host "Siguientes pasos:" -ForegroundColor Cyan
Write-Host "   1. Ejecuta: .\setup-azure-secrets.ps1" -ForegroundColor White
Write-Host "   2. Configura los secrets en GitHub" -ForegroundColor White
Write-Host "   3. Haz push para triggerar deployment" -ForegroundColor White
Write-Host ""

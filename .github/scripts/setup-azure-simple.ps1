# Script simplificado de configuración de Azure
param(
    [string]$RG = "lama-medellin-rg",
    [string]$Location = "eastus",
    [ValidateSet("staging","production","both")]
    [string]$Env = "staging"
)

Write-Host "=== AZURE SETUP ===" -ForegroundColor Cyan

# 1. Verificar login
Write-Host "1. Verificando Azure login..." -ForegroundColor Yellow
$account = az account show --query "name" -o tsv 2>$null
if (-not $account) {
    Write-Host "ERROR: No estás logueado. Ejecuta: az login" -ForegroundColor Red
    exit 1
}
Write-Host "OK: Cuenta $account" -ForegroundColor Green

# 2. Crear Resource Group
Write-Host "2. Creando Resource Group..." -ForegroundColor Yellow
az group create --name $RG --location $Location --output none
Write-Host "OK: Resource Group creado" -ForegroundColor Green

# 3. Crear App Service Plan
Write-Host "3. Creando App Service Plan..." -ForegroundColor Yellow
az appservice plan create --name "lama-medellin-plan" --resource-group $RG --sku B1 --is-linux --output none
Write-Host "OK: App Service Plan creado" -ForegroundColor Green

# 4. Crear Backend Staging
if ($Env -eq "staging" -or $Env -eq "both") {
    Write-Host "4. Creando Backend Staging..." -ForegroundColor Yellow
    az webapp create --name "lama-medellin-api-staging" --resource-group $RG --plan "lama-medellin-plan" --runtime "DOTNET:8.0" --output none
    Write-Host "OK: Backend Staging creado" -ForegroundColor Green
}

# 5. Crear Frontend Staging
if ($Env -eq "staging" -or $Env -eq "both") {
    Write-Host "5. Creando Frontend Staging..." -ForegroundColor Yellow
    az staticwebapp create --name "lama-medellin-frontend-staging" --resource-group $RG --location "eastus2" --output none
    Write-Host "OK: Frontend Staging creado" -ForegroundColor Green
}

# 6. Crear Backend Production
if ($Env -eq "production" -or $Env -eq "both") {
    Write-Host "6. Creando Backend Production..." -ForegroundColor Yellow
    az webapp create --name "lama-medellin-api" --resource-group $RG --plan "lama-medellin-plan" --runtime "DOTNET:8.0" --output none
    Write-Host "OK: Backend Production creado" -ForegroundColor Green
}

# 7. Crear Frontend Production
if ($Env -eq "production" -or $Env -eq "both") {
    Write-Host "7. Creando Frontend Production..." -ForegroundColor Yellow
    az staticwebapp create --name "lama-medellin-frontend" --resource-group $RG --location "eastus2" --output none
    Write-Host "OK: Frontend Production creado" -ForegroundColor Green
}

Write-Host ""
Write-Host "=== COMPLETADO ===" -ForegroundColor Green
Write-Host "Siguiente paso: .\setup-azure-secrets.ps1" -ForegroundColor Cyan

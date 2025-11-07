# Script simplificado de configuración de Azure
# Este script permite:
# - Login interactivo para cualquier tenant
# - Selección de suscripción
# - Creación de recursos Azure para el proyecto LAMA Medellín
#
# Uso:
#   .\setup-azure-simple.ps1 -Env staging
#   .\setup-azure-simple.ps1 -RG "mi-resource-group" -Location "eastus" -Env production

param(
    [string]$RG = "lama-medellin-rg",
    [string]$Location = "eastus",
    [ValidateSet("staging","production","both")]
    [string]$Env = "staging"
)

Write-Host "`n=== AZURE SETUP - LAMA MEDELLIN ===" -ForegroundColor Cyan
Write-Host ""

# 1. Verificar/Realizar login
Write-Host "PASO 1: Verificando Azure login..." -ForegroundColor Yellow
$account = az account show --query "name" -o tsv 2>$null

if (-not $account) {
    Write-Host "No hay sesión activa. Iniciando login interactivo..." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Se abrirá una ventana del navegador para autenticarte." -ForegroundColor White
    Write-Host "Inicia sesión con tu cuenta de Microsoft/Azure." -ForegroundColor White
    Write-Host ""
    
    az login
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host "ERROR: Login fallido" -ForegroundColor Red
        exit 1
    }
    
    Write-Host "OK: Login exitoso" -ForegroundColor Green
} else {
    Write-Host "OK: Ya hay sesión activa ($account)" -ForegroundColor Green
}

Write-Host ""

# 2. Listar y seleccionar suscripción
Write-Host "PASO 2: Seleccionando suscripción..." -ForegroundColor Yellow
Write-Host ""
Write-Host "Suscripciones disponibles:" -ForegroundColor Cyan
Write-Host ""

# Obtener lista de suscripciones
$subscriptions = az account list --query "[].{Number:to_string(row_number(@)), Name:name, ID:id, State:state}" -o json | ConvertFrom-Json

if ($subscriptions.Count -eq 0) {
    Write-Host "ERROR: No se encontraron suscripciones" -ForegroundColor Red
    exit 1
}

# Mostrar suscripciones
for ($i = 0; $i -lt $subscriptions.Count; $i++) {
    $sub = $subscriptions[$i]
    $current = az account show --query "id" -o tsv
    $marker = if ($sub.ID -eq $current) { " (actual)" } else { "" }
    Write-Host "  [$($i+1)] $($sub.Name)$marker" -ForegroundColor White
    Write-Host "      ID: $($sub.ID)" -ForegroundColor Gray
    Write-Host "      Estado: $($sub.State)" -ForegroundColor Gray
    Write-Host ""
}

# Solicitar selección
Write-Host "Selecciona el número de la suscripción a usar [1-$($subscriptions.Count)]: " -ForegroundColor Yellow -NoNewline
$selection = Read-Host

# Validar entrada
$selectionNum = 0
if (-not [int]::TryParse($selection, [ref]$selectionNum) -or $selectionNum -lt 1 -or $selectionNum -gt $subscriptions.Count) {
    Write-Host "ERROR: Selección inválida" -ForegroundColor Red
    exit 1
}

$selectedSub = $subscriptions[$selectionNum - 1]

# Establecer suscripción
Write-Host ""
Write-Host "Configurando suscripción: $($selectedSub.Name)..." -ForegroundColor Yellow
az account set --subscription $selectedSub.ID

if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: No se pudo establecer la suscripción" -ForegroundColor Red
    exit 1
}

Write-Host "OK: Suscripción configurada" -ForegroundColor Green
Write-Host "   Nombre: $($selectedSub.Name)" -ForegroundColor White
Write-Host "   ID: $($selectedSub.ID)" -ForegroundColor White
Write-Host ""

Write-Host ""

# 3. Crear Resource Group
Write-Host "PASO 3: Creando Resource Group..." -ForegroundColor Yellow
Write-Host "   Nombre: $RG" -ForegroundColor Gray
Write-Host "   Ubicación: $Location" -ForegroundColor Gray

az group create --name $RG --location $Location --output none

if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: No se pudo crear el Resource Group" -ForegroundColor Red
    exit 1
}

Write-Host "OK: Resource Group creado" -ForegroundColor Green
Write-Host ""

# 4. Crear App Service Plan
Write-Host "PASO 4: Creando App Service Plan..." -ForegroundColor Yellow
Write-Host "   Nombre: lama-medellin-plan" -ForegroundColor Gray
Write-Host "   SKU: B1 (Basic, ~13 USD/mes)" -ForegroundColor Gray

az appservice plan create --name "lama-medellin-plan" --resource-group $RG --sku B1 --is-linux --output none

if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: No se pudo crear el App Service Plan" -ForegroundColor Red
    exit 1
}

Write-Host "OK: App Service Plan creado" -ForegroundColor Green
Write-Host ""

# 5. Crear Backend Staging
if ($Env -eq "staging" -or $Env -eq "both") {
    Write-Host "PASO 5: Creando Backend Staging..." -ForegroundColor Yellow
    Write-Host "   Nombre: lama-medellin-api-staging" -ForegroundColor Gray
    Write-Host "   Runtime: .NET 8.0" -ForegroundColor Gray
    
    az webapp create --name "lama-medellin-api-staging" --resource-group $RG --plan "lama-medellin-plan" --runtime "DOTNETCORE:8.0" --output none
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host "ERROR: No se pudo crear el Backend Staging" -ForegroundColor Red
        exit 1
    }
    
    Write-Host "OK: Backend Staging creado" -ForegroundColor Green
    Write-Host ""
}

# 6. Crear Frontend Staging
if ($Env -eq "staging" -or $Env -eq "both") {
    Write-Host "PASO 6: Creando Frontend Staging..." -ForegroundColor Yellow
    Write-Host "   Nombre: lama-medellin-frontend-staging" -ForegroundColor Gray
    Write-Host "   Ubicación: East US 2" -ForegroundColor Gray
    
    az staticwebapp create --name "lama-medellin-frontend-staging" --resource-group $RG --location "eastus2" --output none
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host "ERROR: No se pudo crear el Frontend Staging" -ForegroundColor Red
        exit 1
    }
    
    Write-Host "OK: Frontend Staging creado" -ForegroundColor Green
    Write-Host ""
}

# 7. Crear Backend Production
if ($Env -eq "production" -or $Env -eq "both") {
    Write-Host "PASO 7: Creando Backend Production..." -ForegroundColor Yellow
    Write-Host "   Nombre: lama-medellin-api" -ForegroundColor Gray
    
    az webapp create --name "lama-medellin-api" --resource-group $RG --plan "lama-medellin-plan" --runtime "DOTNETCORE:8.0" --output none
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host "ERROR: No se pudo crear el Backend Production" -ForegroundColor Red
        exit 1
    }
    
    Write-Host "OK: Backend Production creado" -ForegroundColor Green
    Write-Host ""
}

# 8. Crear Frontend Production
if ($Env -eq "production" -or $Env -eq "both") {
    Write-Host "PASO 8: Creando Frontend Production..." -ForegroundColor Yellow
    Write-Host "   Nombre: lama-medellin-frontend" -ForegroundColor Gray
    
    az staticwebapp create --name "lama-medellin-frontend" --resource-group $RG --location "eastus2" --output none
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host "ERROR: No se pudo crear el Frontend Production" -ForegroundColor Red
        exit 1
    }
    
    Write-Host "OK: Frontend Production creado" -ForegroundColor Green
    Write-Host ""
}

Write-Host ""
Write-Host "=== COMPLETADO EXITOSAMENTE ===" -ForegroundColor Green
Write-Host ""
Write-Host "Recursos creados en:" -ForegroundColor Cyan
Write-Host "   Suscripción: $($selectedSub.Name)" -ForegroundColor White
Write-Host "   Resource Group: $RG" -ForegroundColor White
Write-Host "   Ubicación: $Location" -ForegroundColor White
Write-Host ""
Write-Host "SIGUIENTE PASO:" -ForegroundColor Cyan
Write-Host "   Ejecuta: .\.github\scripts\get-azure-secrets.ps1" -ForegroundColor Yellow
Write-Host "   Para configurar los GitHub Secrets necesarios" -ForegroundColor White
Write-Host ""

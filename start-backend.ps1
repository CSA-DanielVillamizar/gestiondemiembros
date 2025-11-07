# Script de arranque del Backend API - L.A.M.A. Medellin
# Ejecuta este script para levantar la API en modo desarrollo

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  L.A.M.A. Medellin - Backend API" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Navegar al directorio del API
$apiPath = Join-Path $PSScriptRoot "backend\src\LAMAMedellin.API"
Set-Location $apiPath

Write-Host "Ubicacion: $apiPath" -ForegroundColor Yellow
Write-Host ""

# Configurar variables de entorno
$env:ASPNETCORE_ENVIRONMENT = "Development"
$env:ASPNETCORE_URLS = "https://localhost:7001;http://localhost:5001"

Write-Host "🔧 Configurando entorno de desarrollo..." -ForegroundColor Green
Write-Host "   - Environment: Development" -ForegroundColor Gray
Write-Host "   - URLs: https://localhost:7001, http://localhost:5001" -ForegroundColor Gray
Write-Host ""

# Verificar LocalDB
Write-Host "Verificando SQL Server LocalDB..." -ForegroundColor Green
$localDbInfo = sqllocaldb info MSSQLLocalDB 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Host "   LocalDB no encontrado. Iniciando..." -ForegroundColor Yellow
    sqllocaldb start MSSQLLocalDB
} else {
    Write-Host "   LocalDB disponible" -ForegroundColor Gray
}
Write-Host ""

# Build del proyecto
Write-Host "Compilando proyecto..." -ForegroundColor Green
dotnet build -c Debug --nologo -v quiet
if ($LASTEXITCODE -ne 0) {
    Write-Host "   Error en la compilacion" -ForegroundColor Red
    Read-Host "Presiona Enter para salir"
    exit 1
}
Write-Host "   Compilacion exitosa" -ForegroundColor Gray
Write-Host ""

# Aplicar migraciones
Write-Host "Aplicando migraciones de base de datos..." -ForegroundColor Green
dotnet ef database update --project ..\LAMAMedellin.Infrastructure --startup-project . --no-build 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) {
    Write-Host "   Base de datos actualizada" -ForegroundColor Gray
} else {
    Write-Host "   Migraciones ya aplicadas o error menor" -ForegroundColor Yellow
}
Write-Host ""

# Mensaje de inicio
Write-Host "Iniciando API..." -ForegroundColor Green
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  ENDPOINTS DISPONIBLES:" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Swagger UI:    https://localhost:7001/swagger" -ForegroundColor White
Write-Host "  Health Check:  http://localhost:5001/health" -ForegroundColor White
Write-Host "  API Base:      https://localhost:7001/api" -ForegroundColor White
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Nota: La autenticacion esta deshabilitada en Development" -ForegroundColor Yellow
Write-Host "      Puedes probar todos los endpoints sin token JWT" -ForegroundColor Yellow
Write-Host ""
Write-Host "Presiona Ctrl+C para detener el servidor" -ForegroundColor Gray
Write-Host ""

# Ejecutar la API
dotnet run --no-build

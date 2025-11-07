# Script de arranque completo - L.A.M.A. Medellín
# Ejecuta backend y frontend en ventanas separadas

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  L.A.M.A. Medellín - Inicio Completo" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$rootPath = $PSScriptRoot

Write-Host "🚀 Iniciando aplicación completa..." -ForegroundColor Green
Write-Host ""

# Verificar que los scripts existen
$backendScript = Join-Path $rootPath "start-backend.ps1"
$frontendScript = Join-Path $rootPath "start-frontend.ps1"

if (-Not (Test-Path $backendScript)) {
    Write-Host "❌ No se encontró start-backend.ps1" -ForegroundColor Red
    Read-Host "Presiona Enter para salir"
    exit 1
}

if (-Not (Test-Path $frontendScript)) {
    Write-Host "❌ No se encontró start-frontend.ps1" -ForegroundColor Red
    Read-Host "Presiona Enter para salir"
    exit 1
}

# Iniciar backend en nueva ventana
Write-Host "📡 Abriendo Backend API en nueva terminal..." -ForegroundColor Yellow
Start-Process powershell -ArgumentList "-NoExit", "-ExecutionPolicy", "Bypass", "-File", "`"$backendScript`""
Write-Host "   ✅ Backend iniciado" -ForegroundColor Gray

# Esperar 5 segundos para que el backend inicie
Write-Host ""
Write-Host "⏳ Esperando que el backend inicie (5 segundos)..." -ForegroundColor Yellow
Start-Sleep -Seconds 5

# Iniciar frontend en nueva ventana
Write-Host ""
Write-Host "🌐 Abriendo Frontend React en nueva terminal..." -ForegroundColor Yellow
Start-Process powershell -ArgumentList "-NoExit", "-ExecutionPolicy", "Bypass", "-File", "`"$frontendScript`""
Write-Host "   ✅ Frontend iniciado" -ForegroundColor Gray

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  ✅ APLICACIÓN INICIADA" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "📚 Backend Swagger:  https://localhost:7001/swagger" -ForegroundColor White
Write-Host "🌐 Frontend App:     http://localhost:3000" -ForegroundColor White
Write-Host ""
Write-Host "Para detener los servicios, cierra las ventanas de terminal" -ForegroundColor Gray
Write-Host ""
Read-Host "Presiona Enter para cerrar esta ventana"

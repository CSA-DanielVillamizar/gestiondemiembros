# Script para iniciar toda la aplicación L.A.M.A. Medellín
# Autor: GitHub Copilot
# Fecha: Noviembre 2025

Write-Host "`n╔════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║     L.A.M.A. MEDELLÍN - SISTEMA DE GESTIÓN DE MIEMBROS   ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════════╝`n" -ForegroundColor Cyan

# Verificar si Node.js está instalado
Write-Host "🔍 Verificando dependencias..." -ForegroundColor Yellow
$nodeVersion = node --version 2>$null
if (-not $nodeVersion) {
    Write-Host "❌ Node.js no está instalado o no está en el PATH" -ForegroundColor Red
    Write-Host "   Por favor instala Node.js desde https://nodejs.org" -ForegroundColor Yellow
    exit 1
}
Write-Host "✅ Node.js $nodeVersion instalado" -ForegroundColor Green

# Verificar .NET
$dotnetVersion = dotnet --version 2>$null
if (-not $dotnetVersion) {
    Write-Host "❌ .NET SDK no está instalado" -ForegroundColor Red
    exit 1
}
Write-Host "✅ .NET SDK $dotnetVersion instalado" -ForegroundColor Green

# Detener procesos anteriores
Write-Host "`n🛑 Deteniendo procesos anteriores..." -ForegroundColor Yellow
Get-Process | Where-Object { $_.ProcessName -eq "dotnet" -or $_.ProcessName -eq "node" } | Stop-Process -Force -ErrorAction SilentlyContinue
Start-Sleep -Seconds 2

# Iniciar Backend
Write-Host "`n🚀 Iniciando Backend API..." -ForegroundColor Cyan
$backendPath = "c:\Users\DanielVillamizar\Miembros del capítulo\backend\src\LAMAMedellin.API"
Start-Process powershell -ArgumentList "-NoExit", "-Command", @"
`$env:ASPNETCORE_ENVIRONMENT='Development'
cd '$backendPath'
Write-Host '╔═══════════════════════════════════════════════════════╗' -ForegroundColor Green
Write-Host '║           BACKEND API - L.A.M.A. MEDELLÍN            ║' -ForegroundColor Green
Write-Host '╚═══════════════════════════════════════════════════════╝' -ForegroundColor Green
Write-Host ''
Write-Host '📡 URLs:' -ForegroundColor Cyan
Write-Host '   • API: http://localhost:5001' -ForegroundColor White
Write-Host '   • Swagger: http://localhost:5001/swagger' -ForegroundColor White
Write-Host '   • Health: http://localhost:5001/health' -ForegroundColor White
Write-Host ''
Write-Host '📊 Endpoints disponibles:' -ForegroundColor Yellow
Write-Host '   • GET  /api/Miembros - Lista de miembros' -ForegroundColor Gray
Write-Host '   • POST /api/Miembros - Crear miembro' -ForegroundColor Gray
Write-Host '   • GET  /api/Estadisticas/generales - Dashboard' -ForegroundColor Gray
Write-Host '   • POST /api/Seed/load - Cargar datos de prueba' -ForegroundColor Gray
Write-Host ''
Write-Host '⚙️  Iniciando servidor...' -ForegroundColor Cyan
dotnet run
"@

Start-Sleep -Seconds 3

# Iniciar Frontend
Write-Host "`n🎨 Iniciando Frontend React..." -ForegroundColor Cyan
$frontendPath = "c:\Users\DanielVillamizar\Miembros del capítulo\frontend"
Start-Process powershell -ArgumentList "-NoExit", "-Command", @"
`$env:Path = [System.Environment]::GetEnvironmentVariable('Path','Machine') + ';' + [System.Environment]::GetEnvironmentVariable('Path','User')
cd '$frontendPath'
Write-Host '╔═══════════════════════════════════════════════════════╗' -ForegroundColor Blue
Write-Host '║          FRONTEND WEB - L.A.M.A. MEDELLÍN            ║' -ForegroundColor Blue
Write-Host '╚═══════════════════════════════════════════════════════╝' -ForegroundColor Blue
Write-Host ''
Write-Host '🌐 URL: http://localhost:3000' -ForegroundColor Cyan
Write-Host '🔓 Modo: DESARROLLO (sin autenticación)' -ForegroundColor Yellow
Write-Host ''
Write-Host '📋 Funcionalidades:' -ForegroundColor Yellow
Write-Host '   • Dashboard con estadísticas y gráficos' -ForegroundColor Gray
Write-Host '   • Lista de miembros con filtros y búsqueda' -ForegroundColor Gray
Write-Host '   • Paginación completa' -ForegroundColor Gray
Write-Host '   • Gestión CRUD de miembros' -ForegroundColor Gray
Write-Host ''
Write-Host '⚙️  Iniciando servidor Vite...' -ForegroundColor Cyan
npm run dev
"@

# Esperar a que los servicios inicien
Write-Host "`n⏳ Esperando que los servicios inicien..." -ForegroundColor Yellow
Write-Host "   Backend: 15 segundos" -ForegroundColor Gray
Write-Host "   Frontend: 10 segundos" -ForegroundColor Gray
Start-Sleep -Seconds 15

# Verificar servicios
Write-Host "`n🔍 Verificando servicios..." -ForegroundColor Cyan

$backendOk = $false
$frontendOk = $false

try {
    $health = Invoke-RestMethod -Uri "http://localhost:5001/health" -TimeoutSec 5
    Write-Host "✅ Backend API respondiendo" -ForegroundColor Green
    $backendOk = $true
} catch {
    Write-Host "⚠️  Backend aún iniciando..." -ForegroundColor Yellow
}

try {
    $fe = Invoke-WebRequest -Uri "http://localhost:3000" -TimeoutSec 5 -UseBasicParsing
    Write-Host "✅ Frontend React respondiendo" -ForegroundColor Green
    $frontendOk = $true
} catch {
    Write-Host "⚠️  Frontend aún iniciando..." -ForegroundColor Yellow
}

if ($backendOk -and $frontendOk) {
    Write-Host "`n🎉 ¡SISTEMA LISTO!" -ForegroundColor Green
    Write-Host "═══════════════════════════════════════════════════════════" -ForegroundColor Cyan
    
    # Obtener estadísticas
    try {
        $stats = Invoke-RestMethod -Uri "http://localhost:5001/api/Estadisticas/generales"
        Write-Host "`n📊 ESTADO DEL SISTEMA:" -ForegroundColor Yellow
        Write-Host "   • Total miembros: $($stats.resumen.totalMiembros)" -ForegroundColor White
        Write-Host "   • Miembros activos: $($stats.resumen.miembrosActivos)" -ForegroundColor Green
        Write-Host "   • Comités activos: $($stats.resumen.totalComites)" -ForegroundColor Cyan
        Write-Host "   • Tasa de actividad: $($stats.resumen.tasaActividad)%" -ForegroundColor Yellow
    } catch {
        Write-Host "`n📊 Cargando estadísticas..." -ForegroundColor Gray
    }
    
    Write-Host "`n🌐 ABRIENDO APLICACIÓN..." -ForegroundColor Cyan
    Start-Sleep -Seconds 2
    Start-Process "http://localhost:3000"
    Start-Sleep -Seconds 1
    Start-Process "http://localhost:5001/swagger"
    
    Write-Host "`n╔════════════════════════════════════════════════════════════╗" -ForegroundColor Green
    Write-Host "║                    ¡TODO LISTO!                           ║" -ForegroundColor Green
    Write-Host "╚════════════════════════════════════════════════════════════╝" -ForegroundColor Green
    Write-Host "`n📱 ACCESOS RÁPIDOS:" -ForegroundColor Yellow
    Write-Host "   • Dashboard:        http://localhost:3000" -ForegroundColor White
    Write-Host "   • Lista Miembros:   http://localhost:3000/miembros" -ForegroundColor White
    Write-Host "   • Swagger API:      http://localhost:5001/swagger" -ForegroundColor White
    Write-Host "`n💡 TIPS:" -ForegroundColor Cyan
    Write-Host "   • Usa el Dashboard para ver estadísticas en tiempo real" -ForegroundColor Gray
    Write-Host "   • La lista de miembros tiene búsqueda y filtros avanzados" -ForegroundColor Gray
    Write-Host "   • Swagger permite probar la API directamente" -ForegroundColor Gray
    Write-Host "   • En desarrollo, la autenticación está deshabilitada" -ForegroundColor Gray
    
} else {
    Write-Host "`n⚠️  Los servicios están iniciando..." -ForegroundColor Yellow
    Write-Host "   Espera 30 segundos más y abre manualmente:" -ForegroundColor Gray
    Write-Host "   • Frontend: http://localhost:3000" -ForegroundColor White
    Write-Host "   • Backend:  http://localhost:5001/swagger" -ForegroundColor White
}

Write-Host "`n✨ Presiona cualquier tecla para salir..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

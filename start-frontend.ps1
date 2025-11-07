# Script de arranque del Frontend - L.A.M.A. Medellín
# Ejecuta este script para levantar la aplicación React en modo desarrollo

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  L.A.M.A. Medellín - Frontend React" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Navegar al directorio del frontend
$frontendPath = Join-Path $PSScriptRoot "frontend"
Set-Location $frontendPath

Write-Host "📍 Ubicación: $frontendPath" -ForegroundColor Yellow
Write-Host ""

# Verificar si existen node_modules
if (-Not (Test-Path "node_modules")) {
    Write-Host "📦 Instalando dependencias (primera vez)..." -ForegroundColor Green
    Write-Host "   Esto puede tomar algunos minutos..." -ForegroundColor Gray
    Write-Host ""
    npm install
    if ($LASTEXITCODE -ne 0) {
        Write-Host "   ❌ Error instalando dependencias" -ForegroundColor Red
        Read-Host "Presiona Enter para salir"
        exit 1
    }
    Write-Host "   ✅ Dependencias instaladas" -ForegroundColor Gray
    Write-Host ""
} else {
    Write-Host "✅ Dependencias ya instaladas" -ForegroundColor Gray
    Write-Host ""
}

# Verificar archivo .env.local
if (-Not (Test-Path ".env.local")) {
    Write-Host "⚠️  Creando archivo .env.local desde .env.example..." -ForegroundColor Yellow
    if (Test-Path ".env.example") {
        Copy-Item ".env.example" ".env.local"
        Write-Host "   ✅ Archivo .env.local creado" -ForegroundColor Gray
        Write-Host "   ℹ️  Edítalo con tus credenciales de Azure AD B2C si es necesario" -ForegroundColor Gray
    } else {
        Write-Host "   ⚠️  .env.example no encontrado" -ForegroundColor Yellow
    }
    Write-Host ""
}

# Mensaje de inicio
Write-Host "🚀 Iniciando servidor de desarrollo Vite..." -ForegroundColor Green
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  APLICACIÓN FRONTEND:" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  🌐 URL Local:     http://localhost:3000" -ForegroundColor White
Write-Host "  🔌 API Proxy:     https://localhost:7001/api" -ForegroundColor White
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "⚠️  Asegurate de que el backend este corriendo antes de usar la app" -ForegroundColor Yellow
Write-Host "   Ejecuta 'start-backend.ps1' en otra terminal" -ForegroundColor Yellow
Write-Host ""
Write-Host "📱 La aplicacion se abrira automaticamente en tu navegador" -ForegroundColor Gray
Write-Host "   Presiona Ctrl+C para detener el servidor" -ForegroundColor Gray
Write-Host ""

# Ejecutar Vite
npm run dev

# 🚀 Script de Configuración de GitHub Pages
# Este script te guiará para habilitar GitHub Pages

Write-Host "`n📚 Configuración de GitHub Pages - Guía Automatizada`n" -ForegroundColor Cyan

$repo = "CSA-DanielVillamizar/gestiondemiembros"
$baseUrl = "https://github.com/$repo"

Write-Host "🌐 Abriendo configuración de GitHub Pages...`n" -ForegroundColor Yellow

# Abrir página de Settings
Start-Process "$baseUrl/settings/pages"

Write-Host "✅ Página de configuración abierta`n" -ForegroundColor Green

Write-Host "`n📋 INSTRUCCIONES (1 minuto):`n" -ForegroundColor Cyan

Write-Host "1️⃣  En la página que se abrió:" -ForegroundColor White
Write-Host "   - Sección 'Build and deployment'" -ForegroundColor Gray
Write-Host "   - Source: Selecciona 'GitHub Actions' (no 'Deploy from a branch')" -ForegroundColor Gray
Write-Host "   - Click 'Save' si aparece`n" -ForegroundColor Gray

Write-Host "2️⃣  Trigger del primer deploy:" -ForegroundColor White
Write-Host "   - El workflow 'deploy-docs.yml' se ejecutará automáticamente" -ForegroundColor Gray
Write-Host "   - O puedes ejecutarlo manualmente desde Actions`n" -ForegroundColor Gray

Write-Host "3️⃣  Verificar deploy:" -ForegroundColor White
Write-Host "   - Ve a Actions → 'Deploy Documentation'" -ForegroundColor Gray
Write-Host "   - Espera que termine (1-2 minutos)" -ForegroundColor Gray
Write-Host "   - Tu documentación estará en:" -ForegroundColor Gray
Write-Host "     https://csa-danielvillamizar.github.io/gestiondemiembros/`n" -ForegroundColor Cyan

Write-Host "📝 NOTA:" -ForegroundColor Yellow
Write-Host "   - MkDocs ya está configurado (mkdocs.yml)" -ForegroundColor Gray
Write-Host "   - El workflow deploy-docs.yml ya existe" -ForegroundColor Gray
Write-Host "   - Solo falta habilitar Pages en Settings`n" -ForegroundColor Gray

Write-Host "`n🎯 Para trigger manual del workflow:" -ForegroundColor Cyan
Write-Host "   1. Ve a Actions → 'Deploy Documentation'" -ForegroundColor Gray
Write-Host "   2. Click 'Run workflow' → 'Run workflow'`n" -ForegroundColor Gray

Write-Host "⏱️  Tiempo estimado: 1 minuto de configuración + 2 minutos de deploy" -ForegroundColor Yellow

Write-Host "`n🎉 Cuando GitHub Pages esté habilitado, presiona ENTER..." -ForegroundColor Cyan
Read-Host

Write-Host "`n✅ ¡GitHub Pages configurado!`n" -ForegroundColor Green
Write-Host "📝 Siguiente paso: Configurar secretos de Azure (Paso 3)`n" -ForegroundColor Yellow

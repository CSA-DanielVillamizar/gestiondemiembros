# 🚀 Script de Configuración Rápida de GitHub Discussions
# Este script abrirá todas las páginas necesarias en tu navegador

Write-Host "`n🎯 Configuración de GitHub Discussions - Guía Automatizada`n" -ForegroundColor Cyan

# URLs del repositorio
$repo = "CSA-DanielVillamizar/gestiondemiembros"
$baseUrl = "https://github.com/$repo"

Write-Host "📂 Abriendo archivos de referencia en VS Code...`n" -ForegroundColor Yellow

# Abrir archivos de referencia en VS Code
code ".github/scripts/setup-discussions.md"
Start-Sleep -Seconds 1
code ".github/scripts/welcome-discussion-content.txt"

Write-Host "✅ Archivos de referencia abiertos en VS Code`n" -ForegroundColor Green

Write-Host "🌐 Abriendo páginas de GitHub en tu navegador...`n" -ForegroundColor Yellow

# Abrir página de Discussions
Start-Process "$baseUrl/discussions"
Start-Sleep -Seconds 2

Write-Host "`n📋 INSTRUCCIONES RÁPIDAS:`n" -ForegroundColor Cyan

Write-Host "1️⃣  CONFIGURAR CATEGORÍAS (2 minutos):" -ForegroundColor White
Write-Host "   - En la página que se abrió, click en ⚙️ 'Manage categories'" -ForegroundColor Gray
Write-Host "   - Crea las 6 categorías copiando de 'setup-discussions.md'" -ForegroundColor Gray
Write-Host "   - Categorías: Announcements, Ideas, Q&A, General, Show and Tell, Troubleshooting`n" -ForegroundColor Gray

Write-Host "2️⃣  CREAR DISCUSIÓN DE BIENVENIDA (1 minuto):" -ForegroundColor White
Write-Host "   - Click en 'New discussion'" -ForegroundColor Gray
Write-Host "   - Categoría: Announcements" -ForegroundColor Gray
Write-Host "   - Título: 🎉 ¡Bienvenidos a las Discusiones!" -ForegroundColor Gray
Write-Host "   - Contenido: Copia TODO de 'welcome-discussion-content.txt'" -ForegroundColor Gray
Write-Host "   - Después de crear: Click ⋯ → Pin discussion`n" -ForegroundColor Gray

Write-Host "3️⃣  CREAR FAQ (1 minuto):" -ForegroundColor White
Write-Host "   - Click en 'New discussion'" -ForegroundColor Gray
Write-Host "   - Categoría: Q&A" -ForegroundColor Gray
Write-Host "   - Título: 📚 Preguntas Frecuentes (FAQ)" -ForegroundColor Gray
Write-Host "   - Contenido: Copia de la sección 'Paso 3' en 'setup-discussions.md'`n" -ForegroundColor Gray

Write-Host "📁 Archivos de referencia abiertos en VS Code:" -ForegroundColor Cyan
Write-Host "   ✓ setup-discussions.md - Guía completa paso a paso" -ForegroundColor Green
Write-Host "   ✓ welcome-discussion-content.txt - Contenido listo para copiar`n" -ForegroundColor Green

Write-Host "⏱️  Tiempo estimado total: 5 minutos" -ForegroundColor Yellow
Write-Host "✨ ¡El badge ya está en el README!" -ForegroundColor Green

Write-Host "`n🎉 Cuando termines, presiona ENTER para continuar con el siguiente paso..." -ForegroundColor Cyan
Read-Host

Write-Host "`n✅ ¡Excelente! Discussions configurado.`n" -ForegroundColor Green
Write-Host "📝 Siguiente paso: Habilitar GitHub Pages (Paso 2)`n" -ForegroundColor Yellow

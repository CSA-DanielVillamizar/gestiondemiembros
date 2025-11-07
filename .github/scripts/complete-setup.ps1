# ✅ CHECKLIST COMPLETO - Pasos Manuales Pendientes
# Ejecuta este script para abrir todas las páginas y seguir las instrucciones

Write-Host "`n╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║                                                                ║" -ForegroundColor Cyan
Write-Host "║        ✅ CHECKLIST INTERACTIVO - PASOS MANUALES ✅            ║" -ForegroundColor Cyan
Write-Host "║                                                                ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════════════╝`n" -ForegroundColor Cyan

$completed = @()

# ============================================================================
# PASO 1: GITHUB DISCUSSIONS - CATEGORÍAS
# ============================================================================

Write-Host "╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Yellow
Write-Host "║  PASO 1.1: Crear Categorías en Discussions (2 min)            ║" -ForegroundColor Yellow
Write-Host "╚════════════════════════════════════════════════════════════════╝`n" -ForegroundColor Yellow

Write-Host "🌐 Abriendo página de Discussions..." -ForegroundColor Cyan
Start-Process "https://github.com/CSA-DanielVillamizar/gestiondemiembros/discussions"
Start-Sleep -Seconds 2

Write-Host "`n📋 INSTRUCCIONES:" -ForegroundColor White
Write-Host "1. Click en ⚙️ 'Manage categories' (esquina superior derecha)" -ForegroundColor Gray
Write-Host "2. Crea estas 6 categorías:" -ForegroundColor Gray
Write-Host "`n   📢 Announcements (Tipo: Announcement)" -ForegroundColor Magenta
Write-Host "      Descripción: Noticias oficiales y actualizaciones del proyecto`n" -ForegroundColor DarkGray
Write-Host "   💡 Ideas (Tipo: Open-ended discussion)" -ForegroundColor Magenta
Write-Host "      Descripción: Propuestas de nuevas características y mejoras`n" -ForegroundColor DarkGray
Write-Host "   ❓ Q&A (Tipo: Question / Answer)" -ForegroundColor Magenta
Write-Host "      Descripción: Preguntas técnicas sobre instalación y desarrollo`n" -ForegroundColor DarkGray
Write-Host "   💬 General (Tipo: Open-ended discussion)" -ForegroundColor Magenta
Write-Host "      Descripción: Conversación general sobre el proyecto`n" -ForegroundColor DarkGray
Write-Host "   🎨 Show and Tell (Tipo: Open-ended discussion)" -ForegroundColor Magenta
Write-Host "      Descripción: Comparte proyectos y personalizaciones`n" -ForegroundColor DarkGray
Write-Host "   🔧 Troubleshooting (Tipo: Question / Answer)" -ForegroundColor Magenta
Write-Host "      Descripción: Ayuda para resolver problemas específicos`n" -ForegroundColor DarkGray

Write-Host "❓ ¿Completaste este paso? (S/N): " -ForegroundColor Cyan -NoNewline
$response = Read-Host
if ($response -eq "S" -or $response -eq "s") {
    $completed += "Discussions - Categorías"
    Write-Host "✅ Paso 1.1 completado`n" -ForegroundColor Green
} else {
    Write-Host "⏭️  Puedes volver a este paso después`n" -ForegroundColor Yellow
}

# ============================================================================
# PASO 2: GITHUB DISCUSSIONS - BIENVENIDA
# ============================================================================

Write-Host "╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Yellow
Write-Host "║  PASO 1.2: Crear Discusión de Bienvenida (1 min)              ║" -ForegroundColor Yellow
Write-Host "╚════════════════════════════════════════════════════════════════╝`n" -ForegroundColor Yellow

Write-Host "📄 Abriendo archivo con contenido en VS Code..." -ForegroundColor Cyan
Start-Process "code" -ArgumentList ".github/scripts/welcome-discussion-content.txt"
Start-Sleep -Seconds 1

Write-Host "`n📋 INSTRUCCIONES:" -ForegroundColor White
Write-Host "1. En la página de Discussions, click 'New discussion'" -ForegroundColor Gray
Write-Host "2. Categoría: Announcements" -ForegroundColor Gray
Write-Host "3. Título: 🎉 ¡Bienvenidos a las Discusiones!" -ForegroundColor Gray
Write-Host "4. Contenido: Copia TODO de 'welcome-discussion-content.txt'" -ForegroundColor Gray
Write-Host "5. Click 'Start discussion'" -ForegroundColor Gray
Write-Host "6. Después: Click ⋯ → 'Pin discussion'`n" -ForegroundColor Gray

Write-Host "❓ ¿Completaste este paso? (S/N): " -ForegroundColor Cyan -NoNewline
$response = Read-Host
if ($response -eq "S" -or $response -eq "s") {
    $completed += "Discussions - Bienvenida"
    Write-Host "✅ Paso 1.2 completado`n" -ForegroundColor Green
} else {
    Write-Host "⏭️  Puedes volver a este paso después`n" -ForegroundColor Yellow
}

# ============================================================================
# PASO 3: GITHUB PAGES
# ============================================================================

Write-Host "╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Yellow
Write-Host "║  PASO 2: Habilitar GitHub Pages (1 min)                       ║" -ForegroundColor Yellow
Write-Host "╚════════════════════════════════════════════════════════════════╝`n" -ForegroundColor Yellow

Write-Host "🌐 Abriendo configuración de Pages..." -ForegroundColor Cyan
Start-Process "https://github.com/CSA-DanielVillamizar/gestiondemiembros/settings/pages"
Start-Sleep -Seconds 2

Write-Host "`n📋 INSTRUCCIONES:" -ForegroundColor White
Write-Host "1. En 'Build and deployment'" -ForegroundColor Gray
Write-Host "2. Source: Selecciona 'GitHub Actions' (NO 'Deploy from a branch')" -ForegroundColor Gray
Write-Host "3. NO necesitas hacer nada más, el workflow ya está configurado`n" -ForegroundColor Gray

Write-Host "📝 NOTA: El workflow 'deploy-docs.yml' se ejecutará automáticamente" -ForegroundColor Yellow
Write-Host "         cuando modifiques archivos en docs/ o lo ejecutes manualmente`n" -ForegroundColor Yellow

Write-Host "❓ ¿Completaste este paso? (S/N): " -ForegroundColor Cyan -NoNewline
$response = Read-Host
if ($response -eq "S" -or $response -eq "s") {
    $completed += "GitHub Pages"
    Write-Host "✅ Paso 2 completado`n" -ForegroundColor Green
    
    Write-Host "🚀 ¿Quieres ejecutar el deploy de documentación ahora? (S/N): " -ForegroundColor Cyan -NoNewline
    $deploy = Read-Host
    if ($deploy -eq "S" -or $deploy -eq "s") {
        Write-Host "`n🌐 Abriendo Actions para ejecutar workflow..." -ForegroundColor Cyan
        Start-Process "https://github.com/CSA-DanielVillamizar/gestiondemiembros/actions/workflows/deploy-docs.yml"
        Write-Host "   1. Click 'Run workflow'" -ForegroundColor Gray
        Write-Host "   2. Click 'Run workflow' (botón verde)" -ForegroundColor Gray
        Write-Host "   3. Espera 2-3 minutos" -ForegroundColor Gray
        Write-Host "   4. Tu documentación estará en:" -ForegroundColor Gray
        Write-Host "      https://csa-danielvillamizar.github.io/gestiondemiembros/`n" -ForegroundColor Cyan
    }
} else {
    Write-Host "⏭️  Puedes volver a este paso después`n" -ForegroundColor Yellow
}

# ============================================================================
# PASO 4: BRANCH PROTECTION (OPCIONAL)
# ============================================================================

Write-Host "╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Yellow
Write-Host "║  PASO 3: Branch Protection (Opcional - 3 min)                 ║" -ForegroundColor Yellow
Write-Host "╚════════════════════════════════════════════════════════════════╝`n" -ForegroundColor Yellow

Write-Host "❓ ¿Quieres configurar Branch Protection ahora? (S/N): " -ForegroundColor Cyan -NoNewline
$response = Read-Host
if ($response -eq "S" -or $response -eq "s") {
    Write-Host "`n🌐 Abriendo configuración de Branches..." -ForegroundColor Cyan
    Start-Process "https://github.com/CSA-DanielVillamizar/gestiondemiembros/settings/branches"
    Start-Sleep -Seconds 1
    
    Write-Host "📄 Abriendo guía en VS Code..." -ForegroundColor Cyan
    Start-Process "code" -ArgumentList ".github/BRANCH_PROTECTION.md"
    
    Write-Host "`n📋 INSTRUCCIONES:" -ForegroundColor White
    Write-Host "1. Click 'Add branch protection rule'" -ForegroundColor Gray
    Write-Host "2. Branch name pattern: main" -ForegroundColor Gray
    Write-Host "3. Habilita:" -ForegroundColor Gray
    Write-Host "   ✅ Require a pull request before merging" -ForegroundColor DarkGray
    Write-Host "   ✅ Require approvals (1)" -ForegroundColor DarkGray
    Write-Host "   ✅ Require status checks to pass" -ForegroundColor DarkGray
    Write-Host "      - build-and-test" -ForegroundColor DarkGray
    Write-Host "      - CodeQL" -ForegroundColor DarkGray
    Write-Host "   ✅ Require conversation resolution before merging" -ForegroundColor DarkGray
    Write-Host "4. Click 'Create'`n" -ForegroundColor Gray
    
    Write-Host "❓ ¿Completaste este paso? (S/N): " -ForegroundColor Cyan -NoNewline
    $response2 = Read-Host
    if ($response2 -eq "S" -or $response2 -eq "s") {
        $completed += "Branch Protection"
        Write-Host "✅ Paso 3 completado`n" -ForegroundColor Green
    }
} else {
    Write-Host "⏭️  Saltando Branch Protection`n" -ForegroundColor Yellow
}

# ============================================================================
# PASO 5: CODECOV (OPCIONAL)
# ============================================================================

Write-Host "╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Yellow
Write-Host "║  PASO 4: Codecov (Opcional - 2 min)                           ║" -ForegroundColor Yellow
Write-Host "╚════════════════════════════════════════════════════════════════╝`n" -ForegroundColor Yellow

Write-Host "❓ ¿Quieres configurar Codecov ahora? (S/N): " -ForegroundColor Cyan -NoNewline
$response = Read-Host
if ($response -eq "S" -or $response -eq "s") {
    Write-Host "`n🌐 Abriendo Codecov..." -ForegroundColor Cyan
    Start-Process "https://codecov.io/gh/CSA-DanielVillamizar/gestiondemiembros"
    Start-Sleep -Seconds 2
    
    Write-Host "🌐 Abriendo GitHub Secrets..." -ForegroundColor Cyan
    Start-Process "https://github.com/CSA-DanielVillamizar/gestiondemiembros/settings/secrets/actions"
    
    Write-Host "`n📋 INSTRUCCIONES:" -ForegroundColor White
    Write-Host "1. En Codecov, autoriza el repositorio" -ForegroundColor Gray
    Write-Host "2. Copia el 'Repository Upload Token'" -ForegroundColor Gray
    Write-Host "3. En GitHub Secrets:" -ForegroundColor Gray
    Write-Host "   - Click 'New repository secret'" -ForegroundColor DarkGray
    Write-Host "   - Name: CODECOV_TOKEN" -ForegroundColor DarkGray
    Write-Host "   - Value: [pega el token de Codecov]" -ForegroundColor DarkGray
    Write-Host "   - Click 'Add secret'`n" -ForegroundColor DarkGray
    
    Write-Host "❓ ¿Completaste este paso? (S/N): " -ForegroundColor Cyan -NoNewline
    $response2 = Read-Host
    if ($response2 -eq "S" -or $response2 -eq "s") {
        $completed += "Codecov"
        Write-Host "✅ Paso 4 completado`n" -ForegroundColor Green
    }
} else {
    Write-Host "⏭️  Saltando Codecov`n" -ForegroundColor Yellow
}

# ============================================================================
# RESUMEN FINAL
# ============================================================================

Write-Host "`n╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║                    📊 RESUMEN DE PROGRESO                      ║" -ForegroundColor Green
Write-Host "╚════════════════════════════════════════════════════════════════╝`n" -ForegroundColor Green

if ($completed.Count -gt 0) {
    Write-Host "✅ PASOS COMPLETADOS ($($completed.Count)):`n" -ForegroundColor Green
    foreach ($step in $completed) {
        Write-Host "   ✅ $step" -ForegroundColor White
    }
} else {
    Write-Host "⚠️  No se completaron pasos en esta ejecución" -ForegroundColor Yellow
}

Write-Host "`n📝 PASOS PENDIENTES (puedes hacerlos cuando quieras):`n" -ForegroundColor Yellow

$allSteps = @(
    "Discussions - Categorías",
    "Discussions - Bienvenida",
    "GitHub Pages",
    "Branch Protection",
    "Codecov"
)

$pending = $allSteps | Where-Object { $_ -notin $completed }
if ($pending.Count -gt 0) {
    foreach ($step in $pending) {
        Write-Host "   ⏳ $step" -ForegroundColor Gray
    }
} else {
    Write-Host "   🎉 ¡Todos los pasos completados!" -ForegroundColor Green
}

Write-Host "`n🔗 ENLACES ÚTILES:`n" -ForegroundColor Cyan
Write-Host "   📢 Discussions: https://github.com/CSA-DanielVillamizar/gestiondemiembros/discussions" -ForegroundColor Blue
Write-Host "   ⚙️  Settings: https://github.com/CSA-DanielVillamizar/gestiondemiembros/settings" -ForegroundColor Blue
Write-Host "   🚀 Actions: https://github.com/CSA-DanielVillamizar/gestiondemiembros/actions" -ForegroundColor Blue
Write-Host "   📚 Docs (después de deploy): https://csa-danielvillamizar.github.io/gestiondemiembros/`n" -ForegroundColor Blue

Write-Host "╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Magenta
Write-Host "║  Para volver a ejecutar este checklist, usa:                  ║" -ForegroundColor Magenta
Write-Host "║  .\.github\scripts\complete-setup.ps1                         ║" -ForegroundColor Magenta
Write-Host "╚════════════════════════════════════════════════════════════════╝`n" -ForegroundColor Magenta

Write-Host "Presiona ENTER para cerrar..." -ForegroundColor Cyan
Read-Host

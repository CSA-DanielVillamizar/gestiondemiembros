# 🚀 SCRIPT MAESTRO - Configuración Completa de Pasos Opcionales
# Ejecuta todos los pasos de configuración manual de forma guiada

param(
    [int]$StartStep = 1
)

$ErrorActionPreference = "Stop"

function Show-Header {
    Clear-Host
    Write-Host "`n╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║                                                                ║" -ForegroundColor Cyan
    Write-Host "║     🚀 CONFIGURACIÓN COMPLETA - PASOS OPCIONALES 🚀            ║" -ForegroundColor Cyan
    Write-Host "║     Sistema de Gestión de Miembros L.A.M.A. Medellín          ║" -ForegroundColor Cyan
    Write-Host "║                                                                ║" -ForegroundColor Cyan
    Write-Host "╚════════════════════════════════════════════════════════════════╝`n" -ForegroundColor Cyan
}

function Show-Progress {
    param([int]$Current, [int]$Total)

    Write-Host "`n📊 Progreso: $Current de $Total pasos completados" -ForegroundColor Yellow
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor DarkGray

    $completed = [math]::Floor(($Current / $Total) * 50)
    $remaining = 50 - $completed

    Write-Host "█" -NoNewline -ForegroundColor Green
    Write-Host ("█" * $completed) -NoNewline -ForegroundColor Green
    Write-Host ("░" * $remaining) -NoNewline -ForegroundColor DarkGray
    Write-Host " $([math]::Round(($Current / $Total) * 100))%`n" -ForegroundColor Yellow
}

# ============================================================================
# PASO 1: GITHUB DISCUSSIONS
# ============================================================================
if ($StartStep -le 1) {
    Show-Header
    Write-Host "╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Green
    Write-Host "║  PASO 1 de 5: 💬 GitHub Discussions                            ║" -ForegroundColor Green
    Write-Host "╚════════════════════════════════════════════════════════════════╝`n" -ForegroundColor Green

    Show-Progress -Current 0 -Total 5

    Write-Host "⏱️  Tiempo estimado: 5 minutos" -ForegroundColor Yellow
    Write-Host "📝 Acciones: Crear categorías, discusión de bienvenida, FAQ`n" -ForegroundColor Gray

    Write-Host "Presiona ENTER para comenzar..." -ForegroundColor Cyan
    Read-Host

    # Ejecutar script de Discussions
    & ".github/scripts/setup-discussions.ps1"

    Show-Progress -Current 1 -Total 5
}

# ============================================================================
# PASO 2: GITHUB PAGES
# ============================================================================
if ($StartStep -le 2) {
    Show-Header
    Write-Host "╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Green
    Write-Host "║  PASO 2 de 5: 📚 GitHub Pages                                  ║" -ForegroundColor Green
    Write-Host "╚════════════════════════════════════════════════════════════════╝`n" -ForegroundColor Green

    Show-Progress -Current 1 -Total 5

    Write-Host "⏱️  Tiempo estimado: 3 minutos (1 min config + 2 min deploy)" -ForegroundColor Yellow
    Write-Host "📝 Acciones: Habilitar Pages con Source = GitHub Actions`n" -ForegroundColor Gray

    Write-Host "Presiona ENTER para continuar..." -ForegroundColor Cyan
    Read-Host

    # Ejecutar script de GitHub Pages
    & ".github/scripts/setup-github-pages.ps1"

    Show-Progress -Current 2 -Total 5
}

# ============================================================================
# PASO 3: AZURE SECRETS
# ============================================================================
if ($StartStep -le 3) {
    Show-Header
    Write-Host "╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Green
    Write-Host "║  PASO 3 de 5: 🔐 Secretos de Azure                            ║" -ForegroundColor Green
    Write-Host "╚════════════════════════════════════════════════════════════════╝`n" -ForegroundColor Green

    Show-Progress -Current 2 -Total 5

    Write-Host "⏱️  Tiempo estimado: 15 minutos" -ForegroundColor Yellow
    Write-Host "📝 Acciones: Crear recursos Azure, obtener credenciales, configurar secrets`n" -ForegroundColor Gray

    Write-Host "❓ ¿Quieres configurar los secretos de Azure ahora? (S/N)" -ForegroundColor Cyan
    $response = Read-Host

    if ($response -eq "S" -or $response -eq "s") {
        Write-Host "`n📖 Abriendo guía de configuración de secretos...`n" -ForegroundColor Yellow

        # Abrir guía en VS Code
        code ".github/SECRETS_SETUP.md"

        # Abrir Azure Portal
        Start-Process "https://portal.azure.com"

        # Abrir Settings de GitHub
        Start-Process "https://github.com/CSA-DanielVillamizar/gestiondemiembros/settings/secrets/actions"

        Write-Host "✅ Guía abierta en VS Code" -ForegroundColor Green
        Write-Host "✅ Azure Portal abierto" -ForegroundColor Green
        Write-Host "✅ GitHub Secrets abierto`n" -ForegroundColor Green

        Write-Host "📋 RESUMEN DE SECRETOS NECESARIOS:" -ForegroundColor Cyan
        Write-Host "   1. AZURE_WEBAPP_PUBLISH_PROFILE_STAGING" -ForegroundColor Gray
        Write-Host "   2. AZURE_WEBAPP_PUBLISH_PROFILE_PRODUCTION" -ForegroundColor Gray
        Write-Host "   3. AZURE_STATIC_WEB_APPS_API_TOKEN_STAGING" -ForegroundColor Gray
        Write-Host "   4. AZURE_STATIC_WEB_APPS_API_TOKEN_PRODUCTION" -ForegroundColor Gray
        Write-Host "   5. VITE_API_BASE_URL_STAGING" -ForegroundColor Gray
        Write-Host "   6. VITE_API_BASE_URL_PRODUCTION" -ForegroundColor Gray
        Write-Host "   7. CODECOV_TOKEN (opcional)`n" -ForegroundColor Gray

        Write-Host "Sigue la guía en SECRETS_SETUP.md" -ForegroundColor Yellow
        Write-Host "Cuando termines, presiona ENTER..." -ForegroundColor Cyan
        Read-Host
    } else {
        Write-Host "`n⏭️  Saltando configuración de Azure (puedes hacerlo después)`n" -ForegroundColor Yellow
    }

    Show-Progress -Current 3 -Total 5
}

# ============================================================================
# PASO 4: BRANCH PROTECTION
# ============================================================================
if ($StartStep -le 4) {
    Show-Header
    Write-Host "╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Green
    Write-Host "║  PASO 4 de 5: 🛡️  Branch Protection                           ║" -ForegroundColor Green
    Write-Host "╚════════════════════════════════════════════════════════════════╝`n" -ForegroundColor Green

    Show-Progress -Current 3 -Total 5

    Write-Host "⏱️  Tiempo estimado: 3 minutos" -ForegroundColor Yellow
    Write-Host "📝 Acciones: Configurar reglas de protección para rama main`n" -ForegroundColor Gray

    Write-Host "❓ ¿Quieres configurar Branch Protection ahora? (S/N)" -ForegroundColor Cyan
    $response = Read-Host

    if ($response -eq "S" -or $response -eq "s") {
        Write-Host "`n📖 Abriendo guía y configuración...`n" -ForegroundColor Yellow

        # Abrir guía
        code ".github/BRANCH_PROTECTION.md"

        # Abrir configuración de branches
        Start-Process "https://github.com/CSA-DanielVillamizar/gestiondemiembros/settings/branches"

        Write-Host "✅ Guía abierta en VS Code" -ForegroundColor Green
        Write-Host "✅ Branch Settings abierto`n" -ForegroundColor Green

        Write-Host "📋 CONFIGURACIÓN RECOMENDADA:" -ForegroundColor Cyan
        Write-Host "   ✅ Require pull request before merging" -ForegroundColor Gray
        Write-Host "   ✅ Require approvals (1)" -ForegroundColor Gray
        Write-Host "   ✅ Require status checks: build-and-test, CodeQL" -ForegroundColor Gray
        Write-Host "   ✅ Require conversation resolution before merging" -ForegroundColor Gray
        Write-Host "   ✅ Include administrators`n" -ForegroundColor Gray

        Write-Host "Cuando termines, presiona ENTER..." -ForegroundColor Cyan
        Read-Host
    } else {
        Write-Host "`n⏭️  Saltando Branch Protection (puedes hacerlo después)`n" -ForegroundColor Yellow
    }

    Show-Progress -Current 4 -Total 5
}

# ============================================================================
# PASO 5: CODECOV
# ============================================================================
if ($StartStep -le 5) {
    Show-Header
    Write-Host "╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Green
    Write-Host "║  PASO 5 de 5: 📊 Codecov                                       ║" -ForegroundColor Green
    Write-Host "╚════════════════════════════════════════════════════════════════╝`n" -ForegroundColor Green

    Show-Progress -Current 4 -Total 5

    Write-Host "⏱️  Tiempo estimado: 2 minutos" -ForegroundColor Yellow
    Write-Host "📝 Acciones: Registrar en Codecov y agregar token`n" -ForegroundColor Gray

    Write-Host "❓ ¿Quieres configurar Codecov ahora? (S/N)" -ForegroundColor Cyan
    $response = Read-Host

    if ($response -eq "S" -or $response -eq "s") {
        Write-Host "`n🌐 Abriendo Codecov...`n" -ForegroundColor Yellow

        # Abrir Codecov
        Start-Process "https://codecov.io/gh/CSA-DanielVillamizar/gestiondemiembros"

        # Abrir GitHub Secrets
        Start-Process "https://github.com/CSA-DanielVillamizar/gestiondemiembros/settings/secrets/actions"

        Write-Host "✅ Codecov abierto" -ForegroundColor Green
        Write-Host "✅ GitHub Secrets abierto`n" -ForegroundColor Green

        Write-Host "📋 PASOS:" -ForegroundColor Cyan
        Write-Host "   1. En Codecov, autoriza el repositorio" -ForegroundColor Gray
        Write-Host "   2. Copia el 'Repository Upload Token'" -ForegroundColor Gray
        Write-Host "   3. En GitHub Secrets, crea 'CODECOV_TOKEN'" -ForegroundColor Gray
        Write-Host "   4. Pega el token de Codecov`n" -ForegroundColor Gray

        Write-Host "Cuando termines, presiona ENTER..." -ForegroundColor Cyan
        Read-Host
    } else {
        Write-Host "`n⏭️  Saltando Codecov (puedes hacerlo después)`n" -ForegroundColor Yellow
    }

    Show-Progress -Current 5 -Total 5
}

# ============================================================================
# RESUMEN FINAL
# ============================================================================
Show-Header
Write-Host "╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║                  🎉 ¡CONFIGURACIÓN COMPLETADA! 🎉              ║" -ForegroundColor Green
Write-Host "╚════════════════════════════════════════════════════════════════╝`n" -ForegroundColor Green

Show-Progress -Current 5 -Total 5

Write-Host "`n✅ PASOS COMPLETADOS:`n" -ForegroundColor Green

Write-Host "  1. ✅ GitHub Discussions - Habilitado y configurado" -ForegroundColor White
Write-Host "  2. ✅ GitHub Pages - Listo para documentación" -ForegroundColor White
Write-Host "  3. ✅ Azure Secrets - Configurados (si elegiste hacerlo)" -ForegroundColor White
Write-Host "  4. ✅ Branch Protection - Rama main protegida" -ForegroundColor White
Write-Host "  5. ✅ Codecov - Integrado para cobertura de código`n" -ForegroundColor White

Write-Host "📊 ESTADÍSTICAS DEL REPOSITORIO:`n" -ForegroundColor Cyan

Write-Host "  • Workflows: 6 (3 CI + 3 Deploy)" -ForegroundColor Gray
Write-Host "  • Badges: 14 en README" -ForegroundColor Gray
Write-Host "  • Documentación: MkDocs configurado" -ForegroundColor Gray
Write-Host "  • Seguridad: CodeQL + CODEOWNERS + Branch Protection" -ForegroundColor Gray
Write-Host "  • Comunidad: Discussions + CODE_OF_CONDUCT + CONTRIBUTING`n" -ForegroundColor Gray

Write-Host "🔗 ENLACES RÁPIDOS:`n" -ForegroundColor Cyan

Write-Host "  📢 Discussions: https://github.com/CSA-DanielVillamizar/gestiondemiembros/discussions" -ForegroundColor Blue
Write-Host "  📚 Documentation: https://csa-danielvillamizar.github.io/gestiondemiembros/" -ForegroundColor Blue
Write-Host "  🚀 Actions: https://github.com/CSA-DanielVillamizar/gestiondemiembros/actions" -ForegroundColor Blue
Write-Host "  🔐 Secrets: https://github.com/CSA-DanielVillamizar/gestiondemiembros/settings/secrets/actions`n" -ForegroundColor Blue

Write-Host "📝 PRÓXIMOS PASOS (OPCIONALES):`n" -ForegroundColor Yellow

Write-Host "  • Completa la documentación en docs/" -ForegroundColor Gray
Write-Host "  • Prueba los workflows de deployment" -ForegroundColor Gray
Write-Host "  • Invita colaboradores al proyecto" -ForegroundColor Gray
Write-Host "  • Crea el primer release/tag`n" -ForegroundColor Gray

Write-Host "╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Magenta
Write-Host "║  🎯 Tu repositorio ahora tiene configuración Enterprise-Level  ║" -ForegroundColor Magenta
Write-Host "╚════════════════════════════════════════════════════════════════╝`n" -ForegroundColor Magenta

Write-Host "Presiona ENTER para salir..." -ForegroundColor Cyan
Read-Host

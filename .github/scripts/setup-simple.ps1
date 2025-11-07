# Script Simplificado - Configuracion Manual de Pasos Opcionales
# Sin caracteres especiales para evitar errores de encoding

Write-Host "`n================================================================" -ForegroundColor Cyan
Write-Host "     CONFIGURACION RAPIDA - PASOS MANUALES" -ForegroundColor Cyan
Write-Host "     Repositorio: gestiondemiembros" -ForegroundColor Cyan
Write-Host "================================================================`n" -ForegroundColor Cyan

Write-Host "Este script abrira las paginas necesarias en tu navegador." -ForegroundColor Yellow
Write-Host "Tu solo necesitas hacer los clicks que te indique.`n" -ForegroundColor Yellow

# PASO 1: DISCUSSIONS - CATEGORIAS
Write-Host "`n----------------------------------------------------------------" -ForegroundColor Green
Write-Host "PASO 1: GitHub Discussions - Crear Categorias (2 min)" -ForegroundColor Green
Write-Host "----------------------------------------------------------------`n" -ForegroundColor Green

Write-Host "Abriendo GitHub Discussions..." -ForegroundColor Cyan
Start-Process "https://github.com/CSA-DanielVillamizar/gestiondemiembros/discussions"
Start-Sleep -Seconds 2

Write-Host "`nQue hacer:" -ForegroundColor White
Write-Host "1. Click en 'Manage categories'" -ForegroundColor Gray
Write-Host "2. Crea estas 6 categorias:`n" -ForegroundColor Gray

Write-Host "   - Announcements (Tipo: Announcement)" -ForegroundColor Yellow
Write-Host "   - Ideas (Tipo: Open-ended discussion)" -ForegroundColor Yellow
Write-Host "   - Q and A (Tipo: Question/Answer) <- IMPORTANTE: usa 'Q and A'" -ForegroundColor Yellow
Write-Host "   - General (Tipo: Open-ended discussion)" -ForegroundColor Yellow
Write-Host "   - Show and Tell (Tipo: Open-ended discussion)" -ForegroundColor Yellow
Write-Host "   - Troubleshooting (Tipo: Question/Answer)`n" -ForegroundColor Yellow

Write-Host "Presiona ENTER cuando hayas creado las categorias..." -ForegroundColor Cyan
Read-Host

# PASO 2: DISCUSSIONS - BIENVENIDA
Write-Host "`n----------------------------------------------------------------" -ForegroundColor Green
Write-Host "PASO 2: Crear Discusion de Bienvenida (1 min)" -ForegroundColor Green
Write-Host "----------------------------------------------------------------`n" -ForegroundColor Green

Write-Host "Abriendo archivo con contenido..." -ForegroundColor Cyan
Start-Process "code" -ArgumentList ".github\scripts\welcome-discussion-content.txt"
Start-Sleep -Seconds 1

Write-Host "`nQue hacer:" -ForegroundColor White
Write-Host "1. En Discussions, click 'New discussion'" -ForegroundColor Gray
Write-Host "2. Categoria: Announcements" -ForegroundColor Gray
Write-Host "3. Titulo: Bienvenidos a las Discusiones!" -ForegroundColor Gray
Write-Host "4. Contenido: Copia TODO de 'welcome-discussion-content.txt'" -ForegroundColor Gray
Write-Host "5. Click 'Start discussion'" -ForegroundColor Gray
Write-Host "6. Despues: Click ... -> 'Pin discussion'`n" -ForegroundColor Gray

Write-Host "Presiona ENTER cuando hayas creado la discusion de bienvenida..." -ForegroundColor Cyan
Read-Host

# PASO 3: GITHUB PAGES
Write-Host "`n----------------------------------------------------------------" -ForegroundColor Green
Write-Host "PASO 3: Habilitar GitHub Pages (1 min)" -ForegroundColor Green
Write-Host "----------------------------------------------------------------`n" -ForegroundColor Green

Write-Host "Abriendo configuracion de Pages..." -ForegroundColor Cyan
Start-Process "https://github.com/CSA-DanielVillamizar/gestiondemiembros/settings/pages"
Start-Sleep -Seconds 2

Write-Host "`nQue hacer:" -ForegroundColor White
Write-Host "1. En 'Build and deployment'" -ForegroundColor Gray
Write-Host "2. Source: Selecciona 'GitHub Actions'" -ForegroundColor Gray
Write-Host "3. Listo! El workflow ya esta configurado.`n" -ForegroundColor Gray

Write-Host "Presiona ENTER cuando hayas habilitado Pages..." -ForegroundColor Cyan
Read-Host

# OPCIONALES
Write-Host "`n----------------------------------------------------------------" -ForegroundColor Yellow
Write-Host "PASOS OPCIONALES" -ForegroundColor Yellow
Write-Host "----------------------------------------------------------------`n" -ForegroundColor Yellow

Write-Host "Quieres configurar los pasos opcionales? (S/N): " -ForegroundColor Cyan -NoNewline
$doOptional = Read-Host

if ($doOptional -eq "S" -or $doOptional -eq "s") {
    
    # BRANCH PROTECTION
    Write-Host "`n----------------------------------------------------------------" -ForegroundColor Green
    Write-Host "OPCIONAL: Branch Protection (3 min)" -ForegroundColor Green
    Write-Host "----------------------------------------------------------------`n" -ForegroundColor Green
    
    Write-Host "Abriendo configuracion de Branches..." -ForegroundColor Cyan
    Start-Process "https://github.com/CSA-DanielVillamizar/gestiondemiembros/settings/branches"
    Start-Sleep -Seconds 1
    
    Write-Host "Abriendo guia en VS Code..." -ForegroundColor Cyan
    Start-Process "code" -ArgumentList ".github\BRANCH_PROTECTION.md"
    
    Write-Host "`nQue hacer:" -ForegroundColor White
    Write-Host "1. Click 'Add branch protection rule'" -ForegroundColor Gray
    Write-Host "2. Branch name pattern: main" -ForegroundColor Gray
    Write-Host "3. Habilita las opciones segun la guia`n" -ForegroundColor Gray
    
    Write-Host "Presiona ENTER cuando termines..." -ForegroundColor Cyan
    Read-Host
    
    # CODECOV
    Write-Host "`n----------------------------------------------------------------" -ForegroundColor Green
    Write-Host "OPCIONAL: Codecov (2 min)" -ForegroundColor Green
    Write-Host "----------------------------------------------------------------`n" -ForegroundColor Green
    
    Write-Host "Abriendo Codecov..." -ForegroundColor Cyan
    Start-Process "https://codecov.io/gh/CSA-DanielVillamizar/gestiondemiembros"
    Start-Sleep -Seconds 2
    
    Write-Host "Abriendo GitHub Secrets..." -ForegroundColor Cyan
    Start-Process "https://github.com/CSA-DanielVillamizar/gestiondemiembros/settings/secrets/actions"
    
    Write-Host "`nQue hacer:" -ForegroundColor White
    Write-Host "1. En Codecov, autoriza el repositorio" -ForegroundColor Gray
    Write-Host "2. Copia el token" -ForegroundColor Gray
    Write-Host "3. En GitHub Secrets, crea 'CODECOV_TOKEN'`n" -ForegroundColor Gray
    
    Write-Host "Presiona ENTER cuando termines..." -ForegroundColor Cyan
    Read-Host
}

# RESUMEN
Write-Host "`n================================================================" -ForegroundColor Green
Write-Host "     CONFIGURACION COMPLETADA!" -ForegroundColor Green
Write-Host "================================================================`n" -ForegroundColor Green

Write-Host "Pasos completados:" -ForegroundColor White
Write-Host "  [OK] GitHub Discussions habilitado" -ForegroundColor Green
Write-Host "  [OK] Categorias creadas" -ForegroundColor Green
Write-Host "  [OK] Discusion de bienvenida publicada" -ForegroundColor Green
Write-Host "  [OK] GitHub Pages habilitado`n" -ForegroundColor Green

Write-Host "Tu repositorio ahora tiene:" -ForegroundColor Cyan
Write-Host "  - 14 badges en README" -ForegroundColor Gray
Write-Host "  - 6 workflows activos" -ForegroundColor Gray
Write-Host "  - GitHub Discussions funcionando" -ForegroundColor Gray
Write-Host "  - Documentacion lista para deploy`n" -ForegroundColor Gray

Write-Host "Para deployar la documentacion:" -ForegroundColor Yellow
Write-Host "  1. Ve a Actions" -ForegroundColor Gray
Write-Host "  2. Deploy Documentation" -ForegroundColor Gray
Write-Host "  3. Run workflow`n" -ForegroundColor Gray

Write-Host "Tu documentacion estara en:" -ForegroundColor Cyan
Write-Host "  https://csa-danielvillamizar.github.io/gestiondemiembros/`n" -ForegroundColor Blue

Write-Host "Presiona ENTER para salir..." -ForegroundColor Cyan
Read-Host

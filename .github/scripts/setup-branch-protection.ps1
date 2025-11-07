# Script de configuracion de Branch Protection
# Guia paso a paso para proteger la rama main

Write-Host "`n================================================================" -ForegroundColor Cyan
Write-Host "  CONFIGURACION DE BRANCH PROTECTION" -ForegroundColor Green
Write-Host "  Tiempo estimado: 3 minutos" -ForegroundColor Yellow
Write-Host "================================================================`n" -ForegroundColor Cyan

Write-Host "Que es Branch Protection?" -ForegroundColor White
Write-Host "- Previene push directo a la rama main" -ForegroundColor Gray
Write-Host "- Requiere Pull Requests para hacer cambios" -ForegroundColor Gray
Write-Host "- Requiere que CI/CD pase antes de merge" -ForegroundColor Gray
Write-Host "- Requiere aprobacion de codigo`n" -ForegroundColor Gray

Write-Host "Por que es importante?" -ForegroundColor White
Write-Host "- Protege el codigo de produccion" -ForegroundColor Gray
Write-Host "- Obliga a revisiones de codigo" -ForegroundColor Gray
Write-Host "- Reduce bugs en main" -ForegroundColor Gray
Write-Host "- Profesionaliza el workflow`n" -ForegroundColor Gray

$opcion = Read-Host "Quieres configurar Branch Protection ahora? (S/N)"

if ($opcion -ne "S" -and $opcion -ne "s") {
    Write-Host "`nPuedes configurarlo mas tarde siguiendo .github/BRANCH_PROTECTION.md`n" -ForegroundColor Yellow
    exit
}

Write-Host "`n================================================================" -ForegroundColor Cyan
Write-Host "  OPCION 1: GITHUB CLI (Automatico - Recomendado)" -ForegroundColor Green
Write-Host "================================================================`n" -ForegroundColor Cyan

Write-Host "Verificando si tienes GitHub CLI instalado..." -ForegroundColor Yellow

$ghInstalled = Get-Command gh -ErrorAction SilentlyContinue

if ($ghInstalled) {
    Write-Host "[OK] GitHub CLI detectado`n" -ForegroundColor Green
    
    Write-Host "Verificando autenticacion..." -ForegroundColor Yellow
    $authStatus = gh auth status 2>&1
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "[OK] Autenticado correctamente`n" -ForegroundColor Green
        
        Write-Host "Configurando Branch Protection para 'main'..." -ForegroundColor Yellow
        Write-Host "(Esto puede tardar 5-10 segundos)`n" -ForegroundColor Gray
        
        # Crear branch protection usando GitHub CLI
        $protectionConfig = @"
{
  "required_status_checks": {
    "strict": true,
    "contexts": ["build-and-test", "CodeQL"]
  },
  "enforce_admins": true,
  "required_pull_request_reviews": {
    "dismiss_stale_reviews": true,
    "require_code_owner_reviews": false,
    "required_approving_review_count": 1
  },
  "restrictions": null,
  "required_linear_history": false,
  "allow_force_pushes": false,
  "allow_deletions": false,
  "required_conversation_resolution": true
}
"@
        
        try {
            # Intentar crear/actualizar branch protection
            $result = gh api repos/CSA-DanielVillamizar/gestiondemiembros/branches/main/protection `
                --method PUT `
                --input - `
                <<< $protectionConfig 2>&1
            
            if ($LASTEXITCODE -eq 0) {
                Write-Host "`n================================================================" -ForegroundColor Green
                Write-Host "  BRANCH PROTECTION CONFIGURADO EXITOSAMENTE" -ForegroundColor Green
                Write-Host "================================================================`n" -ForegroundColor Green
                
                Write-Host "Reglas aplicadas a 'main':" -ForegroundColor White
                Write-Host "  [OK] Requiere Pull Request" -ForegroundColor Green
                Write-Host "  [OK] Requiere 1 aprobacion" -ForegroundColor Green
                Write-Host "  [OK] Requiere CI/CD passing" -ForegroundColor Green
                Write-Host "  [OK] Requiere conversaciones resueltas" -ForegroundColor Green
                Write-Host "  [OK] No permite push directo" -ForegroundColor Green
                Write-Host "  [OK] No permite force push" -ForegroundColor Green
                
                Write-Host "`nVerificar en:" -ForegroundColor Yellow
                Write-Host "https://github.com/CSA-DanielVillamizar/gestiondemiembros/settings/branches`n" -ForegroundColor Cyan
                
                $abrirURL = Read-Host "Quieres abrir la pagina para verificar? (S/N)"
                if ($abrirURL -eq "S" -or $abrirURL -eq "s") {
                    Start-Process "https://github.com/CSA-DanielVillamizar/gestiondemiembros/settings/branches"
                }
                
                Write-Host "`n================================================================" -ForegroundColor Cyan
                Write-Host "  PROXIMO PASO: PROBAR PROTECCION" -ForegroundColor Yellow
                Write-Host "================================================================`n" -ForegroundColor Cyan
                
                Write-Host "Intenta hacer push directo a main (deberia fallar):" -ForegroundColor White
                Write-Host 'git checkout main' -ForegroundColor Gray
                Write-Host 'echo "test" >> test.txt' -ForegroundColor Gray
                Write-Host 'git add test.txt' -ForegroundColor Gray
                Write-Host 'git commit -m "test: direct push"' -ForegroundColor Gray
                Write-Host 'git push origin main' -ForegroundColor Gray
                Write-Host "`nDeberia mostrar error: Protected branch update failed`n" -ForegroundColor Yellow
                
                Write-Host "Flujo correcto ahora:" -ForegroundColor White
                Write-Host '1. git checkout -b feature/mi-feature' -ForegroundColor Gray
                Write-Host '2. [hacer cambios]' -ForegroundColor Gray
                Write-Host '3. git push origin feature/mi-feature' -ForegroundColor Gray
                Write-Host '4. Crear PR en GitHub' -ForegroundColor Gray
                Write-Host '5. Esperar aprobacion y CI' -ForegroundColor Gray
                Write-Host '6. Merge via GitHub UI`n' -ForegroundColor Gray
                
                exit
            }
        }
        catch {
            Write-Host "`n[ERROR] No se pudo configurar via CLI" -ForegroundColor Red
            Write-Host "Vamos a usar la opcion manual...`n" -ForegroundColor Yellow
        }
    }
    else {
        Write-Host "[INFO] No estas autenticado en GitHub CLI" -ForegroundColor Yellow
        Write-Host "Vamos a usar la opcion manual...`n" -ForegroundColor Yellow
    }
}
else {
    Write-Host "[INFO] GitHub CLI no esta instalado" -ForegroundColor Yellow
    Write-Host "Vamos a usar la opcion manual...`n" -ForegroundColor Yellow
}

Write-Host "`n================================================================" -ForegroundColor Cyan
Write-Host "  OPCION 2: CONFIGURACION MANUAL (GitHub Web UI)" -ForegroundColor Green
Write-Host "================================================================`n" -ForegroundColor Cyan

Write-Host "PASO 1: Abrir la pagina de configuracion" -ForegroundColor Yellow
Write-Host "  URL: https://github.com/CSA-DanielVillamizar/gestiondemiembros/settings/branches`n" -ForegroundColor Cyan

$abrir = Read-Host "Quieres que abra la pagina ahora? (S/N)"
if ($abrir -eq "S" -or $abrir -eq "s") {
    Start-Process "https://github.com/CSA-DanielVillamizar/gestiondemiembros/settings/branches"
    Write-Host "`n[OK] Pagina abierta en tu navegador`n" -ForegroundColor Green
}
else {
    Write-Host "`nCopia y pega esta URL en tu navegador:" -ForegroundColor Yellow
    Write-Host "https://github.com/CSA-DanielVillamizar/gestiondemiembros/settings/branches`n" -ForegroundColor Cyan
}

Write-Host "================================================================`n" -ForegroundColor Cyan

Write-Host "PASO 2: Agregar regla de proteccion" -ForegroundColor Yellow
Write-Host "  1. Click en 'Add rule' o 'Add branch protection rule'" -ForegroundColor White
Write-Host "  2. En 'Branch name pattern', escribe: main`n" -ForegroundColor White

Write-Host "PASO 3: Configurar reglas (marca estas opciones)" -ForegroundColor Yellow
Write-Host "`n--- SECCION: Protect matching branches ---`n" -ForegroundColor Cyan

Write-Host "  [X] Require a pull request before merging" -ForegroundColor Green
Write-Host "      [X] Require approvals: 1" -ForegroundColor Green
Write-Host "      [X] Dismiss stale pull request approvals when new commits are pushed`n" -ForegroundColor Green

Write-Host "  [X] Require status checks to pass before merging" -ForegroundColor Green
Write-Host "      [X] Require branches to be up to date before merging" -ForegroundColor Green
Write-Host "      Busca y selecciona estos checks:" -ForegroundColor White
Write-Host "      - build-and-test" -ForegroundColor Gray
Write-Host "      - CodeQL`n" -ForegroundColor Gray

Write-Host "  [X] Require conversation resolution before merging`n" -ForegroundColor Green

Write-Host "  [X] Do not allow bypassing the above settings`n" -ForegroundColor Green

Write-Host "--- OPCIONAL (Puedes saltarlas) ---`n" -ForegroundColor Yellow

Write-Host "  [ ] Require signed commits (opcional)" -ForegroundColor Gray
Write-Host "  [ ] Require linear history (opcional)" -ForegroundColor Gray
Write-Host "  [ ] Restrict who can push to matching branches (opcional)`n" -ForegroundColor Gray

Write-Host "PASO 4: Guardar" -ForegroundColor Yellow
Write-Host "  1. Baja hasta el final de la pagina" -ForegroundColor White
Write-Host "  2. Click en 'Create' o 'Save changes'`n" -ForegroundColor White

Write-Host "================================================================" -ForegroundColor Cyan
Write-Host "  VERIFICACION" -ForegroundColor Green
Write-Host "================================================================`n" -ForegroundColor Cyan

Write-Host "Despues de crear la regla, veras:" -ForegroundColor White
Write-Host "  - La rama 'main' aparece en la lista de branch protection rules" -ForegroundColor Gray
Write-Host "  - Un check verde junto a 'main' en la pagina de branches`n" -ForegroundColor Gray

Write-Host "================================================================" -ForegroundColor Cyan
Write-Host "  AYUDA VISUAL" -ForegroundColor Green
Write-Host "================================================================`n" -ForegroundColor Cyan

Write-Host "Si necesitas ayuda visual completa:" -ForegroundColor White
Write-Host "  - Abre: .github/BRANCH_PROTECTION.md" -ForegroundColor Cyan
Write-Host "  - Tiene capturas de pantalla y explicaciones detalladas`n" -ForegroundColor Gray

$abrirGuia = Read-Host "Quieres abrir la guia completa ahora? (S/N)"
if ($abrirGuia -eq "S" -or $abrirGuia -eq "s") {
    code ".github\BRANCH_PROTECTION.md"
    Write-Host "`n[OK] Guia abierta en VS Code`n" -ForegroundColor Green
}

Write-Host "`n================================================================" -ForegroundColor Green
Write-Host "  CONFIGURACION COMPLETADA" -ForegroundColor Green
Write-Host "================================================================`n" -ForegroundColor Green

Write-Host "Una vez configurado Branch Protection:" -ForegroundColor White
Write-Host "  [OK] La rama main esta protegida" -ForegroundColor Green
Write-Host "  [OK] Solo se permiten cambios via Pull Request" -ForegroundColor Green
Write-Host "  [OK] CI/CD debe pasar antes de merge" -ForegroundColor Green
Write-Host "  [OK] Repositorio en nivel ENTERPRISE-READY`n" -ForegroundColor Green

Write-Host "Siguiente paso opcional:" -ForegroundColor Yellow
Write-Host "  - Configurar Codecov (2 minutos)" -ForegroundColor White
Write-Host "  - Deploy a Azure (15 minutos)`n" -ForegroundColor White

Read-Host "Presiona Enter para salir"

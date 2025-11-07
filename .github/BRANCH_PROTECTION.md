# 🛡️ Guía de Branch Protection Rules

Esta guía explica cómo configurar reglas de protección para las ramas principales del repositorio.

## ¿Por qué Branch Protection?

Las reglas de protección de ramas ayudan a:
- ✅ Prevenir push directo a ramas principales
- ✅ Requerir revisiones de código antes de merge
- ✅ Asegurar que CI/CD pase antes de merge
- ✅ Mantener un historial limpio y rastreable
- ✅ Reducir bugs en producción

---

## 🔧 Configuración Recomendada

### Opción 1: GitHub Web UI (Recomendado para principiantes)

1. **Navegar a Settings**
   - Ve a tu repositorio en GitHub
   - Click en **Settings** → **Branches**

2. **Agregar Branch Protection Rule**
   - Click en **"Add rule"** o **"Add branch protection rule"**
   - En **"Branch name pattern"**, escribe: `main`

3. **Configurar Reglas para `main`**

   Habilita las siguientes opciones:

   #### ✅ Require a pull request before merging
   - [x] **Require approvals**: 1 reviewer mínimo
   - [x] **Dismiss stale pull request approvals when new commits are pushed**
   - [x] **Require review from Code Owners** (si tienes CODEOWNERS)

   #### ✅ Require status checks to pass before merging
   - [x] **Require branches to be up to date before merging**
   - Busca y selecciona los siguientes checks:
     - `build-and-test` (Backend CI)
     - `build-and-test` (Frontend CI)
     - `CodeQL`

   #### ✅ Require conversation resolution before merging
   - Asegura que todos los comentarios se resuelvan

   #### ✅ Require signed commits (Opcional)
   - Recomendado para equipos grandes

   #### ✅ Require linear history (Opcional)
   - Previene merge commits, fuerza rebase o squash

   #### ✅ Do not allow bypassing the above settings
   - Aplica reglas incluso a administradores

   #### ✅ Restrict who can push to matching branches (Opcional)
   - Limita push solo a equipos específicos

4. **Guardar**
   - Click en **"Create"** al final de la página

### Opción 2: GitHub CLI

```bash
# Instalar GitHub CLI si no lo tienes
# https://cli.github.com/

# Login
gh auth login

# Crear branch protection rule para main
gh api repos/CSA-DanielVillamizar/gestiondemiembros/branches/main/protection \
  --method PUT \
  --header "Accept: application/vnd.github+json" \
  --field required_status_checks='{"strict":true,"contexts":["build-and-test","CodeQL"]}' \
  --field enforce_admins=true \
  --field required_pull_request_reviews='{"dismissal_restrictions":{},"dismiss_stale_reviews":true,"require_code_owner_reviews":false,"required_approving_review_count":1}' \
  --field restrictions=null \
  --field required_linear_history=false \
  --field allow_force_pushes=false \
  --field allow_deletions=false \
  --field required_conversation_resolution=true
```

### Opción 3: Terraform (Para infraestructura como código)

```hcl
resource "github_branch_protection" "main" {
  repository_id = "gestiondemiembros"
  pattern       = "main"

  required_status_checks {
    strict   = true
    contexts = ["build-and-test", "CodeQL"]
  }

  required_pull_request_reviews {
    dismiss_stale_reviews           = true
    require_code_owner_reviews      = false
    required_approving_review_count = 1
  }

  enforce_admins                  = true
  require_signed_commits          = false
  require_linear_history          = false
  require_conversation_resolution = true
  allows_force_pushes            = false
  allows_deletions               = false
}
```

---

## 📝 Reglas para Rama `develop` (Opcional)

Si usas una rama `develop` para desarrollo:

**Configuración sugerida:**
- ✅ Require pull request (0-1 reviewers)
- ✅ Require status checks
- ❌ No enforce admins (permitir bypass para hotfixes)
- ❌ No require signed commits
- ✅ Require conversation resolution

```bash
gh api repos/CSA-DanielVillamizar/gestiondemiembros/branches/develop/protection \
  --method PUT \
  --header "Accept: application/vnd.github+json" \
  --field required_status_checks='{"strict":false,"contexts":["build-and-test"]}' \
  --field enforce_admins=false \
  --field required_pull_request_reviews='{"required_approving_review_count":0}' \
  --field required_conversation_resolution=true
```

---

## 🔐 CODEOWNERS (Opcional)

Crear archivo `.github/CODEOWNERS` para auto-asignar reviewers:

```
# Archivo CODEOWNERS
# Documentación completa: https://docs.github.com/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-owners

# Propietarios por defecto
* @CSA-DanielVillamizar

# Backend
backend/** @CSA-DanielVillamizar
*.cs @CSA-DanielVillamizar

# Frontend
frontend/** @CSA-DanielVillamizar
*.tsx @CSA-DanielVillamizar
*.ts @CSA-DanielVillamizar

# Infrastructure
docker-compose.yml @CSA-DanielVillamizar
.github/workflows/** @CSA-DanielVillamizar
*.yml @CSA-DanielVillamizar

# Documentation
*.md @CSA-DanielVillamizar
docs/** @CSA-DanielVillamizar
```

---

## ✅ Verificación

### 1. Verificar Reglas Aplicadas

**Web UI:**
- Settings → Branches → Verifica que `main` tenga reglas activas

**CLI:**
```bash
gh api repos/CSA-DanielVillamizar/gestiondemiembros/branches/main/protection
```

### 2. Probar Protección

Intenta hacer push directo a `main`:

```bash
git checkout main
echo "test" >> test.txt
git add test.txt
git commit -m "test: direct push to main"
git push origin main
```

Deberías ver un error:
```
remote: error: GH006: Protected branch update failed for refs/heads/main.
```

✅ ¡Funciona correctamente!

### 3. Flujo Correcto

```bash
# Crear rama feature
git checkout -b feature/mi-feature

# Hacer cambios
echo "cambio" >> archivo.txt
git add archivo.txt
git commit -m "feat: mi nueva característica"

# Push de la rama
git push origin feature/mi-feature

# Crear Pull Request en GitHub
# Esperar aprobación y checks
# Merge via GitHub UI
```

---

## 🎯 Workflow Recomendado

### Para Features

```
main (protegida)
  └─ feature/nueva-caracteristica
       ├─ commit 1
       ├─ commit 2
       └─ PR → main (requiere approval + CI passing)
```

### Para Hotfixes

```
main (protegida)
  └─ hotfix/bug-critico
       ├─ fix
       └─ PR → main (expedited review)
```

### Para Releases

```
main (protegida)
  └─ release/v1.2.0
       ├─ bump version
       ├─ update changelog
       └─ PR → main (requiere approval + full CI)
```

---

## 🚨 Bypass de Protección (Emergencias)

Si necesitas bypass temporal (solo administradores):

1. **Desactivar "Enforce for administrators"**
   - Settings → Branches → Edit rule
   - Desmarcar "Do not allow bypassing"
   - Save

2. **Hacer cambio urgente**
   ```bash
   git push origin main --force  # Solo en emergencias
   ```

3. **Re-activar protección**
   - Settings → Branches → Edit rule
   - Marcar "Do not allow bypassing"
   - Save

⚠️ **IMPORTANTE**: Re-activa la protección inmediatamente después.

---

## 📊 Mejores Prácticas

### ✅ Hacer

- Usar PRs para todos los cambios a `main`
- Revisar código de otros miembros del equipo
- Mantener PRs pequeños y enfocados
- Escribir descripciones claras en PRs
- Resolver todos los comentarios antes de merge
- Esperar a que CI pase completamente
- Usar conventional commits (`feat:`, `fix:`, `docs:`, etc.)

### ❌ Evitar

- Push directo a `main` (incluso si puedes)
- Merge de PRs sin aprobación
- Ignorar fallos de CI
- PRs gigantes con múltiples features
- Force push a ramas compartidas
- Merge con conversaciones sin resolver
- Commits sin mensaje descriptivo

---

## 🔗 Integración con CI/CD

### Status Checks Requeridos

Agrega estos checks como requeridos:

**Backend:**
- `build-and-test` (del workflow backend-ci.yml)
- `CodeQL / Analyze (csharp)` (del workflow codeql-analysis.yml)

**Frontend:**
- `build-and-test` (del workflow frontend-ci.yml)
- `CodeQL / Analyze (javascript)` (del workflow codeql-analysis.yml)

**Deployment (opcional):**
- `deploy-staging` (debe pasar antes de production)

### Configurar Auto-merge (Opcional)

Si los checks pasan automáticamente:

```bash
# Habilitar auto-merge en un PR
gh pr merge 123 --auto --squash
```

---

## 🆘 Troubleshooting

### Error: "Required status check is expected"

- Verifica que el nombre del check coincida exactamente
- Ve a Actions → Un workflow exitoso → Revisa el nombre del job
- Actualiza la branch protection rule con el nombre correcto

### Error: "Review required"

- Asigna un reviewer al PR
- Espera aprobación
- Si eres el único desarrollador, considera reducir a 0 reviewers requeridos

### No puedo hacer push a mi feature branch

- Branch protection solo aplica a `main` (y `develop` si configuraste)
- Verifica que estás en tu feature branch: `git branch`
- Verifica el nombre de la rama: `git push origin <nombre-correcto>`

---

## 📚 Referencias

- [GitHub Branch Protection](https://docs.github.com/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches)
- [CODEOWNERS Documentation](https://docs.github.com/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-owners)
- [GitHub CLI](https://cli.github.com/)
- [Conventional Commits](https://www.conventionalcommits.org/)

---

**Última actualización**: Noviembre 2025

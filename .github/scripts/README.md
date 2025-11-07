# 🚀 Scripts de Configuración Automatizada

Esta carpeta contiene scripts PowerShell para automatizar la configuración de los pasos opcionales del proyecto.

## 📋 Scripts Disponibles

### 🎯 `setup-all.ps1` - Script Maestro (RECOMENDADO)

Ejecuta todos los pasos de configuración de forma guiada e interactiva.

```powershell
# Ejecutar todos los pasos
.\.github\scripts\setup-all.ps1

# Comenzar desde un paso específico (ej: desde el paso 3)
.\.github\scripts\setup-all.ps1 -StartStep 3
```

**Incluye**:
- ✅ Paso 1: GitHub Discussions (5 min)
- ✅ Paso 2: GitHub Pages (3 min)
- ✅ Paso 3: Azure Secrets (15 min)
- ✅ Paso 4: Branch Protection (3 min)
- ✅ Paso 5: Codecov (2 min)

**Total**: ~30 minutos para configuración completa

---

### 💬 `setup-discussions.ps1` - GitHub Discussions

Configura GitHub Discussions con categorías y discusiones iniciales.

```powershell
.\.github\scripts\setup-discussions.ps1
```

**Acciones**:
- Abre VS Code con archivos de referencia
- Abre GitHub Discussions en el navegador
- Guía paso a paso para crear categorías
- Templates listos para copiar y pegar

**Archivos de apoyo**:
- `setup-discussions.md` - Guía completa
- `welcome-discussion-content.txt` - Contenido de bienvenida

---

### 📚 `setup-github-pages.ps1` - GitHub Pages

Habilita y configura GitHub Pages para la documentación con MkDocs.

```powershell
.\.github\scripts\setup-github-pages.ps1
```

**Acciones**:
- Abre configuración de Pages en GitHub
- Instrucciones para habilitar Source: GitHub Actions
- Guía para trigger del primer deploy

**Prerequisitos**: MkDocs ya está configurado (✅)

---

## 📁 Archivos de Referencia

### `setup-discussions.md`
Guía completa paso a paso para configurar GitHub Discussions.

### `welcome-discussion-content.txt`
Contenido listo para copiar y pegar en la discusión de bienvenida.

---

## 🎯 Uso Recomendado

### Opción 1: Configuración Completa (30 min)

```powershell
# Navega al directorio del repositorio
cd "c:\Users\TuUsuario\Miembros del capítulo"

# Ejecuta el script maestro
.\.github\scripts\setup-all.ps1
```

El script te guiará por cada paso y abrirá automáticamente:
- Archivos de referencia en VS Code
- Páginas de configuración en el navegador
- Documentación relevante

### Opción 2: Configuración Individual

Ejecuta solo los pasos que necesites:

```powershell
# Solo Discussions
.\.github\scripts\setup-discussions.ps1

# Solo GitHub Pages
.\.github\scripts\setup-github-pages.ps1
```

---

## 📊 Progreso Visual

El script maestro muestra progreso en tiempo real:

```
📊 Progreso: 2 de 5 pasos completados
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
████████████████████░░░░░░░░░░░░░░░░░░░░░░░░░░ 40%
```

---

## ✅ Checklist de Configuración

Después de ejecutar los scripts, verifica:

- [ ] GitHub Discussions habilitado con 6 categorías
- [ ] Discusión de bienvenida creada y pinned
- [ ] FAQ creado en Q&A
- [ ] GitHub Pages habilitado (Source: GitHub Actions)
- [ ] Documentación deployada y accesible
- [ ] 7 secretos de Azure configurados (si aplica)
- [ ] Branch Protection activo en main
- [ ] Codecov integrado y badge funcionando

---

## 🔧 Troubleshooting

### Script no se ejecuta

```powershell
# Habilitar ejecución de scripts (una vez)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### VS Code no se abre

Asegúrate de que `code` esté en el PATH:
```powershell
# Probar comando
code --version
```

### Navegador no se abre

Los scripts usan `Start-Process` que debería funcionar con el navegador predeterminado. Si falla, copia las URLs manualmente del output del script.

---

## 📚 Documentación Relacionada

- [OPTIONAL_STEPS_COMPLETED.md](../OPTIONAL_STEPS_COMPLETED.md) - Resumen completo
- [SECRETS_SETUP.md](../SECRETS_SETUP.md) - Configuración de Azure
- [BRANCH_PROTECTION.md](../BRANCH_PROTECTION.md) - Protección de ramas
- [GITHUB_DISCUSSIONS.md](../GITHUB_DISCUSSIONS.md) - Guía completa de Discussions

---

## 🎉 Resultado Final

Después de ejecutar todos los scripts, tu repositorio tendrá:

✅ **14 badges** en README  
✅ **6 workflows** (3 CI + 3 Deploy)  
✅ **GitHub Discussions** con comunidad activa  
✅ **GitHub Pages** con documentación profesional  
✅ **Azure Deployment** listo (staging + production)  
✅ **Branch Protection** para código seguro  
✅ **Code Coverage** con Codecov integrado  

**🎯 Nivel alcanzado**: Enterprise-Level Repository

---

## 💡 Tips

1. **Ejecuta en horario tranquilo**: Algunos pasos requieren recursos de Azure
2. **Ten credenciales listas**: Azure CLI autenticado
3. **Lee las guías primero**: Entiende cada paso antes de ejecutar
4. **Toma capturas**: Documenta tu configuración para referencia futura
5. **Pide ayuda en Discussions**: Si algo falla, pregunta a la comunidad

---

**Creado por**: Sistema automatizado de DevOps  
**Última actualización**: Noviembre 2025  
**Mantenedor**: @CSA-DanielVillamizar

# 🗂️ Guía Rápida: Configuración de Categorías en Discussions

Esta guía te ayudará a configurar las categorías de GitHub Discussions en menos de 3 minutos.

## 📍 Acceso a la Configuración

1. Ve a: https://github.com/CSA-DanielVillamizar/gestiondemiembros/discussions
2. Click en **⚙️ Manage categories** (esquina superior derecha)
3. Verás las categorías existentes y podrás crear nuevas

## ✅ Categorías Recomendadas

### 1️⃣ Announcements (📢)

- **Tipo**: Announcement
- **Descripción**: `Noticias oficiales y actualizaciones del proyecto`
- **Configuración**:
  - ✅ Solo maintainers pueden crear discusiones
  - ✅ Solo maintainers pueden comentar (opcional)
  - Emoji: 📢

### 2️⃣ Ideas (💡)

- **Tipo**: Open-ended discussion
- **Descripción**: `Propuestas de nuevas características y mejoras para el sistema`
- **Configuración**:
  - ✅ Cualquiera puede crear y comentar
  - Emoji: 💡

### 3️⃣ Q&A (❓)

- **Tipo**: Question / Answer
- **Descripción**: `Preguntas técnicas sobre instalación, uso y desarrollo`
- **Configuración**:
  - ✅ Cualquiera puede crear y comentar
  - ✅ Habilitar "Mark as answer"
  - Emoji: ❓

### 4️⃣ General (💬)

- **Tipo**: Open-ended discussion
- **Descripción**: `Conversación general sobre el proyecto`
- **Configuración**:
  - ✅ Cualquiera puede crear y comentar
  - Emoji: 💬

### 5️⃣ Show and Tell (🎨)

- **Tipo**: Open-ended discussion
- **Descripción**: `Comparte proyectos, personalizaciones o casos de uso del sistema`
- **Configuración**:
  - ✅ Cualquiera puede crear y comentar
  - Emoji: 🎨

### 6️⃣ Troubleshooting (🔧)

- **Tipo**: Question / Answer
- **Descripción**: `Ayuda para resolver problemas y errores específicos`
- **Configuración**:
  - ✅ Cualquiera puede crear y comentar
  - ✅ Habilitar "Mark as answer"
  - Emoji: 🔧

## 🎯 Pasos de Configuración

### Opción A: Interfaz Web

```bash
1. Click en "New category"
2. Ingresa el nombre (ej: "Ideas")
3. Selecciona el tipo (ej: "Open-ended discussion")
4. Agrega la descripción
5. Selecciona el emoji
6. Click en "Create"
7. Repite para cada categoría
```

### Opción B: GitHub CLI (Más rápido)

```powershell
# Actualmente GitHub CLI no soporta crear categorías de discussions
# Debes usar la interfaz web
```

## 📝 Plantilla de Discusión de Bienvenida

Una vez configuradas las categorías, crea la primera discusión:

1. Click en **New discussion**
2. Selecciona categoría: **Announcements**
3. Título: `🎉 ¡Bienvenidos a las Discusiones!`
4. Copia el contenido de `welcome.md` en este directorio
5. Click en **Start discussion**

## 🔄 Categorías por Defecto a Eliminar (Opcional)

GitHub crea automáticamente:

- **General**: Puedes mantenerla o personalizarla
- **Ideas**: Puedes mantenerla o ajustar su descripción
- **Polls**: Puedes eliminarla si no planeas usarla
- **Show and tell**: Puedes mantenerla o ajustar su descripción

Para eliminar una categoría:
1. Click en **⚙️** junto a la categoría
2. Click en **Delete category**
3. Confirma la acción

## ✨ Resultado Final

Después de la configuración tendrás:

```
📢 Announcements (3 discussions)
💡 Ideas (0 discussions)
❓ Q&A (0 discussions)
💬 General (0 discussions)
🎨 Show and Tell (0 discussions)
🔧 Troubleshooting (0 discussions)
```

## 🎨 Personalización Adicional

### Pinned Discussions

Fija la discusión de bienvenida:
1. Abre la discusión de bienvenida
2. Click en **⋯** (tres puntos)
3. Selecciona **Pin discussion**
4. Esto la mantendrá al tope de la lista

### Labels para Discussions

Puedes crear etiquetas específicas:
- `enhancement`
- `documentation`
- `good first issue`
- `help wanted`

Ve a: Settings → Features → Discussions → Manage labels

## 📊 Estadísticas y Moderación

Para ver estadísticas:
- Ve a **Insights** → **Community**
- Verás métricas de participación en discussions

Para moderar:
- Puedes convertir Issues en Discussions
- Marcar respuestas como correctas (en Q&A)
- Cerrar, bloquear o transferir discussions

## 🔗 Referencias

- [Documentación oficial de GitHub Discussions](https://docs.github.com/en/discussions)
- [Mejores prácticas para moderación](https://docs.github.com/en/discussions/managing-discussions-for-your-community/moderating-discussions)
- [Código de Conducta del proyecto](../../CODE_OF_CONDUCT.md)

---

**Tiempo estimado**: 3-5 minutos para configurar todas las categorías.

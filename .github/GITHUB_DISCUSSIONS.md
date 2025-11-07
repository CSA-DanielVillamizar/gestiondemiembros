# 💬 Guía para Habilitar GitHub Discussions

Esta guía explica cómo habilitar y configurar GitHub Discussions para tu repositorio.

## ¿Qué son GitHub Discussions?

GitHub Discussions es una plataforma de comunicación comunitaria integrada en tu repositorio que permite:

- ✅ Preguntas y respuestas (Q&A)
- ✅ Anuncios del proyecto
- ✅ Ideas y propuestas
- ✅ Encuestas a la comunidad
- ✅ Discusiones generales
- ✅ Mostrar trabajo de la comunidad

**Diferencia con Issues**: 
- **Issues**: Para rastrear bugs y trabajo específico
- **Discussions**: Para conversaciones abiertas y colaboración comunitaria

---

## 🚀 Habilitar Discussions

### Método 1: GitHub Web UI (Recomendado)

1. **Navegar a Settings**
   - Ve a tu repositorio: https://github.com/CSA-DanielVillamizar/gestiondemiembros
   - Click en **Settings** (pestaña superior)

2. **Habilitar Features**
   - En la sección **"Features"**
   - Marca el checkbox **"Discussions"**
   - Click en **"Set up discussions"** si aparece

3. **Configuración Inicial**
   - GitHub creará automáticamente las categorías predeterminadas
   - Verás una nueva pestaña **"Discussions"** en tu repositorio

### Método 2: GitHub CLI

```bash
# Login si no lo has hecho
gh auth login

# Habilitar discussions
gh repo edit CSA-DanielVillamizar/gestiondemiembros --enable-discussions
```

---

## 📋 Configurar Categorías

### Categorías Recomendadas

GitHub crea algunas categorías por defecto. Aquí están las recomendadas para este proyecto:

1. **📢 Announcements** (Anuncios)
   - Tipo: Announcement
   - Descripción: Actualizaciones y noticias del proyecto
   - Solo mantenedores pueden crear posts

2. **💡 Ideas** (Ideas y Propuestas)
   - Tipo: Idea
   - Descripción: Comparte ideas para nuevas características
   - Permite votación

3. **❓ Q&A** (Preguntas y Respuestas)
   - Tipo: Question
   - Descripción: Haz preguntas sobre el proyecto
   - Permite marcar respuestas como solución

4. **🗣️ General** (General)
   - Tipo: Open Discussion
   - Descripción: Discusiones generales sobre el proyecto

5. **🎨 Show and Tell** (Muestra tu Trabajo)
   - Tipo: Open Discussion
   - Descripción: Comparte cómo estás usando L.A.M.A. Medellín

6. **🐛 Troubleshooting** (Solución de Problemas)
   - Tipo: Question
   - Descripción: Ayuda con problemas de instalación o configuración

### Crear/Editar Categorías

1. Ve a **Discussions** → **Categories** (⚙️ Settings)
2. Click en **"New category"** o edita una existente
3. Configura:
   - **Name**: Nombre de la categoría
   - **Description**: Descripción breve
   - **Discussion format**: Announcement, Q&A, o Open-ended
   - **Emoji**: Elige un emoji representativo
4. Click en **"Create"** o **"Save changes"**

---

## 🎯 Crear Discussions de Bienvenida

### 1. Welcome Discussion

Crea una discussion de bienvenida en **Announcements**:

**Título**: 🎉 ¡Bienvenido a las Discusiones de L.A.M.A. Medellín!

**Contenido**:
```markdown
# 👋 ¡Bienvenido!

Gracias por unirte a nuestra comunidad de L.A.M.A. Medellín - Sistema de Gestión de Miembros.

## 📚 Cómo Usar las Discusiones

- **💡 Ideas**: Comparte ideas para nuevas características
- **❓ Q&A**: Haz preguntas sobre instalación, configuración o uso
- **🐛 Troubleshooting**: Obtén ayuda con problemas técnicos
- **🎨 Show and Tell**: Muestra cómo estás usando el sistema
- **📢 Announcements**: Mantente al día con las últimas noticias

## 🤝 Código de Conducta

Por favor, lee nuestro [Código de Conducta](../CODE_OF_CONDUCT.md) antes de participar.

## 🔗 Enlaces Útiles

- [Documentación](../README.md)
- [Guía de Contribución](../CONTRIBUTING.md)
- [Reportar un Bug](../issues/new?template=bug_report.md)
- [Solicitar una Característica](../issues/new?template=feature_request.md)

¡Esperamos ver tus contribuciones! 🚀
```

### 2. FAQ Discussion

Crea una discussion en **Q&A**:

**Título**: 📖 Preguntas Frecuentes (FAQ)

**Contenido**:
```markdown
# Preguntas Frecuentes

## ❓ ¿Qué es L.A.M.A. Medellín?

Es un sistema web de gestión de miembros para el capítulo L.A.M.A. Medellín, construido con React + TypeScript y ASP.NET Core 8.

## 🚀 ¿Cómo empiezo?

Revisa nuestra [Guía de Inicio Rápido](../QUICKSTART.md).

## 🐳 ¿Puedo usar Docker?

¡Sí! Tenemos una [Guía Completa de Docker](../DOCKER.md).

## 🔐 ¿Cómo reporto vulnerabilidades?

Lee nuestra [Política de Seguridad](../SECURITY.md).

## 💻 ¿Cómo contribuyo?

Revisa nuestra [Guía de Contribución](../CONTRIBUTING.md).

---

*¿Tu pregunta no está aquí? Crea una nueva discussion en Q&A.*
```

---

## 🎨 Personalizar Apariencia

### Pinear Discussions Importantes

1. Ve a la discussion que quieres pinear
2. Click en el menú **"..."** (tres puntos)
3. Selecciona **"Pin discussion"**
4. La discussion aparecerá en la parte superior

### Bloquear Discussions

Para discusiones que ya no necesitan más comentarios:

1. Ve a la discussion
2. Click en el menú **"..."**
3. Selecciona **"Lock discussion"**

### Transferir a Issue

Si una discussion se convierte en bug o feature request:

1. Ve a la discussion
2. Click en el menú **"..."**
3. Selecciona **"Convert to issue"**

---

## 📊 Moderación

### Asignar Moderadores

1. **Settings** → **Moderation**
2. **Manage access** → **Add people**
3. Selecciona usuarios y asigna rol de **"Moderator"**

### Configurar Moderación Automática

1. **Settings** → **Moderation settings**
2. Habilita:
   - **Limit interactions**: Limita quién puede comentar
   - **Lock discussions**: Bloquea automáticamente discusiones antiguas
   - **Mark as duplicate**: Marca discusiones duplicadas

### Categorías Moderadas

Para **Announcements**, solo permitir que mantenedores creen posts:

1. **Discussions** → **Categories**
2. Edit **Announcements**
3. Marca **"Only maintainers can create discussions"**

---

## 🔔 Notificaciones

### Para Usuarios

Usuarios pueden subscribirse a:
- Todas las discussions
- Discussions específicas
- Categorías específicas

### Para Mantenedores

Configura notificaciones en:
- **Settings** → **Notifications** → **Watching**
- Selecciona **"Participating and @mentions"** o **"All Activity"**

---

## 📈 Análisis y Métricas

### Insights de Discussions

1. Ve a **Insights** → **Community**
2. Revisa métricas de:
   - Nuevas discussions
   - Comentarios
   - Participantes únicos
   - Discussions resueltas (Q&A)

### Exportar Discussions

```bash
# Usando GitHub CLI
gh api graphql -f query='
  query($owner: String!, $repo: String!) {
    repository(owner: $owner, name: $repo) {
      discussions(first: 100) {
        nodes {
          title
          body
          createdAt
          author {
            login
          }
        }
      }
    }
  }
' -F owner=CSA-DanielVillamizar -F repo=gestiondemiembros
```

---

## 🎯 Mejores Prácticas

### ✅ Hacer

- Responder rápidamente a Q&A
- Usar emojis para reacciones
- Marcar respuestas correctas en Q&A
- Pinear discussions importantes
- Mantener categorías organizadas
- Agradecer contribuciones
- Linkear a documentación relevante

### ❌ Evitar

- Ignorar preguntas de la comunidad
- Crear demasiadas categorías
- Usar discussions para bugs (usar Issues)
- Permitir discusiones off-topic
- Dejar Q&A sin resolver
- Ser descortés o impaciente

---

## 🔗 Integración con Issues/PRs

### Linkear Discussion a Issue

En el Issue, menciona la discussion:
```markdown
Related to discussion #123
```

### Convertir Discussion a Issue

Usa el botón **"Convert to issue"** en la discussion.

### Mencionar en PR

En el PR description:
```markdown
Implements ideas from discussion #456
```

---

## 📢 Promover Discussions

### En el README

Agrega un badge y enlace:

```markdown
[![Discussions](https://img.shields.io/github/discussions/CSA-DanielVillamizar/gestiondemiembros)](https://github.com/CSA-DanielVillamizar/gestiondemiembros/discussions)
```

### En Issue Templates

Agrega enlace en `.github/ISSUE_TEMPLATE/config.yml`:

```yaml
contact_links:
  - name: 💬 Discussions
    url: https://github.com/CSA-DanielVillamizar/gestiondemiembros/discussions
    about: Ask questions and discuss with the community
```

### En Redes Sociales

- Anuncia discussions importantes en Twitter/LinkedIn
- Comparte enlaces a discussions interesantes
- Invita a la comunidad a participar

---

## 🆘 Troubleshooting

### No veo la pestaña Discussions

- Verifica que tengas permisos de admin
- Asegúrate de haber habilitado la feature en Settings
- Refresca la página del repositorio

### No puedo crear categorías

- Solo admins pueden crear/editar categorías
- Verifica tus permisos de repositorio

### Spam en Discussions

1. **Settings** → **Moderation**
2. Habilita **"Limit interactions to existing users"**
3. Bloquea usuarios problemáticos
4. Reporta spam a GitHub

---

## 📚 Referencias

- [GitHub Discussions Documentation](https://docs.github.com/discussions)
- [Best Practices for Discussions](https://docs.github.com/discussions/guides/best-practices-for-community-conversations-on-github)
- [Moderating Discussions](https://docs.github.com/discussions/managing-discussions-for-your-community/moderating-discussions)

---

## ✅ Checklist de Configuración

- [ ] Habilitar Discussions en Settings
- [ ] Configurar categorías recomendadas
- [ ] Crear discussion de bienvenida
- [ ] Crear FAQ discussion
- [ ] Pinear discussions importantes
- [ ] Configurar moderación
- [ ] Agregar badge al README
- [ ] Actualizar issue template config
- [ ] Asignar moderadores
- [ ] Promover en redes sociales

---

**Última actualización**: Noviembre 2025

# 🚀 Script Automatizado: Configuración Completa de Discussions

## ⚡ Configuración Rápida (5 minutos total)

### Paso 1: Crear Categorías (2 minutos)

Abre: https://github.com/CSA-DanielVillamizar/gestiondemiembros/discussions

Click en **⚙️ Manage categories** y crea estas 6 categorías copiando exactamente:

#### 📢 Announcements
```
Nombre: Announcements
Tipo: Announcement
Descripción: Noticias oficiales y actualizaciones del proyecto
Emoji: 📢
```

#### 💡 Ideas
```
Nombre: Ideas
Tipo: Open-ended discussion
Descripción: Propuestas de nuevas características y mejoras para el sistema
Emoji: 💡
```

#### ❓ Q&A
```
Nombre: Q&A
Tipo: Question / Answer
Descripción: Preguntas técnicas sobre instalación, uso y desarrollo
Emoji: ❓
```

#### 💬 General
```
Nombre: General
Tipo: Open-ended discussion
Descripción: Conversación general sobre el proyecto
Emoji: 💬
```

#### 🎨 Show and Tell
```
Nombre: Show and Tell
Tipo: Open-ended discussion
Descripción: Comparte proyectos, personalizaciones o casos de uso del sistema
Emoji: 🎨
```

#### 🔧 Troubleshooting
```
Nombre: Troubleshooting
Tipo: Question / Answer
Descripción: Ayuda para resolver problemas y errores específicos
Emoji: 🔧
```

### Paso 2: Crear Discusión de Bienvenida (2 minutos)

1. Click en **New discussion**
2. Categoría: **Announcements**
3. Título: `🎉 ¡Bienvenidos a las Discusiones!`
4. Copia TODO el contenido de `.github/DISCUSSION_TEMPLATES/welcome.md`
5. Click en **Start discussion**
6. En la discusión creada: Click **⋯** → **Pin discussion**

### Paso 3: Crear FAQ (1 minuto)

1. Click en **New discussion**
2. Categoría: **Q&A**
3. Título: `📚 Preguntas Frecuentes (FAQ)`
4. Contenido:

```markdown
# 📚 Preguntas Frecuentes

## Instalación y Configuración

### ¿Cómo instalo el sistema localmente?
Ver nuestra [Guía de Instalación](../../INSTALACION.md) completa.

**Inicio rápido (10 minutos)**:
1. Clona el repositorio
2. Ejecuta `docker-compose up -d`
3. Abre http://localhost:5173

Más detalles: [QUICKSTART.md](../../QUICKSTART.md)

### ¿Qué prerrequisitos necesito?
- **Docker Desktop** (recomendado) O
- **.NET 8 SDK** + **Node.js 20** + **SQL Server**

### ¿Cómo configuro la base de datos?
Con Docker: automático
Sin Docker: Ver [INSTALACION.md](../../INSTALACION.md#base-de-datos)

## Desarrollo

### ¿Cómo ejecuto el proyecto en modo desarrollo?
**Backend**:
```bash
cd backend/src/LAMAMedellin.API
dotnet run
```

**Frontend**:
```bash
cd frontend
npm run dev
```

### ¿Cómo ejecuto los tests?
**Backend**:
```bash
cd backend
dotnet test
```

**Frontend**:
```bash
cd frontend
npm test
```

### ¿Cómo contribuyo al proyecto?
Lee nuestra [Guía de Contribución](../../CONTRIBUTING.md).

Resumen:
1. Fork el repositorio
2. Crea una rama: `git checkout -b feature/mi-feature`
3. Haz commits descriptivos
4. Envía un Pull Request

## Problemas Comunes

### Error de conexión a la base de datos
**Solución**: Verifica que SQL Server esté corriendo:
```bash
docker-compose ps
```

### El frontend no conecta con el backend
**Solución**: Verifica VITE_API_BASE_URL en `.env`:
```
VITE_API_BASE_URL=http://localhost:5000
```

### Error 401 en las APIs
**Solución**: La autenticación está preparada pero no implementada. Las APIs actuales no requieren auth.

## Características

### ¿El sistema tiene autenticación?
Está **preparado** para Azure AD B2C pero no implementado aún. Ver issue #XX para seguimiento.

### ¿Puedo personalizar el diseño?
Sí, el frontend usa Material-UI con theming. Ver `frontend/src/theme/`.

### ¿Puedo exportar datos?
Actualmente no, pero está en el roadmap. Vota en la discusión de Ideas.

## Despliegue

### ¿Cómo despliego en Azure?
Ver guía completa: `.github/SECRETS_SETUP.md`

Workflows disponibles:
- `deploy-backend.yml` → Azure App Service
- `deploy-frontend.yml` → Azure Static Web Apps

### ¿Funciona en otros clouds?
Sí, es código estándar .NET + React. Requiere adaptación de workflows.

## Preguntas No Resueltas

¿Tu pregunta no está aquí? 
- **Crea una nueva discusión en Q&A**
- **Revisa Issues existentes**
- **Consulta la documentación completa en README**
```

5. Click en **Start discussion**

### Paso 4: Verificación Final

✅ Verifica que tengas:
- 6 categorías creadas
- Discusión de bienvenida (pinned)
- FAQ creado
- Badge en README (ya está)

## 🎉 ¡Listo!

GitHub Discussions está completamente configurado.

**Próximo paso**: Pasar al paso 2 (Habilitar GitHub Pages)

# 📝 Contenido Listo para Discusiones Iniciales

Este archivo contiene el contenido **listo para copiar y pegar** en cada categoría de GitHub Discussions.

---

## 📢 ANNOUNCEMENTS

### Discusión 1: Bienvenida (⭐ PRINCIPAL - PIN ESTA)

**Add a title:**
```
🎉 ¡Bienvenidos a las Discusiones del Sistema L.A.M.A. Medellín!
```

**Add a body:**
```markdown
¡Hola a todos! 👋

Estamos emocionados de abrir este espacio de **GitHub Discussions** para que la comunidad del **Sistema de Gestión de Miembros L.A.M.A. Medellín** pueda colaborar, compartir ideas y resolver dudas.

## 💬 ¿Qué puedes hacer aquí?

### 💡 Proponer Ideas
¿Tienes una idea para mejorar el sistema? ¡Compártela en la categoría **Ideas**! Todas las sugerencias son bienvenidas.

### ❓ Hacer Preguntas
¿Dudas técnicas? ¿Problemas de instalación? Usa la categoría **Q&A** y la comunidad te ayudará.

### 🔧 Resolver Problemas
Si encuentras un problema o error, visita **Troubleshooting** para obtener ayuda específica.

### 🎨 Mostrar tu Trabajo
¿Has personalizado el sistema? ¿Creaste algo interesante? ¡Compártelo en **Show and Tell**!

### 📢 Mantenerte Informado
Sigue la categoría **Announcements** para recibir noticias, actualizaciones y novedades del proyecto.

### 💬 Conversación General
Para todo lo demás, usa la categoría **General**.

---

## 📋 Categorías Disponibles

| Categoría | Uso |
|-----------|-----|
| 📢 **Announcements** | Noticias oficiales y actualizaciones del proyecto |
| 💡 **Ideas** | Propuestas de nuevas características y mejoras |
| ❓ **Q&A** | Preguntas y respuestas técnicas |
| 💬 **General** | Conversación general sobre el proyecto |
| 🎨 **Show and Tell** | Comparte lo que has creado con este proyecto |
| 🔧 **Troubleshooting** | Ayuda para resolver problemas específicos |

---

## 🤝 Código de Conducta

Este espacio está regido por nuestro [Código de Conducta](https://github.com/CSA-DanielVillamizar/gestiondemiembros/blob/main/CODE_OF_CONDUCT.md). Por favor:

- ✅ Sé respetuoso y constructivo
- ✅ Ayuda a otros miembros
- ✅ Comparte conocimiento
- ✅ Reporta comportamientos inapropiados
- ❌ No hagas spam
- ❌ No compartas contenido ofensivo

---

## 🚀 Enlaces Útiles

- **[README](https://github.com/CSA-DanielVillamizar/gestiondemiembros/blob/main/README.md)** - Documentación principal
- **[Guía de Instalación](https://github.com/CSA-DanielVillamizar/gestiondemiembros/blob/main/INSTALACION.md)** - Cómo configurar el sistema
- **[Quickstart](https://github.com/CSA-DanielVillamizar/gestiondemiembros/blob/main/QUICKSTART.md)** - Inicio rápido en 10 minutos
- **[Guía de Contribución](https://github.com/CSA-DanielVillamizar/gestiondemiembros/blob/main/CONTRIBUTING.md)** - Cómo contribuir
- **[Issues](https://github.com/CSA-DanielVillamizar/gestiondemiembros/issues)** - Reporta bugs o solicita features

---

## 💬 Preguntas Frecuentes Rápidas

### ¿Cómo reporto un bug?
Los bugs se reportan en [Issues](https://github.com/CSA-DanielVillamizar/gestiondemiembros/issues/new/choose), no en Discussions. Usa la plantilla de "Bug Report".

### ¿Puedo proponer cambios al código?
¡Sí! Lee nuestra [Guía de Contribución](https://github.com/CSA-DanielVillamizar/gestiondemiembros/blob/main/CONTRIBUTING.md) y envía un Pull Request.

### ¿Dónde pregunto sobre el uso del sistema?
En la categoría **Q&A** - ¡pregunta lo que necesites!

### ¿Cómo sugiero una nueva característica?
Puedes crear una discusión en **Ideas** o abrir un Issue con la plantilla "Feature Request".

---

## 🎯 Comienza Ahora

1. **Explora las categorías** y familiarízate con cada una
2. **Preséntate** en la categoría General si quieres
3. **Comparte tus ideas** en Ideas
4. **Ayuda a otros** respondiendo preguntas en Q&A

---

**¡Gracias por ser parte de esta comunidad!** 🙌

*El equipo de L.A.M.A. Medellín*
```

**Después de publicar**: Click en `⋯` (tres puntos) → `Pin discussion`

---

## ❓ Q&A

### Discusión 1: FAQ - Preguntas Frecuentes

**Add a title:**
```
📚 Preguntas Frecuentes (FAQ) - ¡Empieza aquí!
```

**Add a body:**
```markdown
# 📚 Preguntas Frecuentes

Esta discusión contiene respuestas a las preguntas más comunes. **Revisa aquí primero** antes de crear una nueva pregunta.

---

## 🚀 Instalación y Configuración

### ¿Cómo instalo el sistema localmente?

**Opción 1: Docker (Recomendado - 5 minutos)**
```bash
# Clonar repositorio
git clone https://github.com/CSA-DanielVillamizar/gestiondemiembros.git
cd gestiondemiembros

# Iniciar con Docker
docker-compose up -d

# Acceder
# Frontend: http://localhost:5173
# Backend: http://localhost:5000
# Swagger: http://localhost:5000/swagger
```

**Opción 2: Manual**
Ver nuestra [Guía de Instalación Completa](https://github.com/CSA-DanielVillamizar/gestiondemiembros/blob/main/INSTALACION.md)

**Inicio Rápido**: [QUICKSTART.md](https://github.com/CSA-DanielVillamizar/gestiondemiembros/blob/main/QUICKSTART.md)

---

### ¿Qué prerequisitos necesito?

**Con Docker:**
- Docker Desktop (Windows/Mac) o Docker Engine (Linux)

**Sin Docker:**
- .NET 8 SDK
- Node.js 20+ y npm
- SQL Server 2019+ o SQL Server Express
- Git

---

### ¿Cómo configuro la base de datos?

**Con Docker**: Se configura automáticamente ✅

**Sin Docker**:
1. Instala SQL Server
2. Crea una base de datos llamada `LAMAMedellin`
3. Actualiza `appsettings.Development.json` con tu connection string
4. Ejecuta las migraciones:
```bash
cd backend
dotnet ef database update
```

Ver: [INSTALACION.md - Sección Base de Datos](https://github.com/CSA-DanielVillamizar/gestiondemiembros/blob/main/INSTALACION.md#base-de-datos)

---

## 💻 Desarrollo

### ¿Cómo ejecuto el proyecto en modo desarrollo?

**Backend:**
```bash
cd backend/src/LAMAMedellin.API
dotnet run
# Corre en http://localhost:5000
```

**Frontend:**
```bash
cd frontend
npm install
npm run dev
# Corre en http://localhost:5173
```

---

### ¿Cómo ejecuto los tests?

**Backend:**
```bash
cd backend
dotnet test

# Con cobertura
dotnet test --collect:"XPlat Code Coverage"
```

**Frontend:**
```bash
cd frontend
npm test

# Con cobertura
npm run test:coverage
```

---

### ¿Cómo contribuyo al proyecto?

1. Lee [CONTRIBUTING.md](https://github.com/CSA-DanielVillamizar/gestiondemiembros/blob/main/CONTRIBUTING.md)
2. Fork el repositorio
3. Crea una rama: `git checkout -b feature/mi-caracteristica`
4. Haz commits descriptivos
5. Envía un Pull Request

**Importante**: Sigue las plantillas de PR y el código de conducta.

---

## 🔧 Problemas Comunes

### Error: "Cannot connect to SQL Server"

**Solución con Docker:**
```bash
# Verifica que SQL Server esté corriendo
docker-compose ps

# Si no está corriendo
docker-compose up -d sql-server

# Espera 30 segundos para que inicie
```

**Solución sin Docker:**
- Verifica que SQL Server esté instalado y corriendo
- Verifica el connection string en `appsettings.Development.json`
- Verifica que el puerto 1433 esté abierto

---

### Error: "Frontend cannot connect to backend"

**Solución:**
1. Verifica que el backend esté corriendo en `http://localhost:5000`
2. Verifica el archivo `.env` en la carpeta `frontend`:
```env
VITE_API_BASE_URL=http://localhost:5000
```
3. Reinicia el servidor de desarrollo del frontend

---

### Error: "Port 5000 already in use"

**Solución:**
```bash
# Windows
netstat -ano | findstr :5000
taskkill /PID <PID> /F

# Linux/Mac
lsof -ti:5000 | xargs kill -9
```

O cambia el puerto en `launchSettings.json`

---

### Error 401: Unauthorized en las APIs

**Explicación**: La autenticación con Azure AD B2C está **preparada pero no implementada** aún.

**Solución actual**: Las APIs públicas no requieren autenticación por ahora.

**Futuro**: Seguir el issue para implementación completa de auth.

---

## 🎯 Características

### ¿El sistema tiene autenticación?

**Estado actual**: Preparado para Azure AD B2C pero no implementado.

**Mientras tanto**: Las APIs son públicas para desarrollo.

**Roadmap**: Ver discusión en Ideas para seguimiento.

---

### ¿Puedo exportar datos a Excel/PDF?

**Actualmente**: No está implementado.

**Roadmap**: Está en la lista de características futuras. Vota en la discusión de Ideas.

---

### ¿Puedo personalizar el diseño del frontend?

**Sí**: El frontend usa Material-UI con sistema de theming.

**Archivos a modificar**:
- `frontend/src/theme/theme.ts` - Colores y estilos
- `frontend/src/theme/components.ts` - Componentes personalizados

**Documentación**: Ver comentarios en los archivos de tema.

---

## ☁️ Despliegue

### ¿Cómo despliego en Azure?

**Guía completa**: [.github/SECRETS_SETUP.md](https://github.com/CSA-DanielVillamizar/gestiondemiembros/blob/main/.github/SECRETS_SETUP.md)

**Requisitos**:
- Cuenta de Azure
- Azure CLI instalado
- Configurar secrets en GitHub

**Workflows disponibles**:
- `deploy-backend.yml` → Azure App Service
- `deploy-frontend.yml` → Azure Static Web Apps

---

### ¿Funciona en otros servicios cloud?

**Sí**: El código es estándar .NET 8 y React.

**Opciones**:
- AWS (Elastic Beanstalk + S3)
- Google Cloud (Cloud Run + Cloud Storage)
- Heroku
- DigitalOcean

**Nota**: Requiere adaptar los workflows de GitHub Actions.

---

## 📱 Uso del Sistema

### ¿Cómo agrego un nuevo miembro?

1. Ve a la sección "Miembros"
2. Click en "Agregar Miembro"
3. Completa el formulario
4. Click en "Guardar"

---

### ¿Cómo asigno un miembro a un comité?

1. Ve al detalle del miembro
2. Sección "Comités"
3. Selecciona el comité del dropdown
4. Click en "Agregar"

---

## ❓ Preguntas No Resueltas

**¿Tu pregunta no está aquí?**

1. **Busca** en discusiones existentes
2. **Revisa** los [Issues](https://github.com/CSA-DanielVillamizar/gestiondemiembros/issues) del repositorio
3. **Crea una nueva discusión** en Q&A con tu pregunta
4. **Consulta** la documentación completa en [README](https://github.com/CSA-DanielVillamizar/gestiondemiembros/blob/main/README.md)

---

## 🆘 ¿Necesitas más ayuda?

- **Problemas técnicos**: Categoría **Troubleshooting**
- **Preguntas generales**: Esta categoría (**Q&A**)
- **Reportar bugs**: [Issues](https://github.com/CSA-DanielVillamizar/gestiondemiembros/issues/new/choose)
- **Proponer features**: Categoría **Ideas**

---

**Última actualización**: Noviembre 2025  
**Mantenido por**: Comunidad L.A.M.A. Medellín

*Si esta información te ayudó, marca la respuesta como solución ✓*
```

---

## 💡 IDEAS

### Discusión 1: Roadmap de Características

**Add a title:**
```
💡 Roadmap de Características Futuras - ¡Vota y Propone!
```

**Add a body:**
```markdown
# 💡 Ideas para el Futuro del Sistema

¿Qué características te gustaría ver en el **Sistema de Gestión de Miembros L.A.M.A. Medellín**?

**Vota con 👍 las ideas que más te interesen** y comenta con tus sugerencias.

---

## 🔐 Autenticación y Seguridad

### 🎯 Prioridad Alta

- [ ] **Implementar Azure AD B2C completamente**
  - Login con Microsoft
  - Gestión de usuarios
  - Tokens JWT
  
- [ ] **Sistema de roles y permisos**
  - Administrador
  - Editor
  - Lector
  - Permisos granulares por módulo

### 🔹 Prioridad Media

- [ ] **Autenticación de dos factores (2FA)**
  - SMS
  - Aplicación autenticadora
  - Email

- [ ] **Auditoría de cambios**
  - Log de quién modificó qué
  - Historial de cambios
  - Exportar auditoría

---

## 📊 Funcionalidades del Sistema

### 🎯 Prioridad Alta

- [ ] **Exportar datos**
  - Excel (.xlsx)
  - PDF
  - CSV
  - Filtros personalizados

- [ ] **Importar miembros desde archivos**
  - CSV con validación
  - Excel
  - Mapeo de columnas

- [ ] **Dashboard personalizable**
  - Widgets arrastrables
  - Métricas personalizadas
  - Preferencias por usuario

### 🔹 Prioridad Media

- [ ] **Sistema de notificaciones**
  - Email automático
  - Notificaciones in-app
  - Recordatorios
  - Templates personalizables

- [ ] **Búsqueda avanzada**
  - Filtros múltiples
  - Búsqueda por texto completo
  - Guardar búsquedas

- [ ] **Gestión de documentos**
  - Subir archivos por miembro
  - Almacenamiento en Azure Blob
  - Versionado de documentos

### 🔹 Prioridad Baja

- [ ] **Modo offline**
  - Progressive Web App (PWA)
  - Sincronización automática
  - Cache local

- [ ] **Tema oscuro/claro**
  - Toggle manual
  - Detección automática del sistema
  - Personalización de colores

---

## 📈 Reportes y Analytics

### 🎯 Prioridad Alta

- [ ] **Reportes predefinidos**
  - Miembros activos vs inactivos
  - Distribución por comités
  - Estadísticas de membresía
  - Gráficos interactivos

- [ ] **Exportación programada de reportes**
  - Cron jobs
  - Email automático
  - Formatos múltiples

### 🔹 Prioridad Media

- [ ] **Dashboard de analytics**
  - Métricas en tiempo real
  - Gráficos de tendencias
  - KPIs personalizados

- [ ] **Reportes de asistencia**
  - Tracking de asistencia a eventos
  - Estadísticas individuales
  - Rankings

---

## 🔌 Integraciones

### 🎯 Prioridad Alta

- [ ] **API pública documentada**
  - OpenAPI 3.0 completo
  - Autenticación con API Keys
  - Rate limiting
  - Documentación interactiva

### 🔹 Prioridad Media

- [ ] **Webhooks**
  - Eventos configurables
  - Callbacks HTTP
  - Retry automático

- [ ] **Integración con Microsoft Teams**
  - Notificaciones
  - Bot de consultas
  - Comandos slash

- [ ] **Sincronización con calendarios**
  - Google Calendar
  - Outlook Calendar
  - iCal export

- [ ] **Integración con Mailchimp**
  - Sincronizar contactos
  - Campañas automáticas
  - Segmentación

---

## 📱 Mobile y Accesibilidad

### 🔹 Prioridad Media

- [ ] **Aplicación móvil nativa**
  - React Native
  - iOS y Android
  - Push notifications

- [ ] **Mejoras de accesibilidad**
  - WCAG 2.1 AA compliance
  - Screen reader support
  - Navegación por teclado

---

## 🛠️ DevOps y Calidad

### 🔹 Prioridad Baja

- [ ] **Tests E2E con Playwright**
  - Cobertura completa
  - CI/CD integration
  - Visual regression testing

- [ ] **Monitoreo con Application Insights**
  - Telemetría
  - Alertas
  - Performance monitoring

- [ ] **Feature flags**
  - Despliegues graduales
  - A/B testing
  - Kill switches

---

## 🎨 UX/UI

### 🔹 Prioridad Media

- [ ] **Tour guiado para nuevos usuarios**
  - Onboarding interactivo
  - Tooltips contextuales
  - Ayuda integrada

- [ ] **Atajos de teclado**
  - Navegación rápida
  - Shortcuts personalizables
  - Cheat sheet

---

## 🌍 Internacionalización

### 🔹 Prioridad Baja

- [ ] **Soporte multi-idioma**
  - Español ✅ (actual)
  - Inglés
  - i18n con react-i18next

---

## 💬 ¿Tienes Más Ideas?

### Cómo Proponer una Nueva Idea

1. **Revisa** si ya existe una propuesta similar
2. **Vota** 👍 en ideas existentes que te gusten
3. **Comenta** con tus sugerencias o mejoras
4. **Crea** una nueva discusión si tu idea es diferente

### Formato Sugerido para Nuevas Ideas

```markdown
## [Nombre de la Característica]

**Problema que resuelve:**
[Describe el problema actual]

**Solución propuesta:**
[Describe cómo funcionaría]

**Beneficios:**
- Beneficio 1
- Beneficio 2

**Alternativas consideradas:**
- Alternativa 1
- Alternativa 2
```

---

## 📊 Estado de Implementación

Las características se priorizarán según:
- 👍 **Votos de la comunidad**
- 🎯 **Impacto en usuarios**
- 🔧 **Complejidad técnica**
- ⏱️ **Tiempo de desarrollo**

**Sigue este roadmap**: Las actualizaciones se publicarán en **Announcements**.

---

**¡Tu opinión importa!** Vota, comenta y propone ideas.

*El equipo de L.A.M.A. Medellín*
```

---

## 💬 GENERAL

### Discusión 1: Presentaciones

**Add a title:**
```
👋 ¡Preséntate! Conoce a la comunidad
```

**Add a body:**
```markdown
# 👋 ¡Bienvenido/a! Preséntate

Esta es una discusión para que los miembros de la comunidad se conozcan entre sí.

---

## 🎯 Comparte sobre ti

Para empezar, cuéntanos:

- **¿Quién eres?** (Nombre, apodo, o como prefieras)
- **¿Qué rol tienes?** (Desarrollador, usuario, contribuidor, curioso...)
- **¿De dónde eres?** (Opcional)
- **¿Cómo conociste este proyecto?**
- **¿Qué te interesa del sistema?**
- **¿En qué te gustaría contribuir?** (Código, documentación, ideas, testing...)

---

## 💡 Ejemplo

> ¡Hola! Soy **Daniel**, desarrollador del sistema. 👨‍💻
> 
> Estoy en **Medellín, Colombia** y creé este proyecto para ayudar a gestionar los miembros del capítulo L.A.M.A. Medellín de forma más eficiente.
> 
> Me apasiona el desarrollo web y la arquitectura limpia en .NET. Siempre estoy abierto a **nuevas ideas** y **contribuciones** de la comunidad.
> 
> ¡Espero que este sistema sea útil para más organizaciones!

---

## 🤝 Conéctate

Si quieres conectar con otros miembros:
- Dale 👍 a presentaciones que te interesen
- Responde para iniciar conversaciones
- Compar te tu experiencia con el sistema

---

**¡Adelante, te leemos!** ✨
```

---

## 🎨 SHOW AND TELL

### Discusión 1: Galería de Proyectos

**Add a title:**
```
🎨 Galería de Proyectos - Muestra lo que has creado
```

**Add a body:**
```markdown
# 🎨 Galería de Proyectos

¿Has personalizado el sistema? ¿Creado algo interesante? ¿Implementado una nueva característica?

**¡Compártelo aquí!** 🚀

---

## 💡 Qué puedes compartir

### 🎨 Personalizaciones
- Temas personalizados
- Cambios en el diseño
- Nuevos componentes UI
- Adaptaciones para tu organización

### 🔧 Extensiones
- Nuevas features implementadas
- Integraciones con otros sistemas
- Scripts de automatización
- Herramientas complementarias

### 📊 Casos de Uso
- Cómo usas el sistema en tu organización
- Métricas de impacto
- Casos de éxito
- Lecciones aprendidas

### 📚 Tutoriales
- Guías que creaste
- Videos explicativos
- Documentación adicional
- Tips y trucos

---

## 📋 Formato Sugerido

```markdown
## [Título de tu Proyecto]

**Descripción:**
[Qué es y qué hace]

**Capturas de pantalla:**
![Screenshot](url-de-imagen)

**Características principales:**
- Feature 1
- Feature 2
- Feature 3

**Tecnologías usadas:**
- Tech 1
- Tech 2

**Link al código/demo:**
[GitHub](url) | [Demo](url)

**Lecciones aprendidas:**
[Qué aprendiste en el proceso]
```

---

## 🎯 Inspírate

### Ejemplos de lo que nos encantaría ver:

- 🎨 **Tema oscuro custom** con colores de tu organización
- 🔌 **Integración con WhatsApp** para notificaciones
- 📱 **Versión móvil optimizada** con PWA
- 📊 **Dashboard de analytics** personalizado
- 🤖 **Bot de Telegram** para consultas rápidas
- 📧 **Templates de email** profesionales
- 🔄 **Script de migración** desde otro sistema

---

## 🏆 Proyectos Destacados

*Los proyectos más innovadores serán destacados en Announcements*

---

## ✨ Inspira a Otros

Tu trabajo puede inspirar a otros miembros de la comunidad y ayudar al proyecto a crecer.

**¡No seas tímido/a, comparte!** 🚀

---

*El equipo de L.A.M.A. Medellín*
```

---

## 🔧 TROUBLESHOOTING

### Discusión 1: Guía de Solución de Problemas

**Add a title:**
```
🔧 Guía Rápida de Troubleshooting - Problemas Comunes
```

**Add a body:**
```markdown
# 🔧 Guía de Solución de Problemas

Esta discusión contiene soluciones a los problemas más comunes. **Revisa aquí primero** antes de crear una nueva discusión.

---

## 🚨 Problemas de Instalación

### ❌ Error: "Docker container won't start"

**Síntomas:**
- El contenedor se detiene inmediatamente
- Error en `docker-compose up`

**Soluciones:**
1. Verifica que Docker Desktop esté corriendo
2. Limpia contenedores antiguos:
```bash
docker-compose down
docker system prune -a
docker-compose up -d
```
3. Verifica los logs:
```bash
docker-compose logs backend
docker-compose logs sql-server
```

---

### ❌ Error: "SQL Server container keeps restarting"

**Solución:**
```bash
# Espera 30-60 segundos, SQL Server tarda en iniciar
docker-compose logs -f sql-server

# Verifica el estado
docker-compose ps

# Si sigue fallando, recrea el contenedor
docker-compose down
docker volume rm gestiondemiembros_sqlserver-data
docker-compose up -d
```

---

### ❌ Error: "npm install fails"

**Soluciones:**
```bash
# Limpia caché
npm cache clean --force

# Borra node_modules
rm -rf node_modules package-lock.json

# Reinstala
npm install

# Si persiste, actualiza npm
npm install -g npm@latest
```

---

## 🌐 Problemas de Backend

### ❌ Error: "Could not connect to SQL Server"

**Connection string incorrecto:**

Verifica `appsettings.Development.json`:
```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Server=localhost,1433;Database=LAMAMedellin;User Id=sa;Password=YourStrong@Password;TrustServerCertificate=True;"
  }
}
```

**Con Docker**: `Server=sql-server,1433`  
**Sin Docker**: `Server=localhost,1433`

---

### ❌ Error: "Migrations failed"

**Solución:**
```bash
cd backend

# Borra la base de datos
dotnet ef database drop -f

# Recrea con migraciones
dotnet ef database update

# Si falla, recrea las migraciones
dotnet ef migrations remove
dotnet ef migrations add InitialCreate
dotnet ef database update
```

---

### ❌ Error 500: "Internal Server Error"

**Diagnóstico:**
1. Revisa los logs del backend:
```bash
docker-compose logs -f backend
```

2. Verifica Swagger: `http://localhost:5000/swagger`

3. Revisa `appsettings.Development.json`

4. Verifica que la base de datos existe

---

## 🎨 Problemas de Frontend

### ❌ Error: "Cannot connect to API"

**Síntomas:**
- Datos no cargan
- Errores CORS
- Network errors

**Soluciones:**

1. Verifica que el backend esté corriendo: `http://localhost:5000/swagger`

2. Revisa el archivo `.env`:
```env
VITE_API_BASE_URL=http://localhost:5000
```

3. Reinicia el frontend:
```bash
npm run dev
```

4. Verifica CORS en el backend (`Program.cs` debe tener `AddCors`)

---

### ❌ Error: "Blank page / White screen"

**Soluciones:**
```bash
# Abre la consola del navegador (F12)
# Revisa errores en Console

# Limpia caché del navegador
# Ctrl + Shift + Delete

# Reconstruye el proyecto
rm -rf node_modules .vite dist
npm install
npm run dev
```

---

### ❌ Error: "Module not found"

**Solución:**
```bash
# Reinstala dependencias
npm install

# Si persiste
rm -rf node_modules package-lock.json
npm install
```

---

## 🐛 Problemas de Tests

### ❌ Tests fallan pero el código funciona

**Solución:**
```bash
# Backend
cd backend
dotnet clean
dotnet build
dotnet test

# Frontend
cd frontend
npm run test:clean
npm test
```

---

## 🔐 Problemas de Autenticación

### ❌ Error 401: Unauthorized

**Explicación:**
La autenticación con Azure AD B2C está **preparada pero no implementada**.

**Solución temporal:**
Las APIs públicas no requieren autenticación por ahora.

**Seguimiento:**
Ver issue #XX para implementación completa de auth.

---

## 📦 Problemas de Deploy

### ❌ Azure deployment fails

**Diagnóstico:**
1. Verifica que los secrets estén configurados
2. Revisa los logs de GitHub Actions
3. Verifica que los recursos de Azure existan
4. Revisa `.github/SECRETS_SETUP.md`

---

## ❓ ¿Problema No Resuelto?

### Crea una nueva discusión

Si tu problema no está aquí:

1. **Click en "New discussion"**
2. **Selecciona la categoría "Troubleshooting"**
3. **Usa este formato:**

```markdown
## [Descripción breve del problema]

**Entorno:**
- OS: [Windows/Mac/Linux]
- Docker: [Sí/No]
- Node version: [18/20/etc]
- .NET version: [8.0]

**Síntomas:**
[Describe qué está pasando]

**Pasos para reproducir:**
1. Paso 1
2. Paso 2
3. Paso 3

**Comportamiento esperado:**
[Qué debería pasar]

**Comportamiento actual:**
[Qué pasa realmente]

**Logs/Errores:**
```
[Pega los logs aquí]
```

**Lo que he intentado:**
- Intento 1
- Intento 2
```

---

## 🆘 Ayuda Adicional

- **FAQ completo**: Categoría Q&A
- **Documentación**: [README](https://github.com/CSA-DanielVillamizar/gestiondemiembros/blob/main/README.md)
- **Guía de instalación**: [INSTALACION.md](https://github.com/CSA-DanielVillamizar/gestiondemiembros/blob/main/INSTALACION.md)
- **Issues**: Para bugs confirmados

---

**¡La comunidad está aquí para ayudar!** 🤝

*Última actualización: Noviembre 2025*
```

---

## 🎯 RESUMEN DE ACCIONES

### Para crear cada discusión:

1. Ve a https://github.com/CSA-DanielVillamizar/gestiondemiembros/discussions
2. Click "New discussion"
3. Selecciona la categoría correspondiente
4. Copia el **título** de arriba
5. Copia el **body** de arriba
6. Click "Start discussion"
7. Para la discusión de Bienvenida: Click `⋯` → "Pin discussion"

### Tiempo estimado total: 10 minutos

- Bienvenida (Announcements): 2 min + pin
- FAQ (Q&A): 2 min
- Roadmap (Ideas): 2 min
- Presentaciones (General): 1 min
- Galería (Show and Tell): 2 min
- Troubleshooting: 2 min

---

**¡Contenido listo para usar!** 🚀

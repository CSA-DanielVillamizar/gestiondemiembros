# 🏛️ L.A.M.A. Medellín — Sistema de Gestión de Miembros

[![Backend CI](https://github.com/CSA-DanielVillamizar/gestiondemiembros/actions/workflows/backend-ci.yml/badge.svg)](https://github.com/CSA-DanielVillamizar/gestiondemiembros/actions/workflows/backend-ci.yml)
[![Frontend CI](https://github.com/CSA-DanielVillamizar/gestiondemiembros/actions/workflows/frontend-ci.yml/badge.svg)](https://github.com/CSA-DanielVillamizar/gestiondemiembros/actions/workflows/frontend-ci.yml)
[![CodeQL](https://github.com/CSA-DanielVillamizar/gestiondemiembros/actions/workflows/codeql-analysis.yml/badge.svg)](https://github.com/CSA-DanielVillamizar/gestiondemiembros/actions/workflows/codeql-analysis.yml)
[![Backend Deploy](https://github.com/CSA-DanielVillamizar/gestiondemiembros/actions/workflows/deploy-backend.yml/badge.svg)](https://github.com/CSA-DanielVillamizar/gestiondemiembros/actions/workflows/deploy-backend.yml)
[![Frontend Deploy](https://github.com/CSA-DanielVillamizar/gestiondemiembros/actions/workflows/deploy-frontend.yml/badge.svg)](https://github.com/CSA-DanielVillamizar/gestiondemiembros/actions/workflows/deploy-frontend.yml)
[![codecov](https://codecov.io/gh/CSA-DanielVillamizar/gestiondemiembros/branch/main/graph/badge.svg)](https://codecov.io/gh/CSA-DanielVillamizar/gestiondemiembros)
[![GitHub Discussions](https://img.shields.io/github/discussions/CSA-DanielVillamizar/gestiondemiembros?logo=github&color=purple)](https://github.com/CSA-DanielVillamizar/gestiondemiembros/discussions)
[![.NET](https://img.shields.io/badge/.NET-8.0-512BD4?logo=dotnet)](https://dotnet.microsoft.com/)
[![React](https://img.shields.io/badge/React-18.3-61DAFB?logo=react)](https://react.dev/)
[![TypeScript](https://img.shields.io/badge/TypeScript-5.3-3178C6?logo=typescript)](https://www.typescriptlang.org/)
[![Material-UI](https://img.shields.io/badge/MUI-5.15-007FFF?logo=mui)](https://mui.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Docker](https://img.shields.io/badge/Docker-Ready-2496ED?logo=docker)](docker-compose.yml)
[![Code of Conduct](https://img.shields.io/badge/Code%20of-Conduct-ff69b4.svg)](CODE_OF_CONDUCT.md)

Sistema web para gestionar miembros del capítulo L.A.M.A. Medellín, con frontend en React + TypeScript y backend en ASP.NET Core 8 siguiendo principios de Clean Architecture.

> 🚀 **Inicio rápido**: [QUICKSTART.md](QUICKSTART.md) te pondrá el sistema funcionando en menos de 10 minutos.

---

## 📑 Tabla de Contenidos

- [🎯 Características](#-características)
- [🏗️ Arquitectura](#️-arquitectura)
- [🚀 Tecnologías](#-tecnologías)
- [📦 Prerequisitos](#-prerequisitos)
- [⚙️ Instalación](#️-instalación)
- [🔧 Configuración](#-configuración)
- [▶️ Ejecución](#️-ejecución)
- [📱 Uso](#-uso)
- [🗄️ Base de Datos](#️-base-de-datos)
- [🚢 Despliegue](#-despliegue)
- [📚 Documentación Adicional](#-documentación-adicional)
- [🤝 Contribución](#-contribución)
- [📄 Licencia](#-licencia)

---

## 🎯 Características

- Dashboard con estadísticas y gráficos interactivos
- CRUD completo de miembros (lista, detalle, crear/editar, eliminar)
- Búsqueda en tiempo real y filtros (estado, tipo membresía)
- Gestión de comités y relación N:N (Miembros–Comités)
- API RESTful documentada con Swagger
- Preparado para autenticación con Azure AD B2C
- Interfaz responsive con Material-UI

---

## 🏗️ Arquitectura

El sistema sigue **Clean Architecture** con separación de responsabilidades:

```
Frontend (React + TS + MUI + Vite)
        ⇅ HTTP (Axios)
API (ASP.NET Core Controllers)
        ⇅
Aplicación (Servicios / Casos de uso)
        ⇅
Infraestructura (EF Core, Repositorios)
        ⇅
Dominio (Entidades, Interfaces)
```

**Diagramas visuales:**
- [ARQUITECTURA_LAMA.drawio](ARQUITECTURA_LAMA.drawio) — Arquitectura completa del sistema
- [ARQUITECTURA_AZURE_LAMA.drawio](ARQUITECTURA_AZURE_LAMA.drawio) — Despliegue en Azure con iconos oficiales

---

## 🚀 Tecnologías

### Backend
- .NET 8.0
- ASP.NET Core Web API
- Entity Framework Core 8.0
- AutoMapper
- Swagger/OpenAPI

### Frontend
- React 18.3
- TypeScript 5.3
- Vite 5.4
- Material-UI 5.15
- React Router 6
- Axios

### Base de Datos
- SQL Server (LocalDB/Express/Azure SQL)

---

## 📦 Prerequisitos

Para ejecutar este proyecto necesitas:

- **Node.js 18+** y npm — [Descargar](https://nodejs.org/)
- **.NET SDK 8.0+** — [Descargar](https://dotnet.microsoft.com/download)
- **SQL Server** (LocalDB incluido con Visual Studio, Express, o Azure SQL)
- **Git** — [Descargar](https://git-scm.com/)

**Verificar instalaciones:**

```powershell
node --version
npm --version
dotnet --version
git --version
```

---

## ⚙️ Instalación

### 1. Clonar el repositorio

```powershell
git clone https://github.com/CSA-DanielVillamizar/gestiondemiembros.git
cd gestiondemiembros
```

### 2. Restaurar dependencias del backend

```powershell
dotnet restore .\backend\src\LAMAMedellin.API\LAMAMedellin.API.csproj
```

### 3. Instalar dependencias del frontend

```powershell
cd .\frontend
npm install
cd ..
```

---

## 🔧 Configuración

### Backend

Edita `backend/src/LAMAMedellin.API/appsettings.Development.json`:

```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Server=(localdb)\\mssqllocaldb;Database=LAMAMedellinDB;Trusted_Connection=true;MultipleActiveResultSets=true"
  }
}
```

**Aplicar migraciones** para crear la base de datos:

```powershell
cd .\backend\src\LAMAMedellin.API
dotnet ef database update --project ..\LAMAMedellin.Infrastructure --startup-project .
```

### Frontend

Crea `frontend/.env.local` con:

```env
VITE_API_BASE_URL=http://localhost:5001/api
VITE_API_TIMEOUT=30000
VITE_DEV_MODE=true
```

---

## ▶️ Ejecución

### Opción 1: Script automatizado (Windows)

```powershell
.\INICIAR-SISTEMA.ps1
```

Este script inicia backend y frontend automáticamente.

### Opción 2: Docker Compose (Recomendado)

```bash
docker-compose up --build
```

Esto inicia **todo el stack** (SQL Server + Backend + Frontend) en contenedores. Ver [DOCKER.md](DOCKER.md) para más detalles.

### Opción 3: Manual

**Terminal 1 — Backend:**

```powershell
cd .\backend\src\LAMAMedellin.API
dotnet run
```

**Terminal 2 — Frontend:**

```powershell
cd .\frontend
npm run dev
```

### URLs de acceso

- **Frontend:** http://localhost:3000
- **API Backend:** http://localhost:5001 (o 5000 con Docker)
- **Swagger UI:** http://localhost:5001/swagger
- **Health Check:** http://localhost:5001/health

---

## 📱 Uso

### Dashboard

Accede a http://localhost:3000 para ver:
- Total de miembros, activos, comités
- Gráficos de distribución por tipo de membresía
- Top 5 ciudades con más miembros
- Nuevos ingresos por mes
- Comités más activos

### Gestión de Miembros

- **Listar:** Navega a "Miembros" para ver la tabla completa
- **Buscar:** Escribe en la barra de búsqueda (nombre, apellido, email)
- **Filtrar:** Usa los filtros por estado y tipo de membresía
- **Crear:** Click en "Nuevo Miembro" y completa el formulario
- **Editar:** Click en el ícono ✏️ o desde la vista de detalle
- **Eliminar:** Click en el ícono 🗑️ y confirma
- **Ver detalle:** Click en el ícono 👁️

---

## 🗄️ Base de Datos

### Tablas principales

- **Miembros** — Información completa de cada miembro
- **Comites** — Comités de la organización
- **MiembrosComites** — Relación N:N entre miembros y comités

### Enums

- `TipoIdentificacion`: Cédula, Pasaporte, NIT, etc.
- `EstadoMiembro`: Activo, Inactivo, Suspendido
- `TipoMembresia`: Regular, Honor, Vitalicio, Temporal

### Comandos de migración

```powershell
cd .\backend\src\LAMAMedellin.API

# Crear nueva migración
dotnet ef migrations add NombreMigracion --project ..\LAMAMedellin.Infrastructure --startup-project .

# Aplicar migraciones
dotnet ef database update --project ..\LAMAMedellin.Infrastructure --startup-project .
```

---

## 🚢 Despliegue

### Arquitectura Azure recomendada

- **Frontend:** Azure Static Web Apps o Azure Storage + CDN
- **Backend:** Azure App Service (.NET 8)
- **Base de Datos:** Azure SQL Database
- **Autenticación:** Azure AD B2C
- **Monitoreo:** Application Insights

Ver guía completa: [docs/DESPLIEGUE_AZURE.md](docs/DESPLIEGUE_AZURE.md)

---

## 📚 Documentación Adicional

- **[QUICKSTART.md](QUICKSTART.md)** — Inicio rápido en < 10 minutos
- **[DOCKER.md](DOCKER.md)** — Guía completa de Docker y Docker Compose
- **[CONTRIBUTING.md](CONTRIBUTING.md)** — Guía para contribuidores
- **[SECURITY.md](SECURITY.md)** — Política de seguridad y reporte de vulnerabilidades
- **[CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md)** — Código de conducta del proyecto
- **[CHANGELOG.md](CHANGELOG.md)** — Historial de versiones
- **[docs/INSTALACION.md](docs/INSTALACION.md)** — Instalación detallada
- **[docs/ARQUITECTURA.md](docs/ARQUITECTURA.md)** — Documentación de arquitectura

---

## 🤝 Contribución

¡Las contribuciones son bienvenidas! Por favor lee [CONTRIBUTING.md](CONTRIBUTING.md) para conocer:

- Código de conducta
- Proceso de desarrollo
- Estándares de código
- Formato de commits
- Proceso de Pull Requests

---

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Ver [LICENSE](LICENSE) para más detalles.

---

## 👥 Autores

- **Daniel Villamizar** — Desarrollo inicial — [@CSA-DanielVillamizar](https://github.com/CSA-DanielVillamizar)

Ver [AUTHORS.md](AUTHORS.md) para la lista completa de contribuidores.

---

**Desarrollado con ❤️ para L.A.M.A. Medellín**

# 🏛️ L.A.M.A. Medellín — Sistema de Gestión de Miembros (Documentación Extendida)

[![.NET](https://img.shields.io/badge/.NET-8.0-512BD4?logo=dotnet)](https://dotnet.microsoft.com/)
[![React](https://img.shields.io/badge/React-18.3-61DAFB?logo=react)](https://react.dev/)
[![TypeScript](https://img.shields.io/badge/TypeScript-5.3-3178C6?logo=typescript)](https://www.typescriptlang.org/)
[![Material-UI](https://img.shields.io/badge/MUI-5.15-007FFF?logo=mui)](https://mui.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

Sistema web para gestionar miembros del capítulo L.A.M.A. Medellín, con frontend en React + TypeScript y backend en ASP.NET Core 8 siguiendo principios de Clean Architecture.

> Si sólo quieres ponerlo a funcionar, usa la guía: [QUICKSTART.md](QUICKSTART.md)

---

## Contenidos

- [Características](#características)
- [Arquitectura](#arquitectura)
- [Tecnologías](#tecnologías)
- [Prerequisitos](#prerequisitos)
- [Instalación](#instalación)
- [Configuración](#configuración)
- [Ejecución](#ejecución)
- [Uso](#uso)
- [Base de Datos](#base-de-datos)
- [Despliegue](#despliegue)
- [Documentación Adicional](#documentación-adicional)
- [Contribución](#contribución)
- [Licencia](#licencia)

---

## Características

- Dashboard con estadísticas y gráficos
- CRUD completo de miembros (lista, detalle, crear/editar, eliminar)
- Búsqueda y filtros (estado, tipo membresía)
- Gestión de comités y relación N:N (Miembros–Comités)
- API documentada con Swagger
- Preparado para Azure AD B2C

---

## Arquitectura

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

Diagramas:
- [ARQUITECTURA_LAMA.drawio](ARQUITECTURA_LAMA.drawio)
- [ARQUITECTURA_AZURE_LAMA.drawio](ARQUITECTURA_AZURE_LAMA.drawio)

---

## Tecnologías

- Backend: .NET 8, ASP.NET Core Web API, EF Core 8, AutoMapper, Swagger
- Frontend: React 18, TypeScript 5, Vite, Material-UI, React Router, Axios
- BD: SQL Server (LocalDB/Express/Azure SQL)

---

## Prerequisitos

- Node.js 18+ y npm
- .NET SDK 8.0+
- SQL Server (LocalDB/Express/Developer/Azure SQL)
- Git

---

## Instalación

```powershell
# Clonar
git clone https://github.com/CSA-DanielVillamizar/gestiondemiembros.git
cd gestiondemiembros

# Backend
dotnet restore .\backend\src\LAMAMedellin.API\LAMAMedellin.API.csproj

# Frontend
cd .\frontend; npm install; cd ..
```

---

## Configuración

Backend (`backend/src/LAMAMedellin.API/appsettings.Development.json`):

```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Server=(localdb)\\\\mssqllocaldb;Database=LAMAMedellinDB;Trusted_Connection=true;MultipleActiveResultSets=true"
  }
}
```

Aplicar migraciones y crear la BD:

```powershell
cd .\backend\src\LAMAMedellin.API
 dotnet ef database update --project ..\LAMAMedellin.Infrastructure --startup-project .
```

Frontend (`frontend/.env.local`):

```env
VITE_API_BASE_URL=http://localhost:5001/api
VITE_API_TIMEOUT=30000
VITE_DEV_MODE=true
```

---

## Ejecución

```powershell
# Terminal 1 - Backend
cd .\backend\src\LAMAMedellin.API
 dotnet run

# Terminal 2 - Frontend
cd .\frontend
 npm run dev
```

- Frontend: http://localhost:3000
- Swagger API: http://localhost:5001/swagger

---

## Uso

- Dashboard: métricas generales (activos, por ciudad, por membresía, altas por mes)
- Miembros: lista, búsqueda, filtros, creación/edición con validación, detalle, eliminar

---

## Base de Datos

Tablas: `Miembros`, `Comites`, `MiembrosComites` (N:N).

Migraciones:

```powershell
cd .\backend\src\LAMAMedellin.API
 dotnet ef migrations add NombreMigracion --project ..\LAMAMedellin.Infrastructure --startup-project .
 dotnet ef database update --project ..\LAMAMedellin.Infrastructure --startup-project .
```

---

## Despliegue

- Frontend: Azure Static Web Apps o Azure Storage + CDN
- Backend: Azure App Service
- BD: Azure SQL Database
- Autenticación: Azure AD B2C

---

## Documentación Adicional

- [QUICKSTART.md](QUICKSTART.md)
- [docs/INSTALACION.md](docs/INSTALACION.md)
- [docs/ARQUITECTURA.md](docs/ARQUITECTURA.md)
- [CHANGELOG.md](CHANGELOG.md)

---

## Contribución

Lee la guía: [CONTRIBUTING.md](CONTRIBUTING.md).

---

## Licencia

MIT — ver [LICENSE](LICENSE).

# 🏛️ L.A.M.A. Medellín - Sistema de Gestión de Miembros# Sistema de Gestión de Miembros - L.A.M.A. Medellín



[![.NET](https://img.shields.io/badge/.NET-8.0-512BD4?logo=dotnet)](https://dotnet.microsoft.com/)Sistema web completo para la gestión de miembros del capítulo L.A.M.A. Medellín, desarrollado con **React + TypeScript** (frontend) y **ASP.NET Core Web API** (backend), siguiendo los principios de **Clean Architecture**.

[![React](https://img.shields.io/badge/React-18.3-61DAFB?logo=react)](https://reactjs.org/)

[![TypeScript](https://img.shields.io/badge/TypeScript-5.3-3178C6?logo=typescript)](https://www.typescriptlang.org/)## 📋 Tabla de Contenidos

[![Material-UI](https://img.shields.io/badge/Material--UI-5.15-007FFF?logo=mui)](https://mui.com/)

[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)- [Características](#características)

- [Arquitectura](#arquitectura)

Sistema integral de gestión de miembros para la Liga de Administradores de Medellín Antioquia (L.A.M.A.), desarrollado con **Clean Architecture** y tecnologías modernas.- [Tecnologías](#tecnologías)

- [Requisitos Previos](#requisitos-previos)

---- [Instalación y Configuración](#instalación-y-configuración)

- [Estructura del Proyecto](#estructura-del-proyecto)

## 📋 Tabla de Contenidos- [Despliegue en Azure](#despliegue-en-azure)

- [Uso](#uso)

- [🎯 Características](#-características)- [Contribuir](#contribuir)

- [🏗️ Arquitectura](#️-arquitectura)

- [🚀 Tecnologías](#-tecnologías)## ✨ Características

- [📦 Prerequisitos](#-prerequisitos)

- [⚙️ Instalación](#️-instalación)### Funcionalidades Principales

- [🔧 Configuración](#-configuración)

- [▶️ Ejecución](#️-ejecución)- ✅ **Gestión Completa de Miembros (CRUD)**

- [📱 Uso del Sistema](#-uso-del-sistema)  - Crear, leer, actualizar y eliminar miembros

- [🗄️ Base de Datos](#️-base-de-datos)  - Búsqueda avanzada y filtros

- [🧪 Testing](#-testing)  - Paginación de resultados

- [🚢 Despliegue](#-despliegue)  - Exportación e importación de datos (Excel/CSV)

- [📚 Documentación Adicional](#-documentación-adicional)

- [🤝 Contribución](#-contribución)- 🔐 **Autenticación Segura**

- [📄 Licencia](#-licencia)  - Integración con Azure AD B2C

  - Login con redes sociales (Facebook, Google)

---  - Gestión de tokens JWT

  - Rutas protegidas

## 🎯 Características

- 📊 **Dashboard y Estadísticas**

### ✨ Funcionalidades Principales  - Visualización de métricas de miembros

  - Gráficos interactivos

- **Dashboard Interactivo**  - Reportes personalizados

  - Estadísticas en tiempo real de miembros

  - Gráficos de distribución por tipo de membresía- 👥 **Gestión de Comités**

  - Top 5 ciudades con más miembros  - Asignación de miembros a comités

  - Análisis de nuevos ingresos por mes  - Roles y coordinadores

  - Comités más activos  - Seguimiento de participación



- **Gestión Completa de Miembros (CRUD)**- 📱 **Interfaz Responsiva**

  - Lista con tabla paginada y ordenable  - Diseño mobile-first con Material-UI

  - Búsqueda en tiempo real  - Experiencia optimizada para todos los dispositivos

  - Filtros por estado y tipo de membresía

  - Formulario de creación/edición con validación## 🏗️ Arquitectura

  - Vista detallada de cada miembro

  - Exportación a Excel (próximamente)### Backend - Clean Architecture



- **Gestión de Comités**El backend sigue los principios de **Clean Architecture** con separación clara de responsabilidades:

  - Creación y administración de comités

  - Asignación de miembros a comités```

  - Visualización de miembros por comitébackend/

├── src/

- **Seguridad**│   ├── LAMAMedellin.Domain/          # Capa de Dominio

  - Autenticación con Azure AD B2C│   │   ├── Entities/                 # Entidades de negocio

  - Autorización basada en roles│   │   └── Interfaces/               # Contratos de repositorios

  - Tokens JWT│   │

  - CORS configurado│   ├── LAMAMedellin.Application/     # Capa de Aplicación

│   │   ├── DTOs/                     # Data Transfer Objects

### 🎨 Experiencia de Usuario│   │   ├── Interfaces/               # Contratos de servicios

│   │   ├── Services/                 # Lógica de negocio

- Interfaz moderna con Material Design│   │   └── Mappings/                 # AutoMapper profiles

- Diseño responsive (móvil, tablet, desktop)│   │

- Navegación intuitiva│   ├── LAMAMedellin.Infrastructure/  # Capa de Infraestructura

- Mensajes de error claros│   │   ├── Data/                     # DbContext y configuración

- Estados de carga visuales│   │   └── Repositories/             # Implementación de repositorios

- Tema personalizable│   │

│   └── LAMAMedellin.API/             # Capa de Presentación

---│       ├── Controllers/              # API Controllers

│       └── Program.cs                # Configuración de la aplicación

## 🏗️ Arquitectura```



El sistema implementa **Clean Architecture** separando las responsabilidades en capas:**Ventajas de Clean Architecture:**

- ✅ Separación de responsabilidades

```- ✅ Testeable y mantenible

┌─────────────────────────────────────────────────┐- ✅ Independencia de frameworks

│          CAPA DE PRESENTACIÓN (Frontend)        │- ✅ Escalabilidad

│  React + TypeScript + Material-UI + Vite        │

└─────────────────────────────────────────────────┘### Frontend - React + TypeScript

                       ▼

┌─────────────────────────────────────────────────┐```

│          CAPA DE API (Controllers)              │frontend/

│         ASP.NET Core Web API                    │├── src/

└─────────────────────────────────────────────────┘│   ├── components/       # Componentes reutilizables

                       ▼│   ├── pages/           # Páginas/vistas de la aplicación

┌─────────────────────────────────────────────────┐│   ├── services/        # Servicios de API

│        CAPA DE APLICACIÓN (Services)            ││   ├── types/           # Definiciones de TypeScript

│     Lógica de negocio y casos de uso           ││   ├── config/          # Configuración (auth, API)

└─────────────────────────────────────────────────┘│   ├── hooks/           # Custom hooks

                       ▼│   └── utils/           # Utilidades

┌─────────────────────────────────────────────────┐```

│      CAPA DE INFRAESTRUCTURA (Data Access)      │

│    Repositories + Entity Framework Core         │## 🛠️ Tecnologías

└─────────────────────────────────────────────────┘

                       ▼### Backend

┌─────────────────────────────────────────────────┐- **.NET 8.0** - Framework principal

│           CAPA DE DOMINIO (Entities)            │- **ASP.NET Core Web API** - API RESTful

│        Entidades y reglas de negocio            │- **Entity Framework Core 8.0** - ORM

└─────────────────────────────────────────────────┘- **Azure SQL Database** - Base de datos

```- **Azure AD B2C** - Autenticación

- **AutoMapper** - Mapeo de objetos

**Ver diagramas detallados:**- **FluentValidation** - Validación

- [Diagrama de Arquitectura General](ARQUITECTURA_LAMA.drawio)- **Serilog** - Logging

- [Diagrama de Arquitectura Azure](ARQUITECTURA_AZURE_LAMA.drawio)

### Frontend

---- **React 18.3** - Librería UI

- **TypeScript 5.3** - Lenguaje tipado

## 🚀 Tecnologías- **Vite** - Build tool

- **Material-UI (MUI) 5.15** - Componentes UI

### Frontend- **React Router 6** - Enrutamiento

- **React** 18.3 - Biblioteca de UI- **Axios** - Cliente HTTP

- **TypeScript** 5.3 - Tipado estático- **MSAL React** - Autenticación Microsoft

- **Material-UI** 5.15 - Componentes UI- **React Hook Form** - Gestión de formularios

- **Vite** 5.4 - Build tool y dev server- **Notistack** - Notificaciones

- **React Router** 6 - Navegación

- **Axios** - Cliente HTTP### Azure Services

- **MSAL.js** - Autenticación Microsoft- **Azure App Service** - Hospedaje backend

- **Azure Static Web Apps** - Hospedaje frontend

### Backend- **Azure SQL Database** - Base de datos

- **ASP.NET Core** 8.0 - Framework web- **Azure AD B2C** - Autenticación y autorización

- **C#** 12 - Lenguaje de programación- **Application Insights** - Monitoreo y telemetría

- **Entity Framework Core** 8.0 - ORM

- **SQL Server** - Base de datos## 📦 Requisitos Previos

- **Swagger/OpenAPI** - Documentación API

- **AutoMapper** - Mapeo de objetos### Desarrollo Local



### Herramientas de Desarrollo- **Visual Studio 2022** (o VS Code con extensiones C#)

- **Visual Studio Code** - Editor- **.NET 8.0 SDK** - [Descargar](https://dotnet.microsoft.com/download/dotnet/8.0)

- **SQL Server Management Studio** - Gestión de BD- **Node.js 18+** y **npm** - [Descargar](https://nodejs.org/)

- **Postman** - Testing de API- **SQL Server** (LocalDB, Express, o Azure SQL)

- **Git** - Control de versiones- **Cuenta de Azure** - [Crear cuenta gratuita](https://azure.microsoft.com/free/)

- **DrawIO** - Diagramas

### Para Producción

---

- **Suscripción de Azure**

## 📦 Prerequisitos- **Azure CLI** - [Instalar](https://docs.microsoft.com/cli/azure/install-azure-cli)

- **Git** - [Descargar](https://git-scm.com/)

Antes de comenzar, asegúrate de tener instalado:

## 🚀 Instalación y Configuración

### ✅ Software Requerido

### 1. Clonar el Repositorio

1. **Node.js** (v18 o superior)

   - Descarga: https://nodejs.org/```bash

   - Verifica instalación: `node --version` y `npm --version`git clone <url-del-repositorio>

cd "Miembros del capítulo"

2. **.NET SDK 8.0** o superior```

   - Descarga: https://dotnet.microsoft.com/download

   - Verifica instalación: `dotnet --version`### 2. Configurar Backend



3. **SQL Server** (LocalDB o Express)#### a) Restaurar paquetes NuGet

   - Opción 1: SQL Server LocalDB (incluido con Visual Studio)

   - Opción 2: SQL Server Express: https://www.microsoft.com/sql-server/sql-server-downloads```bash

   - Opción 3: SQL Server Developer Edition (gratis)cd backend

dotnet restore

4. **Git**```

   - Descarga: https://git-scm.com/

   - Verifica instalación: `git --version`#### b) Configurar Base de Datos



### 🔧 Opcional pero RecomendadoEditar `backend/src/LAMAMedellin.API/appsettings.Development.json`:



- **Visual Studio Code** con extensiones:```json

  - C# Dev Kit{

  - ES7+ React/Redux/React-Native snippets  "ConnectionStrings": {

  - ESLint    "DefaultConnection": "Server=(localdb)\\mssqllocaldb;Database=LAMAMedellinDB;Trusted_Connection=True;MultipleActiveResultSets=true"

  - Prettier  }

  - Draw.io Integration}

```

- **SQL Server Management Studio (SSMS)**

  - Descarga: https://docs.microsoft.com/sql/ssms/download-sql-server-management-studio-ssms#### c) Aplicar Migraciones



- **Postman** para testing de API```bash

  - Descarga: https://www.postman.com/downloads/cd src/LAMAMedellin.API

dotnet ef migrations add InitialCreate --project ../LAMAMedellin.Infrastructure

---dotnet ef database update

```

## ⚙️ Instalación

#### d) Configurar Azure AD B2C

### 1️⃣ Clonar el Repositorio

Editar `appsettings.json`:

```bash

git clone https://github.com/CSA-DanielVillamizar/gestiondemiembros.git```json

cd gestiondemiembros{

```  "AzureAdB2C": {

    "Instance": "https://<your-tenant>.b2clogin.com",

### 2️⃣ Instalar Dependencias del Backend    "ClientId": "<your-client-id>",

    "Domain": "<your-tenant>.onmicrosoft.com",

```bash    "SignUpSignInPolicyId": "B2C_1_signupsignin"

cd backend/src/LAMAMedellin.API  }

dotnet restore}

``````



### 3️⃣ Instalar Dependencias del Frontend#### e) Ejecutar Backend



```bash```bash

cd ../../../frontenddotnet run

npm install```

```

La API estará disponible en `https://localhost:7001`

---

### 3. Configurar Frontend

## 🔧 Configuración

#### a) Instalar dependencias

### Backend Configuration

```bash

#### 1. Configurar la Base de Datoscd frontend

npm install

Edita `backend/src/LAMAMedellin.API/appsettings.Development.json`:```



```json#### b) Configurar Variables de Entorno

{

  "ConnectionStrings": {Crear archivo `.env.local` basado en `.env.example`:

    "DefaultConnection": "Server=(localdb)\\mssqllocaldb;Database=LAMAMedellinDB;Trusted_Connection=true;MultipleActiveResultSets=true"

  }```env

}VITE_API_BASE_URL=https://localhost:7001/api

```VITE_AZURE_AD_B2C_CLIENT_ID=<your-client-id>

VITE_AZURE_AD_B2C_AUTHORITY=https://<your-tenant>.b2clogin.com/<your-tenant>.onmicrosoft.com/B2C_1_signupsignin

**Opciones de Connection String:**VITE_AZURE_AD_B2C_KNOWN_AUTHORITY=<your-tenant>.b2clogin.com

VITE_API_SCOPE=https://<your-tenant>.onmicrosoft.com/api/access_as_user

- **LocalDB** (recomendado para desarrollo):VITE_REDIRECT_URI=http://localhost:3000

  ```VITE_POST_LOGOUT_REDIRECT_URI=http://localhost:3000

  Server=(localdb)\\mssqllocaldb;Database=LAMAMedellinDB;Trusted_Connection=true;```

  ```

#### c) Ejecutar Frontend

- **SQL Server Express**:

  ``````bash

  Server=localhost\\SQLEXPRESS;Database=LAMAMedellinDB;Trusted_Connection=true;npm run dev

  ``````



- **SQL Server con usuario/contraseña**:La aplicación estará disponible en `http://localhost:3000`

  ```

  Server=localhost;Database=LAMAMedellinDB;User Id=sa;Password=TuPassword;## 📁 Estructura del Proyecto

  ```

### Backend

#### 2. Aplicar Migraciones

```

```bashbackend/

cd backend/src/LAMAMedellin.API├── src/

│   ├── LAMAMedellin.Domain/

# Aplicar migraciones para crear la base de datos│   │   ├── Entities/

dotnet ef database update --project ../LAMAMedellin.Infrastructure --startup-project .│   │   │   ├── Miembro.cs               # Entidad principal de miembro

```│   │   │   ├── Comite.cs                # Entidad de comité

│   │   │   └── MiembroComite.cs         # Relación muchos a muchos

#### 3. Cargar Datos de Prueba (Opcional)│   │   └── Interfaces/

│   │       ├── IRepository.cs           # Repositorio genérico

Una vez que el backend esté ejecutándose, puedes cargar datos de prueba:│   │       ├── IMiembroRepository.cs    # Repositorio específico

│   │       └── IUnitOfWork.cs           # Patrón Unit of Work

```bash│   │

# Usando PowerShell│   ├── LAMAMedellin.Application/

Invoke-RestMethod -Uri "http://localhost:5001/api/Seed/load" -Method Post│   │   ├── DTOs/

│   │   │   ├── MiembroDto.cs           # DTO de lectura

# O usando curl│   │   │   ├── CrearMiembroDto.cs      # DTO de creación

curl -X POST http://localhost:5001/api/Seed/load│   │   │   └── ActualizarMiembroDto.cs # DTO de actualización

```│   │   ├── Services/

│   │   │   └── MiembroService.cs       # Lógica de negocio

### Frontend Configuration│   │   └── Mappings/

│   │       └── MappingProfile.cs       # Configuración AutoMapper

#### 1. Configurar Variables de Entorno│   │

│   ├── LAMAMedellin.Infrastructure/

Copia el archivo de ejemplo y edítalo:│   │   ├── Data/

│   │   │   └── LAMADbContext.cs        # Contexto de Entity Framework

```bash│   │   └── Repositories/

cd frontend│   │       ├── Repository.cs           # Implementación genérica

cp .env.example .env.local│   │       ├── MiembroRepository.cs    # Implementación específica

```│   │       └── UnitOfWork.cs           # Implementación UoW

│   │

Edita `.env.local`:│   └── LAMAMedellin.API/

│       ├── Controllers/

```env│       │   └── MiembrosController.cs   # Endpoints de API

# URL del backend│       ├── Program.cs                  # Configuración y startup

VITE_API_BASE_URL=http://localhost:5001/api│       └── appsettings.json           # Configuración

```

# Timeout de la API (ms)

VITE_API_TIMEOUT=30000### Frontend



# Modo desarrollo (true = sin autenticación)```

VITE_DEV_MODE=truefrontend/

├── src/

# Azure AD B2C Configuration (para producción)│   ├── components/

VITE_AZURE_AD_CLIENT_ID=your-client-id-here│   │   └── Layout/

VITE_AZURE_AD_TENANT_NAME=your-tenant-name│   │       └── Layout.tsx              # Layout principal con nav

VITE_AZURE_AD_REDIRECT_URI=http://localhost:3000│   ├── pages/

```│   │   ├── Login.tsx                   # Página de autenticación

│   │   ├── Dashboard.tsx               # Dashboard principal

---│   │   ├── Miembros/

│   │   │   ├── MiembrosList.tsx       # Lista de miembros

## ▶️ Ejecución│   │   │   ├── MiembroDetail.tsx      # Detalle de miembro

│   │   │   └── MiembroForm.tsx        # Formulario crear/editar

### Opción 1: Script Automatizado (Windows PowerShell)│   │   └── NotFound.tsx               # Página 404

│   ├── services/

El proyecto incluye un script que inicia todo automáticamente:│   │   ├── httpClient.ts              # Cliente HTTP con Axios

│   │   └── miembroService.ts          # Servicio API miembros

```bash│   ├── types/

.\INICIAR-SISTEMA.ps1│   │   └── miembro.types.ts           # Tipos TypeScript

```│   ├── config/

│   │   ├── authConfig.ts              # Configuración MSAL

Este script:│   │   └── config.ts                  # Configuración general

- ✅ Detiene procesos anteriores│   ├── App.tsx                        # Componente raíz

- ✅ Compila y ejecuta el backend│   ├── main.tsx                       # Punto de entrada

- ✅ Ejecuta el frontend│   └── theme.ts                       # Tema Material-UI

- ✅ Verifica que los servicios estén funcionando```

- ✅ Abre el navegador automáticamente

## ☁️ Despliegue en Azure

### Opción 2: Manual

### 1. Crear Recursos en Azure

#### Terminal 1 - Backend

```bash

```bash# Iniciar sesión

cd backend/src/LAMAMedellin.APIaz login

dotnet build

dotnet run# Crear grupo de recursos

```az group create --name rg-lama-medellin --location eastus



El backend estará disponible en:# Crear Azure SQL Database

- API: http://localhost:5001az sql server create --name sql-lama-medellin --resource-group rg-lama-medellin --location eastus --admin-user sqladmin --admin-password <YourPassword>

- Swagger: http://localhost:5001/swaggeraz sql db create --resource-group rg-lama-medellin --server sql-lama-medellin --name LAMAMedellinDB --service-objective S0



#### Terminal 2 - Frontend# Crear App Service para Backend

az appservice plan create --name plan-lama-api --resource-group rg-lama-medellin --sku B1

```bashaz webapp create --name api-lama-medellin --resource-group rg-lama-medellin --plan plan-lama-api --runtime "DOTNET|8.0"

cd frontend

npm run dev# Crear Static Web App para Frontend

```az staticwebapp create --name swa-lama-frontend --resource-group rg-lama-medellin --location eastus

```

El frontend estará disponible en:

- App: http://localhost:3000### 2. Configurar Azure AD B2C



---1. Ir al [Azure Portal](https://portal.azure.com)

2. Crear un **Azure AD B2C tenant**

## 📱 Uso del Sistema3. Registrar aplicación (Backend API)

4. Registrar aplicación (Frontend SPA)

### 🏠 Dashboard5. Configurar flujos de usuario (Sign up/Sign in)

6. Configurar proveedores de identidad (Google, Facebook)

1. Abre http://localhost:3000

2. Verás el dashboard con:### 3. Desplegar Backend

   - Total de miembros

   - Miembros activos (con porcentaje)```bash

   - Comités activoscd backend/src/LAMAMedellin.API

   - Miembros inactivos/suspendidosdotnet publish -c Release -o ./publish

   - Distribución por tipo de membresía

   - Top 5 ciudades# Desplegar con Azure CLI

   - Nuevos miembros por mesaz webapp deployment source config-zip --resource-group rg-lama-medellin --name api-lama-medellin --src ./publish.zip

   - Comités más activos

# O usar Visual Studio: clic derecho en proyecto > Publish

### 👥 Gestión de Miembros```



#### Ver Lista de Miembros### 4. Desplegar Frontend

1. Click en **"Miembros"** en el menú lateral

2. Usa la tabla para:```bash

   - **Buscar**: Escribe en el campo de búsquedacd frontend

   - **Filtrar**: Selecciona Estado o Tipo de Membresíanpm run build

   - **Ordenar**: Click en los encabezados de columna

   - **Paginar**: Cambia filas por página# Desplegar con Azure Static Web Apps CLI

npm install -g @azure/static-web-apps-cli

#### Crear Nuevo Miembroswa deploy ./dist --env production

1. Click en **"Nuevo Miembro"**```

2. Completa el formulario:

   - Información Personal (requerida)### 5. Configurar Connection Strings y App Settings

   - Dirección

   - Información Profesional```bash

   - Información de Membresía# Configurar connection string en App Service

3. Click en **"Guardar"**az webapp config connection-string set --name api-lama-medellin --resource-group rg-lama-medellin --connection-string-type SQLAzure --settings DefaultConnection="<your-connection-string>"



#### Ver Detalle de Miembro# Configurar Azure AD B2C settings

1. En la lista, click en el icono 👁️ (Ver)az webapp config appsettings set --name api-lama-medellin --resource-group rg-lama-medellin --settings AzureAdB2C__ClientId="<client-id>" AzureAdB2C__Domain="<domain>"

2. Verás toda la información del miembro```

3. Puedes **Editar** o **Eliminar** desde aquí

## 📖 Uso

#### Editar Miembro

1. Click en el icono ✏️ (Editar) en la lista### Autenticación

2. O desde el detalle, click en **"Editar"**

3. Modifica los campos necesarios1. Acceder a la aplicación

4. Click en **"Actualizar"**2. Hacer clic en "Iniciar Sesión"

3. Elegir método de autenticación:

#### Eliminar Miembro   - Email y contraseña

1. Click en el icono 🗑️ (Eliminar)   - Google

2. Confirma la acción   - Facebook

3. El miembro será eliminado

### Gestión de Miembros

### 📊 API Documentation

#### Crear Miembro

Accede a la documentación interactiva de la API en:1. Navegar a "Miembros" > "Nuevo Miembro"

- **Swagger UI**: http://localhost:5001/swagger2. Completar formulario con datos obligatorios

3. Guardar

Desde aquí puedes:

- Ver todos los endpoints disponibles#### Buscar y Filtrar

- Probar las APIs directamente1. En lista de miembros, usar barra de búsqueda

- Ver los modelos de datos2. Aplicar filtros por estado o tipo de membresía

- Descargar la especificación OpenAPI3. Los resultados se actualizan automáticamente



---#### Editar Miembro

1. Hacer clic en miembro de la lista

## 🗄️ Base de Datos2. Clic en "Editar"

3. Modificar datos

### Estructura de Tablas4. Guardar cambios



El sistema utiliza las siguientes tablas principales:#### Exportar Datos

1. En lista de miembros, clic en "Exportar"

#### Miembros2. Seleccionar formato (Excel/CSV)

```sql3. Descargar archivo

- Id (GUID, PK)

- NumeroIdentificacion (string)## 🧪 Testing

- TipoIdentificacion (int)

- Nombres (string)### Backend

- Apellidos (string)

- Email (string, único)```bash

- Telefono (string, nullable)cd backend

- Celular (string)dotnet test

- Ciudad (string)```

- Estado (int)

- TipoMembresia (int)### Frontend

- FechaIngreso (DateTime)

- ... más campos```bash

```cd frontend

npm test

#### Comites```

```sql

- Id (GUID, PK)## 🔒 Seguridad

- Nombre (string)

- Descripcion (string)- ✅ Autenticación con Azure AD B2C

- FechaCreacion (DateTime)- ✅ Tokens JWT con expiración

- Activo (bool)- ✅ HTTPS obligatorio en producción

```- ✅ Validación de datos en backend y frontend

- ✅ Protección CSRF

#### MiembrosComites (Relación N:N)- ✅ Rate limiting en API

```sql- ✅ Secrets en Azure Key Vault (producción)

- MiembroId (GUID, FK)

- ComiteId (GUID, FK)## 📝 Licencia

- FechaAsignacion (DateTime)

- Cargo (string, nullable)Este proyecto es propiedad del Capítulo L.A.M.A. Medellín.

```

## 👥 Contribuidores

### Enums

- Desarrollador Full Stack: [Tu Nombre]

```csharp- Capítulo L.A.M.A. Medellín

// TipoIdentificacion

1 = Cédula de Ciudadanía## 📞 Soporte

2 = Cédula de Extranjería

3 = PasaportePara soporte técnico o preguntas:

4 = NIT- Email: contacto@lamamedellin.org

- Issues: [GitHub Issues](link-to-issues)

// EstadoMiembro

1 = Activo---

2 = Inactivo

3 = Suspendido**Desarrollado con ❤️ para el Capítulo L.A.M.A. Medellín**


// TipoMembresia
1 = Regular
2 = Honor
3 = Vitalicio
4 = Temporal
```

### Migraciones

Para crear nuevas migraciones:

```bash
cd backend/src/LAMAMedellin.API

# Crear migración
dotnet ef migrations add NombreMigracion --project ../LAMAMedellin.Infrastructure --startup-project .

# Aplicar migración
dotnet ef database update --project ../LAMAMedellin.Infrastructure --startup-project .

# Revertir última migración
dotnet ef database update PreviousMigration --project ../LAMAMedellin.Infrastructure --startup-project .

# Eliminar última migración
dotnet ef migrations remove --project ../LAMAMedellin.Infrastructure --startup-project .
```

---

## 🧪 Testing

### Backend Tests

```bash
cd backend/tests/LAMAMedellin.Tests
dotnet test
```

### Frontend Tests (Próximamente)

```bash
cd frontend
npm run test
```

---

## 🚢 Despliegue

### Azure Cloud

El sistema está diseñado para desplegarse en Azure. Ver documentación detallada:
- [Guía de Despliegue en Azure](DESPLIEGUE_AZURE.md)

**Componentes Azure recomendados:**
- Azure Static Web Apps (Frontend)
- Azure App Service (Backend)
- Azure SQL Database (Base de datos)
- Azure AD B2C (Autenticación)
- Application Insights (Monitoreo)

### Variables de Entorno de Producción

#### Frontend (.env.production)
```env
VITE_API_BASE_URL=https://your-api.azurewebsites.net/api
VITE_DEV_MODE=false
VITE_AZURE_AD_CLIENT_ID=your-production-client-id
VITE_AZURE_AD_TENANT_NAME=your-tenant-name
VITE_AZURE_AD_REDIRECT_URI=https://your-app.azurestaticapps.net
```

#### Backend (appsettings.Production.json)
```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Server=tcp:your-server.database.windows.net,1433;Database=LAMAMedellinDB;..."
  },
  "AzureAdB2C": {
    "Instance": "https://your-tenant.b2clogin.com/",
    "ClientId": "your-client-id",
    "Domain": "your-tenant.onmicrosoft.com",
    "SignUpSignInPolicyId": "B2C_1_signupsignin"
  }
}
```

---

## 📚 Documentación Adicional

- [📖 Implementación Dashboard y Lista](IMPLEMENTACION-DASHBOARD-LISTA.md)
- [🏗️ Diagrama de Arquitectura](ARQUITECTURA_LAMA.drawio)
- [☁️ Diagrama Azure](ARQUITECTURA_AZURE_LAMA.drawio)
- [🚀 Despliegue en Azure](DESPLIEGUE_AZURE.md)
- [📋 Changelog](CHANGELOG.md)

---

## 🤝 Contribución

¡Las contribuciones son bienvenidas! Por favor:

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

### Guías de Contribución

- Sigue los principios de Clean Architecture
- Escribe código limpio y bien documentado
- Agrega pruebas para nuevas funcionalidades
- Actualiza la documentación cuando sea necesario
- Usa commits descriptivos siguiendo [Conventional Commits](https://www.conventionalcommits.org/)

---

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo [LICENSE](LICENSE) para más detalles.

---

## 👥 Autores

- **Daniel Villamizar** - *Desarrollo Inicial* - [CSA-DanielVillamizar](https://github.com/CSA-DanielVillamizar)

---

## 🙏 Agradecimientos

- Liga de Administradores de Medellín Antioquia (L.A.M.A.)
- Comunidad de desarrolladores de .NET y React
- Todos los contribuidores del proyecto

---

## 📞 Soporte

Si tienes preguntas o problemas:

1. Revisa la [documentación](#-documentación-adicional)
2. Busca en los [Issues](https://github.com/CSA-DanielVillamizar/gestiondemiembros/issues) existentes
3. Crea un [nuevo Issue](https://github.com/CSA-DanielVillamizar/gestiondemiembros/issues/new) si es necesario

---

## 🗺️ Roadmap

### ✅ Versión 1.0 (Actual)
- [x] CRUD completo de miembros
- [x] Dashboard con estadísticas
- [x] Búsqueda y filtros
- [x] Gestión de comités básica

### 🚧 Versión 1.1 (Próximamente)
- [ ] Exportación a Excel
- [ ] Importación masiva de datos
- [ ] Reportes personalizados
- [ ] Gestión de pagos de membresías

### 🔮 Versión 2.0 (Futuro)
- [ ] Aplicación móvil nativa
- [ ] Sistema de notificaciones
- [ ] Portal de miembros
- [ ] Integración con sistemas de pago

---

**Desarrollado con ❤️ para L.A.M.A. Medellín**

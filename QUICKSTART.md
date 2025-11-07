# ⚡ Inicio Rápido - L.A.M.A. Medellín

Esta guía te ayudará a tener el sistema funcionando en **menos de 10 minutos**.

---

## 📋 Prerequisitos Mínimos

Antes de comenzar, asegúrate de tener instalado:

- ✅ **Node.js 18+** → [Descargar aquí](https://nodejs.org/)
- ✅ **.NET SDK 8.0+** → [Descargar aquí](https://dotnet.microsoft.com/download)
- ✅ **SQL Server LocalDB** (incluido con Visual Studio) o [SQL Server Express](https://www.microsoft.com/sql-server/sql-server-downloads)
- ✅ **Git** → [Descargar aquí](https://git-scm.com/)

### Verificar Instalaciones

```bash
node --version    # Debería mostrar v18.x.x o superior
npm --version     # Debería mostrar 9.x.x o superior
dotnet --version  # Debería mostrar 8.0.x o superior
git --version     # Debería mostrar 2.x.x o superior
```

---

## 🚀 Instalación en 5 Pasos

### 1️⃣ Clonar el Repositorio

```bash
git clone https://github.com/CSA-DanielVillamizar/gestiondemiembros.git
cd gestiondemiembros
```

### 2️⃣ Configurar el Backend

```bash
# Navegar a la API
cd backend/src/LAMAMedellin.API

# Restaurar paquetes
dotnet restore

# Aplicar migraciones (crear la base de datos)
dotnet ef database update --project ../LAMAMedellin.Infrastructure --startup-project .
```

### 3️⃣ Configurar el Frontend

```bash
# Volver a la raíz del proyecto
cd ../../../frontend

# Instalar dependencias
npm install

# Crear archivo de configuración
cp .env.example .env.local
```

**Edita `.env.local`** y asegúrate que tenga:

```env
VITE_API_BASE_URL=http://localhost:5001/api
VITE_DEV_MODE=true
```

### 4️⃣ Iniciar el Sistema

**Opción A: Script Automatizado (Windows)**

```bash
# Desde la raíz del proyecto
.\INICIAR-SISTEMA.ps1
```

Este script:
- ✅ Inicia el backend automáticamente
- ✅ Inicia el frontend automáticamente
- ✅ Abre el navegador en http://localhost:3000
- ✅ Verifica que todo esté funcionando

**Opción B: Manual**

**Terminal 1 - Backend:**
```bash
cd backend/src/LAMAMedellin.API
dotnet run
```

**Terminal 2 - Frontend:**
```bash
cd frontend
npm run dev
```

### 5️⃣ Cargar Datos de Prueba (Opcional)

Una vez que el backend esté ejecutándose:

```bash
# PowerShell
Invoke-RestMethod -Uri "http://localhost:5001/api/Seed/load" -Method Post

# O usando curl
curl -X POST http://localhost:5001/api/Seed/load
```

Esto creará:
- ✅ 6 miembros de ejemplo
- ✅ 3 comités de ejemplo
- ✅ Relaciones miembros-comités

---

## 🎯 Acceso al Sistema

Una vez iniciado:

### Frontend
- **URL**: http://localhost:3000
- **Login**: No requerido en modo desarrollo

### Backend API
- **URL**: http://localhost:5001
- **Swagger**: http://localhost:5001/swagger

---

## 📱 Uso Básico

### Dashboard
1. Abre http://localhost:3000
2. Verás 4 tarjetas con estadísticas
3. Verás 4 gráficos interactivos

### Gestión de Miembros
1. Click en **"Miembros"** en el menú lateral
2. Ver lista completa de miembros
3. Usa **búsqueda** para filtrar por nombre, apellido, email
4. Usa **filtros** para filtrar por estado o tipo de membresía
5. Click en **"Nuevo Miembro"** para crear uno

### Crear un Miembro
1. Click en **"Nuevo Miembro"**
2. Completa:
   - **Identificación**: Número y tipo
   - **Nombres y Apellidos** (requeridos)
   - **Email** (requerido y único)
   - **Celular** (requerido)
   - **Ciudad** (requerida)
   - **Estado y Tipo de Membresía**
3. Click en **"Guardar"**

### Ver/Editar/Eliminar
- 👁️ **Ver**: Click en el icono de ojo
- ✏️ **Editar**: Click en el icono de lápiz
- 🗑️ **Eliminar**: Click en el icono de basura

---

## 🔧 Troubleshooting Rápido

### ❌ Error: "Cannot connect to database"

**Solución:**
```bash
# Verificar que SQL Server LocalDB esté corriendo
sqllocaldb info

# Si no está, iniciarlo
sqllocaldb start mssqllocaldb

# Volver a aplicar migraciones
cd backend/src/LAMAMedellin.API
dotnet ef database update --project ../LAMAMedellin.Infrastructure --startup-project .
```

### ❌ Error: "Port 5001 already in use"

**Solución:**
```bash
# Windows PowerShell - Detener proceso en puerto 5001
Get-Process -Id (Get-NetTCPConnection -LocalPort 5001).OwningProcess | Stop-Process -Force

# O cambiar puerto en backend/src/LAMAMedellin.API/Properties/launchSettings.json
```

### ❌ Error: "Port 3000 already in use"

**Solución:**
```bash
# Windows PowerShell - Detener proceso en puerto 3000
Get-Process -Id (Get-NetTCPConnection -LocalPort 3000).OwningProcess | Stop-Process -Force
```

### ❌ Error: "Failed to resolve import '../services/api'"

**Solución:**
Esto ya está corregido en la versión actual. Si aún lo ves:
```bash
cd frontend
npm install
```

### ❌ Error: "dotnet: command not found"

**Solución:**
Instala .NET SDK 8.0 desde: https://dotnet.microsoft.com/download

---

## 📊 Datos de Prueba

El sistema incluye estos datos de ejemplo:

### Miembros (6)
- Juan Pérez - Medellín - Activo - Regular
- María García - Bogotá - Activo - Honor
- Carlos López - Cali - Inactivo - Temporal
- Ana Martínez - Barranquilla - Activo - Regular
- Luis Rodríguez - Cartagena - Suspendido - Temporal
- Carmen Díaz - Medellín - Activo - Vitalicio

### Comités (3)
- Comité Académico
- Comité de Eventos
- Comité de Ética

---

## 🎓 Próximos Pasos

Una vez que tengas el sistema funcionando:

1. **Lee la documentación completa**: [README.md](README.md)
2. **Explora la arquitectura**: [ARQUITECTURA_LAMA.drawio](ARQUITECTURA_LAMA.drawio)
3. **Revisa el código**:
   - Backend: `backend/src/`
   - Frontend: `frontend/src/`
4. **Prueba la API**: http://localhost:5001/swagger
5. **Contribuye**: [CONTRIBUTING.md](CONTRIBUTING.md)

---

## 📚 Recursos Adicionales

- [📖 Documentación Completa](README.md)
- [🏗️ Diagrama de Arquitectura](ARQUITECTURA_LAMA.drawio)
- [☁️ Despliegue en Azure](docs/DESPLIEGUE_AZURE.md)
- [🤝 Guía de Contribución](CONTRIBUTING.md)
- [📋 Changelog](CHANGELOG.md)

---

## 💬 ¿Necesitas Ayuda?

Si tienes problemas:

1. Revisa esta guía de nuevo
2. Lee el [README.md](README.md) completo
3. Busca en [GitHub Issues](https://github.com/CSA-DanielVillamizar/gestiondemiembros/issues)
4. Crea un [nuevo issue](https://github.com/CSA-DanielVillamizar/gestiondemiembros/issues/new)

---

**🎉 ¡Disfruta usando L.A.M.A. Medellín!**

---

## ⏱️ Resumen: 5 Comandos para Empezar

```bash
# 1. Clonar
git clone https://github.com/CSA-DanielVillamizar/gestiondemiembros.git
cd gestiondemiembros

# 2. Backend - Restaurar y Migrar
cd backend/src/LAMAMedellin.API
dotnet restore
dotnet ef database update --project ../LAMAMedellin.Infrastructure --startup-project .

# 3. Frontend - Instalar
cd ../../../frontend
npm install

# 4. Configurar
cp .env.example .env.local

# 5. Iniciar (PowerShell)
cd ..
.\INICIAR-SISTEMA.ps1
```

**Tiempo estimado**: ⏱️ 5-10 minutos

---

*Última actualización: Enero 2025*

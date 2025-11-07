# 🤝 Guía de Contribución - L.A.M.A. Medellín

¡Gracias por tu interés en contribuir a este proyecto! Esta guía te ayudará a entender cómo puedes participar.

---

## 📋 Tabla de Contenidos

- [Código de Conducta](#código-de-conducta)
- [¿Cómo puedo contribuir?](#cómo-puedo-contribuir)
- [Proceso de Desarrollo](#proceso-de-desarrollo)
- [Estándares de Código](#estándares-de-código)
- [Commits](#commits)
- [Pull Requests](#pull-requests)
- [Reporte de Bugs](#reporte-de-bugs)
- [Sugerencias de Mejoras](#sugerencias-de-mejoras)

---

## 📜 Código de Conducta

Este proyecto se adhiere a un código de conducta basado en el respeto mutuo. Al participar, se espera que:

- ✅ Seas respetuoso con otros contribuyentes
- ✅ Aceptes críticas constructivas
- ✅ Te enfoques en lo que es mejor para la comunidad
- ✅ Muestres empatía hacia otros miembros

---

## 🎯 ¿Cómo puedo contribuir?

### Reportar Bugs

Si encuentras un error:

1. Verifica que no esté ya reportado en [Issues](https://github.com/CSA-DanielVillamizar/gestiondemiembros/issues)
2. Si no existe, crea un nuevo issue usando la plantilla de bug
3. Incluye:
   - Descripción clara del problema
   - Pasos para reproducir
   - Comportamiento esperado vs actual
   - Screenshots (si aplica)
   - Información del entorno (OS, navegador, versiones)

### Sugerir Mejoras

Para proponer nuevas características:

1. Abre un issue con la etiqueta `enhancement`
2. Describe claramente:
   - ¿Qué problema resuelve?
   - ¿Cómo debería funcionar?
   - ¿Por qué sería útil para otros usuarios?

### Contribuir con Código

1. Fork el repositorio
2. Crea una rama desde `main`
3. Implementa tus cambios
4. Asegúrate de que las pruebas pasen
5. Haz un Pull Request

---

## 🔧 Proceso de Desarrollo

### 1. Configurar el Entorno

```bash
# Clonar tu fork
git clone https://github.com/TU-USUARIO/gestiondemiembros.git
cd gestiondemiembros

# Agregar el repositorio original como upstream
git remote add upstream https://github.com/CSA-DanielVillamizar/gestiondemiembros.git

# Instalar dependencias
cd backend/src/LAMAMedellin.API
dotnet restore

cd ../../../frontend
npm install
```

### 2. Crear una Rama

```bash
# Actualizar tu main
git checkout main
git pull upstream main

# Crear rama para tu feature/fix
git checkout -b feature/nombre-descriptivo
# o
git checkout -b fix/nombre-del-bug
```

### 3. Desarrollar

- Escribe código limpio y bien documentado
- Sigue los estándares de código del proyecto
- Agrega pruebas para nuevas funcionalidades
- Actualiza la documentación si es necesario

### 4. Probar

```bash
# Backend
cd backend/tests/LAMAMedellin.Tests
dotnet test

# Frontend
cd frontend
npm run test
npm run lint
```

### 5. Commit

Usa mensajes de commit descriptivos siguiendo [Conventional Commits](https://www.conventionalcommits.org/):

```bash
git add .
git commit -m "feat: agregar filtro por fecha en miembros"
```

### 6. Push y Pull Request

```bash
git push origin feature/nombre-descriptivo
```

Luego crea un Pull Request desde GitHub.

---

## 📝 Estándares de Código

### Backend (C# / .NET)

```csharp
// ✅ Correcto
public class MiembroService : IMiembroService
{
    private readonly IMiembroRepository _repository;
    private readonly ILogger<MiembroService> _logger;

    /// <summary>
    /// Constructor del servicio de miembros
    /// </summary>
    public MiembroService(
        IMiembroRepository repository,
        ILogger<MiembroService> logger)
    {
        _repository = repository ?? throw new ArgumentNullException(nameof(repository));
        _logger = logger ?? throw new ArgumentNullException(nameof(logger));
    }

    public async Task<Miembro> ObtenerPorIdAsync(Guid id)
    {
        _logger.LogInformation("Obteniendo miembro con Id: {MiembroId}", id);
        
        var miembro = await _repository.ObtenerPorIdAsync(id);
        
        if (miembro == null)
        {
            _logger.LogWarning("Miembro con Id {MiembroId} no encontrado", id);
            throw new NotFoundException($"Miembro con Id {id} no encontrado");
        }
        
        return miembro;
    }
}
```

**Reglas:**
- ✅ PascalCase para clases, métodos, propiedades
- ✅ camelCase para parámetros y variables locales
- ✅ Prefijo `_` para campos privados
- ✅ Uso de `async`/`await` para operaciones asíncronas
- ✅ Validación de parámetros nulos
- ✅ Logging apropiado
- ✅ Documentación XML en métodos públicos

### Frontend (TypeScript / React)

```typescript
// ✅ Correcto
import React, { useState, useEffect } from 'react';
import { Box, Typography, CircularProgress } from '@mui/material';
import { Miembro } from '../types';
import { httpClient } from '../services/httpClient';

interface MiembroDetailProps {
  id: string;
}

/**
 * Componente que muestra el detalle de un miembro
 */
export const MiembroDetail: React.FC<MiembroDetailProps> = ({ id }) => {
  const [miembro, setMiembro] = useState<Miembro | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const cargarMiembro = async () => {
      try {
        setLoading(true);
        const response = await httpClient.get<Miembro>(`/Miembros/${id}`);
        setMiembro(response.data);
      } catch (err) {
        setError('Error al cargar el miembro');
        console.error(err);
      } finally {
        setLoading(false);
      }
    };

    cargarMiembro();
  }, [id]);

  if (loading) {
    return <CircularProgress />;
  }

  if (error) {
    return <Typography color="error">{error}</Typography>;
  }

  return (
    <Box>
      <Typography variant="h4">{miembro?.nombres}</Typography>
      {/* Más contenido */}
    </Box>
  );
};
```

**Reglas:**
- ✅ PascalCase para componentes
- ✅ camelCase para variables y funciones
- ✅ Tipado estricto con TypeScript
- ✅ Hooks de React (useState, useEffect)
- ✅ Manejo de estados (loading, error, data)
- ✅ JSDoc para funciones complejas
- ✅ Destructuring de props

---

## 📌 Commits

### Formato

```
<tipo>(<alcance>): <descripción corta>

<descripción detallada opcional>

<footer opcional>
```

### Tipos

- `feat`: Nueva funcionalidad
- `fix`: Corrección de bug
- `docs`: Cambios en documentación
- `style`: Formato, punto y coma faltante, etc (no cambios de código)
- `refactor`: Refactorización de código
- `test`: Agregar o modificar tests
- `chore`: Cambios en build, herramientas, etc

### Ejemplos

```bash
feat(miembros): agregar filtro por fecha de ingreso

Se agregó un nuevo filtro en la lista de miembros que permite
filtrar por rango de fechas de ingreso.

Closes #123
```

```bash
fix(dashboard): corregir cálculo de porcentaje de activos

El porcentaje se estaba calculando incorrectamente cuando
había miembros con estado null.
```

```bash
docs(readme): actualizar instrucciones de instalación

Se agregaron pasos para Windows y macOS
```

---

## 🔀 Pull Requests

### Antes de Enviar

- ✅ Tu código compila sin errores
- ✅ Todas las pruebas pasan
- ✅ Has agregado pruebas para nuevas funcionalidades
- ✅ La documentación está actualizada
- ✅ El código sigue los estándares del proyecto
- ✅ Los commits siguen el formato establecido

### Plantilla de PR

```markdown
## Descripción
[Descripción clara de los cambios]

## Tipo de cambio
- [ ] Bug fix
- [ ] Nueva funcionalidad
- [ ] Breaking change
- [ ] Documentación

## ¿Cómo se ha probado?
[Describe las pruebas realizadas]

## Checklist
- [ ] Mi código sigue los estándares del proyecto
- [ ] He realizado una auto-revisión de mi código
- [ ] He comentado mi código en áreas complejas
- [ ] He actualizado la documentación
- [ ] Mis cambios no generan nuevos warnings
- [ ] He agregado pruebas
- [ ] Todas las pruebas pasan localmente
```

### Proceso de Revisión

1. El PR será revisado por al menos un mantenedor
2. Se pueden solicitar cambios
3. Una vez aprobado, será mergeado a `main`

---

## 🐛 Reporte de Bugs

### Plantilla

```markdown
**Descripción del Bug**
[Descripción clara y concisa]

**Pasos para Reproducir**
1. Ve a '...'
2. Haz click en '...'
3. Scrollea hasta '...'
4. Ver error

**Comportamiento Esperado**
[Lo que debería suceder]

**Comportamiento Actual**
[Lo que realmente sucede]

**Screenshots**
[Si aplica]

**Entorno**
- OS: [e.g. Windows 11, macOS 13]
- Navegador: [e.g. Chrome 120, Firefox 121]
- Versión del sistema: [e.g. 1.0.0]

**Contexto Adicional**
[Cualquier otra información relevante]
```

---

## 💡 Sugerencias de Mejoras

### Plantilla

```markdown
**¿Tu sugerencia está relacionada con un problema?**
[Descripción del problema]

**Describe la solución que te gustaría**
[Descripción clara de lo que quieres que suceda]

**Describe alternativas que hayas considerado**
[Otras soluciones o características que hayas considerado]

**¿Cómo beneficiaría esto al proyecto?**
[Explica por qué sería útil]

**Contexto adicional**
[Screenshots, mockups, etc]
```

---

## 🏗️ Arquitectura del Proyecto

Al contribuir, es importante entender la arquitectura:

- **Clean Architecture**: El proyecto sigue principios de Clean Architecture
- **Frontend**: React con TypeScript, componentes funcionales, hooks
- **Backend**: ASP.NET Core con capas separadas (API, Application, Infrastructure, Domain)
- **Base de datos**: Entity Framework Core con Code-First approach

Ver [ARQUITECTURA_LAMA.drawio](ARQUITECTURA_LAMA.drawio) para más detalles.

---

## 🙏 Reconocimientos

Los contribuyentes serán reconocidos en:
- El archivo [AUTHORS.md](AUTHORS.md)
- Las release notes
- La documentación del proyecto

---

## 📞 ¿Preguntas?

Si tienes preguntas sobre cómo contribuir:

1. Revisa esta guía
2. Busca en los [Issues](https://github.com/CSA-DanielVillamizar/gestiondemiembros/issues)
3. Crea un issue con la etiqueta `question`

---

**¡Gracias por contribuir! 🎉**

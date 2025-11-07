using LAMAMedellin.Application.DTOs;
using LAMAMedellin.Application.Interfaces;
using LAMAMedellin.Domain.Entities;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Security.Claims;
using System.Threading.Tasks;

namespace LAMAMedellin.API.Controllers
{
    /// <summary>
    /// Controlador para la gestión de miembros del capítulo
    /// </summary>
    [ApiController]
    [Route("api/[controller]")]
    // [Authorize] // Deshabilitado temporalmente para desarrollo
    public class MiembrosController : ControllerBase
    {
        private readonly IMiembroService _miembroService;
        private readonly ILogger<MiembrosController> _logger;

        public MiembrosController(
            IMiembroService miembroService,
            ILogger<MiembrosController> logger)
        {
            _miembroService = miembroService ?? throw new ArgumentNullException(nameof(miembroService));
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
        }

        /// <summary>
        /// Obtiene todos los miembros con paginación y filtros
        /// </summary>
        [HttpGet]
        [ProducesResponseType(typeof(PagedResultDto<MiembroDto>), StatusCodes.Status200OK)]
        public async Task<ActionResult<PagedResultDto<MiembroDto>>> GetMiembros(
            [FromQuery] int pageNumber = 1,
            [FromQuery] int pageSize = 10,
            [FromQuery] string? searchTerm = null,
            [FromQuery] EstadoMiembro? estado = null,
            [FromQuery] TipoMembresia? tipoMembresia = null)
        {
            try
            {
                var result = await _miembroService.GetPagedAsync(
                    pageNumber, pageSize, searchTerm, estado, tipoMembresia);
                
                return Ok(result);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error al obtener miembros paginados");
                return StatusCode(500, "Error interno del servidor");
            }
        }

        /// <summary>
        /// Obtiene un miembro por su ID
        /// </summary>
        [HttpGet("{id}")]
        [ProducesResponseType(typeof(MiembroDto), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<ActionResult<MiembroDto>> GetMiembroById(Guid id)
        {
            try
            {
                var miembro = await _miembroService.GetByIdAsync(id);
                
                if (miembro == null)
                {
                    return NotFound($"No se encontró el miembro con ID {id}");
                }

                return Ok(miembro);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error al obtener miembro con ID {Id}", id);
                return StatusCode(500, "Error interno del servidor");
            }
        }

        /// <summary>
        /// Busca miembros por término de búsqueda
        /// </summary>
        [HttpGet("search")]
        [ProducesResponseType(typeof(IEnumerable<MiembroDto>), StatusCodes.Status200OK)]
        public async Task<ActionResult<IEnumerable<MiembroDto>>> SearchMiembros(
            [FromQuery] string searchTerm)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(searchTerm))
                {
                    return BadRequest("El término de búsqueda no puede estar vacío");
                }

                var miembros = await _miembroService.SearchAsync(searchTerm);
                return Ok(miembros);
            }
            catch (Exception ex)
            {
                // Sanitizar el término de búsqueda para prevenir log forging
                var sanitizedSearchTerm = searchTerm?.Replace(Environment.NewLine, "")
                    .Replace("\n", "")
                    .Replace("\r", "");
                _logger.LogError(ex, "Error al buscar miembros con término: {SearchTerm}", sanitizedSearchTerm);
                return StatusCode(500, "Error interno del servidor");
            }
        }

        /// <summary>
        /// Crea un nuevo miembro
        /// </summary>
        [HttpPost]
        [ProducesResponseType(typeof(MiembroDto), StatusCodes.Status201Created)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<ActionResult<MiembroDto>> CreateMiembro([FromBody] CrearMiembroDto dto)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return BadRequest(ModelState);
                }

                var userName = User.FindFirst(ClaimTypes.Name)?.Value 
                    ?? User.FindFirst("name")?.Value;

                var miembro = await _miembroService.CreateAsync(dto, userName);
                
                return CreatedAtAction(
                    nameof(GetMiembroById), 
                    new { id = miembro.Id }, 
                    miembro);
            }
            catch (InvalidOperationException ex)
            {
                _logger.LogWarning(ex, "Validación fallida al crear miembro");
                return BadRequest(ex.Message);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error al crear miembro");
                return StatusCode(500, "Error interno del servidor");
            }
        }

        /// <summary>
        /// Actualiza un miembro existente
        /// </summary>
        [HttpPut("{id}")]
        [ProducesResponseType(typeof(MiembroDto), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<ActionResult<MiembroDto>> UpdateMiembro(
            Guid id, 
            [FromBody] ActualizarMiembroDto dto)
        {
            try
            {
                if (id != dto.Id)
                {
                    return BadRequest("El ID de la URL no coincide con el ID del cuerpo");
                }

                if (!ModelState.IsValid)
                {
                    return BadRequest(ModelState);
                }

                var userName = User.FindFirst(ClaimTypes.Name)?.Value 
                    ?? User.FindFirst("name")?.Value;

                var miembro = await _miembroService.UpdateAsync(dto, userName);
                
                return Ok(miembro);
            }
            catch (KeyNotFoundException ex)
            {
                _logger.LogWarning(ex, "Miembro no encontrado: {Id}", id);
                return NotFound(ex.Message);
            }
            catch (InvalidOperationException ex)
            {
                _logger.LogWarning(ex, "Validación fallida al actualizar miembro");
                return BadRequest(ex.Message);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error al actualizar miembro con ID {Id}", id);
                return StatusCode(500, "Error interno del servidor");
            }
        }

        /// <summary>
        /// Elimina un miembro
        /// </summary>
        [HttpDelete("{id}")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> DeleteMiembro(Guid id)
        {
            try
            {
                var success = await _miembroService.DeleteAsync(id);
                
                if (!success)
                {
                    return NotFound($"No se encontró el miembro con ID {id}");
                }

                return NoContent();
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error al eliminar miembro con ID {Id}", id);
                return StatusCode(500, "Error interno del servidor");
            }
        }

        /// <summary>
        /// Obtiene estadísticas de miembros
        /// </summary>
        [HttpGet("estadisticas")]
        [ProducesResponseType(typeof(MiembrosEstadisticasDto), StatusCodes.Status200OK)]
        public async Task<ActionResult<MiembrosEstadisticasDto>> GetEstadisticas()
        {
            try
            {
                var estadisticas = await _miembroService.GetEstadisticasAsync();
                return Ok(estadisticas);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error al obtener estadísticas de miembros");
                return StatusCode(500, "Error interno del servidor");
            }
        }
    }
}

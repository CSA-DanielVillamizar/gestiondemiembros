using LAMAMedellin.Infrastructure.Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace LAMAMedellin.API.Controllers
{
    /// <summary>
    /// Controlador para estadísticas del dashboard
    /// </summary>
    [ApiController]
    [Route("api/[controller]")]
    public class EstadisticasController : ControllerBase
    {
        private readonly LAMADbContext _context;
        private readonly ILogger<EstadisticasController> _logger;

        public EstadisticasController(LAMADbContext context, ILogger<EstadisticasController> logger)
        {
            _context = context;
            _logger = logger;
        }

        /// <summary>
        /// Obtiene estadísticas generales del sistema
        /// </summary>
        [HttpGet("generales")]
        public async Task<IActionResult> GetEstadisticasGenerales()
        {
            try
            {
                var totalMiembros = await _context.Miembros.CountAsync();
                var miembrosActivos = await _context.Miembros.CountAsync(m => m.Estado == Domain.Entities.EstadoMiembro.Activo);
                var miembrosInactivos = await _context.Miembros.CountAsync(m => m.Estado == Domain.Entities.EstadoMiembro.Inactivo);
                var miembrosSuspendidos = await _context.Miembros.CountAsync(m => m.Estado == Domain.Entities.EstadoMiembro.Suspendido);

                var totalComites = await _context.Comites.CountAsync(c => c.Activo);

                // Miembros por tipo de membresía (simplificado)
                var miembrosRegulares = await _context.Miembros.CountAsync(m => m.TipoMembresia == Domain.Entities.TipoMembresia.Regular);
                var miembrosHonor = await _context.Miembros.CountAsync(m => m.TipoMembresia == Domain.Entities.TipoMembresia.Honor);
                var miembrosVitalicio = await _context.Miembros.CountAsync(m => m.TipoMembresia == Domain.Entities.TipoMembresia.Vitalicio);
                var miembrosTemporal = await _context.Miembros.CountAsync(m => m.TipoMembresia == Domain.Entities.TipoMembresia.Temporal);

                var miembrosPorTipoFormateado = new List<object>();
                if (miembrosRegulares > 0) miembrosPorTipoFormateado.Add(new { tipo = "1", cantidad = miembrosRegulares });
                if (miembrosHonor > 0) miembrosPorTipoFormateado.Add(new { tipo = "2", cantidad = miembrosHonor });
                if (miembrosVitalicio > 0) miembrosPorTipoFormateado.Add(new { tipo = "3", cantidad = miembrosVitalicio });
                if (miembrosTemporal > 0) miembrosPorTipoFormateado.Add(new { tipo = "4", cantidad = miembrosTemporal });

                // Miembros por ciudad (top 5)
                var miembrosPorCiudad = await _context.Miembros
                    .Where(m => !string.IsNullOrEmpty(m.Ciudad))
                    .GroupBy(m => m.Ciudad)
                    .Select(g => new { ciudad = g.Key!, cantidad = g.Count() })
                    .OrderByDescending(x => x.cantidad)
                    .Take(5)
                    .ToListAsync();

                // Nuevos miembros por mes (últimos 6 meses) - simplificado
                var seisMesesAtras = DateTime.UtcNow.AddMonths(-6);
                var miembrosRecientes = await _context.Miembros
                    .Where(m => m.FechaIngreso >= seisMesesAtras)
                    .Select(m => new { m.FechaIngreso.Year, m.FechaIngreso.Month })
                    .ToListAsync();

                var nuevosMiembrosPorMes = miembrosRecientes
                    .GroupBy(m => new { m.Year, m.Month })
                    .Select(g => new
                    {
                        mes = $"{g.Key.Year}-{g.Key.Month:D2}",
                        cantidad = g.Count()
                    })
                    .OrderBy(x => x.mes)
                    .ToList();

                // Comités más activos - simplificado
                var comites = await _context.Comites
                    .Where(c => c.Activo)
                    .Include(c => c.Miembros)
                    .ToListAsync();

                var comitesMasActivos = comites
                    .Select(c => new
                    {
                        id = c.Id.ToString(),
                        nombre = c.Nombre,
                        cantidadMiembros = c.Miembros.Count
                    })
                    .OrderByDescending(x => x.cantidadMiembros)
                    .Take(5)
                    .ToList();

                var estadisticas = new
                {
                    resumen = new
                    {
                        totalMiembros,
                        miembrosActivos,
                        miembrosInactivos,
                        miembrosSuspendidos,
                        totalComites,
                        tasaActividad = totalMiembros > 0 ? Math.Round((double)miembrosActivos / totalMiembros * 100, 1) : 0
                    },
                    miembrosPorTipo = miembrosPorTipoFormateado,
                    miembrosPorCiudad,
                    nuevosMiembrosPorMes,
                    comitesMasActivos
                };

                return Ok(estadisticas);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error al obtener estadísticas generales");
                return StatusCode(500, new { error = "Error al obtener estadísticas", details = ex.Message });
            }
        }

        /// <summary>
        /// Obtiene estadísticas de un comité específico
        /// </summary>
        [HttpGet("comite/{comiteId}")]
        public async Task<IActionResult> GetEstadisticasComite(Guid comiteId)
        {
            try
            {
                var comite = await _context.Comites
                    .Include(c => c.Miembros)
                    .ThenInclude(mc => mc.Miembro)
                    .FirstOrDefaultAsync(c => c.Id == comiteId);

                if (comite == null)
                {
                    return NotFound(new { error = "Comité no encontrado" });
                }

                var totalMiembros = comite.Miembros.Count;
                var coordinadores = comite.Miembros.Count(mc => mc.Rol?.ToLower().Contains("coordinador") == true);

                var estadisticas = new
                {
                    comiteId = comite.Id,
                    nombreComite = comite.Nombre,
                    descripcion = comite.Descripcion,
                    totalMiembros,
                    coordinadores,
                    miembrosRegulares = totalMiembros - coordinadores,
                    fechaCreacion = comite.FechaCreacion,
                    activo = comite.Activo
                };

                return Ok(estadisticas);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error al obtener estadísticas del comité {ComiteId}", comiteId);
                return StatusCode(500, new { error = "Error al obtener estadísticas del comité", details = ex.Message });
            }
        }
    }
}

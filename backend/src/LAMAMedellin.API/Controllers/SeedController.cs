using LAMAMedellin.Domain.Entities;
using LAMAMedellin.Infrastructure.Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace LAMAMedellin.API.Controllers
{
    /// <summary>
    /// Controlador temporal para inicializar datos de prueba (SOLO DESARROLLO)
    /// </summary>
    [ApiController]
    [Route("api/[controller]")]
    public class SeedController : ControllerBase
    {
        private readonly LAMADbContext _context;
        private readonly ILogger<SeedController> _logger;

        public SeedController(LAMADbContext context, ILogger<SeedController> logger)
        {
            _context = context;
            _logger = logger;
        }

        /// <summary>
        /// Carga datos de prueba en la base de datos
        /// </summary>
        [HttpPost("load")]
        public async Task<IActionResult> LoadSeedData()
        {
            try
            {
                // Verificar si ya hay datos
                if (await _context.Miembros.AnyAsync())
                {
                    return Ok(new { message = "La base de datos ya contiene miembros", count = await _context.Miembros.CountAsync() });
                }

                // Crear miembros de prueba
                var miembros = new List<Miembro>
                {
                    new Miembro
                    {
                        Id = Guid.Parse("aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"),
                        NumeroIdentificacion = "1234567890",
                        Nombres = "Juan Carlos",
                        Apellidos = "Pérez González",
                        Email = "juan.perez@example.com",
                        Telefono = "3001234567",
                        Direccion = "Calle 10 # 20-30",
                        Ciudad = "Medellín",
                        FechaNacimiento = new DateTime(1985, 5, 15),
                        Profesion = "Ingeniero de Sistemas",
                        Empresa = "Tech Solutions SAS",
                        Estado = EstadoMiembro.Activo,
                        TipoMembresia = TipoMembresia.Regular,
                        FechaIngreso = new DateTime(2024, 1, 15),
                        FechaCreacion = DateTime.UtcNow,
                        CreadoPor = "System"
                    },
                    new Miembro
                    {
                        Id = Guid.Parse("bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb"),
                        NumeroIdentificacion = "9876543210",
                        Nombres = "María Fernanda",
                        Apellidos = "Rodríguez López",
                        Email = "maria.rodriguez@example.com",
                        Telefono = "3009876543",
                        Direccion = "Carrera 45 # 12-34",
                        Ciudad = "Medellín",
                        FechaNacimiento = new DateTime(1990, 8, 22),
                        Profesion = "Administradora de Empresas",
                        Empresa = "Consultoría Empresarial Ltda",
                        Estado = EstadoMiembro.Activo,
                        TipoMembresia = TipoMembresia.Honor,
                        FechaIngreso = new DateTime(2023, 6, 10),
                        FechaCreacion = DateTime.UtcNow,
                        CreadoPor = "System"
                    },
                    new Miembro
                    {
                        Id = Guid.Parse("cccccccc-cccc-cccc-cccc-cccccccccccc"),
                        NumeroIdentificacion = "5555555555",
                        Nombres = "Carlos Alberto",
                        Apellidos = "Martínez Sánchez",
                        Email = "carlos.martinez@example.com",
                        Telefono = "3105554433",
                        Direccion = "Avenida 80 # 50-20",
                        Ciudad = "Medellín",
                        FechaNacimiento = new DateTime(1982, 3, 10),
                        Profesion = "Arquitecto",
                        Empresa = "Diseños Urbanos SA",
                        Estado = EstadoMiembro.Activo,
                        TipoMembresia = TipoMembresia.Regular,
                        FechaIngreso = new DateTime(2024, 3, 20),
                        FechaCreacion = DateTime.UtcNow,
                        CreadoPor = "System"
                    },
                    new Miembro
                    {
                        Id = Guid.Parse("dddddddd-dddd-dddd-dddd-dddddddddddd"),
                        NumeroIdentificacion = "7777777777",
                        Nombres = "Ana Patricia",
                        Apellidos = "Gómez Restrepo",
                        Email = "ana.gomez@example.com",
                        Telefono = "3207778899",
                        Direccion = "Calle 30 # 70-50",
                        Ciudad = "Envigado",
                        FechaNacimiento = new DateTime(1988, 11, 5),
                        Profesion = "Contadora Pública",
                        Empresa = "Auditoría y Finanzas SAS",
                        Estado = EstadoMiembro.Activo,
                        TipoMembresia = TipoMembresia.Vitalicio,
                        FechaIngreso = new DateTime(2023, 9, 1),
                        FechaCreacion = DateTime.UtcNow,
                        CreadoPor = "System"
                    },
                    new Miembro
                    {
                        Id = Guid.Parse("eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee"),
                        NumeroIdentificacion = "1111222233",
                        Nombres = "Luis Eduardo",
                        Apellidos = "Hernández Díaz",
                        Email = "luis.hernandez@example.com",
                        Telefono = "3151112222",
                        Direccion = "Carrera 70 # 40-10",
                        Ciudad = "Medellín",
                        FechaNacimiento = new DateTime(1992, 7, 18),
                        Profesion = "Médico Veterinario",
                        Empresa = "Clínica Veterinaria El Refugio",
                        Estado = EstadoMiembro.Activo,
                        TipoMembresia = TipoMembresia.Regular,
                        FechaIngreso = new DateTime(2024, 2, 14),
                        FechaCreacion = DateTime.UtcNow,
                        CreadoPor = "System"
                    },
                    new Miembro
                    {
                        Id = Guid.Parse("ffffffff-ffff-ffff-ffff-ffffffffffff"),
                        NumeroIdentificacion = "8888999900",
                        Nombres = "Sofía Isabel",
                        Apellidos = "Valencia Torres",
                        Email = "sofia.valencia@example.com",
                        Telefono = "3008889999",
                        Direccion = "Calle 50 # 25-15",
                        Ciudad = "Sabaneta",
                        FechaNacimiento = new DateTime(1995, 4, 30),
                        Profesion = "Diseñadora Gráfica",
                        Empresa = "Creativo Digital Studio",
                        Estado = EstadoMiembro.Activo,
                        TipoMembresia = TipoMembresia.Temporal,
                        FechaIngreso = new DateTime(2024, 4, 5),
                        FechaCreacion = DateTime.UtcNow,
                        CreadoPor = "System"
                    }
                };

                _context.Miembros.AddRange(miembros);
                await _context.SaveChangesAsync();

                // Asignar comités
                var comites = await _context.Comites.ToListAsync();
                if (comites.Count >= 3)
                {
                    var asignaciones = new List<MiembroComite>
                    {
                        new MiembroComite { MiembroId = miembros[0].Id, ComiteId = comites[0].Id, Rol = "Coordinador", FechaIngreso = new DateTime(2024, 1, 15) },
                        new MiembroComite { MiembroId = miembros[1].Id, ComiteId = comites[1].Id, Rol = "Coordinadora", FechaIngreso = new DateTime(2023, 6, 10) },
                        new MiembroComite { MiembroId = miembros[2].Id, ComiteId = comites[2].Id, Rol = "Miembro", FechaIngreso = new DateTime(2024, 3, 20) },
                        new MiembroComite { MiembroId = miembros[3].Id, ComiteId = comites[0].Id, Rol = "Miembro", FechaIngreso = new DateTime(2023, 9, 1) },
                        new MiembroComite { MiembroId = miembros[3].Id, ComiteId = comites[1].Id, Rol = "Miembro", FechaIngreso = new DateTime(2023, 9, 1) },
                        new MiembroComite { MiembroId = miembros[4].Id, ComiteId = comites[2].Id, Rol = "Coordinador", FechaIngreso = new DateTime(2024, 2, 14) },
                        new MiembroComite { MiembroId = miembros[5].Id, ComiteId = comites[1].Id, Rol = "Miembro", FechaIngreso = new DateTime(2024, 4, 5) }
                    };

                    _context.MiembroComites.AddRange(asignaciones);
                    await _context.SaveChangesAsync();
                }

                _logger.LogInformation("Datos de prueba cargados exitosamente: {Count} miembros", miembros.Count);

                return Ok(new
                {
                    success = true,
                    message = $"✅ {miembros.Count} miembros cargados exitosamente",
                    miembros = miembros.Select(m => new { m.Nombres, m.Apellidos, m.Email, m.Profesion })
                });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error al cargar datos de prueba");
                return StatusCode(500, new { error = ex.Message });
            }
        }

        /// <summary>
        /// Limpia todos los datos de miembros (SOLO DESARROLLO)
        /// </summary>
        [HttpDelete("clear")]
        public async Task<IActionResult> ClearData()
        {
            try
            {
                var miembrosCount = await _context.Miembros.CountAsync();
                _context.MiembroComites.RemoveRange(_context.MiembroComites);
                _context.Miembros.RemoveRange(_context.Miembros);
                await _context.SaveChangesAsync();

                _logger.LogWarning("Datos eliminados: {Count} miembros", miembrosCount);

                return Ok(new { success = true, message = $"✅ {miembrosCount} miembros eliminados" });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error al limpiar datos");
                return StatusCode(500, new { error = ex.Message });
            }
        }
    }
}

using System;
using LAMAMedellin.Domain.Entities;

namespace LAMAMedellin.Application.DTOs
{
    /// <summary>
    /// DTO para mostrar información de un miembro
    /// </summary>
    public class MiembroDto
    {
        public Guid Id { get; set; }
        public string NumeroIdentificacion { get; set; } = string.Empty;
        public string Nombres { get; set; } = string.Empty;
        public string Apellidos { get; set; } = string.Empty;
        public string NombreCompleto { get; set; } = string.Empty;
        public string Email { get; set; } = string.Empty;
        public string? Telefono { get; set; }
        public string? Direccion { get; set; }
        public string? Ciudad { get; set; }
        public DateTime? FechaNacimiento { get; set; }
        public int? Edad { get; set; }
        public string? Profesion { get; set; }
        public string? Empresa { get; set; }
        public DateTime FechaIngreso { get; set; }
        public EstadoMiembro Estado { get; set; }
        public string EstadoDescripcion { get; set; } = string.Empty;
        public TipoMembresia TipoMembresia { get; set; }
        public string TipoMembresiaDescripcion { get; set; } = string.Empty;
        public string? Notas { get; set; }
        public string? FotoUrl { get; set; }
        public DateTime FechaCreacion { get; set; }
        public DateTime? FechaModificacion { get; set; }
        public List<ComiteSimpleDto> Comites { get; set; } = new();
    }

    /// <summary>
    /// DTO simplificado de comité para incluir en MiembroDto
    /// </summary>
    public class ComiteSimpleDto
    {
        public Guid Id { get; set; }
        public string Nombre { get; set; } = string.Empty;
        public string? Rol { get; set; }
        public bool EsCoordinador { get; set; }
    }
}

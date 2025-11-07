using System;
using System.ComponentModel.DataAnnotations;
using LAMAMedellin.Domain.Entities;

namespace LAMAMedellin.Application.DTOs
{
    /// <summary>
    /// DTO para actualizar un miembro existente
    /// </summary>
    public class ActualizarMiembroDto
    {
        [Required(ErrorMessage = "El ID es requerido")]
        public Guid Id { get; set; }

        [Required(ErrorMessage = "El número de identificación es requerido")]
        [StringLength(50, ErrorMessage = "El número de identificación no puede exceder 50 caracteres")]
        public string NumeroIdentificacion { get; set; } = string.Empty;

        [Required(ErrorMessage = "Los nombres son requeridos")]
        [StringLength(100, ErrorMessage = "Los nombres no pueden exceder 100 caracteres")]
        public string Nombres { get; set; } = string.Empty;

        [Required(ErrorMessage = "Los apellidos son requeridos")]
        [StringLength(100, ErrorMessage = "Los apellidos no pueden exceder 100 caracteres")]
        public string Apellidos { get; set; } = string.Empty;

        [Required(ErrorMessage = "El email es requerido")]
        [EmailAddress(ErrorMessage = "El formato del email no es válido")]
        [StringLength(200, ErrorMessage = "El email no puede exceder 200 caracteres")]
        public string Email { get; set; } = string.Empty;

        [Phone(ErrorMessage = "El formato del teléfono no es válido")]
        [StringLength(20)]
        public string? Telefono { get; set; }

        [StringLength(200)]
        public string? Direccion { get; set; }

        [StringLength(100)]
        public string? Ciudad { get; set; }

        public DateTime? FechaNacimiento { get; set; }

        [StringLength(100)]
        public string? Profesion { get; set; }

        [StringLength(100)]
        public string? Empresa { get; set; }

        public DateTime FechaIngreso { get; set; }

        public EstadoMiembro Estado { get; set; }

        public TipoMembresia TipoMembresia { get; set; }

        [StringLength(1000)]
        public string? Notas { get; set; }

        [Url(ErrorMessage = "El formato de la URL no es válido")]
        [StringLength(500)]
        public string? FotoUrl { get; set; }

        public List<Guid>? ComiteIds { get; set; }
    }
}

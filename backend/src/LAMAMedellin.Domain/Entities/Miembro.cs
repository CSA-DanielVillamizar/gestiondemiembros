using System;
using System.Collections.Generic;

namespace LAMAMedellin.Domain.Entities
{
    /// <summary>
    /// Entidad de dominio que representa un miembro del capítulo L.A.M.A. Medellín
    /// </summary>
    public class Miembro
    {
        /// <summary>
        /// Identificador único del miembro
        /// </summary>
        public Guid Id { get; set; }

        /// <summary>
        /// Número de identificación del miembro (cédula, pasaporte, etc.)
        /// </summary>
        public string NumeroIdentificacion { get; set; } = string.Empty;

        /// <summary>
        /// Nombres del miembro
        /// </summary>
        public string Nombres { get; set; } = string.Empty;

        /// <summary>
        /// Apellidos del miembro
        /// </summary>
        public string Apellidos { get; set; } = string.Empty;

        /// <summary>
        /// Correo electrónico principal
        /// </summary>
        public string Email { get; set; } = string.Empty;

        /// <summary>
        /// Teléfono de contacto
        /// </summary>
        public string? Telefono { get; set; }

        /// <summary>
        /// Dirección de residencia
        /// </summary>
        public string? Direccion { get; set; }

        /// <summary>
        /// Ciudad de residencia
        /// </summary>
        public string? Ciudad { get; set; }

        /// <summary>
        /// Fecha de nacimiento
        /// </summary>
        public DateTime? FechaNacimiento { get; set; }

        /// <summary>
        /// Profesión u ocupación
        /// </summary>
        public string? Profesion { get; set; }

        /// <summary>
        /// Empresa donde trabaja
        /// </summary>
        public string? Empresa { get; set; }

        /// <summary>
        /// Fecha de ingreso al capítulo
        /// </summary>
        public DateTime FechaIngreso { get; set; }

        /// <summary>
        /// Estado actual del miembro (Activo, Inactivo, Suspendido)
        /// </summary>
        public EstadoMiembro Estado { get; set; }

        /// <summary>
        /// Tipo de membresía
        /// </summary>
        public TipoMembresia TipoMembresia { get; set; }

        /// <summary>
        /// Notas adicionales sobre el miembro
        /// </summary>
        public string? Notas { get; set; }

        /// <summary>
        /// URL de la foto del perfil
        /// </summary>
        public string? FotoUrl { get; set; }

        /// <summary>
        /// Fecha de creación del registro
        /// </summary>
        public DateTime FechaCreacion { get; set; }

        /// <summary>
        /// Fecha de última modificación
        /// </summary>
        public DateTime? FechaModificacion { get; set; }

        /// <summary>
        /// Usuario que creó el registro
        /// </summary>
        public string? CreadoPor { get; set; }

        /// <summary>
        /// Usuario que modificó el registro por última vez
        /// </summary>
        public string? ModificadoPor { get; set; }

        /// <summary>
        /// Comités a los que pertenece el miembro
        /// </summary>
        public ICollection<MiembroComite> Comites { get; set; } = new List<MiembroComite>();

        /// <summary>
        /// Obtiene el nombre completo del miembro
        /// </summary>
        public string NombreCompleto => $"{Nombres} {Apellidos}";

        /// <summary>
        /// Calcula la edad del miembro
        /// </summary>
        public int? Edad
        {
            get
            {
                if (!FechaNacimiento.HasValue) return null;
                var edad = DateTime.Now.Year - FechaNacimiento.Value.Year;
                if (DateTime.Now.DayOfYear < FechaNacimiento.Value.DayOfYear)
                    edad--;
                return edad;
            }
        }
    }

    /// <summary>
    /// Estados posibles de un miembro
    /// </summary>
    public enum EstadoMiembro
    {
        Activo = 1,
        Inactivo = 2,
        Suspendido = 3
    }

    /// <summary>
    /// Tipos de membresía disponibles
    /// </summary>
    public enum TipoMembresia
    {
        Regular = 1,
        Honor = 2,
        Vitalicio = 3,
        Temporal = 4
    }
}

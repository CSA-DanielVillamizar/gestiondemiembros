using System;

namespace LAMAMedellin.Domain.Entities
{
    /// <summary>
    /// Entidad de relación entre Miembro y Comité (muchos a muchos)
    /// </summary>
    public class MiembroComite
    {
        /// <summary>
        /// ID del miembro
        /// </summary>
        public Guid MiembroId { get; set; }

        /// <summary>
        /// Referencia al miembro
        /// </summary>
        public Miembro Miembro { get; set; } = null!;

        /// <summary>
        /// ID del comité
        /// </summary>
        public Guid ComiteId { get; set; }

        /// <summary>
        /// Referencia al comité
        /// </summary>
        public Comite Comite { get; set; } = null!;

        /// <summary>
        /// Rol del miembro en el comité
        /// </summary>
        public string? Rol { get; set; }

        /// <summary>
        /// Fecha de ingreso al comité
        /// </summary>
        public DateTime FechaIngreso { get; set; }

        /// <summary>
        /// Indica si el miembro es coordinador del comité
        /// </summary>
        public bool EsCoordinador { get; set; }
    }
}

using System;
using System.Collections.Generic;

namespace LAMAMedellin.Domain.Entities
{
    /// <summary>
    /// Entidad que representa un comité del capítulo
    /// </summary>
    public class Comite
    {
        /// <summary>
        /// Identificador único del comité
        /// </summary>
        public Guid Id { get; set; }

        /// <summary>
        /// Nombre del comité
        /// </summary>
        public string Nombre { get; set; } = string.Empty;

        /// <summary>
        /// Descripción del comité
        /// </summary>
        public string? Descripcion { get; set; }

        /// <summary>
        /// Estado del comité
        /// </summary>
        public bool Activo { get; set; } = true;

        /// <summary>
        /// Fecha de creación del comité
        /// </summary>
        public DateTime FechaCreacion { get; set; }

        /// <summary>
        /// Miembros del comité
        /// </summary>
        public ICollection<MiembroComite> Miembros { get; set; } = new List<MiembroComite>();
    }
}

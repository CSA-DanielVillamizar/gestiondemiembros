using System;

namespace LAMAMedellin.Application.DTOs
{
    /// <summary>
    /// DTO para mostrar información de un comité
    /// </summary>
    public class ComiteDto
    {
        public Guid Id { get; set; }
        public string Nombre { get; set; } = string.Empty;
        public string? Descripcion { get; set; }
        public bool Activo { get; set; }
        public DateTime FechaCreacion { get; set; }
        public int CantidadMiembros { get; set; }
    }

    /// <summary>
    /// DTO para crear un comité
    /// </summary>
    public class CrearComiteDto
    {
        public string Nombre { get; set; } = string.Empty;
        public string? Descripcion { get; set; }
        public bool Activo { get; set; } = true;
    }
}

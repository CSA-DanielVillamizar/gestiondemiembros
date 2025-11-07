using System.Collections.Generic;

namespace LAMAMedellin.Application.DTOs
{
    /// <summary>
    /// DTO para estadísticas de miembros
    /// </summary>
    public class MiembrosEstadisticasDto
    {
        public int TotalMiembros { get; set; }
        public int MiembrosActivos { get; set; }
        public int MiembrosInactivos { get; set; }
        public int MiembrosSuspendidos { get; set; }
        public Dictionary<string, int> PorTipoMembresia { get; set; } = new();
        public Dictionary<string, int> PorCiudad { get; set; } = new();
    }

    /// <summary>
    /// DTO para resultado de importación
    /// </summary>
    public class ImportResultDto
    {
        public int TotalRegistros { get; set; }
        public int RegistrosExitosos { get; set; }
        public int RegistrosFallidos { get; set; }
        public List<string> Errores { get; set; } = new();
        public bool Exitoso => RegistrosFallidos == 0;
    }
}

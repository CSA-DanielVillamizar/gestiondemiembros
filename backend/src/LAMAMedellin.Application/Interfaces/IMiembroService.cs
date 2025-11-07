using LAMAMedellin.Application.DTOs;
using LAMAMedellin.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace LAMAMedellin.Application.Interfaces
{
    /// <summary>
    /// Servicio de aplicación para gestión de miembros
    /// </summary>
    public interface IMiembroService
    {
        /// <summary>
        /// Obtiene un miembro por su ID
        /// </summary>
        Task<MiembroDto?> GetByIdAsync(Guid id);

        /// <summary>
        /// Obtiene todos los miembros
        /// </summary>
        Task<IEnumerable<MiembroDto>> GetAllAsync();

        /// <summary>
        /// Obtiene miembros con paginación y filtros
        /// </summary>
        Task<PagedResultDto<MiembroDto>> GetPagedAsync(
            int pageNumber, 
            int pageSize, 
            string? searchTerm = null,
            EstadoMiembro? estado = null,
            TipoMembresia? tipoMembresia = null);

        /// <summary>
        /// Crea un nuevo miembro
        /// </summary>
        Task<MiembroDto> CreateAsync(CrearMiembroDto dto, string? createdBy = null);

        /// <summary>
        /// Actualiza un miembro existente
        /// </summary>
        Task<MiembroDto> UpdateAsync(ActualizarMiembroDto dto, string? modifiedBy = null);

        /// <summary>
        /// Elimina un miembro
        /// </summary>
        Task<bool> DeleteAsync(Guid id);

        /// <summary>
        /// Busca miembros por término
        /// </summary>
        Task<IEnumerable<MiembroDto>> SearchAsync(string searchTerm);

        /// <summary>
        /// Obtiene estadísticas de miembros
        /// </summary>
        Task<MiembrosEstadisticasDto> GetEstadisticasAsync();

        /// <summary>
        /// Exporta miembros a Excel
        /// </summary>
        Task<byte[]> ExportToExcelAsync();

        /// <summary>
        /// Importa miembros desde Excel
        /// </summary>
        Task<ImportResultDto> ImportFromExcelAsync(byte[] fileData, string? importedBy = null);
    }
}

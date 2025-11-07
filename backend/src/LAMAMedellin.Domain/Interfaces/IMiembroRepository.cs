using LAMAMedellin.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace LAMAMedellin.Domain.Interfaces
{
    /// <summary>
    /// Repositorio específico para la entidad Miembro con operaciones adicionales
    /// </summary>
    public interface IMiembroRepository : IRepository<Miembro>
    {
        /// <summary>
        /// Busca miembros por término de búsqueda (nombres, apellidos, email)
        /// </summary>
        Task<IEnumerable<Miembro>> SearchAsync(string searchTerm);

        /// <summary>
        /// Obtiene miembros con paginación
        /// </summary>
        Task<(IEnumerable<Miembro> Items, int TotalCount)> GetPagedAsync(
            int pageNumber, 
            int pageSize, 
            string? searchTerm = null,
            EstadoMiembro? estado = null,
            TipoMembresia? tipoMembresia = null);

        /// <summary>
        /// Obtiene un miembro con sus comités incluidos
        /// </summary>
        Task<Miembro?> GetByIdWithComitesAsync(Guid id);

        /// <summary>
        /// Obtiene miembros por estado
        /// </summary>
        Task<IEnumerable<Miembro>> GetByEstadoAsync(EstadoMiembro estado);

        /// <summary>
        /// Obtiene miembros por tipo de membresía
        /// </summary>
        Task<IEnumerable<Miembro>> GetByTipoMembresiaAsync(TipoMembresia tipo);

        /// <summary>
        /// Verifica si existe un miembro con el número de identificación dado
        /// </summary>
        Task<bool> ExisteNumeroIdentificacionAsync(string numeroIdentificacion, Guid? excludeId = null);

        /// <summary>
        /// Verifica si existe un miembro con el email dado
        /// </summary>
        Task<bool> ExisteEmailAsync(string email, Guid? excludeId = null);
    }
}

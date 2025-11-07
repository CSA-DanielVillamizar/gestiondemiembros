using LAMAMedellin.Domain.Entities;

namespace LAMAMedellin.Domain.Interfaces
{
    /// <summary>
    /// Repositorio específico para la entidad Comité
    /// </summary>
    public interface IComiteRepository : IRepository<Comite>
    {
        /// <summary>
        /// Obtiene un comité con sus miembros incluidos
        /// </summary>
        Task<Comite?> GetByIdWithMiembrosAsync(Guid id);

        /// <summary>
        /// Obtiene todos los comités activos
        /// </summary>
        Task<IEnumerable<Comite>> GetActivosAsync();
    }
}

using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using System.Threading.Tasks;

namespace LAMAMedellin.Domain.Interfaces
{
    /// <summary>
    /// Interfaz genérica para repositorio con operaciones CRUD básicas
    /// </summary>
    /// <typeparam name="T">Tipo de entidad</typeparam>
    public interface IRepository<T> where T : class
    {
        /// <summary>
        /// Obtiene una entidad por su ID
        /// </summary>
        Task<T?> GetByIdAsync(Guid id);

        /// <summary>
        /// Obtiene todas las entidades
        /// </summary>
        Task<IEnumerable<T>> GetAllAsync();

        /// <summary>
        /// Busca entidades que cumplan con un predicado
        /// </summary>
        Task<IEnumerable<T>> FindAsync(Expression<Func<T, bool>> predicate);

        /// <summary>
        /// Agrega una nueva entidad
        /// </summary>
        Task<T> AddAsync(T entity);

        /// <summary>
        /// Actualiza una entidad existente
        /// </summary>
        Task UpdateAsync(T entity);

        /// <summary>
        /// Elimina una entidad
        /// </summary>
        Task DeleteAsync(T entity);

        /// <summary>
        /// Cuenta entidades que cumplan con un predicado
        /// </summary>
        Task<int> CountAsync(Expression<Func<T, bool>>? predicate = null);

        /// <summary>
        /// Verifica si existe una entidad que cumpla con un predicado
        /// </summary>
        Task<bool> ExistsAsync(Expression<Func<T, bool>> predicate);
    }
}

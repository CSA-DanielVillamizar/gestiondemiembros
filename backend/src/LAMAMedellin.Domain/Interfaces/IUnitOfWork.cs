using System;
using System.Threading.Tasks;

namespace LAMAMedellin.Domain.Interfaces
{
    /// <summary>
    /// Interfaz Unit of Work para gestionar transacciones
    /// </summary>
    public interface IUnitOfWork : IDisposable
    {
        /// <summary>
        /// Repositorio de miembros
        /// </summary>
        IMiembroRepository Miembros { get; }

        /// <summary>
        /// Repositorio de comités
        /// </summary>
        IComiteRepository Comites { get; }

        /// <summary>
        /// Guarda todos los cambios en la base de datos
        /// </summary>
        Task<int> SaveChangesAsync();

        /// <summary>
        /// Inicia una transacción
        /// </summary>
        Task BeginTransactionAsync();

        /// <summary>
        /// Confirma la transacción actual
        /// </summary>
        Task CommitTransactionAsync();

        /// <summary>
        /// Revierte la transacción actual
        /// </summary>
        Task RollbackTransactionAsync();
    }
}

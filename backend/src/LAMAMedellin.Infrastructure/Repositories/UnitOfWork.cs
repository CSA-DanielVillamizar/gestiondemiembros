using LAMAMedellin.Domain.Interfaces;
using LAMAMedellin.Infrastructure.Data;
using Microsoft.EntityFrameworkCore.Storage;
using System;
using System.Threading.Tasks;

namespace LAMAMedellin.Infrastructure.Repositories
{
    /// <summary>
    /// Implementación del patrón Unit of Work
    /// </summary>
    public class UnitOfWork : IUnitOfWork
    {
        private readonly LAMADbContext _context;
        private IDbContextTransaction? _transaction;
        private IMiembroRepository? _miembros;
        private IComiteRepository? _comites;

        public UnitOfWork(LAMADbContext context)
        {
            _context = context ?? throw new ArgumentNullException(nameof(context));
        }

        public IMiembroRepository Miembros
        {
            get
            {
                _miembros ??= new MiembroRepository(_context);
                return _miembros;
            }
        }

        public IComiteRepository Comites
        {
            get
            {
                _comites ??= new ComiteRepository(_context);
                return _comites;
            }
        }

        public async Task<int> SaveChangesAsync()
        {
            return await _context.SaveChangesAsync();
        }

        public async Task BeginTransactionAsync()
        {
            _transaction = await _context.Database.BeginTransactionAsync();
        }

        public async Task CommitTransactionAsync()
        {
            if (_transaction != null)
            {
                await _transaction.CommitAsync();
                await _transaction.DisposeAsync();
                _transaction = null;
            }
        }

        public async Task RollbackTransactionAsync()
        {
            if (_transaction != null)
            {
                await _transaction.RollbackAsync();
                await _transaction.DisposeAsync();
                _transaction = null;
            }
        }

        public void Dispose()
        {
            _transaction?.Dispose();
            _context?.Dispose();
        }
    }
}

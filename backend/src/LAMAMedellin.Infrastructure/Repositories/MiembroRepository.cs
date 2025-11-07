using LAMAMedellin.Domain.Entities;
using LAMAMedellin.Domain.Interfaces;
using LAMAMedellin.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace LAMAMedellin.Infrastructure.Repositories
{
    /// <summary>
    /// Implementación del repositorio de Miembros
    /// </summary>
    public class MiembroRepository : Repository<Miembro>, IMiembroRepository
    {
        public MiembroRepository(LAMADbContext context) : base(context)
        {
        }

        public async Task<IEnumerable<Miembro>> SearchAsync(string searchTerm)
        {
            if (string.IsNullOrWhiteSpace(searchTerm))
            {
                return await GetAllAsync();
            }

            var lowerSearchTerm = searchTerm.ToLower();

            return await _dbSet
                .Include(m => m.Comites)
                    .ThenInclude(mc => mc.Comite)
                .Where(m =>
                    m.Nombres.ToLower().Contains(lowerSearchTerm) ||
                    m.Apellidos.ToLower().Contains(lowerSearchTerm) ||
                    m.Email.ToLower().Contains(lowerSearchTerm) ||
                    m.NumeroIdentificacion.ToLower().Contains(lowerSearchTerm))
                .ToListAsync();
        }

        public async Task<(IEnumerable<Miembro> Items, int TotalCount)> GetPagedAsync(
            int pageNumber,
            int pageSize,
            string? searchTerm = null,
            EstadoMiembro? estado = null,
            TipoMembresia? tipoMembresia = null)
        {
            var query = _dbSet
                .Include(m => m.Comites)
                    .ThenInclude(mc => mc.Comite)
                .AsQueryable();

            // Aplicar filtro de búsqueda
            if (!string.IsNullOrWhiteSpace(searchTerm))
            {
                var lowerSearchTerm = searchTerm.ToLower();
                query = query.Where(m =>
                    m.Nombres.ToLower().Contains(lowerSearchTerm) ||
                    m.Apellidos.ToLower().Contains(lowerSearchTerm) ||
                    m.Email.ToLower().Contains(lowerSearchTerm) ||
                    m.NumeroIdentificacion.ToLower().Contains(lowerSearchTerm));
            }

            // Aplicar filtro de estado
            if (estado.HasValue)
            {
                query = query.Where(m => m.Estado == estado.Value);
            }

            // Aplicar filtro de tipo de membresía
            if (tipoMembresia.HasValue)
            {
                query = query.Where(m => m.TipoMembresia == tipoMembresia.Value);
            }

            var totalCount = await query.CountAsync();

            var items = await query
                .OrderBy(m => m.Apellidos)
                .ThenBy(m => m.Nombres)
                .Skip((pageNumber - 1) * pageSize)
                .Take(pageSize)
                .ToListAsync();

            return (items, totalCount);
        }

        public async Task<Miembro?> GetByIdWithComitesAsync(Guid id)
        {
            return await _dbSet
                .Include(m => m.Comites)
                    .ThenInclude(mc => mc.Comite)
                .FirstOrDefaultAsync(m => m.Id == id);
        }

        public async Task<IEnumerable<Miembro>> GetByEstadoAsync(EstadoMiembro estado)
        {
            return await _dbSet
                .Include(m => m.Comites)
                    .ThenInclude(mc => mc.Comite)
                .Where(m => m.Estado == estado)
                .ToListAsync();
        }

        public async Task<IEnumerable<Miembro>> GetByTipoMembresiaAsync(TipoMembresia tipo)
        {
            return await _dbSet
                .Include(m => m.Comites)
                    .ThenInclude(mc => mc.Comite)
                .Where(m => m.TipoMembresia == tipo)
                .ToListAsync();
        }

        public async Task<bool> ExisteNumeroIdentificacionAsync(string numeroIdentificacion, Guid? excludeId = null)
        {
            var query = _dbSet.Where(m => m.NumeroIdentificacion == numeroIdentificacion);

            if (excludeId.HasValue)
            {
                query = query.Where(m => m.Id != excludeId.Value);
            }

            return await query.AnyAsync();
        }

        public async Task<bool> ExisteEmailAsync(string email, Guid? excludeId = null)
        {
            var query = _dbSet.Where(m => m.Email == email);

            if (excludeId.HasValue)
            {
                query = query.Where(m => m.Id != excludeId.Value);
            }

            return await query.AnyAsync();
        }
    }
}

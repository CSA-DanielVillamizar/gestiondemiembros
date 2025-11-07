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
    /// Implementación del repositorio de Comités
    /// </summary>
    public class ComiteRepository : Repository<Comite>, IComiteRepository
    {
        public ComiteRepository(LAMADbContext context) : base(context)
        {
        }

        public async Task<Comite?> GetByIdWithMiembrosAsync(Guid id)
        {
            return await _dbSet
                .Include(c => c.Miembros)
                    .ThenInclude(mc => mc.Miembro)
                .FirstOrDefaultAsync(c => c.Id == id);
        }

        public async Task<IEnumerable<Comite>> GetActivosAsync()
        {
            return await _dbSet
                .Where(c => c.Activo)
                .Include(c => c.Miembros)
                    .ThenInclude(mc => mc.Miembro)
                .ToListAsync();
        }
    }
}

using LAMAMedellin.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using System.Reflection;

namespace LAMAMedellin.Infrastructure.Data
{
    /// <summary>
    /// Contexto de base de datos para la aplicación L.A.M.A. Medellín
    /// </summary>
    public class LAMADbContext : DbContext
    {
        public LAMADbContext(DbContextOptions<LAMADbContext> options) : base(options)
        {
        }

        /// <summary>
        /// Conjunto de entidades Miembro
        /// </summary>
        public DbSet<Miembro> Miembros { get; set; } = null!;

        /// <summary>
        /// Conjunto de entidades Comité
        /// </summary>
        public DbSet<Comite> Comites { get; set; } = null!;

        /// <summary>
        /// Conjunto de entidades MiembroComite (relación)
        /// </summary>
        public DbSet<MiembroComite> MiembroComites { get; set; } = null!;

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // Aplicar todas las configuraciones de entidades del ensamblado
            modelBuilder.ApplyConfigurationsFromAssembly(Assembly.GetExecutingAssembly());

            // Configuración de Miembro
            modelBuilder.Entity<Miembro>(entity =>
            {
                entity.ToTable("Miembros");
                entity.HasKey(e => e.Id);

                entity.Property(e => e.NumeroIdentificacion)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.Nombres)
                    .IsRequired()
                    .HasMaxLength(100);

                entity.Property(e => e.Apellidos)
                    .IsRequired()
                    .HasMaxLength(100);

                entity.Property(e => e.Email)
                    .IsRequired()
                    .HasMaxLength(200);

                entity.Property(e => e.Telefono)
                    .HasMaxLength(20);

                entity.Property(e => e.Direccion)
                    .HasMaxLength(200);

                entity.Property(e => e.Ciudad)
                    .HasMaxLength(100);

                entity.Property(e => e.Profesion)
                    .HasMaxLength(100);

                entity.Property(e => e.Empresa)
                    .HasMaxLength(100);

                entity.Property(e => e.Notas)
                    .HasMaxLength(1000);

                entity.Property(e => e.FotoUrl)
                    .HasMaxLength(500);

                entity.Property(e => e.CreadoPor)
                    .HasMaxLength(100);

                entity.Property(e => e.ModificadoPor)
                    .HasMaxLength(100);

                // Índices
                entity.HasIndex(e => e.NumeroIdentificacion)
                    .IsUnique();

                entity.HasIndex(e => e.Email)
                    .IsUnique();

                entity.HasIndex(e => e.Estado);

                entity.HasIndex(e => e.TipoMembresia);
            });

            // Configuración de Comité
            modelBuilder.Entity<Comite>(entity =>
            {
                entity.ToTable("Comites");
                entity.HasKey(e => e.Id);

                entity.Property(e => e.Nombre)
                    .IsRequired()
                    .HasMaxLength(100);

                entity.Property(e => e.Descripcion)
                    .HasMaxLength(500);

                entity.HasIndex(e => e.Nombre)
                    .IsUnique();
            });

            // Configuración de MiembroComite (relación muchos a muchos)
            modelBuilder.Entity<MiembroComite>(entity =>
            {
                entity.ToTable("MiembroComites");

                entity.HasKey(e => new { e.MiembroId, e.ComiteId });

                entity.Property(e => e.Rol)
                    .HasMaxLength(100);

                entity.HasOne(e => e.Miembro)
                    .WithMany(m => m.Comites)
                    .HasForeignKey(e => e.MiembroId)
                    .OnDelete(DeleteBehavior.Cascade);

                entity.HasOne(e => e.Comite)
                    .WithMany(c => c.Miembros)
                    .HasForeignKey(e => e.ComiteId)
                    .OnDelete(DeleteBehavior.Cascade);
            });

            // Datos semilla para comités por defecto
            SeedData(modelBuilder);
        }

        /// <summary>
        /// Configura datos iniciales
        /// </summary>
        private void SeedData(ModelBuilder modelBuilder)
        {
            var comites = new[]
            {
                new Comite
                {
                    Id = Guid.Parse("11111111-1111-1111-1111-111111111111"),
                    Nombre = "Comité de Eventos",
                    Descripcion = "Organización de eventos del capítulo",
                    Activo = true,
                    FechaCreacion = DateTime.UtcNow
                },
                new Comite
                {
                    Id = Guid.Parse("22222222-2222-2222-2222-222222222222"),
                    Nombre = "Comité de Comunicaciones",
                    Descripcion = "Gestión de comunicación interna y externa",
                    Activo = true,
                    FechaCreacion = DateTime.UtcNow
                },
                new Comite
                {
                    Id = Guid.Parse("33333333-3333-3333-3333-333333333333"),
                    Nombre = "Comité de Proyectos Sociales",
                    Descripcion = "Desarrollo de proyectos de impacto social",
                    Activo = true,
                    FechaCreacion = DateTime.UtcNow
                }
            };

            modelBuilder.Entity<Comite>().HasData(comites);
        }

        /// <summary>
        /// Sobrescribe SaveChanges para auditoría automática
        /// </summary>
        public override Task<int> SaveChangesAsync(CancellationToken cancellationToken = default)
        {
            foreach (var entry in ChangeTracker.Entries<Miembro>())
            {
                if (entry.State == EntityState.Added)
                {
                    entry.Entity.FechaCreacion = DateTime.UtcNow;
                }
                else if (entry.State == EntityState.Modified)
                {
                    entry.Entity.FechaModificacion = DateTime.UtcNow;
                }
            }

            return base.SaveChangesAsync(cancellationToken);
        }
    }
}

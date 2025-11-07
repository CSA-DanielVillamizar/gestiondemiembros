using AutoMapper;
using LAMAMedellin.Application.DTOs;
using LAMAMedellin.Application.Interfaces;
using LAMAMedellin.Domain.Entities;
using LAMAMedellin.Domain.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace LAMAMedellin.Application.Services
{
    /// <summary>
    /// Implementación del servicio de gestión de miembros
    /// </summary>
    public class MiembroService : IMiembroService
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;

        public MiembroService(IUnitOfWork unitOfWork, IMapper mapper)
        {
            _unitOfWork = unitOfWork ?? throw new ArgumentNullException(nameof(unitOfWork));
            _mapper = mapper ?? throw new ArgumentNullException(nameof(mapper));
        }

        public async Task<MiembroDto?> GetByIdAsync(Guid id)
        {
            var miembro = await _unitOfWork.Miembros.GetByIdWithComitesAsync(id);
            return miembro == null ? null : _mapper.Map<MiembroDto>(miembro);
        }

        public async Task<IEnumerable<MiembroDto>> GetAllAsync()
        {
            var miembros = await _unitOfWork.Miembros.GetAllAsync();
            return _mapper.Map<IEnumerable<MiembroDto>>(miembros);
        }

        public async Task<PagedResultDto<MiembroDto>> GetPagedAsync(
            int pageNumber, 
            int pageSize, 
            string? searchTerm = null,
            EstadoMiembro? estado = null,
            TipoMembresia? tipoMembresia = null)
        {
            var (items, totalCount) = await _unitOfWork.Miembros.GetPagedAsync(
                pageNumber, pageSize, searchTerm, estado, tipoMembresia);

            return new PagedResultDto<MiembroDto>
            {
                Items = _mapper.Map<List<MiembroDto>>(items),
                TotalCount = totalCount,
                PageNumber = pageNumber,
                PageSize = pageSize
            };
        }

        public async Task<MiembroDto> CreateAsync(CrearMiembroDto dto, string? createdBy = null)
        {
            // Validar que no exista el número de identificación
            if (await _unitOfWork.Miembros.ExisteNumeroIdentificacionAsync(dto.NumeroIdentificacion))
            {
                throw new InvalidOperationException($"Ya existe un miembro con el número de identificación {dto.NumeroIdentificacion}");
            }

            // Validar que no exista el email
            if (await _unitOfWork.Miembros.ExisteEmailAsync(dto.Email))
            {
                throw new InvalidOperationException($"Ya existe un miembro con el email {dto.Email}");
            }

            var miembro = _mapper.Map<Miembro>(dto);
            miembro.Id = Guid.NewGuid();
            miembro.FechaCreacion = DateTime.UtcNow;
            miembro.CreadoPor = createdBy;

            // Agregar comités si se especificaron
            if (dto.ComiteIds != null && dto.ComiteIds.Any())
            {
                foreach (var comiteId in dto.ComiteIds)
                {
                    miembro.Comites.Add(new MiembroComite
                    {
                        MiembroId = miembro.Id,
                        ComiteId = comiteId,
                        FechaIngreso = DateTime.UtcNow
                    });
                }
            }

            await _unitOfWork.Miembros.AddAsync(miembro);
            await _unitOfWork.SaveChangesAsync();

            return _mapper.Map<MiembroDto>(miembro);
        }

        public async Task<MiembroDto> UpdateAsync(ActualizarMiembroDto dto, string? modifiedBy = null)
        {
            var miembro = await _unitOfWork.Miembros.GetByIdAsync(dto.Id);
            if (miembro == null)
            {
                throw new KeyNotFoundException($"No se encontró el miembro con ID {dto.Id}");
            }

            // Validar que no exista el número de identificación en otro miembro
            if (await _unitOfWork.Miembros.ExisteNumeroIdentificacionAsync(dto.NumeroIdentificacion, dto.Id))
            {
                throw new InvalidOperationException($"Ya existe otro miembro con el número de identificación {dto.NumeroIdentificacion}");
            }

            // Validar que no exista el email en otro miembro
            if (await _unitOfWork.Miembros.ExisteEmailAsync(dto.Email, dto.Id))
            {
                throw new InvalidOperationException($"Ya existe otro miembro con el email {dto.Email}");
            }

            _mapper.Map(dto, miembro);
            miembro.FechaModificacion = DateTime.UtcNow;
            miembro.ModificadoPor = modifiedBy;

            await _unitOfWork.Miembros.UpdateAsync(miembro);
            await _unitOfWork.SaveChangesAsync();

            return _mapper.Map<MiembroDto>(miembro);
        }

        public async Task<bool> DeleteAsync(Guid id)
        {
            var miembro = await _unitOfWork.Miembros.GetByIdAsync(id);
            if (miembro == null)
            {
                return false;
            }

            await _unitOfWork.Miembros.DeleteAsync(miembro);
            await _unitOfWork.SaveChangesAsync();

            return true;
        }

        public async Task<IEnumerable<MiembroDto>> SearchAsync(string searchTerm)
        {
            var miembros = await _unitOfWork.Miembros.SearchAsync(searchTerm);
            return _mapper.Map<IEnumerable<MiembroDto>>(miembros);
        }

        public async Task<MiembrosEstadisticasDto> GetEstadisticasAsync()
        {
            var todosMiembros = await _unitOfWork.Miembros.GetAllAsync();
            var miembrosList = todosMiembros.ToList();

            return new MiembrosEstadisticasDto
            {
                TotalMiembros = miembrosList.Count,
                MiembrosActivos = miembrosList.Count(m => m.Estado == EstadoMiembro.Activo),
                MiembrosInactivos = miembrosList.Count(m => m.Estado == EstadoMiembro.Inactivo),
                MiembrosSuspendidos = miembrosList.Count(m => m.Estado == EstadoMiembro.Suspendido),
                PorTipoMembresia = miembrosList
                    .GroupBy(m => m.TipoMembresia.ToString())
                    .ToDictionary(g => g.Key, g => g.Count()),
                PorCiudad = miembrosList
                    .Where(m => !string.IsNullOrEmpty(m.Ciudad))
                    .GroupBy(m => m.Ciudad!)
                    .ToDictionary(g => g.Key, g => g.Count())
            };
        }

        public Task<byte[]> ExportToExcelAsync()
        {
            // Implementación pendiente - requiere librería EPPlus o similar
            throw new NotImplementedException("La funcionalidad de exportación a Excel será implementada");
        }

        public Task<ImportResultDto> ImportFromExcelAsync(byte[] fileData, string? importedBy = null)
        {
            // Implementación pendiente - requiere librería EPPlus o similar
            throw new NotImplementedException("La funcionalidad de importación desde Excel será implementada");
        }
    }
}

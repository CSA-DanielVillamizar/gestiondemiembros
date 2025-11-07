using AutoMapper;
using LAMAMedellin.Application.DTOs;
using LAMAMedellin.Domain.Entities;
using System.Linq;

namespace LAMAMedellin.Application.Mappings
{
    /// <summary>
    /// Configuración de mapeos con AutoMapper
    /// </summary>
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            // Miembro -> MiembroDto
            CreateMap<Miembro, MiembroDto>()
                .ForMember(dest => dest.EstadoDescripcion, 
                    opt => opt.MapFrom(src => src.Estado.ToString()))
                .ForMember(dest => dest.TipoMembresiaDescripcion, 
                    opt => opt.MapFrom(src => src.TipoMembresia.ToString()))
                .ForMember(dest => dest.Comites, 
                    opt => opt.MapFrom(src => src.Comites.Select(mc => new ComiteSimpleDto
                    {
                        Id = mc.ComiteId,
                        Nombre = mc.Comite.Nombre,
                        Rol = mc.Rol,
                        EsCoordinador = mc.EsCoordinador
                    })));

            // CrearMiembroDto -> Miembro
            CreateMap<CrearMiembroDto, Miembro>()
                .ForMember(dest => dest.Id, opt => opt.Ignore())
                .ForMember(dest => dest.FechaCreacion, opt => opt.MapFrom(src => DateTime.UtcNow))
                .ForMember(dest => dest.FechaModificacion, opt => opt.Ignore())
                .ForMember(dest => dest.Comites, opt => opt.Ignore());

            // ActualizarMiembroDto -> Miembro
            CreateMap<ActualizarMiembroDto, Miembro>()
                .ForMember(dest => dest.FechaCreacion, opt => opt.Ignore())
                .ForMember(dest => dest.FechaModificacion, opt => opt.MapFrom(src => DateTime.UtcNow))
                .ForMember(dest => dest.CreadoPor, opt => opt.Ignore())
                .ForMember(dest => dest.Comites, opt => opt.Ignore());

            // Comite -> ComiteDto
            CreateMap<Comite, ComiteDto>();

            CreateMap<CrearComiteDto, Comite>()
                .ForMember(dest => dest.Id, opt => opt.Ignore())
                .ForMember(dest => dest.FechaCreacion, opt => opt.MapFrom(src => DateTime.UtcNow));
        }
    }
}

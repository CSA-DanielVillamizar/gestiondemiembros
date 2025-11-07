/**
 * Tipos para la entidad Miembro
 */

export enum EstadoMiembro {
  Activo = 1,
  Inactivo = 2,
  Suspendido = 3,
}

export enum TipoMembresia {
  Regular = 1,
  Honor = 2,
  Vitalicio = 3,
  Temporal = 4,
}

export interface ComiteSimple {
  id: string;
  nombre: string;
  rol?: string;
  esCoordinador: boolean;
}

export interface Miembro {
  id: string;
  numeroIdentificacion: string;
  nombres: string;
  apellidos: string;
  nombreCompleto: string;
  email: string;
  telefono?: string;
  direccion?: string;
  ciudad?: string;
  fechaNacimiento?: string;
  edad?: number;
  profesion?: string;
  empresa?: string;
  fechaIngreso: string;
  estado: EstadoMiembro;
  estadoDescripcion: string;
  tipoMembresia: TipoMembresia;
  tipoMembresiaDescripcion: string;
  notas?: string;
  fotoUrl?: string;
  fechaCreacion: string;
  fechaModificacion?: string;
  comites: ComiteSimple[];
}

export interface CrearMiembroDto {
  numeroIdentificacion: string;
  nombres: string;
  apellidos: string;
  email: string;
  telefono?: string;
  direccion?: string;
  ciudad?: string;
  fechaNacimiento?: string;
  profesion?: string;
  empresa?: string;
  fechaIngreso: string;
  estado: EstadoMiembro;
  tipoMembresia: TipoMembresia;
  notas?: string;
  fotoUrl?: string;
  comiteIds?: string[];
}

export interface ActualizarMiembroDto extends CrearMiembroDto {
  id: string;
}

export interface PagedResult<T> {
  items: T[];
  totalCount: number;
  pageNumber: number;
  pageSize: number;
  totalPages: number;
  hasPreviousPage: boolean;
  hasNextPage: boolean;
}

export interface MiembrosEstadisticas {
  totalMiembros: number;
  miembrosActivos: number;
  miembrosInactivos: number;
  miembrosSuspendidos: number;
  porTipoMembresia: Record<string, number>;
  porCiudad: Record<string, number>;
}

export interface MiembroFiltros {
  searchTerm?: string;
  estado?: EstadoMiembro;
  tipoMembresia?: TipoMembresia;
  pageNumber: number;
  pageSize: number;
}

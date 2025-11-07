/**
 * Tipos para las respuestas de la API del sistema L.A.M.A. Medellín
 */

export interface Miembro {
  id?: string;
  numeroIdentificacion: string;
  tipoIdentificacion: number;
  nombres: string;
  apellidos: string;
  email: string;
  telefono?: string;
  celular?: string;
  direccion?: string;
  ciudad?: string;
  departamento?: string;
  profesion?: string;
  empresa?: string;
  cargoActual?: string;
  linkedinUrl?: string;
  estado: number;
  tipoMembresia: number;
  fechaIngreso: string;
  comites?: ComiteMiembro[];
}

export interface ComiteMiembro {
  id: string;
  comiteId: string;
  comite?: Comite;
  cargo?: string;
  fechaInicio: string;
  fechaFin?: string;
}

export interface Comite {
  id: string;
  nombre: string;
  descripcion?: string;
  estado: number;
}

export interface ApiError {
  message: string;
  errors?: Record<string, string[]>;
}

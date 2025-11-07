/**
 * Servicio para operaciones con miembros
 */

import { httpClient } from './httpClient';
import {
  Miembro,
  CrearMiembroDto,
  ActualizarMiembroDto,
  PagedResult,
  MiembrosEstadisticas,
  MiembroFiltros,
} from '@/types/miembro.types';

const MIEMBROS_ENDPOINT = '/miembros';

/**
 * Servicio de API para miembros
 */
export const miembroService = {
  /**
   * Obtiene miembros con paginación y filtros
   */
  async getMiembros(filtros: MiembroFiltros): Promise<PagedResult<Miembro>> {
    const params = new URLSearchParams();
    params.append('pageNumber', filtros.pageNumber.toString());
    params.append('pageSize', filtros.pageSize.toString());
    
    if (filtros.searchTerm) {
      params.append('searchTerm', filtros.searchTerm);
    }
    if (filtros.estado !== undefined) {
      params.append('estado', filtros.estado.toString());
    }
    if (filtros.tipoMembresia !== undefined) {
      params.append('tipoMembresia', filtros.tipoMembresia.toString());
    }

    const response = await httpClient.get<PagedResult<Miembro>>(
      `${MIEMBROS_ENDPOINT}?${params.toString()}`
    );
    return response.data;
  },

  /**
   * Obtiene un miembro por su ID
   */
  async getMiembroById(id: string): Promise<Miembro> {
    const response = await httpClient.get<Miembro>(`${MIEMBROS_ENDPOINT}/${id}`);
    return response.data;
  },

  /**
   * Busca miembros por término
   */
  async searchMiembros(searchTerm: string): Promise<Miembro[]> {
    const response = await httpClient.get<Miembro[]>(
      `${MIEMBROS_ENDPOINT}/search?searchTerm=${encodeURIComponent(searchTerm)}`
    );
    return response.data;
  },

  /**
   * Crea un nuevo miembro
   */
  async createMiembro(dto: CrearMiembroDto): Promise<Miembro> {
    const response = await httpClient.post<Miembro>(MIEMBROS_ENDPOINT, dto);
    return response.data;
  },

  /**
   * Actualiza un miembro existente
   */
  async updateMiembro(id: string, dto: ActualizarMiembroDto): Promise<Miembro> {
    const response = await httpClient.put<Miembro>(`${MIEMBROS_ENDPOINT}/${id}`, dto);
    return response.data;
  },

  /**
   * Elimina un miembro
   */
  async deleteMiembro(id: string): Promise<void> {
    await httpClient.delete(`${MIEMBROS_ENDPOINT}/${id}`);
  },

  /**
   * Obtiene estadísticas de miembros
   */
  async getEstadisticas(): Promise<MiembrosEstadisticas> {
    const response = await httpClient.get<MiembrosEstadisticas>(
      `${MIEMBROS_ENDPOINT}/estadisticas`
    );
    return response.data;
  },
};

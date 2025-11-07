/**
 * Servicio HTTP con Axios para comunicación con la API
 */

import axios, { AxiosError, AxiosInstance, AxiosRequestConfig, AxiosResponse } from 'axios';
import { config } from '@/config/config';

/**
 * Instancia configurada de Axios
 */
const apiClient: AxiosInstance = axios.create({
  baseURL: config.apiBaseUrl,
  timeout: config.apiTimeout,
  headers: {
    'Content-Type': 'application/json',
  },
});

/**
 * Interceptor para agregar el token de autorización a las peticiones
 */
apiClient.interceptors.request.use(
  (config) => {
    // El token será agregado por el hook useApiClient que envuelve MSAL
    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);

/**
 * Interceptor para manejar respuestas de error globalmente
 */
apiClient.interceptors.response.use(
  (response: AxiosResponse) => response,
  (error: AxiosError) => {
    if (error.response) {
      // El servidor respondió con un código de error
      console.error('Error de respuesta:', error.response.status, error.response.data);
      
      switch (error.response.status) {
        case 401:
          // No autorizado - manejar renovación de token o redirigir al login
          console.error('No autorizado. Token inválido o expirado.');
          break;
        case 403:
          // Prohibido
          console.error('Acceso prohibido.');
          break;
        case 404:
          // No encontrado
          console.error('Recurso no encontrado.');
          break;
        case 500:
          // Error del servidor
          console.error('Error interno del servidor.');
          break;
        default:
          console.error('Error desconocido:', error.response.status);
      }
    } else if (error.request) {
      // La petición fue enviada pero no hubo respuesta
      console.error('No se recibió respuesta del servidor:', error.request);
    } else {
      // Error al configurar la petición
      console.error('Error al configurar la petición:', error.message);
    }
    
    return Promise.reject(error);
  }
);

/**
 * Métodos HTTP genéricos
 */
export const httpClient = {
  /**
   * Petición GET
   */
  get: <T>(url: string, config?: AxiosRequestConfig): Promise<AxiosResponse<T>> => {
    return apiClient.get<T>(url, config);
  },

  /**
   * Petición POST
   */
  post: <T>(url: string, data?: any, config?: AxiosRequestConfig): Promise<AxiosResponse<T>> => {
    return apiClient.post<T>(url, data, config);
  },

  /**
   * Petición PUT
   */
  put: <T>(url: string, data?: any, config?: AxiosRequestConfig): Promise<AxiosResponse<T>> => {
    return apiClient.put<T>(url, data, config);
  },

  /**
   * Petición DELETE
   */
  delete: <T>(url: string, config?: AxiosRequestConfig): Promise<AxiosResponse<T>> => {
    return apiClient.delete<T>(url, config);
  },

  /**
   * Petición PATCH
   */
  patch: <T>(url: string, data?: any, config?: AxiosRequestConfig): Promise<AxiosResponse<T>> => {
    return apiClient.patch<T>(url, data, config);
  },
};

/**
 * Función helper para configurar el token de autenticación
 */
export const setAuthToken = (token: string | null): void => {
  if (token) {
    apiClient.defaults.headers.common['Authorization'] = `Bearer ${token}`;
  } else {
    delete apiClient.defaults.headers.common['Authorization'];
  }
};

export default apiClient;

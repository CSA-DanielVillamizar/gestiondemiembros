/**
 * Configuración de la aplicación
 */

export const config = {
  /**
   * URL base de la API
   */
  apiBaseUrl: import.meta.env.VITE_API_BASE_URL || 'https://localhost:7001/api',

  /**
   * Timeout para peticiones HTTP (ms)
   */
  apiTimeout: 30000,

  /**
   * Tamaño de página por defecto para listados paginados
   */
  defaultPageSize: 10,

  /**
   * Opciones de tamaño de página disponibles
   */
  pageSizeOptions: [5, 10, 25, 50, 100],

  /**
   * Tiempo de debounce para búsquedas (ms)
   */
  searchDebounceTime: 500,

  /**
   * Duración de notificaciones (ms)
   */
  notificationDuration: 5000,
};

/**
 * Variables de entorno de Azure AD B2C
 */
export const azureAdB2CConfig = {
  clientId: import.meta.env.VITE_AZURE_AD_B2C_CLIENT_ID || '',
  authority: import.meta.env.VITE_AZURE_AD_B2C_AUTHORITY || '',
  knownAuthority: import.meta.env.VITE_AZURE_AD_B2C_KNOWN_AUTHORITY || '',
  redirectUri: import.meta.env.VITE_REDIRECT_URI || 'http://localhost:3000',
  postLogoutRedirectUri: import.meta.env.VITE_POST_LOGOUT_REDIRECT_URI || 'http://localhost:3000',
  apiScope: import.meta.env.VITE_API_SCOPE || '',
};

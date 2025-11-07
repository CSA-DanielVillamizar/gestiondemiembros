/**
 * Configuración de autenticación con Azure AD B2C
 */

import { Configuration, LogLevel } from '@azure/msal-browser';

/**
 * Configuración de MSAL para Azure AD B2C
 */
export const msalConfig: Configuration = {
  auth: {
    clientId: import.meta.env.VITE_AZURE_AD_B2C_CLIENT_ID || '',
    authority: import.meta.env.VITE_AZURE_AD_B2C_AUTHORITY || '',
    knownAuthorities: [import.meta.env.VITE_AZURE_AD_B2C_KNOWN_AUTHORITY || ''],
    redirectUri: import.meta.env.VITE_REDIRECT_URI || 'http://localhost:3000',
    postLogoutRedirectUri: import.meta.env.VITE_POST_LOGOUT_REDIRECT_URI || 'http://localhost:3000',
  },
  cache: {
    cacheLocation: 'sessionStorage',
    storeAuthStateInCookie: false,
  },
  system: {
    loggerOptions: {
      loggerCallback: (level, message, containsPii) => {
        if (containsPii) return;
        switch (level) {
          case LogLevel.Error:
            console.error(message);
            return;
          case LogLevel.Info:
            console.info(message);
            return;
          case LogLevel.Verbose:
            console.debug(message);
            return;
          case LogLevel.Warning:
            console.warn(message);
            return;
        }
      },
    },
  },
};

/**
 * Scopes de API solicitados durante el login
 */
export const loginRequest = {
  scopes: ['openid', 'profile', 'email'],
};

/**
 * Scopes para obtener tokens de acceso a la API
 */
export const apiRequest = {
  scopes: [import.meta.env.VITE_API_SCOPE || ''],
};

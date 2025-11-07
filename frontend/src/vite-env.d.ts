/// <reference types="vite/client" />

interface ImportMetaEnv {
  readonly VITE_DEV_MODE?: string;
  readonly VITE_API_BASE_URL: string;
  readonly VITE_AZURE_AD_B2C_CLIENT_ID: string;
  readonly VITE_AZURE_AD_B2C_AUTHORITY: string;
  readonly VITE_AZURE_AD_B2C_KNOWN_AUTHORITY: string;
  readonly VITE_API_SCOPE: string;
  readonly VITE_REDIRECT_URI: string;
  readonly VITE_POST_LOGOUT_REDIRECT_URI: string;
}

interface ImportMeta {
  readonly env: ImportMetaEnv;
}

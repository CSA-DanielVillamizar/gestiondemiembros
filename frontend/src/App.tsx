import { Routes, Route, Navigate } from 'react-router-dom';
import { useIsAuthenticated } from '@azure/msal-react';
import { Box } from '@mui/material';
import Layout from './components/Layout/Layout';
import Login from './pages/Login';
import Dashboard from './pages/Dashboard';
import MiembrosList from './pages/Miembros/MiembrosList';
import MiembroDetail from './pages/Miembros/MiembroDetail';
import MiembroForm from './pages/Miembros/MiembroForm';
import NotFound from './pages/NotFound';

/**
 * Componente para rutas protegidas que requieren autenticación
 */
function ProtectedRoute({ children }: { children: React.ReactNode }) {
  const isAuthenticated = useIsAuthenticated();
  
  // En modo desarrollo, permitir acceso sin autenticación
  const devMode = import.meta.env.VITE_DEV_MODE === 'true';
  
  if (!isAuthenticated && !devMode) {
    return <Navigate to="/login" replace />;
  }
  
  return <>{children}</>;
}

/**
 * Componente principal de la aplicación
 */
function App() {
  const isAuthenticated = useIsAuthenticated();
  const devMode = import.meta.env.VITE_DEV_MODE === 'true';

  return (
    <Box sx={{ display: 'flex', minHeight: '100vh' }}>
      <Routes>
        {/* Ruta pública de login */}
        <Route
          path="/login"
          element={
            (isAuthenticated || devMode) ? <Navigate to="/dashboard" replace /> : <Login />
          }
        />

        {/* Rutas protegidas */}
        <Route
          path="/"
          element={
            <ProtectedRoute>
              <Layout />
            </ProtectedRoute>
          }
        >
          <Route index element={<Navigate to="/dashboard" replace />} />
          <Route path="dashboard" element={<Dashboard />} />
          
          {/* Rutas de miembros */}
          <Route path="miembros">
            <Route index element={<MiembrosList />} />
            <Route path="nuevo" element={<MiembroForm />} />
            <Route path=":id" element={<MiembroDetail />} />
            <Route path=":id/editar" element={<MiembroForm />} />
          </Route>
        </Route>

        {/* Ruta 404 */}
        <Route path="*" element={<NotFound />} />
      </Routes>
    </Box>
  );
}

export default App;

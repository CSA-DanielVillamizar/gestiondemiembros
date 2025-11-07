import { Box, Container, Typography, Button, Card, CardContent } from '@mui/material';
import { useMsal } from '@azure/msal-react';
import { loginRequest } from '@/config/authConfig';
import LoginIcon from '@mui/icons-material/Login';
import FacebookIcon from '@mui/icons-material/Facebook';
import GoogleIcon from '@mui/icons-material/Google';

/**
 * Página de login con autenticación de Azure AD B2C
 */
function Login() {
  const { instance } = useMsal();

  const handleLogin = async () => {
    try {
      await instance.loginPopup(loginRequest);
    } catch (error) {
      console.error('Error al iniciar sesión:', error);
    }
  };

  return (
    <Container maxWidth="sm">
      <Box
        sx={{
          minHeight: '100vh',
          display: 'flex',
          flexDirection: 'column',
          justifyContent: 'center',
          alignItems: 'center',
        }}
      >
        <Card sx={{ width: '100%', p: 3 }}>
          <CardContent>
            <Box textAlign="center" mb={4}>
              <Typography variant="h3" gutterBottom>
                L.A.M.A. Medellín
              </Typography>
              <Typography variant="h6" color="text.secondary">
                Sistema de Gestión de Miembros
              </Typography>
            </Box>

            <Button
              fullWidth
              variant="contained"
              size="large"
              startIcon={<LoginIcon />}
              onClick={handleLogin}
              sx={{ mb: 2, py: 1.5 }}
            >
              Iniciar Sesión
            </Button>

            <Typography variant="body2" textAlign="center" color="text.secondary" my={2}>
              O continuar con:
            </Typography>

            <Box display="flex" gap={2}>
              <Button
                fullWidth
                variant="outlined"
                startIcon={<GoogleIcon />}
                onClick={handleLogin}
              >
                Google
              </Button>
              <Button
                fullWidth
                variant="outlined"
                startIcon={<FacebookIcon />}
                onClick={handleLogin}
              >
                Facebook
              </Button>
            </Box>
          </CardContent>
        </Card>
      </Box>
    </Container>
  );
}

export default Login;

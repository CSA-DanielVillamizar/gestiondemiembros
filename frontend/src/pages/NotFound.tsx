import { Box, Typography, Button } from '@mui/material';
import { useNavigate } from 'react-router-dom';

function NotFound() {
  const navigate = useNavigate();
  
  return (
    <Box textAlign="center" mt={8}>
      <Typography variant="h1">404</Typography>
      <Typography variant="h5" gutterBottom>
        Página no encontrada
      </Typography>
      <Button variant="contained" onClick={() => navigate('/dashboard')}>
        Volver al Dashboard
      </Button>
    </Box>
  );
}

export default NotFound;

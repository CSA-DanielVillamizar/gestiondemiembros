import { useState, useEffect } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import {
  Box,
  Typography,
  Paper,
  Grid,
  Button,
  Chip,
  CircularProgress,
  Alert,
  Stack,
  Divider,
  Avatar,
  List,
  ListItem,
  ListItemText,
  Card,
  CardContent
} from '@mui/material';
import {
  ArrowBack as ArrowBackIcon,
  Edit as EditIcon,
  Delete as DeleteIcon,
  Email as EmailIcon,
  Phone as PhoneIcon,
  Business as BusinessIcon,
  LocationOn as LocationOnIcon,
  CalendarToday as CalendarIcon,
  Person as PersonIcon,
  LinkedIn as LinkedInIcon
} from '@mui/icons-material';
import httpClient from '../../api/httpClient';
import { Miembro } from '../../types/api';

interface Miembro {
  id: string;
  numeroIdentificacion: string;
  tipoIdentificacion: number;
  nombres: string;
  apellidos: string;
  nombreCompleto: string;
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
  fotoUrl?: string;
  estado: number;
  tipoMembresia: number;
  fechaIngreso: string;
  fechaCreacion: string;
  ultimaActualizacion?: string;
}

interface InfoCardProps {
  icon: React.ReactNode;
  title: string;
  value: string | undefined;
}

const InfoCard = ({ icon, title, value }: InfoCardProps) => (
  <Card elevation={1} sx={{ height: '100%' }}>
    <CardContent>
      <Stack direction="row" spacing={2} alignItems="center">
        <Box sx={{ color: 'primary.main' }}>{icon}</Box>
        <Box sx={{ flex: 1 }}>
          <Typography variant="caption" color="text.secondary">
            {title}
          </Typography>
          <Typography variant="body1" fontWeight={500}>
            {value || 'No especificado'}
          </Typography>
        </Box>
      </Stack>
    </CardContent>
  </Card>
);

function MiembroDetail() {
  const navigate = useNavigate();
  const { id } = useParams<{ id: string }>();

  const [miembro, setMiembro] = useState<Miembro | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    if (id) {
      loadMiembro(id);
    }
  }, [id]);

  const loadMiembro = async (miembroId: string) => {
    try {
      setLoading(true);
      setError(null);
      const response = await httpClient.get<Miembro>(`/Miembros/${miembroId}`);
      setMiembro(response.data);
    } catch (err: any) {
      console.error('Error al cargar miembro:', err);
      setError(err.response?.data?.message || 'Error al cargar los datos del miembro');
    } finally {
      setLoading(false);
    }
  };

  const handleEdit = () => {
    navigate(`/miembros/editar/${id}`);
  };

  const handleDelete = async () => {
    if (!window.confirm('¿Está seguro de eliminar este miembro?')) {
      return;
    }

    try {
      await httpClient.delete(`/Miembros/${id}`);
      navigate('/miembros');
    } catch (err: any) {
      alert(err.response?.data?.message || 'Error al eliminar el miembro');
    }
  };

  const handleBack = () => {
    navigate('/miembros');
  };

  const getTipoIdentificacionLabel = (tipo: number): string => {
    const labels: Record<number, string> = {
      1: 'Cédula de Ciudadanía',
      2: 'Cédula de Extranjería',
      3: 'Pasaporte',
      4: 'NIT'
    };
    return labels[tipo] || 'No especificado';
  };

  const getEstadoLabel = (estado: number): string => {
    const labels: Record<number, string> = {
      1: 'Activo',
      2: 'Inactivo',
      3: 'Suspendido'
    };
    return labels[estado] || 'Desconocido';
  };

  const getEstadoColor = (estado: number): 'success' | 'default' | 'error' => {
    const colors: Record<number, 'success' | 'default' | 'error'> = {
      1: 'success',
      2: 'default',
      3: 'error'
    };
    return colors[estado] || 'default';
  };

  const getTipoMembresiaLabel = (tipo: number): string => {
    const labels: Record<number, string> = {
      1: 'Regular',
      2: 'Honor',
      3: 'Vitalicio',
      4: 'Temporal'
    };
    return labels[tipo] || 'No especificado';
  };

  const formatDate = (dateString: string): string => {
    return new Date(dateString).toLocaleDateString('es-CO', {
      year: 'numeric',
      month: 'long',
      day: 'numeric'
    });
  };

  if (loading) {
    return (
      <Box display="flex" justifyContent="center" alignItems="center" minHeight="60vh">
        <CircularProgress size={60} />
      </Box>
    );
  }

  if (error || !miembro) {
    return (
      <Box>
        <Alert severity="error" sx={{ mb: 3 }}>
          {error || 'No se encontró el miembro'}
        </Alert>
        <Button startIcon={<ArrowBackIcon />} onClick={handleBack}>
          Volver a la lista
        </Button>
      </Box>
    );
  }

  return (
    <Box>
      {/* Header con acciones */}
      <Stack direction="row" justifyContent="space-between" alignItems="center" sx={{ mb: 3 }}>
        <Stack direction="row" alignItems="center" spacing={2}>
          <Button
            startIcon={<ArrowBackIcon />}
            onClick={handleBack}
            variant="outlined"
          >
            Volver
          </Button>
          <Typography variant="h4">
            Detalle del Miembro
          </Typography>
        </Stack>
        <Stack direction="row" spacing={2}>
          <Button
            startIcon={<EditIcon />}
            onClick={handleEdit}
            variant="contained"
          >
            Editar
          </Button>
          <Button
            startIcon={<DeleteIcon />}
            onClick={handleDelete}
            variant="outlined"
            color="error"
          >
            Eliminar
          </Button>
        </Stack>
      </Stack>

      {/* Información principal */}
      <Paper elevation={2} sx={{ p: 3, mb: 3 }}>
        <Grid container spacing={3}>
          {/* Avatar y nombre */}
          <Grid item xs={12} md={3} sx={{ textAlign: 'center' }}>
            <Avatar
              src={miembro.fotoUrl}
              alt={miembro.nombreCompleto}
              sx={{ width: 150, height: 150, margin: '0 auto', mb: 2 }}
            >
              <PersonIcon sx={{ fontSize: 80 }} />
            </Avatar>
            <Typography variant="h5" gutterBottom>
              {miembro.nombreCompleto}
            </Typography>
            <Stack direction="row" spacing={1} justifyContent="center" sx={{ mb: 2 }}>
              <Chip
                label={getEstadoLabel(miembro.estado)}
                color={getEstadoColor(miembro.estado)}
                size="small"
              />
              <Chip
                label={getTipoMembresiaLabel(miembro.tipoMembresia)}
                variant="outlined"
                size="small"
              />
            </Stack>
          </Grid>

          {/* Información detallada */}
          <Grid item xs={12} md={9}>
            <Typography variant="h6" gutterBottom>
              Información Personal
            </Typography>
            <Divider sx={{ mb: 2 }} />
            <List dense>
              <ListItem>
                <ListItemText
                  primary="Tipo de Identificación"
                  secondary={getTipoIdentificacionLabel(miembro.tipoIdentificacion)}
                />
              </ListItem>
              <ListItem>
                <ListItemText
                  primary="Número de Identificación"
                  secondary={miembro.numeroIdentificacion}
                />
              </ListItem>
              <ListItem>
                <ListItemText
                  primary="Nombres"
                  secondary={miembro.nombres}
                />
              </ListItem>
              <ListItem>
                <ListItemText
                  primary="Apellidos"
                  secondary={miembro.apellidos}
                />
              </ListItem>
            </List>
          </Grid>
        </Grid>
      </Paper>

      {/* Contacto */}
      <Typography variant="h6" gutterBottom sx={{ mt: 3, mb: 2 }}>
        Información de Contacto
      </Typography>
      <Grid container spacing={2} sx={{ mb: 3 }}>
        <Grid item xs={12} sm={6} md={3}>
          <InfoCard
            icon={<EmailIcon />}
            title="Email"
            value={miembro.email}
          />
        </Grid>
        <Grid item xs={12} sm={6} md={3}>
          <InfoCard
            icon={<PhoneIcon />}
            title="Celular"
            value={miembro.celular}
          />
        </Grid>
        <Grid item xs={12} sm={6} md={3}>
          <InfoCard
            icon={<PhoneIcon />}
            title="Teléfono Fijo"
            value={miembro.telefono}
          />
        </Grid>
        <Grid item xs={12} sm={6} md={3}>
          <InfoCard
            icon={<LinkedInIcon />}
            title="LinkedIn"
            value={miembro.linkedinUrl ? 'Ver perfil' : undefined}
          />
        </Grid>
      </Grid>

      {/* Dirección */}
      <Typography variant="h6" gutterBottom sx={{ mt: 3, mb: 2 }}>
        Dirección
      </Typography>
      <Grid container spacing={2} sx={{ mb: 3 }}>
        <Grid item xs={12} sm={6}>
          <InfoCard
            icon={<LocationOnIcon />}
            title="Ciudad"
            value={miembro.ciudad}
          />
        </Grid>
        <Grid item xs={12} sm={6}>
          <InfoCard
            icon={<LocationOnIcon />}
            title="Departamento"
            value={miembro.departamento}
          />
        </Grid>
        <Grid item xs={12}>
          <InfoCard
            icon={<LocationOnIcon />}
            title="Dirección"
            value={miembro.direccion}
          />
        </Grid>
      </Grid>

      {/* Información Profesional */}
      <Typography variant="h6" gutterBottom sx={{ mt: 3, mb: 2 }}>
        Información Profesional
      </Typography>
      <Grid container spacing={2} sx={{ mb: 3 }}>
        <Grid item xs={12} sm={6} md={4}>
          <InfoCard
            icon={<BusinessIcon />}
            title="Profesión"
            value={miembro.profesion}
          />
        </Grid>
        <Grid item xs={12} sm={6} md={4}>
          <InfoCard
            icon={<BusinessIcon />}
            title="Empresa"
            value={miembro.empresa}
          />
        </Grid>
        <Grid item xs={12} sm={6} md={4}>
          <InfoCard
            icon={<BusinessIcon />}
            title="Cargo Actual"
            value={miembro.cargoActual}
          />
        </Grid>
      </Grid>

      {/* Información de Membresía */}
      <Typography variant="h6" gutterBottom sx={{ mt: 3, mb: 2 }}>
        Información de Membresía
      </Typography>
      <Grid container spacing={2} sx={{ mb: 3 }}>
        <Grid item xs={12} sm={6} md={4}>
          <InfoCard
            icon={<CalendarIcon />}
            title="Fecha de Ingreso"
            value={formatDate(miembro.fechaIngreso)}
          />
        </Grid>
        <Grid item xs={12} sm={6} md={4}>
          <InfoCard
            icon={<CalendarIcon />}
            title="Fecha de Registro"
            value={formatDate(miembro.fechaCreacion)}
          />
        </Grid>
        {miembro.ultimaActualizacion && (
          <Grid item xs={12} sm={6} md={4}>
            <InfoCard
              icon={<CalendarIcon />}
              title="Última Actualización"
              value={formatDate(miembro.ultimaActualizacion)}
            />
          </Grid>
        )}
      </Grid>
    </Box>
  );
}

export default MiembroDetail;

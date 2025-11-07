import { useState, useEffect } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import {
  Box,
  Typography,
  Paper,
  Grid,
  TextField,
  Button,
  FormControl,
  InputLabel,
  Select,
  MenuItem,
  Alert,
  CircularProgress,
  Stack,
  Divider
} from '@mui/material';
import {
  Save as SaveIcon,
  Cancel as CancelIcon,
  ArrowBack as ArrowBackIcon
} from '@mui/icons-material';
import { httpClient } from '../../services/httpClient';

interface MiembroFormData {
  numeroIdentificacion: string;
  tipoIdentificacion: number;
  nombres: string;
  apellidos: string;
  email: string;
  telefono: string;
  celular: string;
  direccion: string;
  ciudad: string;
  departamento: string;
  profesion: string;
  empresa: string;
  cargoActual: string;
  linkedinUrl: string;
  estado: number;
  tipoMembresia: number;
  fechaIngreso: string;
}

interface ValidationErrors {
  [key: string]: string;
}

function MiembroForm() {
  const navigate = useNavigate();
  const { id } = useParams<{ id: string }>();
  const isEditMode = Boolean(id);

  const [loading, setLoading] = useState(false);
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [validationErrors, setValidationErrors] = useState<ValidationErrors>({});

  const [formData, setFormData] = useState<MiembroFormData>({
    numeroIdentificacion: '',
    tipoIdentificacion: 1, // Cédula de Ciudadanía
    nombres: '',
    apellidos: '',
    email: '',
    telefono: '',
    celular: '',
    direccion: '',
    ciudad: '',
    departamento: '',
    profesion: '',
    empresa: '',
    cargoActual: '',
    linkedinUrl: '',
    estado: 1, // Activo
    tipoMembresia: 1, // Regular
    fechaIngreso: new Date().toISOString().split('T')[0]
  });

  useEffect(() => {
    if (isEditMode && id) {
      loadMiembro(id);
    }
  }, [id, isEditMode]);

  const loadMiembro = async (miembroId: string) => {
    try {
      setLoading(true);
      setError(null);
      const response = await httpClient.get(`/Miembros/${miembroId}`);
      const miembro = response.data;
      
      setFormData({
        numeroIdentificacion: miembro.numeroIdentificacion || '',
        tipoIdentificacion: miembro.tipoIdentificacion || 1,
        nombres: miembro.nombres || '',
        apellidos: miembro.apellidos || '',
        email: miembro.email || '',
        telefono: miembro.telefono || '',
        celular: miembro.celular || '',
        direccion: miembro.direccion || '',
        ciudad: miembro.ciudad || '',
        departamento: miembro.departamento || '',
        profesion: miembro.profesion || '',
        empresa: miembro.empresa || '',
        cargoActual: miembro.cargoActual || '',
        linkedinUrl: miembro.linkedinUrl || '',
        estado: miembro.estado || 1,
        tipoMembresia: miembro.tipoMembresia || 1,
        fechaIngreso: miembro.fechaIngreso ? miembro.fechaIngreso.split('T')[0] : new Date().toISOString().split('T')[0]
      });
    } catch (err: any) {
      console.error('Error al cargar miembro:', err);
      setError(err.response?.data?.message || 'Error al cargar los datos del miembro');
    } finally {
      setLoading(false);
    }
  };

  const handleChange = (field: keyof MiembroFormData) => (
    event: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement> | any
  ) => {
    const value = event.target.value;
    setFormData(prev => ({ ...prev, [field]: value }));
    
    // Limpiar error de validación del campo
    if (validationErrors[field]) {
      setValidationErrors(prev => {
        const newErrors = { ...prev };
        delete newErrors[field];
        return newErrors;
      });
    }
  };

  const validateForm = (): boolean => {
    const errors: ValidationErrors = {};

    if (!formData.numeroIdentificacion.trim()) {
      errors.numeroIdentificacion = 'El número de identificación es requerido';
    }
    if (!formData.nombres.trim()) {
      errors.nombres = 'Los nombres son requeridos';
    }
    if (!formData.apellidos.trim()) {
      errors.apellidos = 'Los apellidos son requeridos';
    }
    if (!formData.email.trim()) {
      errors.email = 'El email es requerido';
    } else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(formData.email)) {
      errors.email = 'El email no es válido';
    }
    if (!formData.celular.trim()) {
      errors.celular = 'El celular es requerido';
    }
    if (!formData.ciudad.trim()) {
      errors.ciudad = 'La ciudad es requerida';
    }
    if (!formData.fechaIngreso) {
      errors.fechaIngreso = 'La fecha de ingreso es requerida';
    }

    setValidationErrors(errors);
    return Object.keys(errors).length === 0;
  };

  const handleSubmit = async (event: React.FormEvent) => {
    event.preventDefault();

    if (!validateForm()) {
      setError('Por favor corrija los errores en el formulario');
      return;
    }

    try {
      setSaving(true);
      setError(null);

      if (isEditMode && id) {
        await httpClient.put(`/Miembros/${id}`, formData);
      } else {
        await httpClient.post('/Miembros', formData);
      }

      navigate('/miembros');
    } catch (err: any) {
      console.error('Error al guardar miembro:', err);
      setError(err.response?.data?.message || 'Error al guardar el miembro');
    } finally {
      setSaving(false);
    }
  };

  const handleCancel = () => {
    navigate('/miembros');
  };

  if (loading) {
    return (
      <Box display="flex" justifyContent="center" alignItems="center" minHeight="60vh">
        <CircularProgress size={60} />
      </Box>
    );
  }

  return (
    <Box>
      <Stack direction="row" alignItems="center" spacing={2} sx={{ mb: 3 }}>
        <Button
          startIcon={<ArrowBackIcon />}
          onClick={handleCancel}
          variant="outlined"
        >
          Volver
        </Button>
        <Typography variant="h4">
          {isEditMode ? 'Editar Miembro' : 'Nuevo Miembro'}
        </Typography>
      </Stack>

      {error && (
        <Alert severity="error" sx={{ mb: 3 }} onClose={() => setError(null)}>
          {error}
        </Alert>
      )}

      <Paper elevation={2} sx={{ p: 3 }}>
        <form onSubmit={handleSubmit}>
          {/* Información Personal */}
          <Typography variant="h6" gutterBottom sx={{ mb: 2 }}>
            Información Personal
          </Typography>
          <Divider sx={{ mb: 3 }} />

          <Grid container spacing={3}>
            <Grid item xs={12} sm={6} md={3}>
              <FormControl fullWidth error={Boolean(validationErrors.tipoIdentificacion)}>
                <InputLabel>Tipo de Identificación</InputLabel>
                <Select
                  value={formData.tipoIdentificacion}
                  onChange={handleChange('tipoIdentificacion')}
                  label="Tipo de Identificación"
                >
                  <MenuItem value={1}>Cédula de Ciudadanía</MenuItem>
                  <MenuItem value={2}>Cédula de Extranjería</MenuItem>
                  <MenuItem value={3}>Pasaporte</MenuItem>
                  <MenuItem value={4}>NIT</MenuItem>
                </Select>
              </FormControl>
            </Grid>

            <Grid item xs={12} sm={6} md={3}>
              <TextField
                fullWidth
                required
                label="Número de Identificación"
                value={formData.numeroIdentificacion}
                onChange={handleChange('numeroIdentificacion')}
                error={Boolean(validationErrors.numeroIdentificacion)}
                helperText={validationErrors.numeroIdentificacion}
              />
            </Grid>

            <Grid item xs={12} sm={6}>
              <TextField
                fullWidth
                required
                label="Nombres"
                value={formData.nombres}
                onChange={handleChange('nombres')}
                error={Boolean(validationErrors.nombres)}
                helperText={validationErrors.nombres}
              />
            </Grid>

            <Grid item xs={12} sm={6}>
              <TextField
                fullWidth
                required
                label="Apellidos"
                value={formData.apellidos}
                onChange={handleChange('apellidos')}
                error={Boolean(validationErrors.apellidos)}
                helperText={validationErrors.apellidos}
              />
            </Grid>

            <Grid item xs={12} sm={6}>
              <TextField
                fullWidth
                required
                type="email"
                label="Email"
                value={formData.email}
                onChange={handleChange('email')}
                error={Boolean(validationErrors.email)}
                helperText={validationErrors.email}
              />
            </Grid>

            <Grid item xs={12} sm={6} md={3}>
              <TextField
                fullWidth
                label="Teléfono Fijo"
                value={formData.telefono}
                onChange={handleChange('telefono')}
                error={Boolean(validationErrors.telefono)}
                helperText={validationErrors.telefono}
              />
            </Grid>

            <Grid item xs={12} sm={6} md={3}>
              <TextField
                fullWidth
                required
                label="Celular"
                value={formData.celular}
                onChange={handleChange('celular')}
                error={Boolean(validationErrors.celular)}
                helperText={validationErrors.celular}
              />
            </Grid>
          </Grid>

          {/* Dirección */}
          <Typography variant="h6" gutterBottom sx={{ mt: 4, mb: 2 }}>
            Dirección
          </Typography>
          <Divider sx={{ mb: 3 }} />

          <Grid container spacing={3}>
            <Grid item xs={12}>
              <TextField
                fullWidth
                label="Dirección"
                value={formData.direccion}
                onChange={handleChange('direccion')}
              />
            </Grid>

            <Grid item xs={12} sm={6}>
              <TextField
                fullWidth
                required
                label="Ciudad"
                value={formData.ciudad}
                onChange={handleChange('ciudad')}
                error={Boolean(validationErrors.ciudad)}
                helperText={validationErrors.ciudad}
              />
            </Grid>

            <Grid item xs={12} sm={6}>
              <TextField
                fullWidth
                label="Departamento"
                value={formData.departamento}
                onChange={handleChange('departamento')}
              />
            </Grid>
          </Grid>

          {/* Información Profesional */}
          <Typography variant="h6" gutterBottom sx={{ mt: 4, mb: 2 }}>
            Información Profesional
          </Typography>
          <Divider sx={{ mb: 3 }} />

          <Grid container spacing={3}>
            <Grid item xs={12} sm={6}>
              <TextField
                fullWidth
                label="Profesión"
                value={formData.profesion}
                onChange={handleChange('profesion')}
              />
            </Grid>

            <Grid item xs={12} sm={6}>
              <TextField
                fullWidth
                label="Empresa"
                value={formData.empresa}
                onChange={handleChange('empresa')}
              />
            </Grid>

            <Grid item xs={12} sm={6}>
              <TextField
                fullWidth
                label="Cargo Actual"
                value={formData.cargoActual}
                onChange={handleChange('cargoActual')}
              />
            </Grid>

            <Grid item xs={12} sm={6}>
              <TextField
                fullWidth
                label="LinkedIn URL"
                value={formData.linkedinUrl}
                onChange={handleChange('linkedinUrl')}
                placeholder="https://linkedin.com/in/..."
              />
            </Grid>
          </Grid>

          {/* Información de Membresía */}
          <Typography variant="h6" gutterBottom sx={{ mt: 4, mb: 2 }}>
            Información de Membresía
          </Typography>
          <Divider sx={{ mb: 3 }} />

          <Grid container spacing={3}>
            <Grid item xs={12} sm={6} md={3}>
              <FormControl fullWidth error={Boolean(validationErrors.tipoMembresia)}>
                <InputLabel>Tipo de Membresía</InputLabel>
                <Select
                  value={formData.tipoMembresia}
                  onChange={handleChange('tipoMembresia')}
                  label="Tipo de Membresía"
                >
                  <MenuItem value={1}>Regular</MenuItem>
                  <MenuItem value={2}>Honor</MenuItem>
                  <MenuItem value={3}>Vitalicio</MenuItem>
                  <MenuItem value={4}>Temporal</MenuItem>
                </Select>
              </FormControl>
            </Grid>

            <Grid item xs={12} sm={6} md={3}>
              <FormControl fullWidth error={Boolean(validationErrors.estado)}>
                <InputLabel>Estado</InputLabel>
                <Select
                  value={formData.estado}
                  onChange={handleChange('estado')}
                  label="Estado"
                >
                  <MenuItem value={1}>Activo</MenuItem>
                  <MenuItem value={2}>Inactivo</MenuItem>
                  <MenuItem value={3}>Suspendido</MenuItem>
                </Select>
              </FormControl>
            </Grid>

            <Grid item xs={12} sm={6} md={3}>
              <TextField
                fullWidth
                required
                type="date"
                label="Fecha de Ingreso"
                value={formData.fechaIngreso}
                onChange={handleChange('fechaIngreso')}
                error={Boolean(validationErrors.fechaIngreso)}
                helperText={validationErrors.fechaIngreso}
                InputLabelProps={{ shrink: true }}
              />
            </Grid>
          </Grid>

          {/* Botones de acción */}
          <Box sx={{ mt: 4, display: 'flex', gap: 2, justifyContent: 'flex-end' }}>
            <Button
              variant="outlined"
              startIcon={<CancelIcon />}
              onClick={handleCancel}
              disabled={saving}
            >
              Cancelar
            </Button>
            <Button
              type="submit"
              variant="contained"
              startIcon={saving ? <CircularProgress size={20} /> : <SaveIcon />}
              disabled={saving}
            >
              {saving ? 'Guardando...' : isEditMode ? 'Actualizar' : 'Guardar'}
            </Button>
          </Box>
        </form>
      </Paper>
    </Box>
  );
}

export default MiembroForm;

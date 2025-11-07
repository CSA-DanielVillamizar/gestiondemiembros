import { useState, useEffect } from 'react';
import {
  Box,
  Grid,
  Paper,
  Typography,
  Card,
  CardContent,
  CircularProgress,
  Alert,
  Stack,
  Divider,
  List,
  ListItem,
  ListItemText,
  Chip
} from '@mui/material';
import {
  People as PeopleIcon,
  PersonAdd as PersonAddIcon,
  Group as GroupIcon,
  TrendingUp as TrendingUpIcon,
  LocationCity as LocationCityIcon
} from '@mui/icons-material';
import { httpClient } from '../services/httpClient';

interface EstadisticasGenerales {
  resumen: {
    totalMiembros: number;
    miembrosActivos: number;
    miembrosInactivos: number;
    miembrosSuspendidos: number;
    totalComites: number;
    tasaActividad: number;
  };
  miembrosPorTipo: Array<{ tipo: string; cantidad: number }>;
  miembrosPorCiudad: Array<{ ciudad: string; cantidad: number }>;
  nuevosMiembrosPorMes: Array<{ mes: string; cantidad: number }>;
  comitesMasActivos: Array<{ id: string; nombre: string; cantidadMiembros: number }>;
}

interface StatCardProps {
  title: string;
  value: number | string;
  icon: React.ReactNode;
  color: string;
  subtitle?: string;
}

const StatCard = ({ title, value, icon, color, subtitle }: StatCardProps) => (
  <Card elevation={2}>
    <CardContent>
      <Stack direction="row" justifyContent="space-between" alignItems="flex-start">
        <Box>
          <Typography color="text.secondary" variant="body2" gutterBottom>
            {title}
          </Typography>
          <Typography variant="h3" component="div" sx={{ fontWeight: 'bold', color }}>
            {value}
          </Typography>
          {subtitle && (
            <Typography variant="caption" color="text.secondary" sx={{ mt: 1, display: 'block' }}>
              {subtitle}
            </Typography>
          )}
        </Box>
        <Box
          sx={{
            backgroundColor: `${color}15`,
            borderRadius: 2,
            p: 1.5,
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center'
          }}
        >
          {icon}
        </Box>
      </Stack>
    </CardContent>
  </Card>
);

const tipoMembresiaLabels: Record<string, string> = {
  '1': 'Regular',
  '2': 'Honor',
  '3': 'Vitalicio',
  '4': 'Temporal',
  'Regular': 'Regular',
  'Honor': 'Honor',
  'Vitalicio': 'Vitalicio',
  'Temporal': 'Temporal'
};

function Dashboard() {
  const [estadisticas, setEstadisticas] = useState<EstadisticasGenerales | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    fetchEstadisticas();
  }, []);

  const fetchEstadisticas = async () => {
    try {
      setLoading(true);
      setError(null);
      const response = await httpClient.get<EstadisticasGenerales>('/Estadisticas/generales');
      setEstadisticas(response.data);
    } catch (err: any) {
      console.error('Error al cargar estadísticas:', err);
      setError(err.response?.data?.error || 'Error al cargar las estadísticas del dashboard');
    } finally {
      setLoading(false);
    }
  };

  if (loading) {
    return (
      <Box display="flex" justifyContent="center" alignItems="center" minHeight="60vh">
        <CircularProgress size={60} />
      </Box>
    );
  }

  if (error || !estadisticas) {
    return (
      <Alert severity="error" sx={{ mt: 2 }}>
        {error || 'No se pudieron cargar las estadísticas'}
      </Alert>
    );
  }

  const { resumen, miembrosPorTipo, miembrosPorCiudad, nuevosMiembrosPorMes, comitesMasActivos } = estadisticas;

  return (
    <Box>
      <Typography variant="h4" gutterBottom sx={{ mb: 3 }}>
        Dashboard - L.A.M.A. Medellín
      </Typography>

      {/* Tarjetas de resumen */}
      <Grid container spacing={3} sx={{ mb: 4 }}>
        <Grid item xs={12} sm={6} md={3}>
          <StatCard
            title="Total Miembros"
            value={resumen.totalMiembros}
            icon={<PeopleIcon sx={{ fontSize: 40, color: '#1976d2' }} />}
            color="#1976d2"
          />
        </Grid>
        <Grid item xs={12} sm={6} md={3}>
          <StatCard
            title="Miembros Activos"
            value={resumen.miembrosActivos}
            icon={<TrendingUpIcon sx={{ fontSize: 40, color: '#2e7d32' }} />}
            color="#2e7d32"
            subtitle={`${resumen.tasaActividad}% del total`}
          />
        </Grid>
        <Grid item xs={12} sm={6} md={3}>
          <StatCard
            title="Comités Activos"
            value={resumen.totalComites}
            icon={<GroupIcon sx={{ fontSize: 40, color: '#ed6c02' }} />}
            color="#ed6c02"
          />
        </Grid>
        <Grid item xs={12} sm={6} md={3}>
          <StatCard
            title="Inactivos"
            value={resumen.miembrosInactivos}
            icon={<PersonAddIcon sx={{ fontSize: 40, color: '#9e9e9e' }} />}
            color="#9e9e9e"
            subtitle={`${resumen.miembrosSuspendidos} suspendidos`}
          />
        </Grid>
      </Grid>

      <Grid container spacing={3}>
        {/* Miembros por Tipo de Membresía */}
        <Grid item xs={12} md={6}>
          <Paper elevation={2} sx={{ p: 3, height: '100%' }}>
            <Typography variant="h6" gutterBottom sx={{ display: 'flex', alignItems: 'center', gap: 1 }}>
              <GroupIcon color="primary" />
              Distribución por Tipo de Membresía
            </Typography>
            <Divider sx={{ mb: 2 }} />
            {miembrosPorTipo.length > 0 ? (
              <Box sx={{ mt: 2 }}>
                {miembrosPorTipo.map((item, index) => {
                  const porcentaje = resumen.totalMiembros > 0 
                    ? ((item.cantidad / resumen.totalMiembros) * 100).toFixed(1) 
                    : 0;
                  return (
                    <Box key={index} sx={{ mb: 2 }}>
                      <Stack direction="row" justifyContent="space-between" alignItems="center" sx={{ mb: 0.5 }}>
                        <Typography variant="body2" fontWeight={500}>
                          {tipoMembresiaLabels[item.tipo] || item.tipo}
                        </Typography>
                        <Typography variant="body2" color="text.secondary">
                          {item.cantidad} ({porcentaje}%)
                        </Typography>
                      </Stack>
                      <Box
                        sx={{
                          width: '100%',
                          height: 8,
                          bgcolor: '#e0e0e0',
                          borderRadius: 1,
                          overflow: 'hidden'
                        }}
                      >
                        <Box
                          sx={{
                            width: `${porcentaje}%`,
                            height: '100%',
                            bgcolor: ['#1976d2', '#2e7d32', '#ed6c02', '#9c27b0'][index % 4],
                            transition: 'width 0.3s ease'
                          }}
                        />
                      </Box>
                    </Box>
                  );
                })}
              </Box>
            ) : (
              <Typography variant="body2" color="text.secondary" sx={{ mt: 2 }}>
                No hay datos disponibles
              </Typography>
            )}
          </Paper>
        </Grid>

        {/* Miembros por Ciudad */}
        <Grid item xs={12} md={6}>
          <Paper elevation={2} sx={{ p: 3, height: '100%' }}>
            <Typography variant="h6" gutterBottom sx={{ display: 'flex', alignItems: 'center', gap: 1 }}>
              <LocationCityIcon color="primary" />
              Top 5 Ciudades
            </Typography>
            <Divider sx={{ mb: 2 }} />
            {miembrosPorCiudad.length > 0 ? (
              <List dense>
                {miembrosPorCiudad.map((item, index) => (
                  <ListItem
                    key={index}
                    sx={{
                      bgcolor: index % 2 === 0 ? 'action.hover' : 'transparent',
                      borderRadius: 1,
                      mb: 0.5
                    }}
                  >
                    <ListItemText
                      primary={
                        <Stack direction="row" justifyContent="space-between" alignItems="center">
                          <Typography variant="body1" fontWeight={500}>
                            {index + 1}. {item.ciudad}
                          </Typography>
                          <Chip
                            label={item.cantidad}
                            size="small"
                            color="primary"
                            variant="outlined"
                          />
                        </Stack>
                      }
                    />
                  </ListItem>
                ))}
              </List>
            ) : (
              <Typography variant="body2" color="text.secondary" sx={{ mt: 2 }}>
                No hay datos de ciudades disponibles
              </Typography>
            )}
          </Paper>
        </Grid>

        {/* Nuevos Miembros por Mes */}
        <Grid item xs={12} md={6}>
          <Paper elevation={2} sx={{ p: 3, height: '100%' }}>
            <Typography variant="h6" gutterBottom sx={{ display: 'flex', alignItems: 'center', gap: 1 }}>
              <PersonAddIcon color="primary" />
              Nuevos Miembros (Últimos 6 Meses)
            </Typography>
            <Divider sx={{ mb: 2 }} />
            {nuevosMiembrosPorMes.length > 0 ? (
              <Box sx={{ mt: 2 }}>
                {nuevosMiembrosPorMes.map((item, index) => {
                  const maxCantidad = Math.max(...nuevosMiembrosPorMes.map(m => m.cantidad));
                  const porcentaje = maxCantidad > 0 ? (item.cantidad / maxCantidad) * 100 : 0;
                  
                  return (
                    <Box key={index} sx={{ mb: 2 }}>
                      <Stack direction="row" justifyContent="space-between" alignItems="center" sx={{ mb: 0.5 }}>
                        <Typography variant="body2" fontWeight={500}>
                          {item.mes}
                        </Typography>
                        <Chip
                          label={item.cantidad}
                          size="small"
                          color="success"
                          variant="filled"
                        />
                      </Stack>
                      <Box
                        sx={{
                          width: '100%',
                          height: 8,
                          bgcolor: '#e0e0e0',
                          borderRadius: 1,
                          overflow: 'hidden'
                        }}
                      >
                        <Box
                          sx={{
                            width: `${porcentaje}%`,
                            height: '100%',
                            bgcolor: '#2e7d32',
                            transition: 'width 0.3s ease'
                          }}
                        />
                      </Box>
                    </Box>
                  );
                })}
              </Box>
            ) : (
              <Typography variant="body2" color="text.secondary" sx={{ mt: 2 }}>
                No hay datos de nuevos miembros en los últimos meses
              </Typography>
            )}
          </Paper>
        </Grid>

        {/* Comités Más Activos */}
        <Grid item xs={12} md={6}>
          <Paper elevation={2} sx={{ p: 3, height: '100%' }}>
            <Typography variant="h6" gutterBottom sx={{ display: 'flex', alignItems: 'center', gap: 1 }}>
              <GroupIcon color="primary" />
              Comités Más Activos
            </Typography>
            <Divider sx={{ mb: 2 }} />
            {comitesMasActivos.length > 0 ? (
              <List dense>
                {comitesMasActivos.map((comite, index) => (
                  <ListItem
                    key={comite.id}
                    sx={{
                      bgcolor: index % 2 === 0 ? 'action.hover' : 'transparent',
                      borderRadius: 1,
                      mb: 0.5
                    }}
                  >
                    <ListItemText
                      primary={
                        <Stack direction="row" justifyContent="space-between" alignItems="center">
                          <Typography variant="body1" fontWeight={500}>
                            {index + 1}. {comite.nombre}
                          </Typography>
                          <Chip
                            label={`${comite.cantidadMiembros} miembros`}
                            size="small"
                            color={index === 0 ? 'success' : 'default'}
                            variant="outlined"
                          />
                        </Stack>
                      }
                    />
                  </ListItem>
                ))}
              </List>
            ) : (
              <Typography variant="body2" color="text.secondary" sx={{ mt: 2 }}>
                No hay comités activos
              </Typography>
            )}
          </Paper>
        </Grid>
      </Grid>
    </Box>
  );
}

export default Dashboard;

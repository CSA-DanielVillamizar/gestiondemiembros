import { useState, useEffect } from 'react';
import {
  Box,
  Paper,
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
  TablePagination,
  TextField,
  IconButton,
  Chip,
  Typography,
  InputAdornment,
  Stack,
  FormControl,
  InputLabel,
  Select,
  MenuItem,
  Button,
  Tooltip,
  CircularProgress,
  Alert
} from '@mui/material';
import {
  Search as SearchIcon,
  Edit as EditIcon,
  Delete as DeleteIcon,
  Visibility as VisibilityIcon,
  Add as AddIcon,
  FileDownload as FileDownloadIcon
} from '@mui/icons-material';
import { useNavigate } from 'react-router-dom';
import { httpClient } from '../../services/httpClient';

interface Miembro {
  id: string;
  numeroIdentificacion: string;
  nombres: string;
  apellidos: string;
  nombreCompleto: string;
  email: string;
  telefono?: string;
  ciudad?: string;
  profesion?: string;
  empresa?: string;
  estado: string;
  tipoMembresia: string;
  fechaIngreso: string;
}

interface PagedResult {
  items: Miembro[];
  pageNumber: number;
  pageSize: number;
  totalCount: number;
  totalPages: number;
  hasPreviousPage: boolean;
  hasNextPage: boolean;
}

const estadoColors: Record<string, 'success' | 'default' | 'error'> = {
  'Activo': 'success',
  'Inactivo': 'default',
  'Suspendido': 'error',
  '1': 'success',
  '2': 'default',
  '3': 'error'
};

const tipoMembresiaLabels: Record<string, string> = {
  '1': 'Regular',
  '2': 'Honor',
  '3': 'Vitalicio',
  '4': 'Temporal'
};

function MiembrosList() {
  const navigate = useNavigate();
  const [miembros, setMiembros] = useState<Miembro[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [page, setPage] = useState(0);
  const [rowsPerPage, setRowsPerPage] = useState(10);
  const [totalCount, setTotalCount] = useState(0);
  const [searchTerm, setSearchTerm] = useState('');
  const [estadoFilter, setEstadoFilter] = useState('');
  const [tipoMembresiaFilter, setTipoMembresiaFilter] = useState('');

  useEffect(() => {
    fetchMiembros();
  }, [page, rowsPerPage, searchTerm, estadoFilter, tipoMembresiaFilter]);

  const fetchMiembros = async () => {
    try {
      setLoading(true);
      setError(null);
      
      const params: any = {
        pageNumber: page + 1,
        pageSize: rowsPerPage
      };

      if (searchTerm) {
        params.searchTerm = searchTerm;
      }
      if (estadoFilter) {
        params.estado = estadoFilter;
      }
      if (tipoMembresiaFilter) {
        params.tipoMembresia = tipoMembresiaFilter;
      }

      const response = await httpClient.get<PagedResult>('/Miembros', { params });
      setMiembros(response.data.items);
      setTotalCount(response.data.totalCount);
    } catch (err: any) {
      console.error('Error al cargar miembros:', err);
      setError(err.response?.data?.message || 'Error al cargar la lista de miembros');
    } finally {
      setLoading(false);
    }
  };

  const handleChangePage = (_event: unknown, newPage: number) => {
    setPage(newPage);
  };

  const handleChangeRowsPerPage = (event: React.ChangeEvent<HTMLInputElement>) => {
    setRowsPerPage(parseInt(event.target.value, 10));
    setPage(0);
  };

  const handleSearchChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    setSearchTerm(event.target.value);
    setPage(0);
  };

  const handleView = (id: string) => {
    navigate(`/miembros/${id}`);
  };

  const handleEdit = (id: string) => {
    navigate(`/miembros/editar/${id}`);
  };

  const handleDelete = async (id: string) => {
    if (window.confirm('¿Está seguro de eliminar este miembro?')) {
      try {
        await httpClient.delete(`/Miembros/${id}`);
        fetchMiembros();
      } catch (err: any) {
        alert(err.response?.data?.message || 'Error al eliminar el miembro');
      }
    }
  };

  const getEstadoLabel = (estado: string | number): string => {
    const estadoMap: Record<string, string> = {
      '1': 'Activo',
      '2': 'Inactivo',
      '3': 'Suspendido',
      'Activo': 'Activo',
      'Inactivo': 'Inactivo',
      'Suspendido': 'Suspendido'
    };
    return estadoMap[String(estado)] || String(estado);
  };

  const getTipoMembresiaLabel = (tipo: string | number): string => {
    return tipoMembresiaLabels[String(tipo)] || String(tipo);
  };

  return (
    <Box>
      <Stack direction="row" justifyContent="space-between" alignItems="center" mb={3}>
        <Typography variant="h4" component="h1">
          Gestión de Miembros
        </Typography>
        <Stack direction="row" spacing={2}>
          <Button
            variant="outlined"
            startIcon={<FileDownloadIcon />}
            onClick={() => alert('Función de exportación en desarrollo')}
          >
            Exportar
          </Button>
          <Button
            variant="contained"
            startIcon={<AddIcon />}
            onClick={() => navigate('/miembros/nuevo')}
          >
            Nuevo Miembro
          </Button>
        </Stack>
      </Stack>

      {error && (
        <Alert severity="error" sx={{ mb: 2 }} onClose={() => setError(null)}>
          {error}
        </Alert>
      )}

      <Paper sx={{ p: 2, mb: 2 }}>
        <Stack direction={{ xs: 'column', md: 'row' }} spacing={2}>
          <TextField
            fullWidth
            placeholder="Buscar por nombre, email o documento..."
            value={searchTerm}
            onChange={handleSearchChange}
            InputProps={{
              startAdornment: (
                <InputAdornment position="start">
                  <SearchIcon />
                </InputAdornment>
              ),
            }}
          />
          <FormControl sx={{ minWidth: 150 }}>
            <InputLabel>Estado</InputLabel>
            <Select
              value={estadoFilter}
              label="Estado"
              onChange={(e) => {
                setEstadoFilter(e.target.value);
                setPage(0);
              }}
            >
              <MenuItem value="">Todos</MenuItem>
              <MenuItem value="1">Activo</MenuItem>
              <MenuItem value="2">Inactivo</MenuItem>
              <MenuItem value="3">Suspendido</MenuItem>
            </Select>
          </FormControl>
          <FormControl sx={{ minWidth: 150 }}>
            <InputLabel>Membresía</InputLabel>
            <Select
              value={tipoMembresiaFilter}
              label="Membresía"
              onChange={(e) => {
                setTipoMembresiaFilter(e.target.value);
                setPage(0);
              }}
            >
              <MenuItem value="">Todas</MenuItem>
              <MenuItem value="1">Regular</MenuItem>
              <MenuItem value="2">Honor</MenuItem>
              <MenuItem value="3">Vitalicio</MenuItem>
              <MenuItem value="4">Temporal</MenuItem>
            </Select>
          </FormControl>
        </Stack>
      </Paper>

      <TableContainer component={Paper}>
        {loading ? (
          <Box display="flex" justifyContent="center" alignItems="center" minHeight={400}>
            <CircularProgress />
          </Box>
        ) : miembros.length === 0 ? (
          <Box display="flex" justifyContent="center" alignItems="center" minHeight={400}>
            <Typography variant="body1" color="text.secondary">
              No se encontraron miembros
            </Typography>
          </Box>
        ) : (
          <>
            <Table>
              <TableHead>
                <TableRow>
                  <TableCell>Documento</TableCell>
                  <TableCell>Nombre Completo</TableCell>
                  <TableCell>Email</TableCell>
                  <TableCell>Teléfono</TableCell>
                  <TableCell>Ciudad</TableCell>
                  <TableCell>Profesión</TableCell>
                  <TableCell>Estado</TableCell>
                  <TableCell>Tipo</TableCell>
                  <TableCell align="right">Acciones</TableCell>
                </TableRow>
              </TableHead>
              <TableBody>
                {miembros.map((miembro) => (
                  <TableRow key={miembro.id} hover>
                    <TableCell>{miembro.numeroIdentificacion}</TableCell>
                    <TableCell>
                      <Typography variant="body2" fontWeight={500}>
                        {miembro.nombreCompleto || `${miembro.nombres} ${miembro.apellidos}`}
                      </Typography>
                    </TableCell>
                    <TableCell>{miembro.email}</TableCell>
                    <TableCell>{miembro.telefono || '-'}</TableCell>
                    <TableCell>{miembro.ciudad || '-'}</TableCell>
                    <TableCell>{miembro.profesion || '-'}</TableCell>
                    <TableCell>
                      <Chip
                        label={getEstadoLabel(miembro.estado)}
                        color={estadoColors[String(miembro.estado)]}
                        size="small"
                      />
                    </TableCell>
                    <TableCell>
                      <Chip
                        label={getTipoMembresiaLabel(miembro.tipoMembresia)}
                        variant="outlined"
                        size="small"
                      />
                    </TableCell>
                    <TableCell align="right">
                      <Tooltip title="Ver detalles">
                        <IconButton
                          size="small"
                          onClick={() => handleView(miembro.id)}
                          color="info"
                        >
                          <VisibilityIcon fontSize="small" />
                        </IconButton>
                      </Tooltip>
                      <Tooltip title="Editar">
                        <IconButton
                          size="small"
                          onClick={() => handleEdit(miembro.id)}
                          color="primary"
                        >
                          <EditIcon fontSize="small" />
                        </IconButton>
                      </Tooltip>
                      <Tooltip title="Eliminar">
                        <IconButton
                          size="small"
                          onClick={() => handleDelete(miembro.id)}
                          color="error"
                        >
                          <DeleteIcon fontSize="small" />
                        </IconButton>
                      </Tooltip>
                    </TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
            <TablePagination
              component="div"
              count={totalCount}
              page={page}
              onPageChange={handleChangePage}
              rowsPerPage={rowsPerPage}
              onRowsPerPageChange={handleChangeRowsPerPage}
              rowsPerPageOptions={[5, 10, 25, 50]}
              labelRowsPerPage="Filas por página:"
              labelDisplayedRows={({ from, to, count }) => `${from}-${to} de ${count}`}
            />
          </>
        )}
      </TableContainer>
    </Box>
  );
}

export default MiembrosList;

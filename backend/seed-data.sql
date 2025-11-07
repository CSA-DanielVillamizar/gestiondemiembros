-- Script para insertar datos de prueba en L.A.M.A. Medellín
USE LAMAMedellin;
GO

-- Limpiar datos existentes (solo para desarrollo)
DELETE FROM MiembroComites;
DELETE FROM Miembros;
GO

-- Insertar Miembros de prueba
INSERT INTO Miembros (Id, NumeroIdentificacion, TipoIdentificacion, Nombres, Apellidos, Email, Telefono, Direccion, Ciudad, FechaNacimiento, Profesion, Empresa, Estado, TipoMembresia, FechaIngreso, Activo, FechaCreacion, CreadoPor)
VALUES
-- Juan Carlos Pérez
('AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA', '1234567890', 'CC', 'Juan Carlos', 'Pérez González', 'juan.perez@example.com', '3001234567', 'Calle 10 # 20-30', 'Medellín', '1985-05-15', 'Ingeniero de Sistemas', 'Tech Solutions SAS', 'Activo', 'Regular', '2024-01-15', 1, GETDATE(), 'System'),

-- María Fernanda Rodríguez
('BBBBBBBB-BBBB-BBBB-BBBB-BBBBBBBBBBBB', '9876543210', 'CC', 'María Fernanda', 'Rodríguez López', 'maria.rodriguez@example.com', '3009876543', 'Carrera 45 # 12-34', 'Medellín', '1990-08-22', 'Administradora de Empresas', 'Consultoría Empresarial Ltda', 'Activo', 'Premium', '2023-06-10', 1, GETDATE(), 'System'),

-- Carlos Alberto Martínez
('CCCCCCCC-CCCC-CCCC-CCCC-CCCCCCCCCCCC', '5555555555', 'CC', 'Carlos Alberto', 'Martínez Sánchez', 'carlos.martinez@example.com', '3105554433', 'Avenida 80 # 50-20', 'Medellín', '1982-03-10', 'Arquitecto', 'Diseños Urbanos SA', 'Activo', 'Regular', '2024-03-20', 1, GETDATE(), 'System'),

-- Ana Patricia Gómez
('DDDDDDDD-DDDD-DDDD-DDDD-DDDDDDDDDDDD', '7777777777', 'CC', 'Ana Patricia', 'Gómez Restrepo', 'ana.gomez@example.com', '3207778899', 'Calle 30 # 70-50', 'Envigado', '1988-11-05', 'Contadora Pública', 'Auditoría y Finanzas SAS', 'Activo', 'Premium', '2023-09-01', 1, GETDATE(), 'System'),

-- Luis Eduardo Hernández
('EEEEEEEE-EEEE-EEEE-EEEE-EEEEEEEEEEEE', '1111222233', 'CC', 'Luis Eduardo', 'Hernández Díaz', 'luis.hernandez@example.com', '3151112222', 'Carrera 70 # 40-10', 'Medellín', '1992-07-18', 'Médico Veterinario', 'Clínica Veterinaria El Refugio', 'Activo', 'Regular', '2024-02-14', 1, GETDATE(), 'System'),

-- Sofía Isabel Valencia
('FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF', '8888999900', 'CE', 'Sofía Isabel', 'Valencia Torres', 'sofia.valencia@example.com', '3008889999', 'Calle 50 # 25-15', 'Sabaneta', '1995-04-30', 'Diseñadora Gráfica', 'Creativo Digital Studio', 'Activo', 'Premium', '2024-04-05', 1, GETDATE(), 'System');

GO

-- Asignar miembros a comités
INSERT INTO MiembroComites (MiembroId, ComiteId, Rol, FechaIngreso, Activo)
VALUES
-- Juan Carlos - Comité de Eventos (Coordinador)
('AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA', '11111111-1111-1111-1111-111111111111', 'Coordinador', '2024-01-15', 1),

-- María Fernanda - Comité de Comunicaciones (Coordinadora)
('BBBBBBBB-BBBB-BBBB-BBBB-BBBBBBBBBBBB', '22222222-2222-2222-2222-222222222222', 'Coordinadora', '2023-06-10', 1),

-- Carlos Alberto - Comité de Proyectos Sociales (Miembro)
('CCCCCCCC-CCCC-CCCC-CCCC-CCCCCCCCCCCC', '33333333-3333-3333-3333-333333333333', 'Miembro', '2024-03-20', 1),

-- Ana Patricia - Comité de Eventos y Comunicaciones
('DDDDDDDD-DDDD-DDDD-DDDD-DDDDDDDDDDDD', '11111111-1111-1111-1111-111111111111', 'Miembro', '2023-09-01', 1),
('DDDDDDDD-DDDD-DDDD-DDDD-DDDDDDDDDDDD', '22222222-2222-2222-2222-222222222222', 'Miembro', '2023-09-01', 1),

-- Luis Eduardo - Comité de Proyectos Sociales (Coordinador)
('EEEEEEEE-EEEE-EEEE-EEEE-EEEEEEEEEEEE', '33333333-3333-3333-3333-333333333333', 'Coordinador', '2024-02-14', 1),

-- Sofía Isabel - Comité de Comunicaciones
('FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF', '22222222-2222-2222-2222-222222222222', 'Miembro', '2024-04-05', 1);

GO

-- Verificar datos insertados
SELECT COUNT(*) AS 'Total Miembros' FROM Miembros;
SELECT COUNT(*) AS 'Total Asignaciones' FROM MiembroComites;
GO

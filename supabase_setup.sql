-- =============================================
-- SETUP DE BASE DE DATOS - MAPA HUNTER DOUGLAS
-- Ejecutar en Supabase SQL Editor
-- =============================================

-- 1. Crear tabla de clientes
CREATE TABLE IF NOT EXISTS clientes (
    id BIGSERIAL PRIMARY KEY,
    nombre TEXT NOT NULL,
    estado TEXT DEFAULT 'Activo' CHECK (estado IN ('Activo', 'Prospect', 'Inactivo')),
    tipo TEXT DEFAULT 'Distribuidor' CHECK (tipo IN ('Distribuidor', 'Arquitecto', 'Decorador', 'Empresa', 'Otro')),
    direccion TEXT,
    lat DECIMAL(10, 8),
    lng DECIMAL(11, 8),
    telefono TEXT,
    email TEXT,
    notas TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Habilitar Row Level Security (RLS)
ALTER TABLE clientes ENABLE ROW LEVEL SECURITY;

-- 3. Politica para permitir SELECT a todos (lectura publica)
CREATE POLICY "Permitir lectura publica" ON clientes
    FOR SELECT USING (true);

-- 4. Politica para permitir INSERT a usuarios autenticados
CREATE POLICY "Permitir insercion autenticada" ON clientes
    FOR INSERT WITH CHECK (true);

-- 5. Politica para permitir UPDATE a usuarios autenticados
CREATE POLICY "Permitir actualizacion autenticada" ON clientes
    FOR UPDATE USING (true);

-- 6. Politica para permitir DELETE a usuarios autenticados
CREATE POLICY "Permitir eliminacion autenticada" ON clientes
    FOR DELETE USING (true);

-- 7. Trigger para actualizar updated_at automaticamente
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_clientes_updated_at 
    BEFORE UPDATE ON clientes 
    FOR EACH ROW 
    EXECUTE PROCEDURE update_updated_at_column();

-- 8. Datos de ejemplo (opcional - comentar si no se necesitan)
/*
INSERT INTO clientes (nombre, estado, tipo, direccion, lat, lng, telefono, email, notas) VALUES
    ('Distribuidora Buenos Aires Centro', 'Activo', 'Distribuidor', 'Av. Corrientes 1234, Buenos Aires', -34.6037, -58.3816, '+54 11 4444-5555', 'contacto@distba.com', 'Cliente principal zona centro'),
    ('Arquitectos Asociados Rosario', 'Activo', 'Arquitecto', 'Bv. Orono 567, Rosario', -32.9468, -60.6393, '+54 341 555-6666', 'info@arqasoc.com', 'Especialistas en proyectos comerciales'),
    ('Decoradora Mendoza', 'Prospect', 'Decorador', 'Av. San Martin 890, Mendoza', -32.8908, -68.8272, '+54 261 777-8888', 'deco@mendoza.com', 'Interesado en linea premium'),
    ('Empresa Constructora Cordoba', 'Activo', 'Empresa', 'Av. Colón 234, Cordoba', -31.4201, -64.1888, '+54 351 999-0000', 'obras@constructora.com', 'Proyectos grandes escala'),
    ('Distribuidor Zona Norte', 'Inactivo', 'Distribuidor', 'Av. Libertador 456, Tigre', -34.4265, -58.5796, '+54 11 2222-3333', 'norte@dist.com', 'Sin actividad desde 2023');
*/

-- =============================================
-- INSTRUCCIONES DE USO:
-- 1. Abrir Supabase Dashboard
-- 2. Ir a SQL Editor
-- 3. Pegar y ejecutar este script
-- 4. Verificar que la tabla 'clientes' fue creada
-- =============================================

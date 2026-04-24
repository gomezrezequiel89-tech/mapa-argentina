-- =============================================
-- SETUP BASE DE DATOS - MAPA HUNTER DOUGLAS
-- Ejecutar en Supabase > SQL Editor
-- =============================================

-- 1. Crear tabla de clientes
CREATE TABLE IF NOT EXISTS clientes (
    id          BIGSERIAL PRIMARY KEY,
    nombre      TEXT NOT NULL,
    tipo        TEXT DEFAULT 'Distribuidor'
                CHECK (tipo IN ('Distribuidor', 'Obra', 'Desarrolladora', 'Prospecto')),
    zona        TEXT
                				CHECK (zona IS NULL OR zona IN ('Norte', 'Sur', 'Este', 'Oeste', 'La Plata', 'CABA')),
    direccion   TEXT,
    lat         DECIMAL(10, 8),
    lng         DECIMAL(11, 8),
    telefono    TEXT,
    email       TEXT,
    notas       TEXT,
    created_at  TIMESTAMPTZ DEFAULT NOW(),
    updated_at  TIMESTAMPTZ DEFAULT NOW()
);

-- NOTA: el campo "zona" solo se usa para clientes de Buenos Aires
-- Valores posibles: Norte, Sur, Este, Oeste, La Plata (o NULL si no aplica)

-- 2. Habilitar Row Level Security
ALTER TABLE clientes ENABLE ROW LEVEL SECURITY;

-- 3. Politicas de acceso (permiten lectura y escritura publica)
CREATE POLICY "lectura_publica"    ON clientes FOR SELECT USING (true);
CREATE POLICY "insercion_publica"  ON clientes FOR INSERT WITH CHECK (true);
CREATE POLICY "actualizacion_pub"  ON clientes FOR UPDATE USING (true);
CREATE POLICY "eliminacion_pub"    ON clientes FOR DELETE USING (true);

-- 4. Trigger para updated_at automatico
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN NEW.updated_at = NOW(); RETURN NEW; END;
$$ language 'plpgsql';

DROP TRIGGER IF EXISTS update_clientes_updated_at ON clientes;
CREATE TRIGGER update_clientes_updated_at
    BEFORE UPDATE ON clientes
    FOR EACH ROW EXECUTE PROCEDURE update_updated_at_column();

-- =============================================
-- SI YA TENES LA TABLA CREADA, ejecuta esto
-- para agregar el campo zona sin perder datos:
-- ALTER TABLE clientes ADD COLUMN IF NOT EXISTS zona TEXT
--   CHECK (zona IS NULL OR zona IN ('Norte','Sur','Este','Oeste','La Plata'));
--
-- Y para cambiar el campo tipo a los nuevos valores:
-- UPDATE clientes SET tipo = 'Distribuidor' WHERE tipo = 'Activo';
-- UPDATE clientes SET tipo = 'Prospecto' WHERE tipo = 'Prospect';
-- ALTER TABLE clientes DROP CONSTRAINT IF EXISTS clientes_tipo_check;
-- ALTER TABLE clientes ADD CONSTRAINT clientes_tipo_check
--   CHECK (tipo IN ('Distribuidor','Obra','Desarrolladora','Prospecto'));
-- =============================================

-- 5. Datos de ejemplo (opcional)
/*
INSERT INTO clientes (nombre, tipo, zona, direccion, lat, lng) VALUES
  ('Distribuidor Palermo',    'Distribuidor',  NULL,      'Av. Santa Fe 3500, CABA',            -34.5875, -58.4077),
  ('Distribuidor Zona Norte', 'Distribuidor',  'Norte',   'Av. Maipú 1200, San Isidro',         -34.4721, -58.5183),
  ('Obra Torres Nordelta',    'Obra',          'Norte',   'Av. de los Lagos 7000, Tigre',        -34.4190, -58.6380),
  ('Desarrolladora IRSA',     'Desarrolladora',NULL,      'Av. Leandro N. Alem 855, CABA',       -34.5986, -58.3724),
  ('Prospecto Mar del Plata', 'Prospecto',     NULL,      'Av. Colon 2200, Mar del Plata',       -38.0023, -57.5575),
  ('Distribuidor La Plata',   'Distribuidor',  'La Plata','Calle 7 N 1400, La Plata',            -34.9205, -57.9536);
*/

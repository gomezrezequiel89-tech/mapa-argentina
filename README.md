# Mapa Argentina - Hunter Douglas

Aplicacion web para visualizar y gestionar clientes de Hunter Douglas Argentina en un mapa interactivo.

## Caracteristicas

- Mapa interactivo de Argentina con marcadores de clientes
- Filtros por estado (Activo, Prospect, Inactivo) y tipo (Distribuidor, Arquitecto, etc.)
- Busqueda en tiempo real
- Panel de estadisticas
- Agregar, editar y eliminar clientes
- Datos guardados en Supabase (base de datos en la nube)

## Tecnologias usadas

- HTML/CSS/JavaScript (sin frameworks)
- Leaflet.js - mapas interactivos
- Supabase - base de datos y backend
- OpenStreetMap - tiles del mapa

## Configuracion

### 1. Configurar Supabase

1. Crea una cuenta en [supabase.com](https://supabase.com) (gratis)
2. Crea un nuevo proyecto
3. Ve a **SQL Editor** y ejecuta el contenido de `supabase_setup.sql`
4. Ve a **Settings > API** y copia tu URL y anon key

### 2. Configurar config.js

Edita el archivo `config.js` y reemplaza los valores:

```javascript
const SUPABASE_URL = 'https://TU-PROYECTO.supabase.co';
const SUPABASE_ANON_KEY = 'tu-anon-key-aqui';
```

### 3. Deploy en Vercel

1. Crea cuenta en [vercel.com](https://vercel.com)
2. Importa este repositorio de GitHub
3. Deploy automatico!

## Uso

- **Ver clientes**: Los marcadores aparecen en el mapa segun su estado
  - Verde: Activo
  - Amarillo: Prospect  
  - Rojo: Inactivo
- **Agregar cliente**: Boton "+" en la esquina inferior derecha
- **Hacer clic en el mapa**: Autocompleta las coordenadas al agregar un cliente
- **Editar/Eliminar**: Hacer clic en un marcador del mapa

## Estructura del proyecto

```
mapa-argentina/
|-- index.html         # Aplicacion principal
|-- config.js          # Configuracion de Supabase
|-- supabase_setup.sql # Script SQL para crear la base de datos
|-- README.md          # Este archivo
```

## Licencia

MIT - Uso libre para Hunter Douglas Argentina

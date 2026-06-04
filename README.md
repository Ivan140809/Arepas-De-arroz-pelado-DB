<div align="center">
# Chocolate Doom 
 - Proyecto de Bases de Datos  
 - Equipo *Arepas de Arroz Pelado*

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-17.6-336791?style=for-the-badge&logo=postgresql&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-DDL%20%2F%20DML-orange?style=for-the-badge&logo=database&logoColor=white)
![Status](https://img.shields.io/badge/Estado-Finalizado-brightgreen?style=for-the-badge)
</div>

## **Descripción**
Este repositorio contiene el diseño, implementación y datos de una base de datos relacional para el juego **Chocolate Doom**. El objetivo del proyecto es modelar sesiones de juego, capturar telemetría por tic, y registrar las respuestas de los jugadores a instrumentos de experiencia de usuario, utilizando diversos conceptos adquiridos en el curso, como queries, diseño de DB y conceptos de transferencia y rollback.


## **Tabla de Contenido**
- [Chocolate Doom](#chocolate-doom)
  - [**Descripción**](#descripción)
  - [**Tabla de Contenido**](#tabla-de-contenido)
  - [**Estructura del Repositorio**](#estructura-del-repositorio)
  - [Tablas Principales](#tablas-principales)
    - [Jugadores y Usuarios](#jugadores-y-usuarios)
    - [Estructura del Juego](#estructura-del-juego)
    - [Telemetría](#telemetría)
    - [Instrumentos UX](#instrumentos-ux)
  - [Datos de Telemetria](#datos-de-telemetria)
  - [Configuracion](#configuracion)
    - [Requisitos](#requisitos)
    - [Cargar la base de datos](#cargar-la-base-de-datos)
    - [Participantes](#participantes)


## **Estructura del Repositorio**
```
Arepas-De-arroz-pelado-DB/
│
├── DB/
│   ├── ArepasDDL.sql  # DDL completo del esquema SQL
│   ├── ArepasDeArroz-DDL  # Version alternativa del DDL (Importado)
│   └── Inserts    # Scripts de inserción de datos
├── data/
│   ├── telemetria.tsv    # Datos de telemetría base
│   ├── telemetria_total.tsv   # Datos de telemetría consolidados
│   └── telemetria*.tsv   # Sesiones de juego individuales (22 archivos)
└── deliveries
    ├── Delivery1/     # Primera entrega del proyecto (Diseño de DB)
    ├── Delivery2/     # Segunda entrega del proyecto (Recoleccion de datos y encuestas UX)
    └── Delivery3/     # Entrega final del proyecto (Queries investigativas y pruebas de DB)
```

## Tablas Principales
### Jugadores y Usuarios

| Tabla | Descripcion |
|-------|-------------|
| `doom.usuario` | Participantes del estudio: nombre, edad, genero, nivel de experiencia, consentimiento |
| `doom.jugador` | Perfil de juego con alias unico, vinculado a un usuario |

### Estructura del Juego

| Tabla | Descripcion |
|-------|-------------|
| `doom.episodio` | Episodios de Doom (Knee-Deep in the Dead, etc.) |
| `doom.mapa` | Mapas dentro de cada episodio (E1M1, E1M2, etc.) |
| `doom.sector` | Sectores dentro de cada mapa |
| `doom.juego` | Sesiones de juego: dificultad, modo, semilla, fuego amigo, tiempos |

### Telemetría

| Tabla | Descripcion |
|-------|-------------|
| `doom.evento_telemetria` | Un registro por tic: posicion (x, y, z), angulo, momentum, campo de vision, salud, armadura, municion |
| `public.stg_telemetria` | Tabla de staging para carga inicial de archivos TSV |

### Instrumentos UX

| Tabla | Descripcion |
|-------|-------------|
| `doom.instrumento_ux` | Cuestionarios/encuestas aplicadas (SUS, PENS, etc.) |
| `doom.item_ux` | Preguntas individuales de cada instrumento |
| `doom.respuesta_ux` | Respuestas de cada usuario a cada instrumento, con puntaje total |

---

## Datos de Telemetria

Los archivos `.tsv` en `data/` contienen datos capturados directamente del motor de Chocolate Doom durante sesiones reales de juego. Cada fila corresponde a un **tic**. 

| Campo | Descripcion |
|-------|-------------|
| `timestamp` | Fecha y hora de la captura |
| `tic` | Numero de tic desde el inicio del mapa |
| `x`, `y`, `z` | Posicion del jugador en el mapa |
| `angle` | Angulo de vision (grados) |
| `momx`, `momy` | Momentum en los ejes X e Y |

## Configuracion
### Requisitos

- **PostgreSQL 17.x**
- Cliente SQL (psql, DBeaver, pgAdmin, etc.)

### Cargar la base de datos

```sql
-- 1. Crear la base de datos
CREATE DATABASE chocolate_doom;

-- 2. Conectarse y ejecutar el DDL
\c chocolate_doom
\i DB/ArepasDDL.sql

-- 3. Cargar datos de staging 
\COPY public.stg_telemetria FROM 'data/telemetria_total.tsv' WITH (FORMAT csv, DELIMITER E'\t', HEADER true);
-- 4. Ejecutar los inserts del esquema doom
\i DB/Inserts
```
### Participantes

| # | Nombre |
|:-:|--------|
| 1 | Ivan Santiago Lastra Romero |
| 2 | Lucas Fuentes Sanchez |
| 3 | Martin Sanmiguel Delgado |
| 4 | Ana Maria Murcia Gomez |

<div align="center">
Proyecto academico · Bases de Datos · 2025
</div>
--
-- PostgreSQL database dump
--

\restrict KKNWPAELRavsIGKOKUiAIPQarbkqwN0Lpyg43QCCwAklhZAlUrh78pQnPBOuvp9

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

-- Started on 2025-11-07 22:24:04

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 6 (class 2615 OID 16984)
-- Name: doom; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA doom;


ALTER SCHEMA doom OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 223 (class 1259 OID 17008)
-- Name: episodio; Type: TABLE; Schema: doom; Owner: postgres
--

CREATE TABLE doom.episodio (
    id_episodio integer NOT NULL,
    codigo_episodio character varying(20) NOT NULL,
    nombre_episodio character varying(120) NOT NULL
);


ALTER TABLE doom.episodio OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 17007)
-- Name: episodio_id_episodio_seq; Type: SEQUENCE; Schema: doom; Owner: postgres
--

ALTER TABLE doom.episodio ALTER COLUMN id_episodio ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME doom.episodio_id_episodio_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 231 (class 1259 OID 17060)
-- Name: evento_telemetria; Type: TABLE; Schema: doom; Owner: postgres
--

CREATE TABLE doom.evento_telemetria (
    id_evento integer NOT NULL,
    id_partida integer NOT NULL,
    id_jugador integer NOT NULL,
    tic integer NOT NULL,
    posicion_x double precision,
    posicion_y double precision,
    posicion_z double precision,
    angulo double precision,
    momentum_x double precision,
    momentum_y double precision,
    campo_vision double precision,
    salud integer,
    armadura integer,
    municion integer,
    CONSTRAINT ck_armadura_nonneg CHECK (((armadura IS NULL) OR (armadura >= 0))),
    CONSTRAINT ck_municion_nonneg CHECK (((municion IS NULL) OR (municion >= 0))),
    CONSTRAINT ck_salud_nonneg CHECK (((salud IS NULL) OR (salud >= 0)))
);


ALTER TABLE doom.evento_telemetria OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 17059)
-- Name: evento_telemetria_id_evento_seq; Type: SEQUENCE; Schema: doom; Owner: postgres
--

ALTER TABLE doom.evento_telemetria ALTER COLUMN id_evento ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME doom.evento_telemetria_id_evento_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 233 (class 1259 OID 17079)
-- Name: instrumento_ux; Type: TABLE; Schema: doom; Owner: postgres
--

CREATE TABLE doom.instrumento_ux (
    id_instrumento integer NOT NULL,
    nombre_instrumento character varying(80) NOT NULL
);


ALTER TABLE doom.instrumento_ux OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 17078)
-- Name: instrumento_ux_id_instrumento_seq; Type: SEQUENCE; Schema: doom; Owner: postgres
--

ALTER TABLE doom.instrumento_ux ALTER COLUMN id_instrumento ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME doom.instrumento_ux_id_instrumento_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 235 (class 1259 OID 17087)
-- Name: item_ux; Type: TABLE; Schema: doom; Owner: postgres
--

CREATE TABLE doom.item_ux (
    id_item integer NOT NULL,
    id_instrumento integer NOT NULL,
    texto_pregunta text NOT NULL
);


ALTER TABLE doom.item_ux OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 17086)
-- Name: item_ux_id_item_seq; Type: SEQUENCE; Schema: doom; Owner: postgres
--

ALTER TABLE doom.item_ux ALTER COLUMN id_item ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME doom.item_ux_id_item_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 229 (class 1259 OID 17044)
-- Name: juego; Type: TABLE; Schema: doom; Owner: postgres
--

CREATE TABLE doom.juego (
    id_partida integer NOT NULL,
    fecha_inicio timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    fecha_fin timestamp without time zone,
    dificultad character varying(30),
    modo_juego character varying(30) DEFAULT 'singleplayer'::character varying,
    semilla integer,
    limite_tiempo boolean DEFAULT false,
    configuracion text DEFAULT 'default'::text,
    id_episodio integer NOT NULL,
    fuego_amigo boolean DEFAULT false NOT NULL,
    CONSTRAINT ck_juego_tiempo CHECK (((fecha_fin IS NULL) OR (fecha_fin >= fecha_inicio)))
);


ALTER TABLE doom.juego OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 17043)
-- Name: juego_id_partida_seq; Type: SEQUENCE; Schema: doom; Owner: postgres
--

ALTER TABLE doom.juego ALTER COLUMN id_partida ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME doom.juego_id_partida_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 221 (class 1259 OID 16995)
-- Name: jugador; Type: TABLE; Schema: doom; Owner: postgres
--

CREATE TABLE doom.jugador (
    id_jugador integer NOT NULL,
    alias character varying(60) NOT NULL,
    id_usuario integer
);


ALTER TABLE doom.jugador OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16994)
-- Name: jugador_id_jugador_seq; Type: SEQUENCE; Schema: doom; Owner: postgres
--

ALTER TABLE doom.jugador ALTER COLUMN id_jugador ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME doom.jugador_id_jugador_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 225 (class 1259 OID 17016)
-- Name: mapa; Type: TABLE; Schema: doom; Owner: postgres
--

CREATE TABLE doom.mapa (
    id_mapa integer NOT NULL,
    id_episodio integer NOT NULL,
    codigo_mapa character varying(30) NOT NULL,
    nombre_mapa character varying(120) NOT NULL
);


ALTER TABLE doom.mapa OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 17015)
-- Name: mapa_id_mapa_seq; Type: SEQUENCE; Schema: doom; Owner: postgres
--

ALTER TABLE doom.mapa ALTER COLUMN id_mapa ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME doom.mapa_id_mapa_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 237 (class 1259 OID 17100)
-- Name: respuesta_ux; Type: TABLE; Schema: doom; Owner: postgres
--

CREATE TABLE doom.respuesta_ux (
    id_respuesta integer NOT NULL,
    id_usuario integer NOT NULL,
    id_instrumento integer NOT NULL,
    fecha_respuesta timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    puntaje_total numeric(6,2),
    id_pregunta integer
);


ALTER TABLE doom.respuesta_ux OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 17099)
-- Name: respuesta_ux_id_respuesta_seq; Type: SEQUENCE; Schema: doom; Owner: postgres
--

ALTER TABLE doom.respuesta_ux ALTER COLUMN id_respuesta ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME doom.respuesta_ux_id_respuesta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 227 (class 1259 OID 17029)
-- Name: sector; Type: TABLE; Schema: doom; Owner: postgres
--

CREATE TABLE doom.sector (
    id_sector integer NOT NULL,
    id_mapa integer NOT NULL,
    codigo_sector character varying(40) NOT NULL,
    descripcion text
);


ALTER TABLE doom.sector OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 17028)
-- Name: sector_id_sector_seq; Type: SEQUENCE; Schema: doom; Owner: postgres
--

ALTER TABLE doom.sector ALTER COLUMN id_sector ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME doom.sector_id_sector_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 219 (class 1259 OID 16986)
-- Name: usuario; Type: TABLE; Schema: doom; Owner: postgres
--

CREATE TABLE doom.usuario (
    id_usuario integer NOT NULL,
    nombre character varying(50) NOT NULL,
    nivel_experiencia character varying(50),
    consentimiento boolean DEFAULT true NOT NULL,
    fecha_registro timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    edad integer,
    genero character varying(20),
    CONSTRAINT ck_usuario_edad_nonneg CHECK (((edad IS NULL) OR (edad >= 0)))
);


ALTER TABLE doom.usuario OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16985)
-- Name: usuario_id_usuario_seq; Type: SEQUENCE; Schema: doom; Owner: postgres
--

ALTER TABLE doom.usuario ALTER COLUMN id_usuario ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME doom.usuario_id_usuario_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 238 (class 1259 OID 17153)
-- Name: stg_telemetria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stg_telemetria (
    ts_text text,
    tic integer,
    x double precision,
    y double precision,
    z double precision,
    angle double precision,
    momx double precision,
    momy double precision,
    fov_stg double precision
);


ALTER TABLE public.stg_telemetria OWNER TO postgres;

--
-- TOC entry 4812 (class 2606 OID 17014)
-- Name: episodio episodio_codigo_episodio_key; Type: CONSTRAINT; Schema: doom; Owner: postgres
--

ALTER TABLE ONLY doom.episodio
    ADD CONSTRAINT episodio_codigo_episodio_key UNIQUE (codigo_episodio);


--
-- TOC entry 4814 (class 2606 OID 17012)
-- Name: episodio episodio_pkey; Type: CONSTRAINT; Schema: doom; Owner: postgres
--

ALTER TABLE ONLY doom.episodio
    ADD CONSTRAINT episodio_pkey PRIMARY KEY (id_episodio);


--
-- TOC entry 4826 (class 2606 OID 17067)
-- Name: evento_telemetria evento_telemetria_pkey; Type: CONSTRAINT; Schema: doom; Owner: postgres
--

ALTER TABLE ONLY doom.evento_telemetria
    ADD CONSTRAINT evento_telemetria_pkey PRIMARY KEY (id_evento);


--
-- TOC entry 4828 (class 2606 OID 17085)
-- Name: instrumento_ux instrumento_ux_nombre_instrumento_key; Type: CONSTRAINT; Schema: doom; Owner: postgres
--

ALTER TABLE ONLY doom.instrumento_ux
    ADD CONSTRAINT instrumento_ux_nombre_instrumento_key UNIQUE (nombre_instrumento);


--
-- TOC entry 4830 (class 2606 OID 17083)
-- Name: instrumento_ux instrumento_ux_pkey; Type: CONSTRAINT; Schema: doom; Owner: postgres
--

ALTER TABLE ONLY doom.instrumento_ux
    ADD CONSTRAINT instrumento_ux_pkey PRIMARY KEY (id_instrumento);


--
-- TOC entry 4832 (class 2606 OID 17093)
-- Name: item_ux item_ux_pkey; Type: CONSTRAINT; Schema: doom; Owner: postgres
--

ALTER TABLE ONLY doom.item_ux
    ADD CONSTRAINT item_ux_pkey PRIMARY KEY (id_item);


--
-- TOC entry 4824 (class 2606 OID 17053)
-- Name: juego juego_pkey; Type: CONSTRAINT; Schema: doom; Owner: postgres
--

ALTER TABLE ONLY doom.juego
    ADD CONSTRAINT juego_pkey PRIMARY KEY (id_partida);


--
-- TOC entry 4808 (class 2606 OID 17001)
-- Name: jugador jugador_alias_key; Type: CONSTRAINT; Schema: doom; Owner: postgres
--

ALTER TABLE ONLY doom.jugador
    ADD CONSTRAINT jugador_alias_key UNIQUE (alias);


--
-- TOC entry 4810 (class 2606 OID 16999)
-- Name: jugador jugador_pkey; Type: CONSTRAINT; Schema: doom; Owner: postgres
--

ALTER TABLE ONLY doom.jugador
    ADD CONSTRAINT jugador_pkey PRIMARY KEY (id_jugador);


--
-- TOC entry 4816 (class 2606 OID 17020)
-- Name: mapa mapa_pkey; Type: CONSTRAINT; Schema: doom; Owner: postgres
--

ALTER TABLE ONLY doom.mapa
    ADD CONSTRAINT mapa_pkey PRIMARY KEY (id_mapa);


--
-- TOC entry 4834 (class 2606 OID 17105)
-- Name: respuesta_ux respuesta_ux_pkey; Type: CONSTRAINT; Schema: doom; Owner: postgres
--

ALTER TABLE ONLY doom.respuesta_ux
    ADD CONSTRAINT respuesta_ux_pkey PRIMARY KEY (id_respuesta);


--
-- TOC entry 4820 (class 2606 OID 17035)
-- Name: sector sector_pkey; Type: CONSTRAINT; Schema: doom; Owner: postgres
--

ALTER TABLE ONLY doom.sector
    ADD CONSTRAINT sector_pkey PRIMARY KEY (id_sector);


--
-- TOC entry 4818 (class 2606 OID 17022)
-- Name: mapa uq_mapa_por_episodio; Type: CONSTRAINT; Schema: doom; Owner: postgres
--

ALTER TABLE ONLY doom.mapa
    ADD CONSTRAINT uq_mapa_por_episodio UNIQUE (id_episodio, codigo_mapa);


--
-- TOC entry 4836 (class 2606 OID 17107)
-- Name: respuesta_ux uq_respuesta_unica; Type: CONSTRAINT; Schema: doom; Owner: postgres
--

ALTER TABLE ONLY doom.respuesta_ux
    ADD CONSTRAINT uq_respuesta_unica UNIQUE (id_usuario, id_instrumento, fecha_respuesta);


--
-- TOC entry 4822 (class 2606 OID 17037)
-- Name: sector uq_sector_por_mapa; Type: CONSTRAINT; Schema: doom; Owner: postgres
--

ALTER TABLE ONLY doom.sector
    ADD CONSTRAINT uq_sector_por_mapa UNIQUE (id_mapa, codigo_sector);


--
-- TOC entry 4806 (class 2606 OID 16993)
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: doom; Owner: postgres
--

ALTER TABLE ONLY doom.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id_usuario);


--
-- TOC entry 4841 (class 2606 OID 17073)
-- Name: evento_telemetria evento_telemetria_id_jugador_fkey; Type: FK CONSTRAINT; Schema: doom; Owner: postgres
--

ALTER TABLE ONLY doom.evento_telemetria
    ADD CONSTRAINT evento_telemetria_id_jugador_fkey FOREIGN KEY (id_jugador) REFERENCES doom.jugador(id_jugador) ON DELETE CASCADE;


--
-- TOC entry 4842 (class 2606 OID 17068)
-- Name: evento_telemetria evento_telemetria_id_partida_fkey; Type: FK CONSTRAINT; Schema: doom; Owner: postgres
--

ALTER TABLE ONLY doom.evento_telemetria
    ADD CONSTRAINT evento_telemetria_id_partida_fkey FOREIGN KEY (id_partida) REFERENCES doom.juego(id_partida) ON DELETE CASCADE;


--
-- TOC entry 4843 (class 2606 OID 17094)
-- Name: item_ux item_ux_id_instrumento_fkey; Type: FK CONSTRAINT; Schema: doom; Owner: postgres
--

ALTER TABLE ONLY doom.item_ux
    ADD CONSTRAINT item_ux_id_instrumento_fkey FOREIGN KEY (id_instrumento) REFERENCES doom.instrumento_ux(id_instrumento) ON DELETE CASCADE;


--
-- TOC entry 4840 (class 2606 OID 17141)
-- Name: juego juego_id_episodio_fkey; Type: FK CONSTRAINT; Schema: doom; Owner: postgres
--

ALTER TABLE ONLY doom.juego
    ADD CONSTRAINT juego_id_episodio_fkey FOREIGN KEY (id_episodio) REFERENCES doom.episodio(id_episodio) ON DELETE RESTRICT;


--
-- TOC entry 4837 (class 2606 OID 17002)
-- Name: jugador jugador_id_usuario_fkey; Type: FK CONSTRAINT; Schema: doom; Owner: postgres
--

ALTER TABLE ONLY doom.jugador
    ADD CONSTRAINT jugador_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES doom.usuario(id_usuario) ON DELETE SET NULL;


--
-- TOC entry 4838 (class 2606 OID 17023)
-- Name: mapa mapa_id_episodio_fkey; Type: FK CONSTRAINT; Schema: doom; Owner: postgres
--

ALTER TABLE ONLY doom.mapa
    ADD CONSTRAINT mapa_id_episodio_fkey FOREIGN KEY (id_episodio) REFERENCES doom.episodio(id_episodio) ON DELETE RESTRICT;


--
-- TOC entry 4844 (class 2606 OID 17113)
-- Name: respuesta_ux respuesta_ux_id_instrumento_fkey; Type: FK CONSTRAINT; Schema: doom; Owner: postgres
--

ALTER TABLE ONLY doom.respuesta_ux
    ADD CONSTRAINT respuesta_ux_id_instrumento_fkey FOREIGN KEY (id_instrumento) REFERENCES doom.instrumento_ux(id_instrumento) ON DELETE RESTRICT;


--
-- TOC entry 4845 (class 2606 OID 17148)
-- Name: respuesta_ux respuesta_ux_id_pregunta_fkey; Type: FK CONSTRAINT; Schema: doom; Owner: postgres
--

ALTER TABLE ONLY doom.respuesta_ux
    ADD CONSTRAINT respuesta_ux_id_pregunta_fkey FOREIGN KEY (id_pregunta) REFERENCES doom.item_ux(id_item) ON DELETE SET NULL;


--
-- TOC entry 4846 (class 2606 OID 17108)
-- Name: respuesta_ux respuesta_ux_id_usuario_fkey; Type: FK CONSTRAINT; Schema: doom; Owner: postgres
--

ALTER TABLE ONLY doom.respuesta_ux
    ADD CONSTRAINT respuesta_ux_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES doom.usuario(id_usuario) ON DELETE CASCADE;


--
-- TOC entry 4839 (class 2606 OID 17038)
-- Name: sector sector_id_mapa_fkey; Type: FK CONSTRAINT; Schema: doom; Owner: postgres
--

ALTER TABLE ONLY doom.sector
    ADD CONSTRAINT sector_id_mapa_fkey FOREIGN KEY (id_mapa) REFERENCES doom.mapa(id_mapa) ON DELETE CASCADE;


-- Completed on 2025-11-07 22:24:05

--
-- PostgreSQL database dump complete
--

\unrestrict KKNWPAELRavsIGKOKUiAIPQarbkqwN0Lpyg43QCCwAklhZAlUrh78pQnPBOuvp9


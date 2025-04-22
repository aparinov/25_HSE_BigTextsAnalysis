--
-- PostgreSQL database dump
--

-- Dumped from database version 16.6 (Debian 16.6-1.pgdg120+1)
-- Dumped by pg_dump version 17.4

-- Started on 2025-04-22 17:44:35

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
-- TOC entry 3616 (class 1262 OID 16384)
-- Name: amina; Type: DATABASE; Schema: -; Owner: amina
--

CREATE DATABASE amina WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE amina OWNER TO amina;

\connect amina

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
-- TOC entry 7 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 3617 (class 0 OID 0)
-- Dependencies: 7
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 279 (class 1259 OID 17370)
-- Name: news_results; Type: TABLE; Schema: public; Owner: amina
--

CREATE TABLE public.news_results (
    id integer NOT NULL,
    public_date timestamp without time zone,
    txt text,
    link text,
    picture boolean,
    video boolean,
    word_count integer,
    category character varying
);


ALTER TABLE public.news_results OWNER TO amina;

--
-- TOC entry 278 (class 1259 OID 17369)
-- Name: news_results_id_seq; Type: SEQUENCE; Schema: public; Owner: amina
--

CREATE SEQUENCE public.news_results_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.news_results_id_seq OWNER TO amina;

--
-- TOC entry 3618 (class 0 OID 0)
-- Dependencies: 278
-- Name: news_results_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: amina
--

ALTER SEQUENCE public.news_results_id_seq OWNED BY public.news_results.id;


--
-- TOC entry 277 (class 1259 OID 17360)
-- Name: news_without_category; Type: TABLE; Schema: public; Owner: amina
--

CREATE TABLE public.news_without_category (
    id integer NOT NULL,
    public_date timestamp without time zone,
    txt text,
    link text,
    picture boolean,
    video boolean,
    word_count integer
);


ALTER TABLE public.news_without_category OWNER TO amina;

--
-- TOC entry 276 (class 1259 OID 17359)
-- Name: news_without_category_id_seq; Type: SEQUENCE; Schema: public; Owner: amina
--

CREATE SEQUENCE public.news_without_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.news_without_category_id_seq OWNER TO amina;

--
-- TOC entry 3619 (class 0 OID 0)
-- Dependencies: 276
-- Name: news_without_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: amina
--

ALTER SEQUENCE public.news_without_category_id_seq OWNED BY public.news_without_category.id;


--
-- TOC entry 281 (class 1259 OID 17380)
-- Name: stg_news; Type: TABLE; Schema: public; Owner: amina
--

CREATE TABLE public.stg_news (
    id integer NOT NULL,
    project character varying,
    project_nick character varying,
    type character varying,
    category character varying,
    title character varying,
    publish_date timestamp without time zone,
    fronturl text,
    picture text,
    overview character varying,
    text text
);


ALTER TABLE public.stg_news OWNER TO amina;

--
-- TOC entry 280 (class 1259 OID 17379)
-- Name: stg_news_id_seq; Type: SEQUENCE; Schema: public; Owner: amina
--

CREATE SEQUENCE public.stg_news_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.stg_news_id_seq OWNER TO amina;

--
-- TOC entry 3620 (class 0 OID 0)
-- Dependencies: 280
-- Name: stg_news_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: amina
--

ALTER SEQUENCE public.stg_news_id_seq OWNED BY public.stg_news.id;


--
-- TOC entry 3435 (class 2604 OID 17373)
-- Name: news_results id; Type: DEFAULT; Schema: public; Owner: amina
--

ALTER TABLE ONLY public.news_results ALTER COLUMN id SET DEFAULT nextval('public.news_results_id_seq'::regclass);


--
-- TOC entry 3434 (class 2604 OID 17363)
-- Name: news_without_category id; Type: DEFAULT; Schema: public; Owner: amina
--

ALTER TABLE ONLY public.news_without_category ALTER COLUMN id SET DEFAULT nextval('public.news_without_category_id_seq'::regclass);


--
-- TOC entry 3436 (class 2604 OID 17383)
-- Name: stg_news id; Type: DEFAULT; Schema: public; Owner: amina
--

ALTER TABLE ONLY public.stg_news ALTER COLUMN id SET DEFAULT nextval('public.stg_news_id_seq'::regclass);


--
-- TOC entry 3608 (class 0 OID 17370)
-- Dependencies: 279
-- Data for Name: news_results; Type: TABLE DATA; Schema: public; Owner: amina
--

COPY public.news_results (id, public_date, txt, link, picture, video, word_count, category) FROM stdin;
\.


--
-- TOC entry 3606 (class 0 OID 17360)
-- Dependencies: 277
-- Data for Name: news_without_category; Type: TABLE DATA; Schema: public; Owner: amina
--

COPY public.news_without_category (id, public_date, txt, link, picture, video, word_count) FROM stdin;
\.


--
-- TOC entry 3610 (class 0 OID 17380)
-- Dependencies: 281
-- Data for Name: stg_news; Type: TABLE DATA; Schema: public; Owner: amina
--

COPY public.stg_news (id, project, project_nick, type, category, title, publish_date, fronturl, picture, overview, text) FROM stdin;
\.


--
-- TOC entry 3621 (class 0 OID 0)
-- Dependencies: 278
-- Name: news_results_id_seq; Type: SEQUENCE SET; Schema: public; Owner: amina
--

SELECT pg_catalog.setval('public.news_results_id_seq', 1, false);


--
-- TOC entry 3622 (class 0 OID 0)
-- Dependencies: 276
-- Name: news_without_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: amina
--

SELECT pg_catalog.setval('public.news_without_category_id_seq', 1, false);


--
-- TOC entry 3623 (class 0 OID 0)
-- Dependencies: 280
-- Name: stg_news_id_seq; Type: SEQUENCE SET; Schema: public; Owner: amina
--

SELECT pg_catalog.setval('public.stg_news_id_seq', 1, false);


--
-- TOC entry 3440 (class 2606 OID 17377)
-- Name: news_results news_results_pkey; Type: CONSTRAINT; Schema: public; Owner: amina
--

ALTER TABLE ONLY public.news_results
    ADD CONSTRAINT news_results_pkey PRIMARY KEY (id);


--
-- TOC entry 3438 (class 2606 OID 17367)
-- Name: news_without_category news_without_category_pkey; Type: CONSTRAINT; Schema: public; Owner: amina
--

ALTER TABLE ONLY public.news_without_category
    ADD CONSTRAINT news_without_category_pkey PRIMARY KEY (id);


--
-- TOC entry 3442 (class 2606 OID 17387)
-- Name: stg_news stg_news_pkey; Type: CONSTRAINT; Schema: public; Owner: amina
--

ALTER TABLE ONLY public.stg_news
    ADD CONSTRAINT stg_news_pkey PRIMARY KEY (id);


-- Citus configuration
SELECT create_distributed_table('stg_news', 'id');
SELECT create_distributed_table('news_results', 'id');
SELECT create_distributed_table('news_without_category', 'id');

-- Completed on 2025-04-22 17:44:43

--
-- PostgreSQL database dump complete
--


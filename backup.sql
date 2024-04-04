--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    order_number integer NOT NULL,
    product_id integer NOT NULL,
    quantity integer
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_id_seq OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: product_shelves; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_shelves (
    id integer NOT NULL,
    product_id integer NOT NULL,
    shelf_id integer NOT NULL,
    primary_shelf boolean
);


ALTER TABLE public.product_shelves OWNER TO postgres;

--
-- Name: product_shelves_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.product_shelves_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.product_shelves_id_seq OWNER TO postgres;

--
-- Name: product_shelves_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_shelves_id_seq OWNED BY public.product_shelves.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id integer NOT NULL,
    name character varying NOT NULL,
    description text
);


ALTER TABLE public.products OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_id_seq OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: shelves; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shelves (
    id integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.shelves OWNER TO postgres;

--
-- Name: shelves_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.shelves_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.shelves_id_seq OWNER TO postgres;

--
-- Name: shelves_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.shelves_id_seq OWNED BY public.shelves.id;


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: product_shelves id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_shelves ALTER COLUMN id SET DEFAULT nextval('public.product_shelves_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: shelves id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shelves ALTER COLUMN id SET DEFAULT nextval('public.shelves_id_seq'::regclass);


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (id, order_number, product_id, quantity) FROM stdin;
1	10	1	2
2	11	2	3
3	10	3	1
4	14	1	3
5	15	5	1
6	10	6	1
7	14	4	4
\.


--
-- Data for Name: product_shelves; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_shelves (id, product_id, shelf_id, primary_shelf) FROM stdin;
1	1	1	t
2	2	1	t
3	3	2	t
4	3	3	f
5	3	4	f
6	4	5	t
7	5	5	t
8	5	1	f
9	6	5	t
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id, name, description) FROM stdin;
1	Ноутбук	Мощный ноутбук "для учебы, мам"
2	Телевизор	4KKKKK Smart TV
3	Телефон	Смартфон с камерой высокого разрешения
4	Системный блок	Гей_мерский ПК
5	Часы	Умные часы с GPS и пульсометром
6	Микрофон	Конденсаторный микрофон для студийной записи(твоих оров)
\.


--
-- Data for Name: shelves; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shelves (id, name) FROM stdin;
1	A
2	Б
3	В
4	З
5	Ж
\.


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_id_seq', 7, true);


--
-- Name: product_shelves_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_shelves_id_seq', 9, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_id_seq', 6, true);


--
-- Name: shelves_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shelves_id_seq', 8, true);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: product_shelves product_shelves_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_shelves
    ADD CONSTRAINT product_shelves_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: shelves shelves_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shelves
    ADD CONSTRAINT shelves_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--


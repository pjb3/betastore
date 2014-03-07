--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: customers; Type: TABLE; Schema: public; Owner: paul; Tablespace: 
--

CREATE TABLE customers (
    id integer NOT NULL,
    name character varying(255),
    email character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.customers OWNER TO paul;

--
-- Name: customers_id_seq; Type: SEQUENCE; Schema: public; Owner: paul
--

CREATE SEQUENCE customers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customers_id_seq OWNER TO paul;

--
-- Name: customers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paul
--

ALTER SEQUENCE customers_id_seq OWNED BY customers.id;


--
-- Name: line_items; Type: TABLE; Schema: public; Owner: paul; Tablespace: 
--

CREATE TABLE line_items (
    id integer NOT NULL,
    order_id integer,
    product_id integer,
    quantity integer,
    price numeric,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.line_items OWNER TO paul;

--
-- Name: line_items_id_seq; Type: SEQUENCE; Schema: public; Owner: paul
--

CREATE SEQUENCE line_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.line_items_id_seq OWNER TO paul;

--
-- Name: line_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paul
--

ALTER SEQUENCE line_items_id_seq OWNED BY line_items.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: paul; Tablespace: 
--

CREATE TABLE orders (
    id integer NOT NULL,
    customer_id integer,
    placed_at timestamp without time zone,
    total_amount numeric,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.orders OWNER TO paul;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: paul
--

CREATE SEQUENCE orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_id_seq OWNER TO paul;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paul
--

ALTER SEQUENCE orders_id_seq OWNED BY orders.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: paul; Tablespace: 
--

CREATE TABLE products (
    id integer NOT NULL,
    name character varying(255),
    price numeric,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.products OWNER TO paul;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: paul
--

CREATE SEQUENCE products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_id_seq OWNER TO paul;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paul
--

ALTER SEQUENCE products_id_seq OWNED BY products.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: paul; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO paul;

--
-- Name: subscriptions; Type: TABLE; Schema: public; Owner: paul; Tablespace: 
--

CREATE TABLE subscriptions (
    id integer NOT NULL,
    email character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.subscriptions OWNER TO paul;

--
-- Name: subscriptions_id_seq; Type: SEQUENCE; Schema: public; Owner: paul
--

CREATE SEQUENCE subscriptions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subscriptions_id_seq OWNER TO paul;

--
-- Name: subscriptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paul
--

ALTER SEQUENCE subscriptions_id_seq OWNED BY subscriptions.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: paul
--

ALTER TABLE ONLY customers ALTER COLUMN id SET DEFAULT nextval('customers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: paul
--

ALTER TABLE ONLY line_items ALTER COLUMN id SET DEFAULT nextval('line_items_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: paul
--

ALTER TABLE ONLY orders ALTER COLUMN id SET DEFAULT nextval('orders_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: paul
--

ALTER TABLE ONLY products ALTER COLUMN id SET DEFAULT nextval('products_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: paul
--

ALTER TABLE ONLY subscriptions ALTER COLUMN id SET DEFAULT nextval('subscriptions_id_seq'::regclass);


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: paul
--

COPY customers (id, name, email, created_at, updated_at) FROM stdin;
1	Paul Barry	mail@paulbarry.com	2014-03-06 09:47:20.29229	2014-03-06 09:47:20.29229
2	John Doe	test@example.com	2014-03-06 09:47:20.30248	2014-03-06 09:47:20.30248
3	Nowhere Man	man@nowhere.com	2014-03-06 09:47:20.30497	2014-03-06 09:47:20.30497
\.


--
-- Name: customers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paul
--

SELECT pg_catalog.setval('customers_id_seq', 4, true);


--
-- Data for Name: line_items; Type: TABLE DATA; Schema: public; Owner: paul
--

COPY line_items (id, order_id, product_id, quantity, price, created_at, updated_at) FROM stdin;
1	1	1	1	\N	2014-03-06 09:47:20.368647	2014-03-06 09:47:20.368647
2	1	2	1	\N	2014-03-06 09:47:20.372919	2014-03-06 09:47:20.372919
3	2	2	1	\N	2014-03-06 09:47:20.378488	2014-03-06 09:47:20.378488
4	3	1	1	\N	2014-03-06 09:47:20.383939	2014-03-06 09:47:20.383939
5	3	3	1	\N	2014-03-06 09:47:20.386504	2014-03-06 09:47:20.386504
\.


--
-- Name: line_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paul
--

SELECT pg_catalog.setval('line_items_id_seq', 5, true);


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: paul
--

COPY orders (id, customer_id, placed_at, total_amount, created_at, updated_at) FROM stdin;
1	1	2013-09-27 00:00:00	\N	2014-03-06 09:47:20.351343	2014-03-06 09:47:20.351343
2	1	2014-03-06 09:47:20.374823	\N	2014-03-06 09:47:20.375697	2014-03-06 09:47:20.375697
3	2	2014-03-06 09:47:20.380245	\N	2014-03-06 09:47:20.381082	2014-03-06 09:47:20.381082
\.


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paul
--

SELECT pg_catalog.setval('orders_id_seq', 3, true);


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: paul
--

COPY products (id, name, price, created_at, updated_at) FROM stdin;
1	Muffin	2.99	2014-03-06 09:47:20.317279	2014-03-06 09:47:20.317279
2	Smoothie	3.75	2014-03-06 09:47:20.32101	2014-03-06 09:47:20.32101
3	Coffee	3.99	2014-03-06 09:47:20.323369	2014-03-06 09:47:20.323369
\.


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paul
--

SELECT pg_catalog.setval('products_id_seq', 3, true);


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: paul
--

COPY schema_migrations (version) FROM stdin;
20140305010415
20140306094331
20140306094336
20140306094342
20140306094346
\.


--
-- Data for Name: subscriptions; Type: TABLE DATA; Schema: public; Owner: paul
--

COPY subscriptions (id, email, created_at, updated_at) FROM stdin;
\.


--
-- Name: subscriptions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paul
--

SELECT pg_catalog.setval('subscriptions_id_seq', 1, false);


--
-- Name: customers_pkey; Type: CONSTRAINT; Schema: public; Owner: paul; Tablespace: 
--

ALTER TABLE ONLY customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- Name: line_items_pkey; Type: CONSTRAINT; Schema: public; Owner: paul; Tablespace: 
--

ALTER TABLE ONLY line_items
    ADD CONSTRAINT line_items_pkey PRIMARY KEY (id);


--
-- Name: orders_pkey; Type: CONSTRAINT; Schema: public; Owner: paul; Tablespace: 
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: products_pkey; Type: CONSTRAINT; Schema: public; Owner: paul; Tablespace: 
--

ALTER TABLE ONLY products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: subscriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: paul; Tablespace: 
--

ALTER TABLE ONLY subscriptions
    ADD CONSTRAINT subscriptions_pkey PRIMARY KEY (id);


--
-- Name: index_line_items_on_order_id; Type: INDEX; Schema: public; Owner: paul; Tablespace: 
--

CREATE INDEX index_line_items_on_order_id ON line_items USING btree (order_id);


--
-- Name: index_line_items_on_product_id; Type: INDEX; Schema: public; Owner: paul; Tablespace: 
--

CREATE INDEX index_line_items_on_product_id ON line_items USING btree (product_id);


--
-- Name: index_orders_on_customer_id; Type: INDEX; Schema: public; Owner: paul; Tablespace: 
--

CREATE INDEX index_orders_on_customer_id ON orders USING btree (customer_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: paul; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: public; Type: ACL; Schema: -; Owner: paul
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM paul;
GRANT ALL ON SCHEMA public TO paul;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--


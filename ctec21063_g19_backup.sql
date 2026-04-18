--
-- PostgreSQL database dump
--

\restrict ksMiUbpobQM2n89ixJG2hUdbxhWfZd4hRxAbpducYhT2oSiExr0CTkftiR6QAeT

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: document; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.document (
    agreement_id integer NOT NULL,
    doc_id integer NOT NULL,
    doc_type character varying(100),
    file_path text
);


ALTER TABLE public.document OWNER TO postgres;

--
-- Name: document_doc_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.document_doc_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.document_doc_id_seq OWNER TO postgres;

--
-- Name: document_doc_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.document_doc_id_seq OWNED BY public.document.doc_id;


--
-- Name: land; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.land (
    land_id integer NOT NULL,
    owner_id integer NOT NULL,
    city character varying(100),
    district character varying(100),
    province character varying(100),
    size numeric(10,2),
    land_type character varying(50),
    description text
);


ALTER TABLE public.land OWNER TO postgres;

--
-- Name: land_facility; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.land_facility (
    land_id integer NOT NULL,
    facility_name character varying(100) NOT NULL
);


ALTER TABLE public.land_facility OWNER TO postgres;

--
-- Name: land_land_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.land_land_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.land_land_id_seq OWNER TO postgres;

--
-- Name: land_land_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.land_land_id_seq OWNED BY public.land.land_id;


--
-- Name: owner; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.owner (
    owner_id integer NOT NULL,
    address_no character varying(20),
    street character varying(100),
    city character varying(100),
    district character varying(100)
);


ALTER TABLE public.owner OWNER TO postgres;

--
-- Name: payment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment (
    payment_id integer NOT NULL,
    agreement_id integer NOT NULL,
    payment_date date NOT NULL,
    amount numeric(12,2) NOT NULL,
    payment_method character varying(50)
);


ALTER TABLE public.payment OWNER TO postgres;

--
-- Name: payment_payment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payment_payment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payment_payment_id_seq OWNER TO postgres;

--
-- Name: payment_payment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payment_payment_id_seq OWNED BY public.payment.payment_id;


--
-- Name: rental_agreement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rental_agreement (
    agreement_id integer NOT NULL,
    offer_id integer NOT NULL,
    tenant_id integer NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    total_amount numeric(12,2) NOT NULL,
    CONSTRAINT chk_agreement_dates CHECK ((end_date >= start_date))
);


ALTER TABLE public.rental_agreement OWNER TO postgres;

--
-- Name: rental_agreement_agreement_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rental_agreement_agreement_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.rental_agreement_agreement_id_seq OWNER TO postgres;

--
-- Name: rental_agreement_agreement_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rental_agreement_agreement_id_seq OWNED BY public.rental_agreement.agreement_id;


--
-- Name: rental_offer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rental_offer (
    offer_id integer NOT NULL,
    land_id integer NOT NULL,
    price_per_month numeric(12,2) NOT NULL,
    available_from date NOT NULL,
    status character varying(20) DEFAULT 'available'::character varying,
    offer_created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.rental_offer OWNER TO postgres;

--
-- Name: rental_offer_offer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rental_offer_offer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.rental_offer_offer_id_seq OWNER TO postgres;

--
-- Name: rental_offer_offer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rental_offer_offer_id_seq OWNED BY public.rental_offer.offer_id;


--
-- Name: review; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.review (
    review_id integer NOT NULL,
    tenant_id integer NOT NULL,
    land_id integer NOT NULL,
    rating integer,
    comment text,
    created_at timestamp without time zone DEFAULT now(),
    CONSTRAINT review_rating_check CHECK (((rating >= 1) AND (rating <= 5)))
);


ALTER TABLE public.review OWNER TO postgres;

--
-- Name: review_review_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.review_review_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.review_review_id_seq OWNER TO postgres;

--
-- Name: review_review_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.review_review_id_seq OWNED BY public.review.review_id;


--
-- Name: tenant; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tenant (
    tenant_id integer NOT NULL,
    occupation character varying(100)
);


ALTER TABLE public.tenant OWNER TO postgres;

--
-- Name: user_account; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_account (
    user_id integer NOT NULL,
    f_name character varying(50) NOT NULL,
    m_name character varying(50),
    l_name character varying(50) NOT NULL,
    country_code character varying(10),
    phone character varying(20),
    email character varying(150) NOT NULL,
    role character varying(20) NOT NULL,
    password character varying(255) NOT NULL,
    referred_by integer
);


ALTER TABLE public.user_account OWNER TO postgres;

--
-- Name: user_account_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_account_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_account_user_id_seq OWNER TO postgres;

--
-- Name: user_account_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_account_user_id_seq OWNED BY public.user_account.user_id;


--
-- Name: document doc_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document ALTER COLUMN doc_id SET DEFAULT nextval('public.document_doc_id_seq'::regclass);


--
-- Name: land land_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.land ALTER COLUMN land_id SET DEFAULT nextval('public.land_land_id_seq'::regclass);


--
-- Name: payment payment_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment ALTER COLUMN payment_id SET DEFAULT nextval('public.payment_payment_id_seq'::regclass);


--
-- Name: rental_agreement agreement_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rental_agreement ALTER COLUMN agreement_id SET DEFAULT nextval('public.rental_agreement_agreement_id_seq'::regclass);


--
-- Name: rental_offer offer_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rental_offer ALTER COLUMN offer_id SET DEFAULT nextval('public.rental_offer_offer_id_seq'::regclass);


--
-- Name: review review_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.review ALTER COLUMN review_id SET DEFAULT nextval('public.review_review_id_seq'::regclass);


--
-- Name: user_account user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_account ALTER COLUMN user_id SET DEFAULT nextval('public.user_account_user_id_seq'::regclass);


--
-- Data for Name: document; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.document (agreement_id, doc_id, doc_type, file_path) FROM stdin;
1	1	NIC Copy	/docs/ag1/nic.pdf
1	2	Proof of Funds	/docs/ag1/funds.pdf
2	1	Business License	/docs/ag2/license.pdf
3	1	Contract	/docs/ag3/contract.pdf
4	1	NIC Copy	/docs/ag4/nic.pdf
\.


--
-- Data for Name: land; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.land (land_id, owner_id, city, district, province, size, land_type, description) FROM stdin;
1	2	Colombo	Colombo	Western	5000.00	Agricultural	Land near river
2	4	Galle	Galle	Southern	3000.00	Commercial	Beachfront property
3	3	Kandy	Kandy	Central	2500.00	Residential	Hilltop scenic land
4	1	Matara	Matara	Southern	4000.00	Agricultural	Coconut plantation
5	5	Kurunegala	Kurunegala	North Western	3500.00	Residential	Calm neighborhood land
\.


--
-- Data for Name: land_facility; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.land_facility (land_id, facility_name) FROM stdin;
1	Electricity
1	Water Supply
2	Main Road Access
3	Fencing
4	Well Water
\.


--
-- Data for Name: owner; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.owner (owner_id, address_no, street, city, district) FROM stdin;
2	45A	Temple Road	Colombo	Colombo
4	15B	Beach Road	Galle	Galle
3	12C	Station Lane	Colombo	Colombo
1	89D	Hill Side	Kandy	Kandy
5	77A	Park Avenue	Colombo	Colombo
\.


--
-- Data for Name: payment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payment (payment_id, agreement_id, payment_date, amount, payment_method) FROM stdin;
1	1	2026-01-15	30000.00	Card
2	1	2026-02-15	30000.00	Bank Transfer
3	2	2026-02-20	75000.00	Card
4	4	2026-03-10	60000.00	Cash
5	5	2026-04-15	22000.00	Card
\.


--
-- Data for Name: rental_agreement; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rental_agreement (agreement_id, offer_id, tenant_id, start_date, end_date, total_amount) FROM stdin;
1	1	1	2026-01-10	2026-07-10	90000.00
2	2	3	2026-02-15	2026-08-15	150000.00
3	3	1	2026-01-01	2026-04-01	54000.00
4	4	5	2026-03-05	2026-06-05	60000.00
5	5	3	2026-04-10	2026-10-10	132000.00
\.


--
-- Data for Name: rental_offer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rental_offer (offer_id, land_id, price_per_month, available_from, status, offer_created_at) FROM stdin;
1	1	15000.00	2026-01-01	available	2025-11-16 10:16:53.913043
2	2	25000.00	2026-02-01	available	2025-11-16 10:16:53.913043
3	3	18000.00	2025-12-15	pending	2025-11-16 10:16:53.913043
4	4	20000.00	2026-03-01	available	2025-11-16 10:16:53.913043
5	5	22000.00	2026-04-01	available	2025-11-16 10:16:53.913043
\.


--
-- Data for Name: review; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.review (review_id, tenant_id, land_id, rating, comment, created_at) FROM stdin;
1	1	1	5	Beautiful land with great surroundings. Highly recommended!	2025-11-16 10:17:52.176288
2	3	2	4	Good residential area, but price slightly high.	2025-11-16 10:17:52.176288
3	5	3	5	Perfect commercial land. Very convenient location.	2025-11-16 10:17:52.176288
4	1	4	3	Decent land but needs some cleaning and maintenance.	2025-11-16 10:17:52.176288
5	3	5	4	Nice neighborhood, good for building a house.	2025-11-16 10:17:52.176288
\.


--
-- Data for Name: tenant; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tenant (tenant_id, occupation) FROM stdin;
1	Engineer
2	Teacher
5	Nurse
4	Designer
3	Doctor
\.


--
-- Data for Name: user_account; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_account (user_id, f_name, m_name, l_name, country_code, phone, email, role, password, referred_by) FROM stdin;
1	Sanduni	M	Perera	+94	712345678	sanduni@example.com	tenant	pass123	\N
2	Michael	A	Johnson	+1	2025550199	michael@example.com	owner	pass456	1
3	Kavinda	\N	Ranasinghe	+94	771112233	kavinda@example.com	tenant	pass789	1
4	Sophia	L	Martinez	+34	612345678	sophia@example.com	owner	pass999	2
5	Tharindu	S	Weerasinghe	+94	775556677	tharindu@example.com	tenant	pass321	\N
\.


--
-- Name: document_doc_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.document_doc_id_seq', 1, false);


--
-- Name: land_land_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.land_land_id_seq', 5, true);


--
-- Name: payment_payment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payment_payment_id_seq', 5, true);


--
-- Name: rental_agreement_agreement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rental_agreement_agreement_id_seq', 5, true);


--
-- Name: rental_offer_offer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rental_offer_offer_id_seq', 5, true);


--
-- Name: review_review_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.review_review_id_seq', 5, true);


--
-- Name: user_account_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_account_user_id_seq', 5, true);


--
-- Name: document document_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document
    ADD CONSTRAINT document_pkey PRIMARY KEY (agreement_id, doc_id);


--
-- Name: land_facility land_facility_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.land_facility
    ADD CONSTRAINT land_facility_pkey PRIMARY KEY (land_id, facility_name);


--
-- Name: land land_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.land
    ADD CONSTRAINT land_pkey PRIMARY KEY (land_id);


--
-- Name: owner owner_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.owner
    ADD CONSTRAINT owner_pkey PRIMARY KEY (owner_id);


--
-- Name: payment payment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_pkey PRIMARY KEY (payment_id);


--
-- Name: rental_agreement rental_agreement_offer_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rental_agreement
    ADD CONSTRAINT rental_agreement_offer_id_key UNIQUE (offer_id);


--
-- Name: rental_agreement rental_agreement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rental_agreement
    ADD CONSTRAINT rental_agreement_pkey PRIMARY KEY (agreement_id);


--
-- Name: rental_offer rental_offer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rental_offer
    ADD CONSTRAINT rental_offer_pkey PRIMARY KEY (offer_id);


--
-- Name: review review_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.review
    ADD CONSTRAINT review_pkey PRIMARY KEY (review_id);


--
-- Name: tenant tenant_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tenant
    ADD CONSTRAINT tenant_pkey PRIMARY KEY (tenant_id);


--
-- Name: review uq_review; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.review
    ADD CONSTRAINT uq_review UNIQUE (tenant_id, land_id);


--
-- Name: user_account user_account_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_account
    ADD CONSTRAINT user_account_email_key UNIQUE (email);


--
-- Name: user_account user_account_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_account
    ADD CONSTRAINT user_account_pkey PRIMARY KEY (user_id);


--
-- Name: rental_agreement fk_agreement_offer; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rental_agreement
    ADD CONSTRAINT fk_agreement_offer FOREIGN KEY (offer_id) REFERENCES public.rental_offer(offer_id) ON DELETE CASCADE;


--
-- Name: rental_agreement fk_agreement_tenant; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rental_agreement
    ADD CONSTRAINT fk_agreement_tenant FOREIGN KEY (tenant_id) REFERENCES public.tenant(tenant_id) ON DELETE CASCADE;


--
-- Name: document fk_document_agreement; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document
    ADD CONSTRAINT fk_document_agreement FOREIGN KEY (agreement_id) REFERENCES public.rental_agreement(agreement_id) ON DELETE CASCADE;


--
-- Name: land_facility fk_facility_land; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.land_facility
    ADD CONSTRAINT fk_facility_land FOREIGN KEY (land_id) REFERENCES public.land(land_id) ON DELETE CASCADE;


--
-- Name: land fk_land_owner; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.land
    ADD CONSTRAINT fk_land_owner FOREIGN KEY (owner_id) REFERENCES public.owner(owner_id) ON DELETE CASCADE;


--
-- Name: rental_offer fk_offer_land; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rental_offer
    ADD CONSTRAINT fk_offer_land FOREIGN KEY (land_id) REFERENCES public.land(land_id) ON DELETE CASCADE;


--
-- Name: owner fk_owner_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.owner
    ADD CONSTRAINT fk_owner_user FOREIGN KEY (owner_id) REFERENCES public.user_account(user_id) ON DELETE CASCADE;


--
-- Name: payment fk_payment_agreement; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT fk_payment_agreement FOREIGN KEY (agreement_id) REFERENCES public.rental_agreement(agreement_id) ON DELETE CASCADE;


--
-- Name: review fk_review_land; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.review
    ADD CONSTRAINT fk_review_land FOREIGN KEY (land_id) REFERENCES public.land(land_id) ON DELETE CASCADE;


--
-- Name: review fk_review_tenant; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.review
    ADD CONSTRAINT fk_review_tenant FOREIGN KEY (tenant_id) REFERENCES public.tenant(tenant_id) ON DELETE CASCADE;


--
-- Name: tenant fk_tenant_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tenant
    ADD CONSTRAINT fk_tenant_user FOREIGN KEY (tenant_id) REFERENCES public.user_account(user_id) ON DELETE CASCADE;


--
-- Name: user_account fk_user_refers; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_account
    ADD CONSTRAINT fk_user_refers FOREIGN KEY (referred_by) REFERENCES public.user_account(user_id) ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

\unrestrict ksMiUbpobQM2n89ixJG2hUdbxhWfZd4hRxAbpducYhT2oSiExr0CTkftiR6QAeT


--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5 (Debian 17.5-1.pgdg120+1)
-- Dumped by pg_dump version 17.5

-- Started on 2025-06-02 06:53:33 UTC

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
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 3560 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 252 (class 1259 OID 16572)
-- Name: Действия по устранению; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Действия по устранению" (
    id integer NOT NULL,
    "id_действия" integer NOT NULL,
    "id_статуса" integer NOT NULL,
    "время" timestamp without time zone NOT NULL
);


ALTER TABLE public."Действия по устранению" OWNER TO root;

--
-- TOC entry 251 (class 1259 OID 16571)
-- Name: Действия по устранению_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public."Действия по устранению_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Действия по устранению_id_seq" OWNER TO root;

--
-- TOC entry 3561 (class 0 OID 0)
-- Dependencies: 251
-- Name: Действия по устранению_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."Действия по устранению_id_seq" OWNED BY public."Действия по устранению".id;


--
-- TOC entry 232 (class 1259 OID 16500)
-- Name: Должности; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Должности" (
    id integer NOT NULL,
    "должность" character varying(30) NOT NULL
);


ALTER TABLE public."Должности" OWNER TO root;

--
-- TOC entry 231 (class 1259 OID 16499)
-- Name: Должности_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public."Должности_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Должности_id_seq" OWNER TO root;

--
-- TOC entry 3562 (class 0 OID 0)
-- Dependencies: 231
-- Name: Должности_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."Должности_id_seq" OWNED BY public."Должности".id;


--
-- TOC entry 238 (class 1259 OID 16521)
-- Name: Инциденты; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Инциденты" (
    id integer NOT NULL,
    "время_происшествия" timestamp without time zone NOT NULL,
    "id_типа_угрозы" integer NOT NULL,
    "id_степени_угрозы" integer NOT NULL,
    "id_статуса" integer NOT NULL,
    "id_источника" integer NOT NULL,
    "id_ответственного" integer NOT NULL,
    "время_устранения" timestamp without time zone
);


ALTER TABLE public."Инциденты" OWNER TO root;

--
-- TOC entry 237 (class 1259 OID 16520)
-- Name: Инциденты_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public."Инциденты_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Инциденты_id_seq" OWNER TO root;

--
-- TOC entry 3563 (class 0 OID 0)
-- Dependencies: 237
-- Name: Инциденты_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."Инциденты_id_seq" OWNED BY public."Инциденты".id;


--
-- TOC entry 254 (class 1259 OID 16589)
-- Name: Инциденты_действия; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Инциденты_действия" (
    id integer NOT NULL,
    "id_инцидента" integer NOT NULL,
    "id_действия" integer NOT NULL
);


ALTER TABLE public."Инциденты_действия" OWNER TO root;

--
-- TOC entry 253 (class 1259 OID 16588)
-- Name: Инциденты_действия_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public."Инциденты_действия_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Инциденты_действия_id_seq" OWNER TO root;

--
-- TOC entry 3564 (class 0 OID 0)
-- Dependencies: 253
-- Name: Инциденты_действия_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."Инциденты_действия_id_seq" OWNED BY public."Инциденты_действия".id;


--
-- TOC entry 230 (class 1259 OID 16493)
-- Name: Источник инцидента; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Источник инцидента" (
    id integer NOT NULL,
    "id_типа_источника" integer NOT NULL,
    "id_источника" integer NOT NULL
);


ALTER TABLE public."Источник инцидента" OWNER TO root;

--
-- TOC entry 229 (class 1259 OID 16492)
-- Name: Источник инцидента_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public."Источник инцидента_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Источник инцидента_id_seq" OWNER TO root;

--
-- TOC entry 3565 (class 0 OID 0)
-- Dependencies: 229
-- Name: Источник инцидента_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."Источник инцидента_id_seq" OWNED BY public."Источник инцидента".id;


--
-- TOC entry 236 (class 1259 OID 16514)
-- Name: Отделы; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Отделы" (
    id integer NOT NULL,
    "название" character varying(50) NOT NULL,
    "адрес" character varying(20) NOT NULL
);


ALTER TABLE public."Отделы" OWNER TO root;

--
-- TOC entry 235 (class 1259 OID 16513)
-- Name: Отделы_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public."Отделы_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Отделы_id_seq" OWNER TO root;

--
-- TOC entry 3566 (class 0 OID 0)
-- Dependencies: 235
-- Name: Отделы_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."Отделы_id_seq" OWNED BY public."Отделы".id;


--
-- TOC entry 228 (class 1259 OID 16485)
-- Name: Пользователи; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Пользователи" (
    id integer NOT NULL,
    "имя" character varying(30) NOT NULL,
    "электронная_почта" character varying(30) NOT NULL,
    "пароль" character varying(30) NOT NULL
);


ALTER TABLE public."Пользователи" OWNER TO root;

--
-- TOC entry 227 (class 1259 OID 16484)
-- Name: Пользователи_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public."Пользователи_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Пользователи_id_seq" OWNER TO root;

--
-- TOC entry 3567 (class 0 OID 0)
-- Dependencies: 227
-- Name: Пользователи_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."Пользователи_id_seq" OWNED BY public."Пользователи".id;


--
-- TOC entry 226 (class 1259 OID 16478)
-- Name: Приложения; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Приложения" (
    id integer NOT NULL,
    "название" character varying(30) NOT NULL,
    "описание" character varying(100) NOT NULL
);


ALTER TABLE public."Приложения" OWNER TO root;

--
-- TOC entry 225 (class 1259 OID 16477)
-- Name: Приложения_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public."Приложения_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Приложения_id_seq" OWNER TO root;

--
-- TOC entry 3568 (class 0 OID 0)
-- Dependencies: 225
-- Name: Приложения_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."Приложения_id_seq" OWNED BY public."Приложения".id;


--
-- TOC entry 250 (class 1259 OID 16563)
-- Name: Рекомендации; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Рекомендации" (
    id integer NOT NULL,
    "тип_инцидента" integer NOT NULL,
    "степень_угрозы" integer NOT NULL,
    "рекомендации" text NOT NULL
);


ALTER TABLE public."Рекомендации" OWNER TO root;

--
-- TOC entry 249 (class 1259 OID 16562)
-- Name: Рекомендации_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public."Рекомендации_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Рекомендации_id_seq" OWNER TO root;

--
-- TOC entry 3569 (class 0 OID 0)
-- Dependencies: 249
-- Name: Рекомендации_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."Рекомендации_id_seq" OWNED BY public."Рекомендации".id;


--
-- TOC entry 224 (class 1259 OID 16471)
-- Name: Системы; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Системы" (
    id integer NOT NULL,
    "описание" character varying(100) NOT NULL,
    "название" character varying(50) NOT NULL
);


ALTER TABLE public."Системы" OWNER TO root;

--
-- TOC entry 223 (class 1259 OID 16470)
-- Name: Системы_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public."Системы_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Системы_id_seq" OWNER TO root;

--
-- TOC entry 3570 (class 0 OID 0)
-- Dependencies: 223
-- Name: Системы_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."Системы_id_seq" OWNED BY public."Системы".id;


--
-- TOC entry 234 (class 1259 OID 16507)
-- Name: Сотрудники; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Сотрудники" (
    id integer NOT NULL,
    "имя" character varying(30) NOT NULL,
    "фамилия" character varying(30) NOT NULL,
    "отчество" character varying(30),
    "id_должности" integer NOT NULL,
    "id_отдела" integer NOT NULL,
    "адрес_почты" character varying(30) NOT NULL
);


ALTER TABLE public."Сотрудники" OWNER TO root;

--
-- TOC entry 233 (class 1259 OID 16506)
-- Name: Сотрудники_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public."Сотрудники_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Сотрудники_id_seq" OWNER TO root;

--
-- TOC entry 3571 (class 0 OID 0)
-- Dependencies: 233
-- Name: Сотрудники_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."Сотрудники_id_seq" OWNED BY public."Сотрудники".id;


--
-- TOC entry 248 (class 1259 OID 16556)
-- Name: Статус действия; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Статус действия" (
    id integer NOT NULL,
    "статус" character varying(20) NOT NULL
);


ALTER TABLE public."Статус действия" OWNER TO root;

--
-- TOC entry 246 (class 1259 OID 16549)
-- Name: Статус действия по устранению инц; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Статус действия по устранению инц" (
    id integer NOT NULL,
    "статус" character varying(20) NOT NULL
);


ALTER TABLE public."Статус действия по устранению инц" OWNER TO root;

--
-- TOC entry 245 (class 1259 OID 16548)
-- Name: Статус действия по устранению _id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public."Статус действия по устранению _id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Статус действия по устранению _id_seq" OWNER TO root;

--
-- TOC entry 3572 (class 0 OID 0)
-- Dependencies: 245
-- Name: Статус действия по устранению _id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."Статус действия по устранению _id_seq" OWNED BY public."Статус действия по устранению инц".id;


--
-- TOC entry 247 (class 1259 OID 16555)
-- Name: Статус действия_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public."Статус действия_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Статус действия_id_seq" OWNER TO root;

--
-- TOC entry 3573 (class 0 OID 0)
-- Dependencies: 247
-- Name: Статус действия_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."Статус действия_id_seq" OWNED BY public."Статус действия".id;


--
-- TOC entry 218 (class 1259 OID 16448)
-- Name: Статус уязвимости; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Статус уязвимости" (
    id integer NOT NULL,
    "статус" character varying(20) NOT NULL
);


ALTER TABLE public."Статус уязвимости" OWNER TO root;

--
-- TOC entry 217 (class 1259 OID 16447)
-- Name: Статус уязвимости_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public."Статус уязвимости_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Статус уязвимости_id_seq" OWNER TO root;

--
-- TOC entry 3574 (class 0 OID 0)
-- Dependencies: 217
-- Name: Статус уязвимости_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."Статус уязвимости_id_seq" OWNED BY public."Статус уязвимости".id;


--
-- TOC entry 240 (class 1259 OID 16528)
-- Name: Статусы; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Статусы" (
    id integer NOT NULL,
    "Статус" character varying(20) NOT NULL
);


ALTER TABLE public."Статусы" OWNER TO root;

--
-- TOC entry 239 (class 1259 OID 16527)
-- Name: Статусы_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public."Статусы_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Статусы_id_seq" OWNER TO root;

--
-- TOC entry 3575 (class 0 OID 0)
-- Dependencies: 239
-- Name: Статусы_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."Статусы_id_seq" OWNED BY public."Статусы".id;


--
-- TOC entry 244 (class 1259 OID 16542)
-- Name: Степени угроз; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Степени угроз" (
    id integer NOT NULL,
    "уровень" character varying(20) NOT NULL
);


ALTER TABLE public."Степени угроз" OWNER TO root;

--
-- TOC entry 243 (class 1259 OID 16541)
-- Name: Степени угроз_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public."Степени угроз_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Степени угроз_id_seq" OWNER TO root;

--
-- TOC entry 3576 (class 0 OID 0)
-- Dependencies: 243
-- Name: Степени угроз_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."Степени угроз_id_seq" OWNED BY public."Степени угроз".id;


--
-- TOC entry 222 (class 1259 OID 16462)
-- Name: Тип источника; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Тип источника" (
    id integer NOT NULL,
    "тип источника" character varying NOT NULL
);


ALTER TABLE public."Тип источника" OWNER TO root;

--
-- TOC entry 221 (class 1259 OID 16461)
-- Name: Тип источника_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public."Тип источника_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Тип источника_id_seq" OWNER TO root;

--
-- TOC entry 3577 (class 0 OID 0)
-- Dependencies: 221
-- Name: Тип источника_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."Тип источника_id_seq" OWNED BY public."Тип источника".id;


--
-- TOC entry 242 (class 1259 OID 16535)
-- Name: Типы инцидентов; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Типы инцидентов" (
    id integer NOT NULL,
    "тип" character varying(20) NOT NULL
);


ALTER TABLE public."Типы инцидентов" OWNER TO root;

--
-- TOC entry 241 (class 1259 OID 16534)
-- Name: Типы инцидентов_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public."Типы инцидентов_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Типы инцидентов_id_seq" OWNER TO root;

--
-- TOC entry 3578 (class 0 OID 0)
-- Dependencies: 241
-- Name: Типы инцидентов_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."Типы инцидентов_id_seq" OWNED BY public."Типы инцидентов".id;


--
-- TOC entry 220 (class 1259 OID 16455)
-- Name: Уязвимости; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Уязвимости" (
    id integer NOT NULL,
    "Название" character varying(20) NOT NULL,
    "id_статуса" integer NOT NULL,
    "id_степени_угрозы" integer NOT NULL,
    "id_источника_уязвимости" integer NOT NULL,
    "Описание" character varying(100) NOT NULL
);


ALTER TABLE public."Уязвимости" OWNER TO root;

--
-- TOC entry 219 (class 1259 OID 16454)
-- Name: Уязвимости_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public."Уязвимости_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Уязвимости_id_seq" OWNER TO root;

--
-- TOC entry 3579 (class 0 OID 0)
-- Dependencies: 219
-- Name: Уязвимости_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."Уязвимости_id_seq" OWNED BY public."Уязвимости".id;


--
-- TOC entry 3317 (class 2604 OID 16575)
-- Name: Действия по устранению id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Действия по устранению" ALTER COLUMN id SET DEFAULT nextval('public."Действия по устранению_id_seq"'::regclass);


--
-- TOC entry 3307 (class 2604 OID 16503)
-- Name: Должности id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Должности" ALTER COLUMN id SET DEFAULT nextval('public."Должности_id_seq"'::regclass);


--
-- TOC entry 3310 (class 2604 OID 16524)
-- Name: Инциденты id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Инциденты" ALTER COLUMN id SET DEFAULT nextval('public."Инциденты_id_seq"'::regclass);


--
-- TOC entry 3318 (class 2604 OID 16592)
-- Name: Инциденты_действия id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Инциденты_действия" ALTER COLUMN id SET DEFAULT nextval('public."Инциденты_действия_id_seq"'::regclass);


--
-- TOC entry 3306 (class 2604 OID 16496)
-- Name: Источник инцидента id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Источник инцидента" ALTER COLUMN id SET DEFAULT nextval('public."Источник инцидента_id_seq"'::regclass);


--
-- TOC entry 3309 (class 2604 OID 16517)
-- Name: Отделы id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Отделы" ALTER COLUMN id SET DEFAULT nextval('public."Отделы_id_seq"'::regclass);


--
-- TOC entry 3305 (class 2604 OID 16488)
-- Name: Пользователи id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Пользователи" ALTER COLUMN id SET DEFAULT nextval('public."Пользователи_id_seq"'::regclass);


--
-- TOC entry 3304 (class 2604 OID 16481)
-- Name: Приложения id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Приложения" ALTER COLUMN id SET DEFAULT nextval('public."Приложения_id_seq"'::regclass);


--
-- TOC entry 3316 (class 2604 OID 16566)
-- Name: Рекомендации id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Рекомендации" ALTER COLUMN id SET DEFAULT nextval('public."Рекомендации_id_seq"'::regclass);


--
-- TOC entry 3303 (class 2604 OID 16474)
-- Name: Системы id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Системы" ALTER COLUMN id SET DEFAULT nextval('public."Системы_id_seq"'::regclass);


--
-- TOC entry 3308 (class 2604 OID 16510)
-- Name: Сотрудники id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Сотрудники" ALTER COLUMN id SET DEFAULT nextval('public."Сотрудники_id_seq"'::regclass);


--
-- TOC entry 3315 (class 2604 OID 16559)
-- Name: Статус действия id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Статус действия" ALTER COLUMN id SET DEFAULT nextval('public."Статус действия_id_seq"'::regclass);


--
-- TOC entry 3314 (class 2604 OID 16552)
-- Name: Статус действия по устранению инц id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Статус действия по устранению инц" ALTER COLUMN id SET DEFAULT nextval('public."Статус действия по устранению _id_seq"'::regclass);


--
-- TOC entry 3300 (class 2604 OID 16451)
-- Name: Статус уязвимости id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Статус уязвимости" ALTER COLUMN id SET DEFAULT nextval('public."Статус уязвимости_id_seq"'::regclass);


--
-- TOC entry 3311 (class 2604 OID 16531)
-- Name: Статусы id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Статусы" ALTER COLUMN id SET DEFAULT nextval('public."Статусы_id_seq"'::regclass);


--
-- TOC entry 3313 (class 2604 OID 16545)
-- Name: Степени угроз id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Степени угроз" ALTER COLUMN id SET DEFAULT nextval('public."Степени угроз_id_seq"'::regclass);


--
-- TOC entry 3302 (class 2604 OID 16465)
-- Name: Тип источника id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Тип источника" ALTER COLUMN id SET DEFAULT nextval('public."Тип источника_id_seq"'::regclass);


--
-- TOC entry 3312 (class 2604 OID 16538)
-- Name: Типы инцидентов id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Типы инцидентов" ALTER COLUMN id SET DEFAULT nextval('public."Типы инцидентов_id_seq"'::regclass);


--
-- TOC entry 3301 (class 2604 OID 16458)
-- Name: Уязвимости id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Уязвимости" ALTER COLUMN id SET DEFAULT nextval('public."Уязвимости_id_seq"'::regclass);


--
-- TOC entry 3552 (class 0 OID 16572)
-- Dependencies: 252
-- Data for Name: Действия по устранению; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- TOC entry 3532 (class 0 OID 16500)
-- Dependencies: 232
-- Data for Name: Должности; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- TOC entry 3538 (class 0 OID 16521)
-- Dependencies: 238
-- Data for Name: Инциденты; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- TOC entry 3554 (class 0 OID 16589)
-- Dependencies: 254
-- Data for Name: Инциденты_действия; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- TOC entry 3530 (class 0 OID 16493)
-- Dependencies: 230
-- Data for Name: Источник инцидента; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- TOC entry 3536 (class 0 OID 16514)
-- Dependencies: 236
-- Data for Name: Отделы; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- TOC entry 3528 (class 0 OID 16485)
-- Dependencies: 228
-- Data for Name: Пользователи; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- TOC entry 3526 (class 0 OID 16478)
-- Dependencies: 226
-- Data for Name: Приложения; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- TOC entry 3550 (class 0 OID 16563)
-- Dependencies: 250
-- Data for Name: Рекомендации; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- TOC entry 3524 (class 0 OID 16471)
-- Dependencies: 224
-- Data for Name: Системы; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- TOC entry 3534 (class 0 OID 16507)
-- Dependencies: 234
-- Data for Name: Сотрудники; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- TOC entry 3548 (class 0 OID 16556)
-- Dependencies: 248
-- Data for Name: Статус действия; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- TOC entry 3546 (class 0 OID 16549)
-- Dependencies: 246
-- Data for Name: Статус действия по устранению инц; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- TOC entry 3518 (class 0 OID 16448)
-- Dependencies: 218
-- Data for Name: Статус уязвимости; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- TOC entry 3540 (class 0 OID 16528)
-- Dependencies: 240
-- Data for Name: Статусы; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- TOC entry 3544 (class 0 OID 16542)
-- Dependencies: 244
-- Data for Name: Степени угроз; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- TOC entry 3522 (class 0 OID 16462)
-- Dependencies: 222
-- Data for Name: Тип источника; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- TOC entry 3542 (class 0 OID 16535)
-- Dependencies: 242
-- Data for Name: Типы инцидентов; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- TOC entry 3520 (class 0 OID 16455)
-- Dependencies: 220
-- Data for Name: Уязвимости; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- TOC entry 3580 (class 0 OID 0)
-- Dependencies: 251
-- Name: Действия по устранению_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Действия по устранению_id_seq"', 1, false);


--
-- TOC entry 3581 (class 0 OID 0)
-- Dependencies: 231
-- Name: Должности_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Должности_id_seq"', 1, false);


--
-- TOC entry 3582 (class 0 OID 0)
-- Dependencies: 237
-- Name: Инциденты_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Инциденты_id_seq"', 1, false);


--
-- TOC entry 3583 (class 0 OID 0)
-- Dependencies: 253
-- Name: Инциденты_действия_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Инциденты_действия_id_seq"', 1, false);


--
-- TOC entry 3584 (class 0 OID 0)
-- Dependencies: 229
-- Name: Источник инцидента_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Источник инцидента_id_seq"', 1, false);


--
-- TOC entry 3585 (class 0 OID 0)
-- Dependencies: 235
-- Name: Отделы_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Отделы_id_seq"', 1, false);


--
-- TOC entry 3586 (class 0 OID 0)
-- Dependencies: 227
-- Name: Пользователи_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Пользователи_id_seq"', 1, false);


--
-- TOC entry 3587 (class 0 OID 0)
-- Dependencies: 225
-- Name: Приложения_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Приложения_id_seq"', 1, false);


--
-- TOC entry 3588 (class 0 OID 0)
-- Dependencies: 249
-- Name: Рекомендации_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Рекомендации_id_seq"', 1, false);


--
-- TOC entry 3589 (class 0 OID 0)
-- Dependencies: 223
-- Name: Системы_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Системы_id_seq"', 1, false);


--
-- TOC entry 3590 (class 0 OID 0)
-- Dependencies: 233
-- Name: Сотрудники_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Сотрудники_id_seq"', 1, false);


--
-- TOC entry 3591 (class 0 OID 0)
-- Dependencies: 245
-- Name: Статус действия по устранению _id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Статус действия по устранению _id_seq"', 1, false);


--
-- TOC entry 3592 (class 0 OID 0)
-- Dependencies: 247
-- Name: Статус действия_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Статус действия_id_seq"', 1, false);


--
-- TOC entry 3593 (class 0 OID 0)
-- Dependencies: 217
-- Name: Статус уязвимости_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Статус уязвимости_id_seq"', 1, false);


--
-- TOC entry 3594 (class 0 OID 0)
-- Dependencies: 239
-- Name: Статусы_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Статусы_id_seq"', 1, false);


--
-- TOC entry 3595 (class 0 OID 0)
-- Dependencies: 243
-- Name: Степени угроз_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Степени угроз_id_seq"', 1, false);


--
-- TOC entry 3596 (class 0 OID 0)
-- Dependencies: 221
-- Name: Тип источника_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Тип источника_id_seq"', 1, false);


--
-- TOC entry 3597 (class 0 OID 0)
-- Dependencies: 241
-- Name: Типы инцидентов_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Типы инцидентов_id_seq"', 1, false);


--
-- TOC entry 3598 (class 0 OID 0)
-- Dependencies: 219
-- Name: Уязвимости_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Уязвимости_id_seq"', 1, false);


--
-- TOC entry 3354 (class 2606 OID 16577)
-- Name: Действия по устранению Действия по устранению_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Действия по устранению"
    ADD CONSTRAINT "Действия по устранению_pkey" PRIMARY KEY (id);


--
-- TOC entry 3334 (class 2606 OID 16505)
-- Name: Должности Должности_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Должности"
    ADD CONSTRAINT "Должности_pkey" PRIMARY KEY (id);


--
-- TOC entry 3340 (class 2606 OID 16526)
-- Name: Инциденты Инциденты_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Инциденты"
    ADD CONSTRAINT "Инциденты_pkey" PRIMARY KEY (id);


--
-- TOC entry 3356 (class 2606 OID 16594)
-- Name: Инциденты_действия Инциденты_действия_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Инциденты_действия"
    ADD CONSTRAINT "Инциденты_действия_pkey" PRIMARY KEY (id);


--
-- TOC entry 3332 (class 2606 OID 16498)
-- Name: Источник инцидента Источник инцидента_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Источник инцидента"
    ADD CONSTRAINT "Источник инцидента_pkey" PRIMARY KEY (id);


--
-- TOC entry 3338 (class 2606 OID 16519)
-- Name: Отделы Отделы_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Отделы"
    ADD CONSTRAINT "Отделы_pkey" PRIMARY KEY (id);


--
-- TOC entry 3330 (class 2606 OID 16490)
-- Name: Пользователи Пользователи_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Пользователи"
    ADD CONSTRAINT "Пользователи_pkey" PRIMARY KEY (id);


--
-- TOC entry 3328 (class 2606 OID 16483)
-- Name: Приложения Приложения_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Приложения"
    ADD CONSTRAINT "Приложения_pkey" PRIMARY KEY (id);


--
-- TOC entry 3352 (class 2606 OID 16570)
-- Name: Рекомендации Рекомендации_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Рекомендации"
    ADD CONSTRAINT "Рекомендации_pkey" PRIMARY KEY (id);


--
-- TOC entry 3326 (class 2606 OID 16476)
-- Name: Системы Системы_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Системы"
    ADD CONSTRAINT "Системы_pkey" PRIMARY KEY (id);


--
-- TOC entry 3336 (class 2606 OID 16512)
-- Name: Сотрудники Сотрудники_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Сотрудники"
    ADD CONSTRAINT "Сотрудники_pkey" PRIMARY KEY (id);


--
-- TOC entry 3348 (class 2606 OID 16554)
-- Name: Статус действия по устранению инц Статус действия по устранению и_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Статус действия по устранению инц"
    ADD CONSTRAINT "Статус действия по устранению и_pkey" PRIMARY KEY (id);


--
-- TOC entry 3350 (class 2606 OID 16561)
-- Name: Статус действия Статус действия_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Статус действия"
    ADD CONSTRAINT "Статус действия_pkey" PRIMARY KEY (id);


--
-- TOC entry 3320 (class 2606 OID 16453)
-- Name: Статус уязвимости Статус уязвимости_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Статус уязвимости"
    ADD CONSTRAINT "Статус уязвимости_pkey" PRIMARY KEY (id);


--
-- TOC entry 3342 (class 2606 OID 16533)
-- Name: Статусы Статусы_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Статусы"
    ADD CONSTRAINT "Статусы_pkey" PRIMARY KEY (id);


--
-- TOC entry 3346 (class 2606 OID 16547)
-- Name: Степени угроз Степени угроз_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Степени угроз"
    ADD CONSTRAINT "Степени угроз_pkey" PRIMARY KEY (id);


--
-- TOC entry 3324 (class 2606 OID 16469)
-- Name: Тип источника Тип источника_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Тип источника"
    ADD CONSTRAINT "Тип источника_pkey" PRIMARY KEY (id);


--
-- TOC entry 3344 (class 2606 OID 16540)
-- Name: Типы инцидентов Типы инцидентов_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Типы инцидентов"
    ADD CONSTRAINT "Типы инцидентов_pkey" PRIMARY KEY (id);


--
-- TOC entry 3322 (class 2606 OID 16460)
-- Name: Уязвимости Уязвимости_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Уязвимости"
    ADD CONSTRAINT "Уязвимости_pkey" PRIMARY KEY (id);


--
-- TOC entry 3370 (class 2606 OID 16600)
-- Name: Инциденты_действия действия; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Инциденты_действия"
    ADD CONSTRAINT "действия" FOREIGN KEY ("id_действия") REFERENCES public."Действия по устранению"(id) NOT VALID;


--
-- TOC entry 3361 (class 2606 OID 16578)
-- Name: Сотрудники должность сотрудника; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Сотрудники"
    ADD CONSTRAINT "должность сотрудника" FOREIGN KEY ("id_должности") REFERENCES public."Должности"(id) NOT VALID;


--
-- TOC entry 3371 (class 2606 OID 16595)
-- Name: Инциденты_действия инциденты; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Инциденты_действия"
    ADD CONSTRAINT "инциденты" FOREIGN KEY ("id_инцидента") REFERENCES public."Инциденты"(id) NOT VALID;


--
-- TOC entry 3363 (class 2606 OID 16650)
-- Name: Инциденты источник инцидента; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Инциденты"
    ADD CONSTRAINT "источник инцидента" FOREIGN KEY ("id_источника") REFERENCES public."Источник инцидента"(id) NOT VALID;


--
-- TOC entry 3357 (class 2606 OID 16660)
-- Name: Уязвимости источник уязвимости; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Уязвимости"
    ADD CONSTRAINT "источник уязвимости" FOREIGN KEY ("id_источника_уязвимости") REFERENCES public."Источник инцидента"(id) NOT VALID;


--
-- TOC entry 3362 (class 2606 OID 16583)
-- Name: Сотрудники отдел работы сотрудника; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Сотрудники"
    ADD CONSTRAINT "отдел работы сотрудника" FOREIGN KEY ("id_отдела") REFERENCES public."Отделы"(id) NOT VALID;


--
-- TOC entry 3368 (class 2606 OID 16605)
-- Name: Действия по устранению рекомендации_действия; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Действия по устранению"
    ADD CONSTRAINT "рекомендации_действия" FOREIGN KEY ("id_действия") REFERENCES public."Рекомендации"(id) NOT VALID;


--
-- TOC entry 3364 (class 2606 OID 16645)
-- Name: Инциденты сотрудник расследующий; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Инциденты"
    ADD CONSTRAINT "сотрудник расследующий" FOREIGN KEY ("id_ответственного") REFERENCES public."Сотрудники"(id) NOT VALID;


--
-- TOC entry 3365 (class 2606 OID 16640)
-- Name: Инциденты статус инцидента; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Инциденты"
    ADD CONSTRAINT "статус инцидента" FOREIGN KEY ("id_статуса") REFERENCES public."Статусы"(id) NOT VALID;


--
-- TOC entry 3358 (class 2606 OID 16615)
-- Name: Уязвимости статус уязвимости; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Уязвимости"
    ADD CONSTRAINT "статус уязвимости" FOREIGN KEY ("id_статуса") REFERENCES public."Статус уязвимости"(id) NOT VALID;


--
-- TOC entry 3369 (class 2606 OID 16610)
-- Name: Действия по устранению статус_действие; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Действия по устранению"
    ADD CONSTRAINT "статус_действие" FOREIGN KEY ("id_статуса") REFERENCES public."Статус действия"(id) NOT VALID;


--
-- TOC entry 3366 (class 2606 OID 16630)
-- Name: Инциденты степень угрозы инцидента; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Инциденты"
    ADD CONSTRAINT "степень угрозы инцидента" FOREIGN KEY ("id_степени_угрозы") REFERENCES public."Степени угроз"(id) NOT VALID;


--
-- TOC entry 3359 (class 2606 OID 16620)
-- Name: Уязвимости степень угрозы уязвимости; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Уязвимости"
    ADD CONSTRAINT "степень угрозы уязвимости" FOREIGN KEY ("id_степени_угрозы") REFERENCES public."Степени угроз"(id) NOT VALID;


--
-- TOC entry 3367 (class 2606 OID 16635)
-- Name: Инциденты тип инцидента; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Инциденты"
    ADD CONSTRAINT "тип инцидента" FOREIGN KEY ("id_типа_угрозы") REFERENCES public."Типы инцидентов"(id) NOT VALID;


--
-- TOC entry 3360 (class 2606 OID 16655)
-- Name: Источник инцидента тип источника; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Источник инцидента"
    ADD CONSTRAINT "тип источника" FOREIGN KEY ("id_типа_источника") REFERENCES public."Тип источника"(id) NOT VALID;


-- Completed on 2025-06-02 06:53:33 UTC

--
-- PostgreSQL database dump complete
--


--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5 (Debian 17.5-1.pgdg120+1)
-- Dumped by pg_dump version 17.5 (Debian 17.5-1.pgdg120+1)

-- Started on 2025-06-04 08:14:01 UTC

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
-- TOC entry 253 (class 1255 OID 16665)
-- Name: avg_reaction_time(); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION public.avg_reaction_time() RETURNS interval
    LANGUAGE plpgsql
    AS $$
DECLARE
    avg_reaction interval;
BEGIN
    SELECT AVG("время_устранения" - "время_происшествия")
    INTO avg_reaction
    FROM "Инциденты"
    WHERE "время_устранения" IS NOT NULL;

    RETURN avg_reaction;
END;
$$;


ALTER FUNCTION public.avg_reaction_time() OWNER TO root;

--
-- TOC entry 254 (class 1255 OID 16666)
-- Name: check_threat_level(integer); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION public.check_threat_level(incident_id integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
DECLARE
    threat_exists boolean;
BEGIN
    SELECT EXISTS (
        SELECT 1
        FROM "Инциденты"
        WHERE "id" = incident_id
          AND "id_степени_угрозы" IS NOT NULL
    ) INTO threat_exists;

    RETURN threat_exists;
END;
$$;


ALTER FUNCTION public.check_threat_level(incident_id integer) OWNER TO root;

--
-- TOC entry 255 (class 1255 OID 16667)
-- Name: incident_frequency(timestamp without time zone, timestamp without time zone); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION public.incident_frequency(start_time timestamp without time zone, end_time timestamp without time zone) RETURNS TABLE("Тип инцидента" character varying, "Количество" integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT ti."тип", COUNT(*)::integer AS "Количество"
    FROM "Инциденты" i
    JOIN "Типы инцидентов" ti ON i."id_типа_угрозы" = ti."id"
    WHERE i."время_происшествия" BETWEEN start_time AND end_time
    GROUP BY ti."тип"
    ORDER BY COUNT(*) DESC;
END;
$$;


ALTER FUNCTION public.incident_frequency(start_time timestamp without time zone, end_time timestamp without time zone) OWNER TO root;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 250 (class 1259 OID 16572)
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
-- TOC entry 249 (class 1259 OID 16571)
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
-- TOC entry 3553 (class 0 OID 0)
-- Dependencies: 249
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
-- TOC entry 3554 (class 0 OID 0)
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
-- TOC entry 3555 (class 0 OID 0)
-- Dependencies: 237
-- Name: Инциденты_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."Инциденты_id_seq" OWNED BY public."Инциденты".id;


--
-- TOC entry 252 (class 1259 OID 16589)
-- Name: Инциденты_действия; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Инциденты_действия" (
    id integer NOT NULL,
    "id_инцидента" integer NOT NULL,
    "id_действия" integer NOT NULL
);


ALTER TABLE public."Инциденты_действия" OWNER TO root;

--
-- TOC entry 251 (class 1259 OID 16588)
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
-- TOC entry 3556 (class 0 OID 0)
-- Dependencies: 251
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
-- TOC entry 3557 (class 0 OID 0)
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
-- TOC entry 3558 (class 0 OID 0)
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
-- TOC entry 3559 (class 0 OID 0)
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
-- TOC entry 3560 (class 0 OID 0)
-- Dependencies: 225
-- Name: Приложения_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."Приложения_id_seq" OWNED BY public."Приложения".id;


--
-- TOC entry 248 (class 1259 OID 16563)
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
-- TOC entry 247 (class 1259 OID 16562)
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
-- TOC entry 3561 (class 0 OID 0)
-- Dependencies: 247
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
-- TOC entry 3562 (class 0 OID 0)
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
-- TOC entry 3563 (class 0 OID 0)
-- Dependencies: 233
-- Name: Сотрудники_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."Сотрудники_id_seq" OWNED BY public."Сотрудники".id;


--
-- TOC entry 246 (class 1259 OID 16556)
-- Name: Статус действия; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Статус действия" (
    id integer NOT NULL,
    "статус" character varying(20) NOT NULL
);


ALTER TABLE public."Статус действия" OWNER TO root;

--
-- TOC entry 245 (class 1259 OID 16555)
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
-- TOC entry 3564 (class 0 OID 0)
-- Dependencies: 245
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
-- TOC entry 3565 (class 0 OID 0)
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
-- TOC entry 3566 (class 0 OID 0)
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
-- TOC entry 3567 (class 0 OID 0)
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
-- TOC entry 3568 (class 0 OID 0)
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
-- TOC entry 3569 (class 0 OID 0)
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
-- TOC entry 3570 (class 0 OID 0)
-- Dependencies: 219
-- Name: Уязвимости_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."Уязвимости_id_seq" OWNED BY public."Уязвимости".id;


--
-- TOC entry 3314 (class 2604 OID 16575)
-- Name: Действия по устранению id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Действия по устранению" ALTER COLUMN id SET DEFAULT nextval('public."Действия по устранению_id_seq"'::regclass);


--
-- TOC entry 3305 (class 2604 OID 16503)
-- Name: Должности id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Должности" ALTER COLUMN id SET DEFAULT nextval('public."Должности_id_seq"'::regclass);


--
-- TOC entry 3308 (class 2604 OID 16524)
-- Name: Инциденты id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Инциденты" ALTER COLUMN id SET DEFAULT nextval('public."Инциденты_id_seq"'::regclass);


--
-- TOC entry 3315 (class 2604 OID 16592)
-- Name: Инциденты_действия id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Инциденты_действия" ALTER COLUMN id SET DEFAULT nextval('public."Инциденты_действия_id_seq"'::regclass);


--
-- TOC entry 3304 (class 2604 OID 16496)
-- Name: Источник инцидента id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Источник инцидента" ALTER COLUMN id SET DEFAULT nextval('public."Источник инцидента_id_seq"'::regclass);


--
-- TOC entry 3307 (class 2604 OID 16517)
-- Name: Отделы id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Отделы" ALTER COLUMN id SET DEFAULT nextval('public."Отделы_id_seq"'::regclass);


--
-- TOC entry 3303 (class 2604 OID 16488)
-- Name: Пользователи id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Пользователи" ALTER COLUMN id SET DEFAULT nextval('public."Пользователи_id_seq"'::regclass);


--
-- TOC entry 3302 (class 2604 OID 16481)
-- Name: Приложения id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Приложения" ALTER COLUMN id SET DEFAULT nextval('public."Приложения_id_seq"'::regclass);


--
-- TOC entry 3313 (class 2604 OID 16566)
-- Name: Рекомендации id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Рекомендации" ALTER COLUMN id SET DEFAULT nextval('public."Рекомендации_id_seq"'::regclass);


--
-- TOC entry 3301 (class 2604 OID 16474)
-- Name: Системы id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Системы" ALTER COLUMN id SET DEFAULT nextval('public."Системы_id_seq"'::regclass);


--
-- TOC entry 3306 (class 2604 OID 16510)
-- Name: Сотрудники id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Сотрудники" ALTER COLUMN id SET DEFAULT nextval('public."Сотрудники_id_seq"'::regclass);


--
-- TOC entry 3312 (class 2604 OID 16559)
-- Name: Статус действия id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Статус действия" ALTER COLUMN id SET DEFAULT nextval('public."Статус действия_id_seq"'::regclass);


--
-- TOC entry 3298 (class 2604 OID 16451)
-- Name: Статус уязвимости id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Статус уязвимости" ALTER COLUMN id SET DEFAULT nextval('public."Статус уязвимости_id_seq"'::regclass);


--
-- TOC entry 3309 (class 2604 OID 16531)
-- Name: Статусы id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Статусы" ALTER COLUMN id SET DEFAULT nextval('public."Статусы_id_seq"'::regclass);


--
-- TOC entry 3311 (class 2604 OID 16545)
-- Name: Степени угроз id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Степени угроз" ALTER COLUMN id SET DEFAULT nextval('public."Степени угроз_id_seq"'::regclass);


--
-- TOC entry 3300 (class 2604 OID 16465)
-- Name: Тип источника id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Тип источника" ALTER COLUMN id SET DEFAULT nextval('public."Тип источника_id_seq"'::regclass);


--
-- TOC entry 3310 (class 2604 OID 16538)
-- Name: Типы инцидентов id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Типы инцидентов" ALTER COLUMN id SET DEFAULT nextval('public."Типы инцидентов_id_seq"'::regclass);


--
-- TOC entry 3299 (class 2604 OID 16458)
-- Name: Уязвимости id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Уязвимости" ALTER COLUMN id SET DEFAULT nextval('public."Уязвимости_id_seq"'::regclass);


--
-- TOC entry 3545 (class 0 OID 16572)
-- Dependencies: 250
-- Data for Name: Действия по устранению; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO public."Действия по устранению" (id, "id_действия", "id_статуса", "время") VALUES (6, 25, 2, '2025-05-31 15:27:07.458789');
INSERT INTO public."Действия по устранению" (id, "id_действия", "id_статуса", "время") VALUES (7, 6, 3, '2025-06-01 15:27:07.458789');
INSERT INTO public."Действия по устранению" (id, "id_действия", "id_статуса", "время") VALUES (8, 10, 1, '2025-06-02 03:27:07.458789');
INSERT INTO public."Действия по устранению" (id, "id_действия", "id_статуса", "время") VALUES (9, 15, 6, '2025-06-02 09:27:07.458789');
INSERT INTO public."Действия по устранению" (id, "id_действия", "id_статуса", "время") VALUES (10, 20, 2, '2025-06-02 14:27:07.458789');
INSERT INTO public."Действия по устранению" (id, "id_действия", "id_статуса", "время") VALUES (11, 6, 3, '2025-05-25 09:22:07.489041');
INSERT INTO public."Действия по устранению" (id, "id_действия", "id_статуса", "время") VALUES (12, 7, 3, '2025-05-26 09:22:07.489041');
INSERT INTO public."Действия по устранению" (id, "id_действия", "id_статуса", "время") VALUES (13, 12, 3, '2025-05-27 09:22:07.489041');
INSERT INTO public."Действия по устранению" (id, "id_действия", "id_статуса", "время") VALUES (14, 13, 3, '2025-05-28 09:22:07.489041');
INSERT INTO public."Действия по устранению" (id, "id_действия", "id_статуса", "время") VALUES (15, 18, 3, '2025-05-29 09:22:07.489041');
INSERT INTO public."Действия по устранению" (id, "id_действия", "id_статуса", "время") VALUES (16, 23, 3, '2025-05-30 09:22:07.489041');
INSERT INTO public."Действия по устранению" (id, "id_действия", "id_статуса", "время") VALUES (17, 28, 3, '2025-05-31 09:22:07.489041');


--
-- TOC entry 3527 (class 0 OID 16500)
-- Dependencies: 232
-- Data for Name: Должности; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO public."Должности" (id, "должность") VALUES (1, 'Специалист по ИБ');
INSERT INTO public."Должности" (id, "должность") VALUES (2, 'Системный администратор');
INSERT INTO public."Должности" (id, "должность") VALUES (3, 'Разработчик ПО');


--
-- TOC entry 3533 (class 0 OID 16521)
-- Dependencies: 238
-- Data for Name: Инциденты; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO public."Инциденты" (id, "время_происшествия", "id_типа_угрозы", "id_степени_угрозы", "id_статуса", "id_источника", "id_ответственного", "время_устранения") VALUES (1, '2025-05-30 15:12:39.380654', 1, 1, 1, 1, 1, NULL);
INSERT INTO public."Инциденты" (id, "время_происшествия", "id_типа_угрозы", "id_степени_угрозы", "id_статуса", "id_источника", "id_ответственного", "время_устранения") VALUES (2, '2025-05-30 15:27:39.380654', 2, 2, 1, 1, 2, NULL);
INSERT INTO public."Инциденты" (id, "время_происшествия", "id_типа_угрозы", "id_степени_угрозы", "id_статуса", "id_источника", "id_ответственного", "время_устранения") VALUES (3, '2025-05-30 15:42:39.380654', 3, 3, 1, 1, 3, NULL);
INSERT INTO public."Инциденты" (id, "время_происшествия", "id_типа_угрозы", "id_степени_угрозы", "id_статуса", "id_источника", "id_ответственного", "время_устранения") VALUES (4, '2025-05-31 15:12:39.380654', 4, 4, 1, 2, 4, NULL);
INSERT INTO public."Инциденты" (id, "время_происшествия", "id_типа_угрозы", "id_степени_угрозы", "id_статуса", "id_источника", "id_ответственного", "время_устранения") VALUES (5, '2025-05-31 16:12:39.380654', 5, 1, 1, 2, 1, NULL);
INSERT INTO public."Инциденты" (id, "время_происшествия", "id_типа_угрозы", "id_степени_угрозы", "id_статуса", "id_источника", "id_ответственного", "время_устранения") VALUES (6, '2025-05-31 17:12:39.380654', 6, 2, 1, 2, 2, NULL);
INSERT INTO public."Инциденты" (id, "время_происшествия", "id_типа_угрозы", "id_степени_угрозы", "id_статуса", "id_источника", "id_ответственного", "время_устранения") VALUES (7, '2025-05-31 18:12:39.380654', 7, 3, 1, 2, 3, NULL);
INSERT INTO public."Инциденты" (id, "время_происшествия", "id_типа_угрозы", "id_степени_угрозы", "id_статуса", "id_источника", "id_ответственного", "время_устранения") VALUES (8, '2025-06-01 15:12:39.380654', 1, 1, 1, 3, 4, NULL);
INSERT INTO public."Инциденты" (id, "время_происшествия", "id_типа_угрозы", "id_степени_угрозы", "id_статуса", "id_источника", "id_ответственного", "время_устранения") VALUES (9, '2025-06-01 19:12:39.380654', 2, 2, 1, 4, 1, NULL);
INSERT INTO public."Инциденты" (id, "время_происшествия", "id_типа_угрозы", "id_степени_угрозы", "id_статуса", "id_источника", "id_ответственного", "время_устранения") VALUES (10, '2025-06-02 00:12:39.380654', 3, 3, 1, 5, 2, NULL);
INSERT INTO public."Инциденты" (id, "время_происшествия", "id_типа_угрозы", "id_степени_угрозы", "id_статуса", "id_источника", "id_ответственного", "время_устранения") VALUES (11, '2025-06-02 05:12:39.380654', 4, 4, 1, 6, 3, NULL);
INSERT INTO public."Инциденты" (id, "время_происшествия", "id_типа_угрозы", "id_степени_угрозы", "id_статуса", "id_источника", "id_ответственного", "время_устранения") VALUES (12, '2025-06-02 07:12:39.380654', 5, 1, 1, 7, 4, NULL);
INSERT INTO public."Инциденты" (id, "время_происшествия", "id_типа_угрозы", "id_степени_угрозы", "id_статуса", "id_источника", "id_ответственного", "время_устранения") VALUES (13, '2025-06-02 09:12:39.380654', 6, 2, 1, 3, 1, NULL);
INSERT INTO public."Инциденты" (id, "время_происшествия", "id_типа_угрозы", "id_степени_угрозы", "id_статуса", "id_источника", "id_ответственного", "время_устранения") VALUES (14, '2025-06-02 11:12:39.380654', 7, 3, 1, 4, 2, NULL);
INSERT INTO public."Инциденты" (id, "время_происшествия", "id_типа_угрозы", "id_степени_угрозы", "id_статуса", "id_источника", "id_ответственного", "время_устранения") VALUES (15, '2025-06-02 13:12:39.380654', 1, 4, 1, 5, 3, NULL);
INSERT INTO public."Инциденты" (id, "время_происшествия", "id_типа_угрозы", "id_степени_угрозы", "id_статуса", "id_источника", "id_ответственного", "время_устранения") VALUES (16, '2025-05-24 21:22:07.489041', 1, 2, 5, 1, 2, '2025-05-25 22:22:07.489041');
INSERT INTO public."Инциденты" (id, "время_происшествия", "id_типа_угрозы", "id_степени_угрозы", "id_статуса", "id_источника", "id_ответственного", "время_устранения") VALUES (17, '2025-05-25 21:22:07.489041', 2, 3, 5, 2, 3, '2025-05-26 23:22:07.489041');
INSERT INTO public."Инциденты" (id, "время_происшествия", "id_типа_угрозы", "id_степени_угрозы", "id_статуса", "id_источника", "id_ответственного", "время_устранения") VALUES (18, '2025-05-26 21:22:07.489041', 3, 4, 5, 3, 4, '2025-05-28 00:22:07.489041');
INSERT INTO public."Инциденты" (id, "время_происшествия", "id_типа_угрозы", "id_степени_угрозы", "id_статуса", "id_источника", "id_ответственного", "время_устранения") VALUES (19, '2025-05-27 21:22:07.489041', 4, 1, 5, 4, 1, '2025-05-29 01:22:07.489041');
INSERT INTO public."Инциденты" (id, "время_происшествия", "id_типа_угрозы", "id_степени_угрозы", "id_статуса", "id_источника", "id_ответственного", "время_устранения") VALUES (20, '2025-05-28 21:22:07.489041', 5, 2, 5, 5, 2, '2025-05-30 02:22:07.489041');
INSERT INTO public."Инциденты" (id, "время_происшествия", "id_типа_угрозы", "id_степени_угрозы", "id_статуса", "id_источника", "id_ответственного", "время_устранения") VALUES (21, '2025-05-29 21:22:07.489041', 6, 3, 5, 6, 3, '2025-05-31 03:22:07.489041');
INSERT INTO public."Инциденты" (id, "время_происшествия", "id_типа_угрозы", "id_степени_угрозы", "id_статуса", "id_источника", "id_ответственного", "время_устранения") VALUES (22, '2025-05-30 21:22:07.489041', 7, 4, 5, 7, 4, '2025-06-01 04:22:07.489041');
INSERT INTO public."Инциденты" (id, "время_происшествия", "id_типа_угрозы", "id_степени_угрозы", "id_статуса", "id_источника", "id_ответственного", "время_устранения") VALUES (23, '2025-06-03 02:09:46.368682', 1, 3, 1, 1, 1, NULL);
INSERT INTO public."Инциденты" (id, "время_происшествия", "id_типа_угрозы", "id_степени_угрозы", "id_статуса", "id_источника", "id_ответственного", "время_устранения") VALUES (24, '2025-06-03 02:24:46.368682', 2, 3, 1, 2, 2, NULL);
INSERT INTO public."Инциденты" (id, "время_происшествия", "id_типа_угрозы", "id_степени_угрозы", "id_статуса", "id_источника", "id_ответственного", "время_устранения") VALUES (25, '2025-06-03 02:39:46.368682', 3, 4, 1, 3, 3, NULL);
INSERT INTO public."Инциденты" (id, "время_происшествия", "id_типа_угрозы", "id_степени_угрозы", "id_статуса", "id_источника", "id_ответственного", "время_устранения") VALUES (26, '2025-06-03 02:54:46.368682', 4, 4, 1, 4, 4, NULL);


--
-- TOC entry 3547 (class 0 OID 16589)
-- Dependencies: 252
-- Data for Name: Инциденты_действия; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO public."Инциденты_действия" (id, "id_инцидента", "id_действия") VALUES (1, 1, 6);
INSERT INTO public."Инциденты_действия" (id, "id_инцидента", "id_действия") VALUES (2, 4, 7);
INSERT INTO public."Инциденты_действия" (id, "id_инцидента", "id_действия") VALUES (3, 8, 8);
INSERT INTO public."Инциденты_действия" (id, "id_инцидента", "id_действия") VALUES (4, 2, 9);
INSERT INTO public."Инциденты_действия" (id, "id_инцидента", "id_действия") VALUES (5, 5, 10);
INSERT INTO public."Инциденты_действия" (id, "id_инцидента", "id_действия") VALUES (6, 16, 11);
INSERT INTO public."Инциденты_действия" (id, "id_инцидента", "id_действия") VALUES (7, 17, 12);
INSERT INTO public."Инциденты_действия" (id, "id_инцидента", "id_действия") VALUES (8, 18, 13);
INSERT INTO public."Инциденты_действия" (id, "id_инцидента", "id_действия") VALUES (9, 19, 14);
INSERT INTO public."Инциденты_действия" (id, "id_инцидента", "id_действия") VALUES (10, 20, 15);
INSERT INTO public."Инциденты_действия" (id, "id_инцидента", "id_действия") VALUES (11, 21, 16);
INSERT INTO public."Инциденты_действия" (id, "id_инцидента", "id_действия") VALUES (12, 22, 17);


--
-- TOC entry 3525 (class 0 OID 16493)
-- Dependencies: 230
-- Data for Name: Источник инцидента; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO public."Источник инцидента" (id, "id_типа_источника", "id_источника") VALUES (1, 1, 1);
INSERT INTO public."Источник инцидента" (id, "id_типа_источника", "id_источника") VALUES (2, 1, 2);
INSERT INTO public."Источник инцидента" (id, "id_типа_источника", "id_источника") VALUES (3, 1, 3);
INSERT INTO public."Источник инцидента" (id, "id_типа_источника", "id_источника") VALUES (4, 2, 1);
INSERT INTO public."Источник инцидента" (id, "id_типа_источника", "id_источника") VALUES (5, 2, 2);
INSERT INTO public."Источник инцидента" (id, "id_типа_источника", "id_источника") VALUES (6, 2, 3);
INSERT INTO public."Источник инцидента" (id, "id_типа_источника", "id_источника") VALUES (7, 3, 1);


--
-- TOC entry 3531 (class 0 OID 16514)
-- Dependencies: 236
-- Data for Name: Отделы; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO public."Отделы" (id, "название", "адрес") VALUES (1, 'Отдел информационной безопасности', 'Кабинет 101');
INSERT INTO public."Отделы" (id, "название", "адрес") VALUES (2, 'IT-департамент', 'Кабинет 205');
INSERT INTO public."Отделы" (id, "название", "адрес") VALUES (3, 'Отдел разработки', 'Кабинет 312');


--
-- TOC entry 3523 (class 0 OID 16485)
-- Dependencies: 228
-- Data for Name: Пользователи; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO public."Пользователи" (id, "имя", "электронная_почта", "пароль") VALUES (1, 'Fedor', 'fedor43@gmail.com', '123123123');
INSERT INTO public."Пользователи" (id, "имя", "электронная_почта", "пароль") VALUES (2, 'alex', 'alex@gmail.com', 'qwe');
INSERT INTO public."Пользователи" (id, "имя", "электронная_почта", "пароль") VALUES (3, 'katerina', 'katerina@gmail.com', '123qwe');
INSERT INTO public."Пользователи" (id, "имя", "электронная_почта", "пароль") VALUES (4, 'alex2', 'alex2@gmail.com', 'weqweqwe');


--
-- TOC entry 3521 (class 0 OID 16478)
-- Dependencies: 226
-- Data for Name: Приложения; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO public."Приложения" (id, "название", "описание") VALUES (1, 'Google Chrome', 'Быстрый и безопасный веб-браузер от Google.');
INSERT INTO public."Приложения" (id, "название", "описание") VALUES (2, 'Gmail', 'Сервис электронной почты с мощным поиском и защитой от спама.');
INSERT INTO public."Приложения" (id, "название", "описание") VALUES (3, 'Google Maps', 'Картографический сервис с навигацией, информацией о пробках и панорамами улиц.');
INSERT INTO public."Приложения" (id, "название", "описание") VALUES (4, 'YouTube', 'Видеохостинг для просмотра, загрузки и обмена видеороликами.');
INSERT INTO public."Приложения" (id, "название", "описание") VALUES (5, 'Google Drive', 'Облачное хранилище для файлов с возможностью совместной работы.');


--
-- TOC entry 3543 (class 0 OID 16563)
-- Dependencies: 248
-- Data for Name: Рекомендации; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO public."Рекомендации" (id, "тип_инцидента", "степень_угрозы", "рекомендации") VALUES (6, 1, 1, 'Немедленно изолировать зараженные системы. Запустить полное сканирование антивирусом с последними базами. Восстановить из бэкапа при необходимости. Провести анализ источника заражения и устранить его.');
INSERT INTO public."Рекомендации" (id, "тип_инцидента", "степень_угрозы", "рекомендации") VALUES (7, 1, 2, 'Изолировать затронутые системы. Обновить антивирусные базы и провести полное сканирование. Удалить вредоносное ПО. Проанализировать вектор атаки и применить патчи.');
INSERT INTO public."Рекомендации" (id, "тип_инцидента", "степень_угрозы", "рекомендации") VALUES (8, 1, 3, 'Запустить сканирование на затронутых узлах. Удалить обнаруженное ПО. Уведомить пользователя о рисках. Проверить и установить обновления безопасности ОС и ПО.');
INSERT INTO public."Рекомендации" (id, "тип_инцидента", "степень_угрозы", "рекомендации") VALUES (9, 1, 4, 'Провести сканирование системы антивирусом. Удалить обнаруженное нежелательное ПО. Провести инструктаж пользователя по безопасной работе в сети.');
INSERT INTO public."Рекомендации" (id, "тип_инцидента", "степень_угрозы", "рекомендации") VALUES (10, 2, 1, 'Немедленно заблокировать скомпрометированную учетную запись/доступ. Изолировать затронутую систему. Провести полный аудит безопасности системы и логов. Выявить и устранить уязвимость. Уведомить руководство и ответственных лиц.');
INSERT INTO public."Рекомендации" (id, "тип_инцидента", "степень_угрозы", "рекомендации") VALUES (11, 2, 2, 'Заблокировать доступ/учетную запись. Провести анализ логов для определения масштаба и вектора НСД. Устранить уязвимость. Принудительно сменить пароли затронутых сервисов и учетных записей.');
INSERT INTO public."Рекомендации" (id, "тип_инцидента", "степень_угрозы", "рекомендации") VALUES (12, 2, 3, 'Проверить легитимность зафиксированного доступа. В случае подтверждения НСД, сменить пароли, проверить права доступа. Провести инструктаж пользователя по парольной политике и 2FA.');
INSERT INTO public."Рекомендации" (id, "тип_инцидента", "степень_угрозы", "рекомендации") VALUES (13, 2, 4, 'Проанализировать попытку НСД. Укрепить парольную политику для затронутого сервиса/пользователя. Проверить корректность настроек двухфакторной аутентификации (2FA), если применимо.');
INSERT INTO public."Рекомендации" (id, "тип_инцидента", "степень_угрозы", "рекомендации") VALUES (14, 3, 1, 'Немедленно активировать систему защиты от DDoS-атак. Связаться с интернет-провайдером для фильтрации вредоносного трафика на его стороне. Идентифицировать и блокировать основные источники атаки. Мониторить доступность критически важных сервисов.');
INSERT INTO public."Рекомендации" (id, "тип_инцидента", "степень_угрозы", "рекомендации") VALUES (15, 3, 2, 'Применить правила фильтрации на межсетевом экране/WAF. Временно увеличить ресурсы сервера, если возможно. Анализировать источники и тип атаки для более точной блокировки.');
INSERT INTO public."Рекомендации" (id, "тип_инцидента", "степень_угрозы", "рекомендации") VALUES (16, 3, 3, 'Мониторить нагрузку на сервисы. Определить тип и интенсивность атаки. Применить базовые меры защиты (например, rate limiting, блокировка по геолокации).');
INSERT INTO public."Рекомендации" (id, "тип_инцидента", "степень_угрозы", "рекомендации") VALUES (17, 3, 4, 'Проанализировать логи на предмет подозрительной активности, указывающей на попытку DoS малой интенсивности. Укрепить конфигурацию сервера (например, таймауты соединений, лимиты запросов).');
INSERT INTO public."Рекомендации" (id, "тип_инцидента", "степень_угрозы", "рекомендации") VALUES (18, 4, 1, 'Немедленно остановить процесс утечки данных. Определить объем и тип утекших данных (особенно персональные данные, коммерческая тайна). Изолировать затронутые системы. Уведомить руководство, юридический отдел и, при необходимости, регуляторов. Начать расследование причин.');
INSERT INTO public."Рекомендации" (id, "тип_инцидента", "степень_угрозы", "рекомендации") VALUES (19, 4, 2, 'Принять меры по остановке утечки. Провести детальный анализ инцидента. Определить затронутые данные и системы. Уведомить пользователей, чьи данные могли быть скомпрометированы, если это необходимо. Устранить причину утечки.');
INSERT INTO public."Рекомендации" (id, "тип_инцидента", "степень_угрозы", "рекомендации") VALUES (20, 4, 3, 'Расследовать инцидент для определения источника и типа данных. Принять корректирующие меры для предотвращения повторения. Пересмотреть политики доступа к данным и DLP-системы.');
INSERT INTO public."Рекомендации" (id, "тип_инцидента", "степень_угрозы", "рекомендации") VALUES (21, 4, 4, 'Проанализировать инцидент. Убедиться в отсутствии утечки критичных или конфиденциальных данных. Укрепить меры технической защиты данных (шифрование, контроль доступа).');
INSERT INTO public."Рекомендации" (id, "тип_инцидента", "степень_угрозы", "рекомендации") VALUES (22, 5, 1, 'Если учетные данные скомпрометированы в результате фишинга: немедленно сменить пароли на всех затронутых и связанных сервисах, проверить системы на НСД и вредоносное ПО. Заблокировать фишинговый сайт/почтовый адрес. Провести массовое уведомление всех сотрудников об активной фишинговой угрозе.');
INSERT INTO public."Рекомендации" (id, "тип_инцидента", "степень_угрозы", "рекомендации") VALUES (23, 5, 2, 'Если пользователь перешел по фишинговой ссылке или открыл вредоносное вложение: проверить систему пользователя на наличие вредоносного ПО. Обязательно сменить пароли. Провести дополнительный инструктаж. Заблокировать источник фишинга на уровне почтового шлюза/прокси.');
INSERT INTO public."Рекомендации" (id, "тип_инцидента", "степень_угрозы", "рекомендации") VALUES (24, 5, 3, 'Идентифицировать фишинговое письмо. Предупредить целевых пользователей или отдел. Заблокировать отправителя/фишинговый сайт. По возможности удалить письма из почтовых ящиков сотрудников.');
INSERT INTO public."Рекомендации" (id, "тип_инцидента", "степень_угрозы", "рекомендации") VALUES (25, 5, 4, 'Проанализировать полученное фишинговое письмо. Добавить индикаторы компрометации (IoC) в спам-фильтры и системы защиты. Провести плановое обучение сотрудников по распознаванию фишинга.');
INSERT INTO public."Рекомендации" (id, "тип_инцидента", "степень_угрозы", "рекомендации") VALUES (26, 6, 1, 'Немедленно пресечь нарушение, если оно имеет продолжающийся характер и несет критические риски (например, несанкционированное использование привилегированных учетных записей). Оценить возможный ущерб. Провести служебное расследование. Уведомить руководство. Пересмотреть и принудительно усилить исполнение политики.');
INSERT INTO public."Рекомендации" (id, "тип_инцидента", "степень_угрозы", "рекомендации") VALUES (27, 6, 2, 'Пресечь нарушение. Расследовать инцидент для выяснения причин и мотивов. Применить дисциплинарные меры в соответствии с внутренними регламентами, если необходимо. Провести дополнительный инструктаж для вовлеченных лиц или отдела.');
INSERT INTO public."Рекомендации" (id, "тип_инцидента", "степень_угрозы", "рекомендации") VALUES (28, 6, 3, 'Зафиксировать факт нарушения политики. Провести беседу с сотрудником, допустившим нарушение. Уточнить понимание требований политики. Документировать инцидент для последующего анализа тенденций.');
INSERT INTO public."Рекомендации" (id, "тип_инцидента", "степень_угрозы", "рекомендации") VALUES (29, 6, 4, 'Указать сотруднику на допущенное нарушение. Напомнить о действующих требованиях политики безопасности. Убедиться в отсутствии системных причин, способствующих нарушению (например, неудобные или невыполнимые требования).');
INSERT INTO public."Рекомендации" (id, "тип_инцидента", "степень_угрозы", "рекомендации") VALUES (30, 7, 1, 'Немедленно изолировать скомпрометированные сегменты сети или системы. Определить точку входа и масштаб вторжения (lateral movement). Провести полное удаление следов присутствия злоумышленника. Восстановить затронутые системы из доверенных резервных копий. Провести комплексный аудит безопасности всей инфраструктуры.');
INSERT INTO public."Рекомендации" (id, "тип_инцидента", "степень_угрозы", "рекомендации") VALUES (31, 7, 2, 'Изолировать затронутые системы. Провести анализ логов и сетевого трафика для определения вектора атаки и скомпрометированных активов. Удалить вредоносные компоненты и бэкдоры. Устранить уязвимость, использованную для первоначального проникновения. Сменить все потенциально скомпрометированные учетные данные.');
INSERT INTO public."Рекомендации" (id, "тип_инцидента", "степень_угрозы", "рекомендации") VALUES (32, 7, 3, 'Проанализировать признаки возможного вторжения (например, аномальная активность в логах, срабатывания IDS/IPS). Провести углубленное сканирование на наличие вредоносного ПО и следов несанкционированной активности. Укрепить защиту периметра и ключевых узлов.');
INSERT INTO public."Рекомендации" (id, "тип_инцидента", "степень_угрозы", "рекомендации") VALUES (33, 7, 4, 'Расследовать подозрительную активность, которая может указывать на ранние этапы попытки вторжения (например, сканирование, подбор паролей). Проверить актуальность систем защиты, обновлений ОС и прикладного ПО. Усилить мониторинг подозрительных узлов.');


--
-- TOC entry 3519 (class 0 OID 16471)
-- Dependencies: 224
-- Data for Name: Системы; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO public."Системы" (id, "описание", "название") VALUES (1, 'Серверная операционная система от Microsoft для корпоративных сетей.', 'Windows Server');
INSERT INTO public."Системы" (id, "описание", "название") VALUES (2, 'Популярный дистрибутив Linux с долгосрочной поддержкой.', 'Ubuntu Linux');
INSERT INTO public."Системы" (id, "описание", "название") VALUES (3, 'Служба каталогов Microsoft для управления пользователями и ресурсами в домене.', 'Active Directory');
INSERT INTO public."Системы" (id, "описание", "название") VALUES (4, 'Платформа виртуализации для создания и управления виртуальными машинами.', 'VMware vSphere');
INSERT INTO public."Системы" (id, "описание", "название") VALUES (5, 'Локальная и глобальная вычислительная сеть организации.', 'LAN/WAN');


--
-- TOC entry 3529 (class 0 OID 16507)
-- Dependencies: 234
-- Data for Name: Сотрудники; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO public."Сотрудники" (id, "имя", "фамилия", "отчество", "id_должности", "id_отдела", "адрес_почты") VALUES (1, 'Фёдор', 'Мокрецов', 'Михайлович', 1, 1, 'f.mok@gmail.com');
INSERT INTO public."Сотрудники" (id, "имя", "фамилия", "отчество", "id_должности", "id_отдела", "адрес_почты") VALUES (2, 'Александр', 'Лужнецкий', 'Александрович', 2, 2, 'a.luz@gmail.com');
INSERT INTO public."Сотрудники" (id, "имя", "фамилия", "отчество", "id_должности", "id_отдела", "адрес_почты") VALUES (3, 'Екатерина', 'Мартынова', 'Дмитреевна', 3, 3, 'e.mar@gmail.com');
INSERT INTO public."Сотрудники" (id, "имя", "фамилия", "отчество", "id_должности", "id_отдела", "адрес_почты") VALUES (4, 'Александр', 'Неверов', 'Сергеевич', 1, 1, 'a.nev@gmail.com');


--
-- TOC entry 3541 (class 0 OID 16556)
-- Dependencies: 246
-- Data for Name: Статус действия; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO public."Статус действия" (id, "статус") VALUES (1, 'Запланировано');
INSERT INTO public."Статус действия" (id, "статус") VALUES (2, 'В процессе');
INSERT INTO public."Статус действия" (id, "статус") VALUES (3, 'Выполнено');
INSERT INTO public."Статус действия" (id, "статус") VALUES (4, 'Отложено');
INSERT INTO public."Статус действия" (id, "статус") VALUES (5, 'Отменено');
INSERT INTO public."Статус действия" (id, "статус") VALUES (6, 'На проверке');


--
-- TOC entry 3513 (class 0 OID 16448)
-- Dependencies: 218
-- Data for Name: Статус уязвимости; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO public."Статус уязвимости" (id, "статус") VALUES (1, 'Новая');
INSERT INTO public."Статус уязвимости" (id, "статус") VALUES (2, 'Подтверждена');
INSERT INTO public."Статус уязвимости" (id, "статус") VALUES (3, 'В работе');
INSERT INTO public."Статус уязвимости" (id, "статус") VALUES (4, 'Исправлена');
INSERT INTO public."Статус уязвимости" (id, "статус") VALUES (5, 'Закрыта');
INSERT INTO public."Статус уязвимости" (id, "статус") VALUES (6, 'Отклонена');
INSERT INTO public."Статус уязвимости" (id, "статус") VALUES (7, 'Принятый риск');


--
-- TOC entry 3535 (class 0 OID 16528)
-- Dependencies: 240
-- Data for Name: Статусы; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO public."Статусы" (id, "Статус") VALUES (1, 'Новый');
INSERT INTO public."Статусы" (id, "Статус") VALUES (2, 'Назначен');
INSERT INTO public."Статусы" (id, "Статус") VALUES (3, 'В работе');
INSERT INTO public."Статусы" (id, "Статус") VALUES (4, 'Устранен');
INSERT INTO public."Статусы" (id, "Статус") VALUES (5, 'Закрыт');
INSERT INTO public."Статусы" (id, "Статус") VALUES (6, 'Отложен');
INSERT INTO public."Статусы" (id, "Статус") VALUES (7, 'Ложный вызов');


--
-- TOC entry 3539 (class 0 OID 16542)
-- Dependencies: 244
-- Data for Name: Степени угроз; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO public."Степени угроз" (id, "уровень") VALUES (1, 'Критический');
INSERT INTO public."Степени угроз" (id, "уровень") VALUES (2, 'Высокий');
INSERT INTO public."Степени угроз" (id, "уровень") VALUES (3, 'Средний');
INSERT INTO public."Степени угроз" (id, "уровень") VALUES (4, 'Низкий');


--
-- TOC entry 3517 (class 0 OID 16462)
-- Dependencies: 222
-- Data for Name: Тип источника; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO public."Тип источника" (id, "тип источника") VALUES (1, 'Система');
INSERT INTO public."Тип источника" (id, "тип источника") VALUES (2, 'Приложение');
INSERT INTO public."Тип источника" (id, "тип источника") VALUES (3, 'Пользователь');


--
-- TOC entry 3537 (class 0 OID 16535)
-- Dependencies: 242
-- Data for Name: Типы инцидентов; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO public."Типы инцидентов" (id, "тип") VALUES (1, 'Вредоносное ПО');
INSERT INTO public."Типы инцидентов" (id, "тип") VALUES (2, 'НСД');
INSERT INTO public."Типы инцидентов" (id, "тип") VALUES (3, 'DoS/DDoS атака');
INSERT INTO public."Типы инцидентов" (id, "тип") VALUES (4, 'Утечка данных');
INSERT INTO public."Типы инцидентов" (id, "тип") VALUES (5, 'Фишинг');
INSERT INTO public."Типы инцидентов" (id, "тип") VALUES (6, 'Нарушение политики');
INSERT INTO public."Типы инцидентов" (id, "тип") VALUES (7, 'Вторжение');


--
-- TOC entry 3515 (class 0 OID 16455)
-- Dependencies: 220
-- Data for Name: Уязвимости; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO public."Уязвимости" (id, "Название", "id_статуса", "id_степени_угрозы", "id_источника_уязвимости", "Описание") VALUES (1, 'Conf. AppServ01', 1, 1, 1, 'Обнаружены множественные инциденты. проблемы с конфигурацией безопасности источника ID 1.');
INSERT INTO public."Уязвимости" (id, "Название", "id_статуса", "id_степени_угрозы", "id_источника_уязвимости", "Описание") VALUES (2, 'OS Sec WorkstationX', 1, 2, 2, 'Частые инциденты. Системная уязвимость настроек операционной системы.');
INSERT INTO public."Уязвимости" (id, "Название", "id_статуса", "id_степени_угрозы", "id_источника_уязвимости", "Описание") VALUES (3, 'WeakPass CRM-Lite', 1, 3, 3, 'Повторяющиеся инциденты могут быть вызваны использованием слабых или стандартных паролей.');
INSERT INTO public."Уязвимости" (id, "Название", "id_статуса", "id_степени_угрозы", "id_источника_уязвимости", "Описание") VALUES (4, 'NoPatch DB-Main', 1, 2, 4, 'Источник ID 4 демонстрирует признаки устаревшего ПО, что подтверждается несколькими инцидентами.');
INSERT INTO public."Уязвимости" (id, "Название", "id_статуса", "id_степени_угрозы", "id_источника_уязвимости", "Описание") VALUES (5, 'OpenRDP UserPC77', 1, 4, 5, 'Повторяющиеся инциденты. Вероятно, из-за излишне открытых сетевых портов.');


--
-- TOC entry 3571 (class 0 OID 0)
-- Dependencies: 249
-- Name: Действия по устранению_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Действия по устранению_id_seq"', 17, true);


--
-- TOC entry 3572 (class 0 OID 0)
-- Dependencies: 231
-- Name: Должности_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Должности_id_seq"', 3, true);


--
-- TOC entry 3573 (class 0 OID 0)
-- Dependencies: 237
-- Name: Инциденты_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Инциденты_id_seq"', 26, true);


--
-- TOC entry 3574 (class 0 OID 0)
-- Dependencies: 251
-- Name: Инциденты_действия_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Инциденты_действия_id_seq"', 12, true);


--
-- TOC entry 3575 (class 0 OID 0)
-- Dependencies: 229
-- Name: Источник инцидента_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Источник инцидента_id_seq"', 7, true);


--
-- TOC entry 3576 (class 0 OID 0)
-- Dependencies: 235
-- Name: Отделы_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Отделы_id_seq"', 3, true);


--
-- TOC entry 3577 (class 0 OID 0)
-- Dependencies: 227
-- Name: Пользователи_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Пользователи_id_seq"', 4, true);


--
-- TOC entry 3578 (class 0 OID 0)
-- Dependencies: 225
-- Name: Приложения_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Приложения_id_seq"', 5, true);


--
-- TOC entry 3579 (class 0 OID 0)
-- Dependencies: 247
-- Name: Рекомендации_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Рекомендации_id_seq"', 33, true);


--
-- TOC entry 3580 (class 0 OID 0)
-- Dependencies: 223
-- Name: Системы_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Системы_id_seq"', 5, true);


--
-- TOC entry 3581 (class 0 OID 0)
-- Dependencies: 233
-- Name: Сотрудники_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Сотрудники_id_seq"', 4, true);


--
-- TOC entry 3582 (class 0 OID 0)
-- Dependencies: 245
-- Name: Статус действия_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Статус действия_id_seq"', 6, true);


--
-- TOC entry 3583 (class 0 OID 0)
-- Dependencies: 217
-- Name: Статус уязвимости_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Статус уязвимости_id_seq"', 7, true);


--
-- TOC entry 3584 (class 0 OID 0)
-- Dependencies: 239
-- Name: Статусы_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Статусы_id_seq"', 7, true);


--
-- TOC entry 3585 (class 0 OID 0)
-- Dependencies: 243
-- Name: Степени угроз_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Степени угроз_id_seq"', 4, true);


--
-- TOC entry 3586 (class 0 OID 0)
-- Dependencies: 221
-- Name: Тип источника_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Тип источника_id_seq"', 3, true);


--
-- TOC entry 3587 (class 0 OID 0)
-- Dependencies: 241
-- Name: Типы инцидентов_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Типы инцидентов_id_seq"', 7, true);


--
-- TOC entry 3588 (class 0 OID 0)
-- Dependencies: 219
-- Name: Уязвимости_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Уязвимости_id_seq"', 5, true);


--
-- TOC entry 3349 (class 2606 OID 16577)
-- Name: Действия по устранению Действия по устранению_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Действия по устранению"
    ADD CONSTRAINT "Действия по устранению_pkey" PRIMARY KEY (id);


--
-- TOC entry 3331 (class 2606 OID 16505)
-- Name: Должности Должности_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Должности"
    ADD CONSTRAINT "Должности_pkey" PRIMARY KEY (id);


--
-- TOC entry 3337 (class 2606 OID 16526)
-- Name: Инциденты Инциденты_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Инциденты"
    ADD CONSTRAINT "Инциденты_pkey" PRIMARY KEY (id);


--
-- TOC entry 3351 (class 2606 OID 16594)
-- Name: Инциденты_действия Инциденты_действия_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Инциденты_действия"
    ADD CONSTRAINT "Инциденты_действия_pkey" PRIMARY KEY (id);


--
-- TOC entry 3329 (class 2606 OID 16498)
-- Name: Источник инцидента Источник инцидента_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Источник инцидента"
    ADD CONSTRAINT "Источник инцидента_pkey" PRIMARY KEY (id);


--
-- TOC entry 3335 (class 2606 OID 16519)
-- Name: Отделы Отделы_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Отделы"
    ADD CONSTRAINT "Отделы_pkey" PRIMARY KEY (id);


--
-- TOC entry 3327 (class 2606 OID 16490)
-- Name: Пользователи Пользователи_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Пользователи"
    ADD CONSTRAINT "Пользователи_pkey" PRIMARY KEY (id);


--
-- TOC entry 3325 (class 2606 OID 16483)
-- Name: Приложения Приложения_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Приложения"
    ADD CONSTRAINT "Приложения_pkey" PRIMARY KEY (id);


--
-- TOC entry 3347 (class 2606 OID 16570)
-- Name: Рекомендации Рекомендации_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Рекомендации"
    ADD CONSTRAINT "Рекомендации_pkey" PRIMARY KEY (id);


--
-- TOC entry 3323 (class 2606 OID 16476)
-- Name: Системы Системы_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Системы"
    ADD CONSTRAINT "Системы_pkey" PRIMARY KEY (id);


--
-- TOC entry 3333 (class 2606 OID 16512)
-- Name: Сотрудники Сотрудники_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Сотрудники"
    ADD CONSTRAINT "Сотрудники_pkey" PRIMARY KEY (id);


--
-- TOC entry 3345 (class 2606 OID 16561)
-- Name: Статус действия Статус действия_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Статус действия"
    ADD CONSTRAINT "Статус действия_pkey" PRIMARY KEY (id);


--
-- TOC entry 3317 (class 2606 OID 16453)
-- Name: Статус уязвимости Статус уязвимости_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Статус уязвимости"
    ADD CONSTRAINT "Статус уязвимости_pkey" PRIMARY KEY (id);


--
-- TOC entry 3339 (class 2606 OID 16533)
-- Name: Статусы Статусы_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Статусы"
    ADD CONSTRAINT "Статусы_pkey" PRIMARY KEY (id);


--
-- TOC entry 3343 (class 2606 OID 16547)
-- Name: Степени угроз Степени угроз_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Степени угроз"
    ADD CONSTRAINT "Степени угроз_pkey" PRIMARY KEY (id);


--
-- TOC entry 3321 (class 2606 OID 16469)
-- Name: Тип источника Тип источника_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Тип источника"
    ADD CONSTRAINT "Тип источника_pkey" PRIMARY KEY (id);


--
-- TOC entry 3341 (class 2606 OID 16540)
-- Name: Типы инцидентов Типы инцидентов_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Типы инцидентов"
    ADD CONSTRAINT "Типы инцидентов_pkey" PRIMARY KEY (id);


--
-- TOC entry 3319 (class 2606 OID 16460)
-- Name: Уязвимости Уязвимости_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Уязвимости"
    ADD CONSTRAINT "Уязвимости_pkey" PRIMARY KEY (id);


--
-- TOC entry 3365 (class 2606 OID 16600)
-- Name: Инциденты_действия действия; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Инциденты_действия"
    ADD CONSTRAINT "действия" FOREIGN KEY ("id_действия") REFERENCES public."Действия по устранению"(id) NOT VALID;


--
-- TOC entry 3356 (class 2606 OID 16578)
-- Name: Сотрудники должность сотрудника; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Сотрудники"
    ADD CONSTRAINT "должность сотрудника" FOREIGN KEY ("id_должности") REFERENCES public."Должности"(id) NOT VALID;


--
-- TOC entry 3366 (class 2606 OID 16595)
-- Name: Инциденты_действия инциденты; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Инциденты_действия"
    ADD CONSTRAINT "инциденты" FOREIGN KEY ("id_инцидента") REFERENCES public."Инциденты"(id) NOT VALID;


--
-- TOC entry 3358 (class 2606 OID 16650)
-- Name: Инциденты источник инцидента; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Инциденты"
    ADD CONSTRAINT "источник инцидента" FOREIGN KEY ("id_источника") REFERENCES public."Источник инцидента"(id) NOT VALID;


--
-- TOC entry 3352 (class 2606 OID 16660)
-- Name: Уязвимости источник уязвимости; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Уязвимости"
    ADD CONSTRAINT "источник уязвимости" FOREIGN KEY ("id_источника_уязвимости") REFERENCES public."Источник инцидента"(id) NOT VALID;


--
-- TOC entry 3357 (class 2606 OID 16583)
-- Name: Сотрудники отдел работы сотрудника; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Сотрудники"
    ADD CONSTRAINT "отдел работы сотрудника" FOREIGN KEY ("id_отдела") REFERENCES public."Отделы"(id) NOT VALID;


--
-- TOC entry 3363 (class 2606 OID 16605)
-- Name: Действия по устранению рекомендации_действия; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Действия по устранению"
    ADD CONSTRAINT "рекомендации_действия" FOREIGN KEY ("id_действия") REFERENCES public."Рекомендации"(id) NOT VALID;


--
-- TOC entry 3359 (class 2606 OID 16645)
-- Name: Инциденты сотрудник расследующий; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Инциденты"
    ADD CONSTRAINT "сотрудник расследующий" FOREIGN KEY ("id_ответственного") REFERENCES public."Сотрудники"(id) NOT VALID;


--
-- TOC entry 3360 (class 2606 OID 16640)
-- Name: Инциденты статус инцидента; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Инциденты"
    ADD CONSTRAINT "статус инцидента" FOREIGN KEY ("id_статуса") REFERENCES public."Статусы"(id) NOT VALID;


--
-- TOC entry 3353 (class 2606 OID 16615)
-- Name: Уязвимости статус уязвимости; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Уязвимости"
    ADD CONSTRAINT "статус уязвимости" FOREIGN KEY ("id_статуса") REFERENCES public."Статус уязвимости"(id) NOT VALID;


--
-- TOC entry 3364 (class 2606 OID 16610)
-- Name: Действия по устранению статус_действие; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Действия по устранению"
    ADD CONSTRAINT "статус_действие" FOREIGN KEY ("id_статуса") REFERENCES public."Статус действия"(id) NOT VALID;


--
-- TOC entry 3361 (class 2606 OID 16630)
-- Name: Инциденты степень угрозы инцидента; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Инциденты"
    ADD CONSTRAINT "степень угрозы инцидента" FOREIGN KEY ("id_степени_угрозы") REFERENCES public."Степени угроз"(id) NOT VALID;


--
-- TOC entry 3354 (class 2606 OID 16620)
-- Name: Уязвимости степень угрозы уязвимости; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Уязвимости"
    ADD CONSTRAINT "степень угрозы уязвимости" FOREIGN KEY ("id_степени_угрозы") REFERENCES public."Степени угроз"(id) NOT VALID;


--
-- TOC entry 3362 (class 2606 OID 16635)
-- Name: Инциденты тип инцидента; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Инциденты"
    ADD CONSTRAINT "тип инцидента" FOREIGN KEY ("id_типа_угрозы") REFERENCES public."Типы инцидентов"(id) NOT VALID;


--
-- TOC entry 3355 (class 2606 OID 16655)
-- Name: Источник инцидента тип источника; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Источник инцидента"
    ADD CONSTRAINT "тип источника" FOREIGN KEY ("id_типа_источника") REFERENCES public."Тип источника"(id) NOT VALID;


-- Completed on 2025-06-04 08:14:01 UTC

--
-- PostgreSQL database dump complete
--


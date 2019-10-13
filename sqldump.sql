--
-- PostgreSQL database dump
--

-- Dumped from database version 10.10 (Ubuntu 10.10-1.pgdg16.04+1)
-- Dumped by pg_dump version 10.10 (Ubuntu 10.10-1.pgdg16.04+1)

-- Started on 2019-10-13 00:48:28 CEST

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

--
-- TOC entry 1 (class 3079 OID 13009)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 3113 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 236 (class 1259 OID 24808)
-- Name: blog; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.blog (
    id integer NOT NULL,
    title name NOT NULL,
    text text NOT NULL,
    user_id integer NOT NULL,
    published timestamp without time zone NOT NULL,
    edited timestamp without time zone,
    visable numeric NOT NULL
);


--
-- TOC entry 235 (class 1259 OID 24806)
-- Name: blog_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.blog_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3114 (class 0 OID 0)
-- Dependencies: 235
-- Name: blog_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.blog_id_seq OWNED BY public.blog.id;


--
-- TOC entry 199 (class 1259 OID 16399)
-- Name: content; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.content (
    id integer NOT NULL,
    name name,
    visable smallint NOT NULL,
    number integer NOT NULL,
    published timestamp(4) with time zone NOT NULL,
    content_folder_id integer NOT NULL,
    content_type_id integer NOT NULL,
    user_account_id integer NOT NULL
);


--
-- TOC entry 198 (class 1259 OID 16397)
-- Name: chapter_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.chapter_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3115 (class 0 OID 0)
-- Dependencies: 198
-- Name: chapter_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.chapter_id_seq OWNED BY public.content.id;


--
-- TOC entry 205 (class 1259 OID 16430)
-- Name: content_folder_genre; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.content_folder_genre (
    id integer NOT NULL,
    content_folder_id integer NOT NULL,
    genre_id integer NOT NULL
);


--
-- TOC entry 204 (class 1259 OID 16428)
-- Name: comic_ganre_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.comic_ganre_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3116 (class 0 OID 0)
-- Dependencies: 204
-- Name: comic_ganre_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.comic_ganre_id_seq OWNED BY public.content_folder_genre.id;


--
-- TOC entry 197 (class 1259 OID 16388)
-- Name: content_folder; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.content_folder (
    id integer NOT NULL,
    name name NOT NULL,
    author name,
    description text,
    year smallint,
    content_folder_status_id smallint NOT NULL,
    visable smallint,
    alter_name name,
    content_folder_type_id smallint,
    published timestamp with time zone NOT NULL,
    cover text
);


--
-- TOC entry 196 (class 1259 OID 16386)
-- Name: comic_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.comic_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3117 (class 0 OID 0)
-- Dependencies: 196
-- Name: comic_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.comic_id_seq OWNED BY public.content_folder.id;


--
-- TOC entry 228 (class 1259 OID 16570)
-- Name: comment; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.comment (
    id integer NOT NULL,
    user_account_id integer NOT NULL,
    published timestamp(4) with time zone NOT NULL,
    edited timestamp(4) with time zone,
    parent_id integer NOT NULL,
    text text NOT NULL,
    parent_type integer NOT NULL
);


--
-- TOC entry 230 (class 1259 OID 24762)
-- Name: comment_reply; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.comment_reply (
    id integer NOT NULL,
    user_account_id integer NOT NULL,
    published timestamp without time zone NOT NULL,
    edited timestamp without time zone,
    comment_id integer NOT NULL,
    text text NOT NULL
);


--
-- TOC entry 229 (class 1259 OID 24760)
-- Name: comment_reply_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.comment_reply_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3118 (class 0 OID 0)
-- Dependencies: 229
-- Name: comment_reply_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.comment_reply_id_seq OWNED BY public.comment_reply.id;


--
-- TOC entry 227 (class 1259 OID 16568)
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.comments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3119 (class 0 OID 0)
-- Dependencies: 227
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.comments_id_seq OWNED BY public.comment.id;


--
-- TOC entry 226 (class 1259 OID 16562)
-- Name: content_folder_counter; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.content_folder_counter (
    id integer NOT NULL,
    published timestamp(4) without time zone NOT NULL,
    content_folder_id integer NOT NULL,
    user_account_id integer NOT NULL
);


--
-- TOC entry 225 (class 1259 OID 16560)
-- Name: content_folder_calls_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.content_folder_calls_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3120 (class 0 OID 0)
-- Dependencies: 225
-- Name: content_folder_calls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.content_folder_calls_id_seq OWNED BY public.content_folder_counter.id;


--
-- TOC entry 213 (class 1259 OID 16462)
-- Name: content_folder_status; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.content_folder_status (
    id integer NOT NULL,
    name name
);


--
-- TOC entry 211 (class 1259 OID 16454)
-- Name: content_folder_type; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.content_folder_type (
    id integer NOT NULL,
    name name NOT NULL
);


--
-- TOC entry 210 (class 1259 OID 16452)
-- Name: content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3121 (class 0 OID 0)
-- Dependencies: 210
-- Name: content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.content_type_id_seq OWNED BY public.content_folder_type.id;


--
-- TOC entry 203 (class 1259 OID 16422)
-- Name: genre; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.genre (
    id integer NOT NULL,
    name name NOT NULL
);


--
-- TOC entry 202 (class 1259 OID 16420)
-- Name: genre_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.genre_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3122 (class 0 OID 0)
-- Dependencies: 202
-- Name: genre_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.genre_id_seq OWNED BY public.genre.id;


--
-- TOC entry 201 (class 1259 OID 16411)
-- Name: page; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.page (
    id integer NOT NULL,
    chapter_id integer NOT NULL,
    url text NOT NULL,
    number integer NOT NULL,
    cloud_id name NOT NULL
);


--
-- TOC entry 200 (class 1259 OID 16409)
-- Name: page_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.page_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3123 (class 0 OID 0)
-- Dependencies: 200
-- Name: page_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.page_id_seq OWNED BY public.page.id;


--
-- TOC entry 215 (class 1259 OID 16468)
-- Name: rating; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.rating (
    id integer NOT NULL,
    user_account_id integer NOT NULL,
    content_folder_id integer NOT NULL,
    value boolean NOT NULL,
    published timestamp with time zone NOT NULL
);


--
-- TOC entry 214 (class 1259 OID 16466)
-- Name: rating_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.rating_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3124 (class 0 OID 0)
-- Dependencies: 214
-- Name: rating_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.rating_id_seq OWNED BY public.rating.id;


--
-- TOC entry 207 (class 1259 OID 16438)
-- Name: relation; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.relation (
    id integer NOT NULL,
    comic_id_from integer NOT NULL,
    comic_id_to integer NOT NULL,
    relation_type_id integer NOT NULL
);


--
-- TOC entry 206 (class 1259 OID 16436)
-- Name: relation_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.relation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3125 (class 0 OID 0)
-- Dependencies: 206
-- Name: relation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.relation_id_seq OWNED BY public.relation.id;


--
-- TOC entry 209 (class 1259 OID 16446)
-- Name: relation_type; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.relation_type (
    id integer NOT NULL,
    name name NOT NULL
);


--
-- TOC entry 208 (class 1259 OID 16444)
-- Name: relation_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.relation_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3126 (class 0 OID 0)
-- Dependencies: 208
-- Name: relation_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.relation_type_id_seq OWNED BY public.relation_type.id;


--
-- TOC entry 212 (class 1259 OID 16460)
-- Name: status_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3127 (class 0 OID 0)
-- Dependencies: 212
-- Name: status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.status_id_seq OWNED BY public.content_folder_status.id;


--
-- TOC entry 217 (class 1259 OID 16476)
-- Name: user_account; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_account (
    id integer NOT NULL,
    user_role_id integer NOT NULL,
    published timestamp with time zone NOT NULL,
    email name NOT NULL,
    profile_pic text DEFAULT 'https://res.cloudinary.com/baka/image/upload/v1535124069/profile/dummy.png'::text,
    birth date NOT NULL
);


--
-- TOC entry 216 (class 1259 OID 16474)
-- Name: user_account_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_account_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3128 (class 0 OID 0)
-- Dependencies: 216
-- Name: user_account_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_account_id_seq OWNED BY public.user_account.id;


--
-- TOC entry 219 (class 1259 OID 16484)
-- Name: user_login; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_login (
    id integer NOT NULL,
    username name NOT NULL,
    password_salt name NOT NULL,
    password_hash text NOT NULL,
    hash_algorythmus name NOT NULL,
    user_account_id integer NOT NULL
);


--
-- TOC entry 218 (class 1259 OID 16482)
-- Name: user_login_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_login_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3129 (class 0 OID 0)
-- Dependencies: 218
-- Name: user_login_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_login_id_seq OWNED BY public.user_login.id;


--
-- TOC entry 234 (class 1259 OID 24795)
-- Name: user_read_content; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_read_content (
    id integer NOT NULL,
    content_folder_id integer NOT NULL,
    content_id integer NOT NULL,
    read_status name NOT NULL,
    page_number integer,
    published timestamp without time zone NOT NULL,
    user_account_id integer NOT NULL,
    edited timestamp without time zone
);


--
-- TOC entry 232 (class 1259 OID 24787)
-- Name: user_read_content_folder; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_read_content_folder (
    id integer NOT NULL,
    user_account_id integer NOT NULL,
    content_folder_id integer NOT NULL,
    read_status name NOT NULL,
    published timestamp without time zone NOT NULL,
    edited timestamp without time zone
);


--
-- TOC entry 231 (class 1259 OID 24785)
-- Name: user_read_content_folder_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_read_content_folder_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3130 (class 0 OID 0)
-- Dependencies: 231
-- Name: user_read_content_folder_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_read_content_folder_id_seq OWNED BY public.user_read_content_folder.id;


--
-- TOC entry 233 (class 1259 OID 24793)
-- Name: user_read_content_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_read_content_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3131 (class 0 OID 0)
-- Dependencies: 233
-- Name: user_read_content_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_read_content_id_seq OWNED BY public.user_read_content.id;


--
-- TOC entry 221 (class 1259 OID 16507)
-- Name: user_role; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_role (
    id integer NOT NULL,
    name name NOT NULL,
    visable_id numeric
);


--
-- TOC entry 220 (class 1259 OID 16505)
-- Name: user_role_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3132 (class 0 OID 0)
-- Dependencies: 220
-- Name: user_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_role_id_seq OWNED BY public.user_role.id;


--
-- TOC entry 224 (class 1259 OID 16539)
-- Name: visable; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.visable (
    id integer NOT NULL,
    name name NOT NULL
);


--
-- TOC entry 223 (class 1259 OID 16537)
-- Name: visable_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.visable_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3133 (class 0 OID 0)
-- Dependencies: 223
-- Name: visable_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.visable_id_seq OWNED BY public.visable.id;


--
-- TOC entry 222 (class 1259 OID 16523)
-- Name: watchlist; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.watchlist (
    user_account_id integer NOT NULL,
    content_folder_id integer NOT NULL,
    published timestamp without time zone NOT NULL
);


--
-- TOC entry 2901 (class 2604 OID 24811)
-- Name: blog id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blog ALTER COLUMN id SET DEFAULT nextval('public.blog_id_seq'::regclass);


--
-- TOC entry 2897 (class 2604 OID 16573)
-- Name: comment id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comment ALTER COLUMN id SET DEFAULT nextval('public.comments_id_seq'::regclass);


--
-- TOC entry 2898 (class 2604 OID 24765)
-- Name: comment_reply id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comment_reply ALTER COLUMN id SET DEFAULT nextval('public.comment_reply_id_seq'::regclass);


--
-- TOC entry 2882 (class 2604 OID 16402)
-- Name: content id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.content ALTER COLUMN id SET DEFAULT nextval('public.chapter_id_seq'::regclass);


--
-- TOC entry 2881 (class 2604 OID 16391)
-- Name: content_folder id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.content_folder ALTER COLUMN id SET DEFAULT nextval('public.comic_id_seq'::regclass);


--
-- TOC entry 2896 (class 2604 OID 16565)
-- Name: content_folder_counter id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.content_folder_counter ALTER COLUMN id SET DEFAULT nextval('public.content_folder_calls_id_seq'::regclass);


--
-- TOC entry 2885 (class 2604 OID 16433)
-- Name: content_folder_genre id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.content_folder_genre ALTER COLUMN id SET DEFAULT nextval('public.comic_ganre_id_seq'::regclass);


--
-- TOC entry 2889 (class 2604 OID 16465)
-- Name: content_folder_status id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.content_folder_status ALTER COLUMN id SET DEFAULT nextval('public.status_id_seq'::regclass);


--
-- TOC entry 2888 (class 2604 OID 16457)
-- Name: content_folder_type id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.content_folder_type ALTER COLUMN id SET DEFAULT nextval('public.content_type_id_seq'::regclass);


--
-- TOC entry 2884 (class 2604 OID 16425)
-- Name: genre id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.genre ALTER COLUMN id SET DEFAULT nextval('public.genre_id_seq'::regclass);


--
-- TOC entry 2883 (class 2604 OID 16414)
-- Name: page id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.page ALTER COLUMN id SET DEFAULT nextval('public.page_id_seq'::regclass);


--
-- TOC entry 2890 (class 2604 OID 16471)
-- Name: rating id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rating ALTER COLUMN id SET DEFAULT nextval('public.rating_id_seq'::regclass);


--
-- TOC entry 2886 (class 2604 OID 16441)
-- Name: relation id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.relation ALTER COLUMN id SET DEFAULT nextval('public.relation_id_seq'::regclass);


--
-- TOC entry 2887 (class 2604 OID 16449)
-- Name: relation_type id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.relation_type ALTER COLUMN id SET DEFAULT nextval('public.relation_type_id_seq'::regclass);


--
-- TOC entry 2891 (class 2604 OID 16479)
-- Name: user_account id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_account ALTER COLUMN id SET DEFAULT nextval('public.user_account_id_seq'::regclass);


--
-- TOC entry 2893 (class 2604 OID 16487)
-- Name: user_login id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_login ALTER COLUMN id SET DEFAULT nextval('public.user_login_id_seq'::regclass);


--
-- TOC entry 2900 (class 2604 OID 24798)
-- Name: user_read_content id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_read_content ALTER COLUMN id SET DEFAULT nextval('public.user_read_content_id_seq'::regclass);


--
-- TOC entry 2899 (class 2604 OID 24790)
-- Name: user_read_content_folder id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_read_content_folder ALTER COLUMN id SET DEFAULT nextval('public.user_read_content_folder_id_seq'::regclass);


--
-- TOC entry 2894 (class 2604 OID 16510)
-- Name: user_role id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_role ALTER COLUMN id SET DEFAULT nextval('public.user_role_id_seq'::regclass);


--
-- TOC entry 2895 (class 2604 OID 16542)
-- Name: visable id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.visable ALTER COLUMN id SET DEFAULT nextval('public.visable_id_seq'::regclass);


--
-- TOC entry 3105 (class 0 OID 24808)
-- Dependencies: 236
-- Data for Name: blog; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.blog (id, title, text, user_id, published, edited, visable) VALUES (9, 'New Empire', 'Die neue Manga-Page ist eröffnet :)', 6, '2018-12-08 23:23:31.042071', '2018-12-08 23:27:21.781853', 2);


--
-- TOC entry 3097 (class 0 OID 16570)
-- Dependencies: 228
-- Data for Name: comment; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.comment (id, user_account_id, published, edited, parent_id, text, parent_type) VALUES (3, 7, '2018-08-23 19:56:31.9832+02', NULL, 23, 'Wirklich gut...', 0);
INSERT INTO public.comment (id, user_account_id, published, edited, parent_id, text, parent_type) VALUES (1, 6, '2018-08-23 19:55:54.8412+02', '2018-08-29 02:36:33.5597+02', 23, 'Cooler Manga hier noch mal ein edit', 0);
INSERT INTO public.comment (id, user_account_id, published, edited, parent_id, text, parent_type) VALUES (14, 6, '2018-09-29 23:04:38.4027+02', NULL, 1, 'Noch ein Main Comment', 0);
INSERT INTO public.comment (id, user_account_id, published, edited, parent_id, text, parent_type) VALUES (13, 6, '2018-09-29 23:03:41.3958+02', '2018-10-02 19:03:24.2619+02', 1, 'Togari ist schon echt cool ...
Also mal echt!

DRAGON', 0);
INSERT INTO public.comment (id, user_account_id, published, edited, parent_id, text, parent_type) VALUES (15, 6, '2018-12-09 13:00:31.0761+01', '2018-12-09 13:01:51.0037+01', 1, '<script>
    alert("Hello! I am an alert box!");
</script>
<script>
function myFunction() {
    alert("Hello! I am an alert box!");
}
</script>
<img _ngcontent-c3="" src="http://res.cloudinary.com/baka/image/upload/v1533469430/Togari/1/%5BBaka%5D_Togari_1_3.png">', 0);
INSERT INTO public.comment (id, user_account_id, published, edited, parent_id, text, parent_type) VALUES (16, 6, '2018-12-21 19:53:16.0153+01', '2018-12-21 19:53:56.6185+01', 23, 'Dragon hier ist ', 0);


--
-- TOC entry 3099 (class 0 OID 24762)
-- Dependencies: 230
-- Data for Name: comment_reply; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.comment_reply (id, user_account_id, published, edited, comment_id, text) VALUES (1, 7, '2018-08-23 20:15:14.365825', NULL, 1, 'finde ich auch!!');
INSERT INTO public.comment_reply (id, user_account_id, published, edited, comment_id, text) VALUES (2, 8, '2018-08-23 20:30:36.935839', NULL, 1, 'ich nicht so...');
INSERT INTO public.comment_reply (id, user_account_id, published, edited, comment_id, text) VALUES (11, 6, '2018-09-29 23:04:22.720808', NULL, 13, '@Itachidhdr und mich selber noch mal antworten :D');


--
-- TOC entry 3068 (class 0 OID 16399)
-- Dependencies: 199
-- Data for Name: content; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.content (id, name, visable, number, published, content_folder_id, content_type_id, user_account_id) VALUES (48, 'test', 1, 1, '2019-09-20 16:52:19.2607+02', 44, 1, 6);
INSERT INTO public.content (id, name, visable, number, published, content_folder_id, content_type_id, user_account_id) VALUES (49, 'test', 1, 1, '2019-09-20 17:03:04.2215+02', 55, 1, 6);
INSERT INTO public.content (id, name, visable, number, published, content_folder_id, content_type_id, user_account_id) VALUES (50, 'test', 1, 1, '2019-09-20 17:03:27.5566+02', 54, 1, 6);
INSERT INTO public.content (id, name, visable, number, published, content_folder_id, content_type_id, user_account_id) VALUES (51, 'test', 1, 1, '2019-09-20 17:03:53.0155+02', 53, 1, 6);
INSERT INTO public.content (id, name, visable, number, published, content_folder_id, content_type_id, user_account_id) VALUES (52, 'test', 1, 1, '2019-09-20 17:04:19.1653+02', 52, 1, 6);
INSERT INTO public.content (id, name, visable, number, published, content_folder_id, content_type_id, user_account_id) VALUES (53, 'test', 1, 1, '2019-09-20 17:04:42.3667+02', 51, 1, 6);
INSERT INTO public.content (id, name, visable, number, published, content_folder_id, content_type_id, user_account_id) VALUES (55, 'test', 1, 1, '2019-09-20 17:06:20.8911+02', 50, 1, 6);
INSERT INTO public.content (id, name, visable, number, published, content_folder_id, content_type_id, user_account_id) VALUES (21, 'Danke...?', 1, 1, '2018-08-04 17:40:33.0659+02', 1, 1, 6);
INSERT INTO public.content (id, name, visable, number, published, content_folder_id, content_type_id, user_account_id) VALUES (23, 'Trauer', 1, 1, '2018-08-13 08:45:36.7276+02', 23, 1, 6);
INSERT INTO public.content (id, name, visable, number, published, content_folder_id, content_type_id, user_account_id) VALUES (24, 'Wahrheit', 1, 2, '2018-08-13 09:16:55.6309+02', 23, 1, 6);
INSERT INTO public.content (id, name, visable, number, published, content_folder_id, content_type_id, user_account_id) VALUES (25, 'jo', 1, 1, '2019-02-20 20:07:08.6812+01', 22, 1, 6);
INSERT INTO public.content (id, name, visable, number, published, content_folder_id, content_type_id, user_account_id) VALUES (34, 'd', 4, 0, '2019-02-21 19:32:55.517+01', 38, 1, 6);
INSERT INTO public.content (id, name, visable, number, published, content_folder_id, content_type_id, user_account_id) VALUES (35, 'd', 4, 1, '2019-02-21 19:33:53.2359+01', 39, 1, 6);
INSERT INTO public.content (id, name, visable, number, published, content_folder_id, content_type_id, user_account_id) VALUES (36, 'd', 4, 1, '2019-02-21 19:35:53.2796+01', 39, 1, 6);
INSERT INTO public.content (id, name, visable, number, published, content_folder_id, content_type_id, user_account_id) VALUES (37, 'dd', 4, 0, '2019-02-21 20:35:10.8899+01', 40, 1, 6);
INSERT INTO public.content (id, name, visable, number, published, content_folder_id, content_type_id, user_account_id) VALUES (38, 'dd', 4, 0, '2019-02-21 20:37:10.8999+01', 40, 1, 6);
INSERT INTO public.content (id, name, visable, number, published, content_folder_id, content_type_id, user_account_id) VALUES (39, 'Kapitel', 1, 1, '2019-09-20 14:34:00.6267+02', 7, 1, 6);
INSERT INTO public.content (id, name, visable, number, published, content_folder_id, content_type_id, user_account_id) VALUES (56, 'test', 1, 1, '2019-09-20 17:06:57.0521+02', 49, 1, 6);
INSERT INTO public.content (id, name, visable, number, published, content_folder_id, content_type_id, user_account_id) VALUES (31, '1', 1, 0, '2019-02-21 19:30:25.1551+01', 37, 1, 6);
INSERT INTO public.content (id, name, visable, number, published, content_folder_id, content_type_id, user_account_id) VALUES (40, 'Kapitel 1', 1, 1, '2019-09-20 15:01:20.7344+02', 36, 1, 6);
INSERT INTO public.content (id, name, visable, number, published, content_folder_id, content_type_id, user_account_id) VALUES (43, 'schatz', 1, 1, '2019-09-20 15:03:45.7641+02', 18, 1, 6);
INSERT INTO public.content (id, name, visable, number, published, content_folder_id, content_type_id, user_account_id) VALUES (44, 'mein schatz', 1, 1, '2019-09-20 15:05:11.1923+02', 18, 1, 6);
INSERT INTO public.content (id, name, visable, number, published, content_folder_id, content_type_id, user_account_id) VALUES (45, 'Test', 1, 1, '2019-09-20 15:41:16.8264+02', 0, 1, 6);
INSERT INTO public.content (id, name, visable, number, published, content_folder_id, content_type_id, user_account_id) VALUES (46, 'test', 1, 1, '2019-09-20 15:43:35.1862+02', 42, 1, 6);
INSERT INTO public.content (id, name, visable, number, published, content_folder_id, content_type_id, user_account_id) VALUES (47, 'test', 1, 1, '2019-09-20 16:49:22.0242+02', 43, 1, 6);
INSERT INTO public.content (id, name, visable, number, published, content_folder_id, content_type_id, user_account_id) VALUES (57, 'test', 1, 1, '2019-09-20 17:07:17.9753+02', 48, 1, 6);
INSERT INTO public.content (id, name, visable, number, published, content_folder_id, content_type_id, user_account_id) VALUES (58, 'test', 1, 1, '2019-09-20 17:07:32.9457+02', 47, 1, 6);
INSERT INTO public.content (id, name, visable, number, published, content_folder_id, content_type_id, user_account_id) VALUES (59, 'test', 1, 1, '2019-09-20 17:08:03.3792+02', 46, 1, 6);
INSERT INTO public.content (id, name, visable, number, published, content_folder_id, content_type_id, user_account_id) VALUES (60, 'test', 1, 1, '2019-09-20 17:08:33.3301+02', 45, 1, 6);


--
-- TOC entry 3066 (class 0 OID 16388)
-- Dependencies: 197
-- Data for Name: content_folder; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.content_folder (id, name, author, description, year, content_folder_status_id, visable, alter_name, content_folder_type_id, published, cover) VALUES (18, 'One Piece', 'test', '', 1997, 4, 1, '', 1, '2018-07-15 13:54:04.861743+02', 'http://res.cloudinary.com/baka/image/upload/v1533143857/cover/One%20Piece_cover.png');
INSERT INTO public.content_folder (id, name, author, description, year, content_folder_status_id, visable, alter_name, content_folder_type_id, published, cover) VALUES (23, 'Memesis', 'Yagyuu Takuya', 'Ash und Kijira, zwei mutige Ritter, wollen nur eines, Rache nehmen am Helden Leon. Die ganze Welt hofft, dass Leon den böses Dämonenlord besiegt, unsere zwei Krieger wollen, dass er vor ihnen auf die Knie fällt!
Der neue Rache-Fantasy-Manga! ', 2018, 3, 1, '', 1, '2018-08-13 08:42:50.792968+02', 'http://res.cloudinary.com/baka/image/upload/v1534142573/cover/Memesis_cover.jpg');
INSERT INTO public.content_folder (id, name, author, description, year, content_folder_status_id, visable, alter_name, content_folder_type_id, published, cover) VALUES (36, 'Fary Tail', 'asdf', 'asdf', 2000, 3, 1, '', 1, '2019-02-21 19:26:57.882209+01', 'http://res.cloudinary.com/baka/image/upload/v1550773618/cover/Fary%20Tail_cover.jpg');
INSERT INTO public.content_folder (id, name, author, description, year, content_folder_status_id, visable, alter_name, content_folder_type_id, published, cover) VALUES (42, 'GTO: Great Teacher Onizuka', 'asdf', 'Männlich, 22 und noch keinen Plan, wohin es im Leben gehen soll? Warum nicht Lehrer werden um an hübsche Schülerinnen zu kommen? Diesen Gedanken setzt Eikichi Onizuka in die Tat um: Er wird Great Teacher Onizuka! Aber keine Angst. Er hat natürlich ein Herz aus Gold. Und so entsteht einer der abgedrehtesten und zugleich erfolgreichsten Mangas Japans', 2000, 1, 1, 'test', 1, '2019-09-20 15:43:01.984971+02', 'http://res.cloudinary.com/baka/image/upload/v1568986983/cover/GTO:%20Great%20Teacher%20Onizuka_cover.jpg');
INSERT INTO public.content_folder (id, name, author, description, year, content_folder_status_id, visable, alter_name, content_folder_type_id, published, cover) VALUES (37, 'My Hero Academia', '', '', 2000, 4, 1, '', 1, '2019-02-21 19:30:10.597648+01', 'http://res.cloudinary.com/baka/image/upload/v1550773811/cover/My%20Hero%20Academia_cover.jpg');
INSERT INTO public.content_folder (id, name, author, description, year, content_folder_status_id, visable, alter_name, content_folder_type_id, published, cover) VALUES (1, 'Togari', 'Oza', 'Ein Ninja Manga', 2002, 1, 1, '', 1, '2018-07-11 22:38:54+02', 'http://res.cloudinary.com/baka/image/upload/v1533303715/cover/Togari_cover.png');
INSERT INTO public.content_folder (id, name, author, description, year, content_folder_status_id, visable, alter_name, content_folder_type_id, published, cover) VALUES (22, 'Naruto', 'asdf', '', 2000, 1, 1, '', 1, '2018-08-01 19:56:55.323535+02', 'http://res.cloudinary.com/baka/image/upload/v1533146217/cover/Naruto_cover.jpg');
INSERT INTO public.content_folder (id, name, author, description, year, content_folder_status_id, visable, alter_name, content_folder_type_id, published, cover) VALUES (43, 'Spice and Wolf', 'df', 'Händler macht stuff', 2000, 4, 1, '', 1, '2019-09-20 16:46:24.089388+02', 'http://res.cloudinary.com/baka/image/upload/v1568990930/cover/Spice%20and%20Wolf_cover.jpg');
INSERT INTO public.content_folder (id, name, author, description, year, content_folder_status_id, visable, alter_name, content_folder_type_id, published, cover) VALUES (44, 'Bakuman.', 'dd', 'Ein Manganka macht stuff', 2000, 4, 4, '', 1, '2019-09-20 16:51:57.794916+02', 'http://res.cloudinary.com/baka/image/upload/v1568991118/cover/Bakuman._cover.jpg');
INSERT INTO public.content_folder (id, name, author, description, year, content_folder_status_id, visable, alter_name, content_folder_type_id, published, cover) VALUES (7, 'Bleach', 'me', 'Manga mit Ichigo und Hollows', 2001, 1, 1, 'null', 1, '2018-07-13 22:46:13.942996+02', 'http://res.cloudinary.com/baka/image/upload/v1533142869/cover/Bleach_cover.jpg');
INSERT INTO public.content_folder (id, name, author, description, year, content_folder_status_id, visable, alter_name, content_folder_type_id, published, cover) VALUES (52, 'Test 8', 'test', 'test', 2000, 4, 1, '', 1, '2019-09-20 17:00:47.62121+02', 'http://res.cloudinary.com/baka/image/upload/v1568991653/cover/Test%208_cover.jpg');
INSERT INTO public.content_folder (id, name, author, description, year, content_folder_status_id, visable, alter_name, content_folder_type_id, published, cover) VALUES (45, 'Test 1', 'asdf', 'test', 2000, 4, 1, '', 1, '2019-09-20 16:57:02.661728+02', 'http://res.cloudinary.com/baka/image/upload/v1568991432/cover/Test%201_cover.jpg');
INSERT INTO public.content_folder (id, name, author, description, year, content_folder_status_id, visable, alter_name, content_folder_type_id, published, cover) VALUES (47, 'Test 3', 'test', 'test', 2000, 3, 1, '', 1, '2019-09-20 16:58:08.246338+02', 'http://res.cloudinary.com/baka/image/upload/v1568991495/cover/Test%203_cover.jpg');
INSERT INTO public.content_folder (id, name, author, description, year, content_folder_status_id, visable, alter_name, content_folder_type_id, published, cover) VALUES (48, 'Test 4', 'test', 'test', 2000, 4, 1, '', 1, '2019-09-20 16:58:40.557997+02', 'http://res.cloudinary.com/baka/image/upload/v1568991528/cover/Test%204_cover.jpg');
INSERT INTO public.content_folder (id, name, author, description, year, content_folder_status_id, visable, alter_name, content_folder_type_id, published, cover) VALUES (49, 'Test 5', 'test', 'test', 2000, 4, 1, '', 1, '2019-09-20 16:59:02.091764+02', 'http://res.cloudinary.com/baka/image/upload/v1568991548/cover/Test%205_cover.jpg');
INSERT INTO public.content_folder (id, name, author, description, year, content_folder_status_id, visable, alter_name, content_folder_type_id, published, cover) VALUES (51, 'Test 7', '', 'test', 2000, 4, 1, '', 1, '2019-09-20 17:00:11.529418+02', 'http://res.cloudinary.com/baka/image/upload/v1568991617/cover/Test%207_cover.jpg');
INSERT INTO public.content_folder (id, name, author, description, year, content_folder_status_id, visable, alter_name, content_folder_type_id, published, cover) VALUES (50, 'Test 6', 'test', 'test', 2000, 4, 1, '', 1, '2019-09-20 16:59:33.749979+02', 'http://res.cloudinary.com/baka/image/upload/v1568991587/cover/Test%206_cover.jpg');
INSERT INTO public.content_folder (id, name, author, description, year, content_folder_status_id, visable, alter_name, content_folder_type_id, published, cover) VALUES (53, 'Test 9', 'test', 'test', 2000, 2, 1, '', 1, '2019-09-20 17:01:28.101957+02', 'http://res.cloudinary.com/baka/image/upload/v1568991696/cover/Test%209_cover.jpg');
INSERT INTO public.content_folder (id, name, author, description, year, content_folder_status_id, visable, alter_name, content_folder_type_id, published, cover) VALUES (54, 'Test 10', 'test', 'test', 2000, 4, 1, '', 1, '2019-09-20 17:01:51.237116+02', 'http://res.cloudinary.com/baka/image/upload/v1568991719/cover/Test%2010_cover.jpg');
INSERT INTO public.content_folder (id, name, author, description, year, content_folder_status_id, visable, alter_name, content_folder_type_id, published, cover) VALUES (46, 'Test 2', 'asdf', '', 2000, 4, 1, '', 1, '2019-09-20 16:57:33.660186+02', 'http://res.cloudinary.com/baka/image/upload/v1568991461/cover/Test%202_cover.jpg');
INSERT INTO public.content_folder (id, name, author, description, year, content_folder_status_id, visable, alter_name, content_folder_type_id, published, cover) VALUES (55, 'Test 11', 'test', 'test', 2000, 4, 1, '', 1, '2019-09-20 17:02:45.868131+02', 'http://res.cloudinary.com/baka/image/upload/v1568991770/cover/Test%2011_cover.jpg');


--
-- TOC entry 3095 (class 0 OID 16562)
-- Dependencies: 226
-- Data for Name: content_folder_counter; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (1, '2018-08-29 13:46:00.3297', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (2, '2018-08-29 17:25:06.4933', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (3, '2018-08-29 17:25:19.3543', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (4, '2018-08-29 17:41:25.6341', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (5, '2018-08-29 17:42:18.1091', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (6, '2018-08-29 17:46:09.073', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (7, '2018-08-29 17:46:22.2506', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (8, '2018-08-29 17:57:25.2651', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (9, '2018-08-29 18:15:24.5437', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (10, '2018-08-29 18:15:38.1271', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (11, '2018-08-29 18:16:12.9297', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (12, '2018-08-29 18:18:12.4502', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (13, '2018-08-29 18:18:23.1491', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (14, '2018-08-29 18:18:53.8102', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (15, '2018-08-29 18:19:15.0216', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (16, '2018-08-29 18:19:40.1024', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (17, '2018-08-29 18:20:34.4498', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (18, '2018-08-29 18:20:44.0061', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (19, '2018-08-30 13:46:31.6036', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (20, '2018-08-30 13:48:16.3569', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (21, '2018-08-30 13:48:49.2262', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (22, '2018-08-30 13:48:52.857', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (23, '2018-08-30 13:49:43.2459', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (24, '2018-08-30 13:50:20.7723', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (25, '2018-08-30 14:25:26.0934', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (26, '2018-09-03 21:04:36.573', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (27, '2018-09-03 21:05:33.7412', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (28, '2018-09-03 21:08:33.92', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (29, '2018-09-06 20:39:00.8717', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (30, '2018-09-06 20:39:21.6821', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (31, '2018-09-06 20:41:29.7842', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (32, '2018-09-06 20:42:11.5114', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (33, '2018-09-06 20:43:03.9709', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (34, '2018-09-06 20:43:55.6901', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (35, '2018-09-06 20:47:41.0978', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (36, '2018-09-06 21:01:26.7983', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (37, '2018-09-06 21:09:27.9456', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (38, '2018-09-06 21:14:31.3963', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (39, '2018-09-06 21:14:44.1536', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (40, '2018-09-06 21:14:50.9318', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (41, '2018-09-06 21:15:29.8988', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (42, '2018-09-06 21:27:32.7781', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (43, '2018-09-06 21:33:05.8737', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (44, '2018-09-06 21:33:22.2852', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (45, '2018-09-06 21:34:02.9688', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (46, '2018-09-06 21:34:08.8497', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (47, '2018-09-06 21:39:33.9117', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (48, '2018-09-06 21:51:13.5075', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (49, '2018-09-06 21:51:36.3385', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (50, '2018-09-06 21:53:37.4582', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (51, '2018-09-06 21:53:49.9365', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (52, '2018-09-06 21:53:57.6639', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (53, '2018-09-06 21:54:35.6619', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (54, '2018-09-06 21:59:37.064', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (55, '2018-09-06 22:00:28.5352', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (56, '2018-09-06 22:00:37.0859', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (57, '2018-09-06 22:00:57.7814', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (58, '2018-09-06 22:01:40.1294', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (59, '2018-09-06 22:03:17.9976', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (60, '2018-09-06 22:03:36.6275', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (61, '2018-09-06 22:05:08.3473', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (62, '2018-09-06 22:06:27.5676', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (63, '2018-09-06 22:06:46.4709', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (64, '2018-09-06 22:13:09.0615', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (65, '2018-09-06 22:13:37.0897', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (66, '2018-09-06 22:13:49.5954', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (67, '2018-09-06 22:15:38.6452', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (68, '2018-09-06 22:15:57.5977', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (69, '2018-09-06 22:16:08.4282', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (70, '2018-09-06 22:16:15.6053', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (71, '2018-09-06 22:16:28.8267', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (72, '2018-09-06 22:17:07.7594', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (73, '2018-09-06 22:17:16.882', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (74, '2018-09-06 22:18:03.4963', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (75, '2018-09-06 22:18:55.0365', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (76, '2018-09-06 22:19:12.8771', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (77, '2018-09-06 22:19:34.1439', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (78, '2018-09-06 22:20:42.8411', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (79, '2018-09-06 22:21:44.2065', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (80, '2018-09-06 22:21:56.3452', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (81, '2018-09-06 22:22:22.1561', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (82, '2018-09-06 22:22:42.4382', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (83, '2018-09-06 22:23:40.3806', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (84, '2018-09-06 22:23:51.3561', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (85, '2018-09-06 22:28:55.4825', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (86, '2018-09-06 22:29:38.2436', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (87, '2018-09-06 22:29:46.848', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (88, '2018-09-06 22:30:40.6812', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (89, '2018-09-06 22:31:01.3188', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (90, '2018-09-06 22:31:23.6513', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (91, '2018-09-06 22:31:36.4654', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (92, '2018-09-06 22:32:13.6356', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (93, '2018-09-06 22:32:55.0564', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (94, '2018-09-06 22:34:36.6346', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (95, '2018-09-06 22:34:58.4995', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (96, '2018-09-06 22:35:13.8578', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (97, '2018-09-06 22:35:47.2319', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (98, '2018-09-06 22:36:06.3159', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (99, '2018-09-06 22:36:25.0398', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (100, '2018-09-06 22:36:43.4496', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (101, '2018-09-06 22:36:50.7592', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (102, '2018-09-06 22:36:59.7282', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (103, '2018-09-06 22:37:07.44', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (104, '2018-09-06 22:37:19.9183', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (105, '2018-09-06 22:37:39.3048', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (106, '2018-09-09 21:01:50.4117', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (107, '2018-09-09 21:02:00.9099', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (108, '2018-09-09 21:02:20.7953', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (109, '2018-09-09 21:03:06.5661', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (110, '2018-09-09 21:03:48.8788', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (111, '2018-09-09 21:04:23.507', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (112, '2018-09-09 21:06:28.4514', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (113, '2018-09-09 21:39:50.1408', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (114, '2018-09-09 21:42:22.6719', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (115, '2018-09-09 21:42:51.8532', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (116, '2018-09-09 21:43:14.0909', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (117, '2018-09-09 21:43:29.6457', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (118, '2018-09-09 21:43:57.0806', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (119, '2018-09-09 21:46:35.7268', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (120, '2018-09-09 21:47:59.2691', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (121, '2018-09-09 21:48:53.7517', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (122, '2018-09-09 21:49:15.8713', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (123, '2018-09-09 21:49:50.5816', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (124, '2018-09-09 21:50:19.2161', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (125, '2018-09-09 21:51:28.1802', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (126, '2018-09-09 21:52:44.1735', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (127, '2018-09-09 21:54:44.4863', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (128, '2018-09-09 21:54:58.7234', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (129, '2018-09-09 21:55:53.3758', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (130, '2018-09-09 21:56:31.0364', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (131, '2018-09-10 19:46:05.2165', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (132, '2018-09-10 19:46:58.3617', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (133, '2018-09-10 19:47:50.8551', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (134, '2018-09-10 19:52:26.7985', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (135, '2018-09-10 19:52:52.7506', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (136, '2018-09-10 19:53:09.3315', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (137, '2018-09-10 19:53:23.9478', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (138, '2018-09-10 19:53:33.2548', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (139, '2018-09-10 19:53:46.8918', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (140, '2018-09-10 19:54:27.4047', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (141, '2018-09-10 19:54:41.2448', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (142, '2018-09-10 19:56:11.3323', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (143, '2018-09-10 19:57:25.2843', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (144, '2018-09-10 19:57:42.334', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (145, '2018-09-10 19:57:52.7426', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (146, '2018-09-10 19:58:04.5707', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (147, '2018-09-10 19:58:20.7591', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (148, '2018-09-10 19:58:42.9617', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (149, '2018-09-10 19:59:11.6206', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (150, '2018-09-10 19:59:30.7327', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (151, '2018-09-10 19:59:55.7916', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (152, '2018-09-10 20:00:04.9639', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (153, '2018-09-10 20:01:57.2844', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (154, '2018-09-10 20:02:21.1346', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (155, '2018-09-10 20:02:32.9572', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (156, '2018-09-10 20:04:10.2745', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (157, '2018-09-10 20:04:25.547', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (158, '2018-09-10 20:04:44.1259', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (159, '2018-09-10 20:04:56.0193', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (160, '2018-09-10 20:05:23.4363', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (161, '2018-09-10 20:05:34.5595', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (162, '2018-09-10 20:05:47.5417', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (163, '2018-09-10 20:06:30.7486', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (164, '2018-09-10 20:06:41.7089', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (165, '2018-09-10 20:07:07.065', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (166, '2018-09-10 20:07:35.6833', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (167, '2018-09-10 20:07:57.0756', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (168, '2018-09-10 20:08:12.4627', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (169, '2018-09-10 20:09:04.2426', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (170, '2018-09-10 20:09:13.1949', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (171, '2018-09-10 20:10:20.7343', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (172, '2018-09-10 20:10:41.1938', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (173, '2018-09-10 20:10:52.5993', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (174, '2018-09-10 20:11:10.5453', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (175, '2018-09-10 20:11:26.0533', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (176, '2018-09-10 20:12:21.4301', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (177, '2018-09-10 20:13:39.4478', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (178, '2018-09-10 20:13:54.9519', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (179, '2018-09-10 20:14:06.3286', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (180, '2018-09-10 20:14:28.7597', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (181, '2018-09-10 20:14:42.9486', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (182, '2018-09-10 20:14:50.981', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (183, '2018-09-10 20:15:08.1918', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (184, '2018-09-10 20:17:28.4776', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (185, '2018-09-10 20:17:45.8309', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (186, '2018-09-10 20:18:02.4301', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (187, '2018-09-10 20:18:18.3324', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (188, '2018-09-10 20:18:28.9508', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (189, '2018-09-10 20:19:18.1597', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (190, '2018-09-10 20:19:30.5283', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (191, '2018-09-10 20:19:46.8169', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (192, '2018-09-10 20:19:58.6892', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (193, '2018-09-10 20:20:12.951', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (194, '2018-09-10 20:20:26.5533', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (195, '2018-09-10 20:20:39.1461', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (196, '2018-09-10 20:21:00.046', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (197, '2018-09-10 20:21:43.8295', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (198, '2018-09-10 20:24:33.1788', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (199, '2018-09-10 20:24:50.6651', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (200, '2018-09-10 20:25:16.7694', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (201, '2018-09-10 20:27:09.6943', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (202, '2018-09-10 20:27:23.7008', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (203, '2018-09-12 18:07:22.1122', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (204, '2018-09-12 18:28:43.6194', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (205, '2018-09-12 18:51:09.241', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (206, '2018-09-12 18:51:36.5217', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (207, '2018-09-12 18:51:41.4906', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (208, '2018-09-18 20:46:04.6475', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (209, '2018-09-26 14:35:21.4554', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (210, '2018-09-26 15:04:17.9392', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (211, '2018-09-27 16:36:33.1222', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (212, '2018-09-27 16:38:33.0591', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (213, '2018-09-27 16:44:17.7683', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (214, '2018-09-28 11:42:06.4444', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (215, '2018-09-28 11:43:40.7497', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (216, '2018-09-28 11:44:12.6494', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (217, '2018-09-28 11:44:19.9423', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (218, '2018-09-28 11:52:38.4099', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (219, '2018-09-28 12:10:36.4593', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (220, '2018-09-28 12:27:02.58', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (221, '2018-09-28 12:27:48.614', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (222, '2018-09-29 14:43:35.2107', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (223, '2018-09-29 14:53:03.7253', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (224, '2018-09-29 14:53:55.8941', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (225, '2018-09-29 14:54:07.5753', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (226, '2018-09-29 14:54:21.7246', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (227, '2018-09-29 14:55:32.6767', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (228, '2018-09-29 14:55:49.9864', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (229, '2018-09-29 14:56:27.3027', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (230, '2018-09-29 14:56:45.6543', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (231, '2018-09-29 14:58:13.2194', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (232, '2018-09-29 14:58:36.5511', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (233, '2018-09-29 14:59:02.9977', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (234, '2018-09-29 14:59:13.331', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (235, '2018-09-29 14:59:36.791', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (236, '2018-09-29 15:00:17.8391', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (237, '2018-09-29 15:00:27.79', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (238, '2018-09-29 15:01:29.1492', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (239, '2018-09-29 15:02:19.6892', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (240, '2018-09-29 15:03:28.2965', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (241, '2018-09-29 15:03:39.9244', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (242, '2018-09-29 15:04:03.1349', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (243, '2018-09-29 15:05:48.1148', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (244, '2018-09-29 15:06:04.8437', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (245, '2018-09-29 15:06:28.2055', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (246, '2018-09-29 15:06:42.7598', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (247, '2018-09-29 15:07:08.712', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (248, '2018-09-29 15:09:23.3816', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (249, '2018-09-29 15:09:38.9496', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (250, '2018-09-29 15:10:18.3633', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (251, '2018-09-29 15:11:26.9746', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (252, '2018-09-29 15:11:53.0091', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (253, '2018-09-29 15:12:19.3425', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (254, '2018-09-29 15:12:48.6304', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (255, '2018-09-29 15:13:10.735', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (256, '2018-09-29 15:13:27.112', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (257, '2018-09-29 15:14:03.8007', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (258, '2018-09-29 15:14:15.2847', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (259, '2018-09-29 15:15:20.9512', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (260, '2018-09-29 16:39:42.1291', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (261, '2018-09-29 16:40:24.0482', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (262, '2018-09-29 16:40:41.7184', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (263, '2018-09-29 16:40:51.6824', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (264, '2018-09-29 16:40:58.8164', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (265, '2018-09-29 19:50:30.0572', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (266, '2018-09-29 19:51:07.8929', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (267, '2018-09-29 21:40:43.4512', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (268, '2018-09-29 21:40:55.3312', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (269, '2018-09-29 21:44:41.3153', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (270, '2018-09-29 21:44:49.0747', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (271, '2018-09-29 21:45:37.3974', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (272, '2018-09-29 21:45:53.8179', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (273, '2018-09-29 21:46:01.5485', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (274, '2018-09-29 21:47:34.4801', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (275, '2018-09-29 21:47:49.607', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (276, '2018-09-29 21:50:44.6158', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (277, '2018-09-29 21:51:26.3475', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (278, '2018-09-29 21:52:26.5003', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (279, '2018-09-29 21:53:20.2605', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (280, '2018-09-29 21:53:28.2757', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (281, '2018-09-29 21:57:08.6986', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (282, '2018-09-29 21:58:32.3202', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (283, '2018-09-29 21:58:56.1254', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (284, '2018-09-29 22:02:01.9321', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (285, '2018-09-29 22:02:45.5098', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (286, '2018-09-29 22:03:40.9833', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (287, '2018-09-29 22:06:40.3082', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (288, '2018-09-29 22:08:18.4525', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (289, '2018-09-29 22:14:08.5525', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (290, '2018-09-29 22:17:53.3806', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (291, '2018-09-29 22:22:49.9162', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (292, '2018-09-29 22:23:12.6518', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (293, '2018-09-29 22:23:23.1462', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (294, '2018-09-29 22:23:48.6093', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (295, '2018-09-29 22:24:42.0703', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (296, '2018-09-29 22:25:12.7648', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (297, '2018-09-29 22:25:24.9032', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (298, '2018-09-29 22:25:42.9777', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (299, '2018-09-29 22:26:36.849', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (300, '2018-09-29 22:28:38.8165', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (301, '2018-09-29 22:30:31.218', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (302, '2018-09-29 22:31:47.3093', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (303, '2018-09-29 22:32:24.5946', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (304, '2018-09-29 22:33:21.626', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (305, '2018-09-29 22:33:49.883', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (306, '2018-09-29 22:34:39.5129', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (307, '2018-09-29 22:35:50.8223', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (308, '2018-09-29 22:35:58.2036', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (309, '2018-09-29 22:42:38.2688', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (310, '2018-09-29 22:45:37.8152', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (311, '2018-09-29 22:46:38.404', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (312, '2018-09-29 22:46:52.4154', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (313, '2018-09-29 22:47:17.4112', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (314, '2018-09-29 22:48:52.5629', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (315, '2018-09-29 22:53:16.39', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (316, '2018-09-29 22:53:46.9481', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (317, '2018-09-29 22:54:25.574', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (318, '2018-09-29 22:55:13.6726', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (319, '2018-09-29 22:55:22.8883', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (320, '2018-09-29 22:55:41.2581', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (321, '2018-09-29 22:55:47.735', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (322, '2018-09-29 22:58:43.8986', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (323, '2018-09-29 22:59:01.6018', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (324, '2018-09-29 22:59:56.9974', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (325, '2018-09-29 23:00:37.8877', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (326, '2018-09-29 23:00:50.9825', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (327, '2018-09-29 23:01:11.4685', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (328, '2018-09-29 23:02:34.615', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (329, '2018-09-29 23:02:42.7659', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (330, '2018-09-29 23:02:59.1795', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (331, '2018-09-29 23:03:13.3516', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (332, '2018-09-29 23:03:19.2469', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (333, '2018-09-29 23:03:30.6865', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (334, '2018-10-01 18:56:15.8759', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (335, '2018-10-01 19:00:00.5307', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (336, '2018-10-01 19:00:26.5475', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (337, '2018-10-01 19:01:48.1905', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (338, '2018-10-01 19:02:28.4843', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (339, '2018-10-01 19:02:32.4023', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (340, '2018-10-01 19:02:35.5289', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (341, '2018-10-01 19:02:37.3533', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (342, '2018-10-01 19:02:41.313', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (343, '2018-10-01 19:25:01.2635', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (344, '2018-10-01 19:25:15.8562', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (345, '2018-10-01 19:25:30.3506', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (346, '2018-10-02 07:29:48.4697', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (347, '2018-10-02 07:33:10.5475', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (348, '2018-10-02 07:38:46.0145', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (349, '2018-10-02 07:38:55.5723', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (350, '2018-10-02 07:42:03.2666', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (351, '2018-10-02 18:21:24.8337', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (352, '2018-10-02 18:39:06.5328', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (353, '2018-10-02 18:39:46.9716', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (354, '2018-10-02 18:41:22.7391', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (355, '2018-10-02 18:41:35.0027', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (356, '2018-10-02 18:41:42.3159', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (357, '2018-10-02 18:41:57.2758', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (358, '2018-10-02 18:48:05.9056', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (359, '2018-10-02 19:02:46.7027', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (360, '2018-10-02 19:03:07.727', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (361, '2018-10-02 19:03:11.7339', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (362, '2018-10-02 19:03:31.6055', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (363, '2018-10-02 19:03:49.9483', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (364, '2018-10-02 19:04:11.9324', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (365, '2018-10-02 19:04:25.3891', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (366, '2018-10-02 19:04:34.3965', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (367, '2018-10-02 19:04:40.3788', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (368, '2018-10-02 19:04:52.3861', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (369, '2018-10-02 19:06:15.5445', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (370, '2018-10-02 19:06:40.149', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (371, '2018-10-02 19:08:15.4328', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (372, '2018-10-02 19:10:31.7511', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (373, '2018-10-02 19:11:09.3276', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (374, '2018-10-02 19:12:19.5998', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (375, '2018-10-02 19:16:30.877', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (376, '2018-10-02 19:22:28.9035', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (377, '2018-10-02 19:26:06.4791', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (378, '2018-10-05 17:27:58.7412', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (379, '2018-10-05 17:28:37.9354', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (380, '2018-10-05 17:31:01.7519', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (381, '2018-10-05 17:37:27.4641', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (382, '2018-10-05 17:39:29.7534', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (383, '2018-10-05 17:39:37.5837', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (384, '2018-10-05 17:40:39.6263', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (385, '2018-10-05 17:40:47.9004', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (386, '2018-10-05 17:41:23.3612', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (387, '2018-10-05 17:42:28.6025', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (388, '2018-10-05 17:44:31.6947', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (389, '2018-10-05 17:45:22.385', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (390, '2018-10-05 17:53:52.3953', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (391, '2018-10-07 13:57:26.0312', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (392, '2018-11-04 16:57:14.8134', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (393, '2018-12-09 12:59:38.0416', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (394, '2018-12-09 13:00:37.1122', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (395, '2018-12-09 13:02:50.782', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (396, '2018-12-09 13:17:19.3459', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (397, '2018-12-09 21:02:25.7909', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (398, '2018-12-09 21:02:59.6163', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (399, '2018-12-09 21:03:32.2676', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (400, '2018-12-15 12:20:56.2721', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (401, '2018-12-15 13:42:33.6357', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (402, '2018-12-15 13:46:46.9637', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (403, '2018-12-15 13:47:10.2207', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (404, '2018-12-15 13:48:19.8825', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (405, '2018-12-15 13:49:43.0248', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (406, '2018-12-15 13:50:35.8158', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (407, '2018-12-15 13:50:54.8753', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (408, '2018-12-15 13:52:47.4309', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (409, '2018-12-15 13:52:52.6475', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (410, '2018-12-15 13:53:25.1501', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (411, '2018-12-17 21:51:22.6529', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (412, '2018-12-17 21:51:33.4923', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (413, '2018-12-17 22:19:41.6778', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (414, '2018-12-18 21:18:44.1658', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (415, '2018-12-18 21:20:30.0864', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (416, '2018-12-21 18:59:09.2088', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (417, '2018-12-21 18:59:19.1837', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (418, '2018-12-21 19:50:03.933', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (419, '2018-12-21 19:50:18.3462', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (420, '2018-12-21 19:51:18.9631', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (421, '2018-12-21 19:51:28.186', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (422, '2018-12-21 19:51:36.4786', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (423, '2018-12-21 19:52:09.2903', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (424, '2018-12-21 19:52:47.4599', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (425, '2018-12-21 20:00:39.6908', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (426, '2018-12-21 20:01:09.1537', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (427, '2018-12-21 20:03:04.8665', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (428, '2018-12-22 13:11:12.8515', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (429, '2018-12-22 13:21:09.7912', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (430, '2018-12-22 13:21:14.0901', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (431, '2018-12-22 13:21:38.7513', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (432, '2018-12-22 13:23:51.5993', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (433, '2018-12-22 13:24:31.5531', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (434, '2018-12-22 13:24:52.3747', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (435, '2018-12-22 13:26:09.6263', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (436, '2018-12-22 13:26:49.8229', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (437, '2018-12-22 13:33:54.501', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (438, '2018-12-22 13:34:11.1342', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (439, '2018-12-22 13:35:19.9415', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (440, '2018-12-22 13:37:44.3129', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (441, '2018-12-22 13:37:49.8961', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (442, '2018-12-22 13:38:40.9128', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (443, '2018-12-22 13:39:04.2177', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (444, '2018-12-22 13:39:13.1333', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (445, '2018-12-22 13:39:35.9744', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (446, '2018-12-22 13:40:01.6374', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (447, '2018-12-22 13:40:54.865', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (448, '2018-12-22 13:41:10.6397', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (449, '2018-12-22 13:41:57.7442', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (450, '2018-12-23 22:17:00.2141', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (451, '2018-12-23 22:17:37.9162', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (452, '2018-12-23 22:19:05.0826', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (453, '2018-12-23 22:20:47.0335', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (454, '2018-12-23 22:21:38.8842', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (455, '2018-12-23 22:21:47.2293', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (456, '2018-12-23 22:22:33.9209', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (457, '2018-12-23 22:23:23.1496', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (458, '2018-12-23 22:24:26.0007', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (459, '2018-12-23 22:25:42.5935', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (460, '2018-12-23 22:25:56.7278', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (461, '2018-12-23 22:26:26.0022', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (462, '2018-12-23 22:32:43.3077', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (463, '2018-12-23 22:33:33.7934', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (464, '2018-12-23 22:34:37.8561', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (465, '2018-12-24 17:16:37.6986', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (466, '2018-12-24 17:37:04.1034', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (467, '2018-12-25 16:55:55.2316', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (468, '2018-12-25 17:00:28.5844', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (469, '2018-12-25 17:00:40.6449', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (470, '2018-12-25 17:02:16.275', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (471, '2018-12-25 17:03:24.6468', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (472, '2018-12-25 17:03:50.6222', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (473, '2018-12-25 17:03:59.5546', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (474, '2018-12-25 17:04:28.3368', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (475, '2018-12-25 17:04:52.5', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (476, '2018-12-25 17:05:45.9499', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (477, '2018-12-25 17:06:56.9972', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (478, '2018-12-25 17:07:27.3406', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (479, '2018-12-25 17:07:39.3383', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (480, '2018-12-25 17:09:03.8312', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (481, '2018-12-25 17:09:08.7116', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (482, '2018-12-25 17:11:35.4273', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (483, '2018-12-25 17:13:55.7794', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (484, '2018-12-25 17:18:27.3227', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (485, '2018-12-25 17:20:30.764', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (486, '2018-12-25 17:21:57.7215', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (487, '2018-12-25 17:26:23.1868', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (488, '2018-12-25 17:27:21.407', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (489, '2018-12-25 17:27:35.6508', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (490, '2018-12-25 17:27:41.8449', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (491, '2018-12-25 17:27:57.8977', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (492, '2018-12-25 17:28:03.6781', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (493, '2018-12-25 17:28:08.1527', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (494, '2018-12-25 17:28:43.3723', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (495, '2018-12-25 17:28:49.0621', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (496, '2018-12-25 17:53:31.84', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (497, '2019-02-15 20:33:44.286', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (498, '2019-02-20 20:09:07.7692', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (499, '2019-02-20 21:11:49.5088', 22, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (500, '2019-02-21 19:20:18.045', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (501, '2019-02-21 19:31:23.5955', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (502, '2019-02-23 23:05:11.6082', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (503, '2019-02-23 23:05:19.2589', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (504, '2019-02-25 16:36:15.757', 22, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (505, '2019-02-25 16:38:22.366', 22, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (506, '2019-02-25 16:38:27.6977', 22, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (507, '2019-02-25 16:38:48.3731', 22, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (508, '2019-02-25 16:39:03.8592', 22, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (509, '2019-02-25 16:39:13.6818', 22, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (510, '2019-02-25 16:41:55.9496', 22, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (511, '2019-02-25 16:42:20.7568', 22, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (512, '2019-02-25 16:42:57.9116', 22, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (513, '2019-02-25 16:43:20.995', 22, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (514, '2019-02-25 16:43:32.6444', 22, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (515, '2019-02-25 16:45:06.6219', 22, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (516, '2019-02-25 16:45:59.1075', 22, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (517, '2019-02-25 16:46:14.927', 22, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (518, '2019-02-25 16:46:45.363', 22, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (519, '2019-02-28 21:06:45.0727', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (520, '2019-02-28 21:08:18.0295', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (521, '2019-02-28 21:10:40.7765', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (522, '2019-03-03 09:22:56.1937', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (523, '2019-03-04 17:10:49.0412', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (524, '2019-03-04 17:12:11.5768', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (525, '2019-03-04 17:13:51.0055', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (526, '2019-03-04 17:13:59.0316', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (527, '2019-03-04 17:14:10.7103', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (528, '2019-03-04 17:14:32.1711', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (529, '2019-03-04 17:15:05.3704', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (530, '2019-03-04 17:15:19.4814', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (531, '2019-03-05 20:47:14.4229', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (532, '2019-03-05 20:47:18.8691', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (533, '2019-03-05 20:49:52.009', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (534, '2019-03-05 20:50:36.2575', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (535, '2019-03-05 21:02:12.6873', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (536, '2019-03-05 21:02:45.7222', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (537, '2019-03-05 21:02:58.5027', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (538, '2019-03-05 21:03:10.6246', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (539, '2019-03-05 21:03:57.9017', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (540, '2019-03-05 21:04:53.4324', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (541, '2019-03-05 21:05:23.1217', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (542, '2019-03-05 21:09:42.4272', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (543, '2019-03-05 21:10:07.9505', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (544, '2019-03-06 20:08:12.1584', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (545, '2019-03-06 20:08:33.5824', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (546, '2019-03-06 20:09:01.8626', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (547, '2019-03-06 20:09:51.1976', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (548, '2019-03-06 20:36:10.5642', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (549, '2019-03-06 20:37:19.6633', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (550, '2019-03-07 17:42:52.7047', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (551, '2019-03-07 17:43:23.45', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (552, '2019-03-07 17:45:37.5171', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (553, '2019-03-07 20:34:37.4174', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (554, '2019-03-09 18:38:44.9317', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (555, '2019-03-09 23:44:36.3745', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (556, '2019-03-09 23:45:13.8374', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (557, '2019-03-09 23:45:21.0095', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (558, '2019-09-18 19:15:49.6975', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (559, '2019-09-18 19:17:27.8838', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (560, '2019-09-18 19:30:57.4391', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (561, '2019-09-18 19:41:26.4881', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (562, '2019-09-18 19:43:25.5794', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (563, '2019-09-20 10:02:40.2208', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (564, '2019-09-20 10:06:13.693', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (565, '2019-09-20 10:06:19.5612', 22, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (566, '2019-09-20 10:41:56.4225', 22, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (567, '2019-09-20 10:42:00.0174', 22, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (568, '2019-09-20 14:37:50.7039', 7, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (569, '2019-09-20 14:37:59.2652', 7, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (570, '2019-09-20 14:38:09.5533', 7, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (571, '2019-09-23 19:31:26.3829', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (572, '2019-09-27 21:27:31.9117', 42, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (573, '2019-09-27 21:33:09.8621', 7, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (574, '2019-09-27 21:34:01.7429', 7, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (575, '2019-09-27 22:09:18.3786', 44, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (576, '2019-09-27 22:49:40.8407', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (577, '2019-09-27 22:49:46.1699', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (578, '2019-09-27 22:50:56.1293', 1, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (579, '2019-09-27 22:51:00.8795', 44, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (580, '2019-09-27 22:54:10.0395', 7, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (581, '2019-09-27 23:12:59.3143', 7, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (582, '2019-09-27 23:13:12.2711', 7, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (583, '2019-09-28 11:57:21.9854', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (584, '2019-09-28 11:58:42.6587', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (585, '2019-09-28 11:59:09.803', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (586, '2019-09-28 12:00:18.624', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (587, '2019-09-28 12:03:48.3996', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (588, '2019-09-28 12:04:50.6919', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (589, '2019-09-28 12:08:48.1653', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (590, '2019-09-30 19:37:20.7342', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (591, '2019-09-30 19:39:25.9023', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (592, '2019-09-30 19:56:24.1258', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (593, '2019-10-01 16:49:20.1963', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (594, '2019-10-03 21:40:27.3452', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (595, '2019-10-03 21:40:54.7615', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (596, '2019-10-03 21:44:20.6822', 7, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (597, '2019-10-03 21:45:39.3378', 7, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (598, '2019-10-03 22:33:18.2604', 7, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (599, '2019-10-03 22:33:56.2771', 7, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (600, '2019-10-03 22:34:12.3273', 7, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (601, '2019-10-03 22:35:04.4536', 7, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (602, '2019-10-03 22:36:16.5478', 7, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (603, '2019-10-03 22:36:56.8666', 7, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (604, '2019-10-03 22:37:28.4626', 7, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (605, '2019-10-03 22:37:46.2953', 7, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (606, '2019-10-03 22:37:54.9058', 7, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (607, '2019-10-03 22:40:01.8772', 7, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (608, '2019-10-03 22:40:46.5884', 7, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (609, '2019-10-03 22:40:54.2202', 7, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (610, '2019-10-03 22:41:11.0457', 7, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (611, '2019-10-03 22:41:18.0239', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (612, '2019-10-03 22:41:25.0443', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (613, '2019-10-03 22:41:27.8063', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (614, '2019-10-03 22:41:33.2001', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (615, '2019-10-04 22:13:31.3097', 7, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (616, '2019-10-04 22:15:08.6165', 7, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (617, '2019-10-04 22:15:50.9805', 7, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (618, '2019-10-04 22:16:42.1806', 7, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (619, '2019-10-04 22:20:17.5584', 7, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (620, '2019-10-04 22:20:30.9213', 7, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (621, '2019-10-04 22:22:45.4882', 7, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (622, '2019-10-04 22:22:55.1508', 7, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (623, '2019-10-04 22:24:44.9719', 7, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (624, '2019-10-04 22:25:37.0373', 7, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (625, '2019-10-04 22:29:16.447', 7, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (626, '2019-10-04 22:29:23.3068', 7, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (627, '2019-10-04 22:35:49.3484', 7, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (628, '2019-10-04 22:39:14.5216', 7, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (629, '2019-10-04 22:40:28.6635', 7, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (630, '2019-10-04 22:40:36.9587', 7, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (631, '2019-10-04 22:41:23.015', 7, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (632, '2019-10-04 22:51:14.4404', 7, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (633, '2019-10-05 13:50:02.7823', 7, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (634, '2019-10-05 13:59:12.3262', 7, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (635, '2019-10-05 14:00:57.53', 7, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (636, '2019-10-05 14:01:11.006', 7, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (637, '2019-10-05 14:01:43.7894', 7, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (638, '2019-10-05 15:23:37.9855', 7, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (639, '2019-10-05 15:23:51.8783', 42, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (640, '2019-10-05 15:48:19.6489', 42, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (641, '2019-10-05 19:57:44.6699', 7, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (642, '2019-10-05 19:59:07.9643', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (643, '2019-10-05 19:59:13.1155', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (644, '2019-10-05 20:40:09.0053', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (645, '2019-10-05 21:05:48.6541', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (646, '2019-10-05 21:07:16.7876', 23, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (647, '2019-10-06 15:33:01.2999', 44, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (648, '2019-10-06 17:03:14.166', 7, 6);
INSERT INTO public.content_folder_counter (id, published, content_folder_id, user_account_id) VALUES (649, '2019-10-09 16:01:27.3675', 36, 6);


--
-- TOC entry 3074 (class 0 OID 16430)
-- Dependencies: 205
-- Data for Name: content_folder_genre; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.content_folder_genre (id, content_folder_id, genre_id) VALUES (205, 7, 4);
INSERT INTO public.content_folder_genre (id, content_folder_id, genre_id) VALUES (206, 7, 9);
INSERT INTO public.content_folder_genre (id, content_folder_id, genre_id) VALUES (144, 1, 1);
INSERT INTO public.content_folder_genre (id, content_folder_id, genre_id) VALUES (145, 1, 9);
INSERT INTO public.content_folder_genre (id, content_folder_id, genre_id) VALUES (146, 1, 8);
INSERT INTO public.content_folder_genre (id, content_folder_id, genre_id) VALUES (211, 42, 4);
INSERT INTO public.content_folder_genre (id, content_folder_id, genre_id) VALUES (212, 42, 9);
INSERT INTO public.content_folder_genre (id, content_folder_id, genre_id) VALUES (215, 43, 8);
INSERT INTO public.content_folder_genre (id, content_folder_id, genre_id) VALUES (216, 43, 6);
INSERT INTO public.content_folder_genre (id, content_folder_id, genre_id) VALUES (155, 23, 1);
INSERT INTO public.content_folder_genre (id, content_folder_id, genre_id) VALUES (156, 23, 4);
INSERT INTO public.content_folder_genre (id, content_folder_id, genre_id) VALUES (157, 23, 8);
INSERT INTO public.content_folder_genre (id, content_folder_id, genre_id) VALUES (158, 23, 5);
INSERT INTO public.content_folder_genre (id, content_folder_id, genre_id) VALUES (220, 44, 4);
INSERT INTO public.content_folder_genre (id, content_folder_id, genre_id) VALUES (221, 44, 9);
INSERT INTO public.content_folder_genre (id, content_folder_id, genre_id) VALUES (222, 44, 6);
INSERT INTO public.content_folder_genre (id, content_folder_id, genre_id) VALUES (235, 47, 6);
INSERT INTO public.content_folder_genre (id, content_folder_id, genre_id) VALUES (236, 47, 10);
INSERT INTO public.content_folder_genre (id, content_folder_id, genre_id) VALUES (237, 47, 5);
INSERT INTO public.content_folder_genre (id, content_folder_id, genre_id) VALUES (238, 47, 3);
INSERT INTO public.content_folder_genre (id, content_folder_id, genre_id) VALUES (180, 22, 1);
INSERT INTO public.content_folder_genre (id, content_folder_id, genre_id) VALUES (184, 18, 1);
INSERT INTO public.content_folder_genre (id, content_folder_id, genre_id) VALUES (187, 36, 1);
INSERT INTO public.content_folder_genre (id, content_folder_id, genre_id) VALUES (188, 36, 4);
INSERT INTO public.content_folder_genre (id, content_folder_id, genre_id) VALUES (193, 37, 1);
INSERT INTO public.content_folder_genre (id, content_folder_id, genre_id) VALUES (194, 37, 4);
INSERT INTO public.content_folder_genre (id, content_folder_id, genre_id) VALUES (264, 51, 4);
INSERT INTO public.content_folder_genre (id, content_folder_id, genre_id) VALUES (265, 51, 8);
INSERT INTO public.content_folder_genre (id, content_folder_id, genre_id) VALUES (266, 51, 5);
INSERT INTO public.content_folder_genre (id, content_folder_id, genre_id) VALUES (274, 53, 4);
INSERT INTO public.content_folder_genre (id, content_folder_id, genre_id) VALUES (276, 54, 9);
INSERT INTO public.content_folder_genre (id, content_folder_id, genre_id) VALUES (278, 55, 8);
INSERT INTO public.content_folder_genre (id, content_folder_id, genre_id) VALUES (279, 46, 7);
INSERT INTO public.content_folder_genre (id, content_folder_id, genre_id) VALUES (280, 46, 2);
INSERT INTO public.content_folder_genre (id, content_folder_id, genre_id) VALUES (281, 45, 10);
INSERT INTO public.content_folder_genre (id, content_folder_id, genre_id) VALUES (282, 45, 5);
INSERT INTO public.content_folder_genre (id, content_folder_id, genre_id) VALUES (283, 52, 4);
INSERT INTO public.content_folder_genre (id, content_folder_id, genre_id) VALUES (284, 52, 2);
INSERT INTO public.content_folder_genre (id, content_folder_id, genre_id) VALUES (285, 52, 3);
INSERT INTO public.content_folder_genre (id, content_folder_id, genre_id) VALUES (286, 50, 2);
INSERT INTO public.content_folder_genre (id, content_folder_id, genre_id) VALUES (287, 50, 6);
INSERT INTO public.content_folder_genre (id, content_folder_id, genre_id) VALUES (288, 50, 10);
INSERT INTO public.content_folder_genre (id, content_folder_id, genre_id) VALUES (289, 49, 8);
INSERT INTO public.content_folder_genre (id, content_folder_id, genre_id) VALUES (290, 49, 7);
INSERT INTO public.content_folder_genre (id, content_folder_id, genre_id) VALUES (291, 49, 2);
INSERT INTO public.content_folder_genre (id, content_folder_id, genre_id) VALUES (292, 49, 6);
INSERT INTO public.content_folder_genre (id, content_folder_id, genre_id) VALUES (293, 48, 1);
INSERT INTO public.content_folder_genre (id, content_folder_id, genre_id) VALUES (294, 48, 4);
INSERT INTO public.content_folder_genre (id, content_folder_id, genre_id) VALUES (295, 48, 9);
INSERT INTO public.content_folder_genre (id, content_folder_id, genre_id) VALUES (296, 48, 8);


--
-- TOC entry 3082 (class 0 OID 16462)
-- Dependencies: 213
-- Data for Name: content_folder_status; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.content_folder_status (id, name) VALUES (1, 'Abgeschlossen');
INSERT INTO public.content_folder_status (id, name) VALUES (2, 'Pausiert');
INSERT INTO public.content_folder_status (id, name) VALUES (3, 'Laufend');
INSERT INTO public.content_folder_status (id, name) VALUES (4, 'Unbekannt');


--
-- TOC entry 3080 (class 0 OID 16454)
-- Dependencies: 211
-- Data for Name: content_folder_type; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.content_folder_type (id, name) VALUES (1, 'manga-serie');
INSERT INTO public.content_folder_type (id, name) VALUES (2, 'anime-serie');
INSERT INTO public.content_folder_type (id, name) VALUES (3, 'one-shot');


--
-- TOC entry 3072 (class 0 OID 16422)
-- Dependencies: 203
-- Data for Name: genre; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.genre (id, name) VALUES (1, 'Action');
INSERT INTO public.genre (id, name) VALUES (2, 'Ninja');
INSERT INTO public.genre (id, name) VALUES (3, 'Superpower');
INSERT INTO public.genre (id, name) VALUES (4, 'Comedy');
INSERT INTO public.genre (id, name) VALUES (5, 'Shounen');
INSERT INTO public.genre (id, name) VALUES (6, 'Romance');
INSERT INTO public.genre (id, name) VALUES (7, 'Krimi');
INSERT INTO public.genre (id, name) VALUES (8, 'Fantasy');
INSERT INTO public.genre (id, name) VALUES (9, 'Drama');
INSERT INTO public.genre (id, name) VALUES (10, 'School');


--
-- TOC entry 3070 (class 0 OID 16411)
-- Dependencies: 201
-- Data for Name: page; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (59, 21, 'http://res.cloudinary.com/baka/image/upload/v1533469435/Togari/1/%5BBaka%5D_Togari_1_0.png', 0, 'Togari/1/[Baka]_Togari_1_0');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (60, 21, 'http://res.cloudinary.com/baka/image/upload/v1533469427/Togari/1/%5BBaka%5D_Togari_1_1.png', 1, 'Togari/1/[Baka]_Togari_1_1');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (61, 21, 'http://res.cloudinary.com/baka/image/upload/v1533469429/Togari/1/%5BBaka%5D_Togari_1_2.png', 2, 'Togari/1/[Baka]_Togari_1_2');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (62, 21, 'http://res.cloudinary.com/baka/image/upload/v1533469430/Togari/1/%5BBaka%5D_Togari_1_3.png', 3, 'Togari/1/[Baka]_Togari_1_3');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (63, 21, 'http://res.cloudinary.com/baka/image/upload/v1533469436/Togari/1/%5BBaka%5D_Togari_1_4.png', 4, 'Togari/1/[Baka]_Togari_1_4');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (64, 21, 'http://res.cloudinary.com/baka/image/upload/v1533469430/Togari/1/%5BBaka%5D_Togari_1_5.png', 5, 'Togari/1/[Baka]_Togari_1_5');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (65, 21, 'http://res.cloudinary.com/baka/image/upload/v1533469432/Togari/1/%5BBaka%5D_Togari_1_6.png', 6, 'Togari/1/[Baka]_Togari_1_6');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (66, 21, 'http://res.cloudinary.com/baka/image/upload/v1533469434/Togari/1/%5BBaka%5D_Togari_1_7.png', 7, 'Togari/1/[Baka]_Togari_1_7');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (67, 21, 'http://res.cloudinary.com/baka/image/upload/v1533469432/Togari/1/%5BBaka%5D_Togari_1_8.png', 8, 'Togari/1/[Baka]_Togari_1_8');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (68, 21, 'http://res.cloudinary.com/baka/image/upload/v1533469430/Togari/1/%5BBaka%5D_Togari_1_9.png', 9, 'Togari/1/[Baka]_Togari_1_9');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (69, 21, 'http://res.cloudinary.com/baka/image/upload/v1533469433/Togari/1/%5BBaka%5D_Togari_1_10.png', 10, 'Togari/1/[Baka]_Togari_1_10');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (70, 21, 'http://res.cloudinary.com/baka/image/upload/v1533469430/Togari/1/%5BBaka%5D_Togari_1_11.png', 11, 'Togari/1/[Baka]_Togari_1_11');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (71, 21, 'http://res.cloudinary.com/baka/image/upload/v1533469432/Togari/1/%5BBaka%5D_Togari_1_12.png', 12, 'Togari/1/[Baka]_Togari_1_12');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (72, 21, 'http://res.cloudinary.com/baka/image/upload/v1533469435/Togari/1/%5BBaka%5D_Togari_1_13.png', 13, 'Togari/1/[Baka]_Togari_1_13');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (73, 21, 'http://res.cloudinary.com/baka/image/upload/v1533469440/Togari/1/%5BBaka%5D_Togari_1_14.png', 14, 'Togari/1/[Baka]_Togari_1_14');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (74, 21, 'http://res.cloudinary.com/baka/image/upload/v1533469436/Togari/1/%5BBaka%5D_Togari_1_15.png', 15, 'Togari/1/[Baka]_Togari_1_15');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (75, 21, 'http://res.cloudinary.com/baka/image/upload/v1533469432/Togari/1/%5BBaka%5D_Togari_1_16.png', 16, 'Togari/1/[Baka]_Togari_1_16');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (76, 21, 'http://res.cloudinary.com/baka/image/upload/v1533469436/Togari/1/%5BBaka%5D_Togari_1_17.png', 17, 'Togari/1/[Baka]_Togari_1_17');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (77, 21, 'http://res.cloudinary.com/baka/image/upload/v1533469435/Togari/1/%5BBaka%5D_Togari_1_18.png', 18, 'Togari/1/[Baka]_Togari_1_18');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (78, 21, 'http://res.cloudinary.com/baka/image/upload/v1533469432/Togari/1/%5BBaka%5D_Togari_1_19.png', 19, 'Togari/1/[Baka]_Togari_1_19');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (79, 21, 'http://res.cloudinary.com/baka/image/upload/v1533469429/Togari/1/%5BBaka%5D_Togari_1_20.png', 20, 'Togari/1/[Baka]_Togari_1_20');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (80, 21, 'http://res.cloudinary.com/baka/image/upload/v1533469435/Togari/1/%5BBaka%5D_Togari_1_21.png', 21, 'Togari/1/[Baka]_Togari_1_21');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (81, 21, 'http://res.cloudinary.com/baka/image/upload/v1533469432/Togari/1/%5BBaka%5D_Togari_1_22.png', 22, 'Togari/1/[Baka]_Togari_1_22');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (82, 21, 'http://res.cloudinary.com/baka/image/upload/v1533469434/Togari/1/%5BBaka%5D_Togari_1_23.png', 23, 'Togari/1/[Baka]_Togari_1_23');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (83, 21, 'http://res.cloudinary.com/baka/image/upload/v1533469428/Togari/1/%5BBaka%5D_Togari_1_24.png', 24, 'Togari/1/[Baka]_Togari_1_24');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (84, 21, 'http://res.cloudinary.com/baka/image/upload/v1533469439/Togari/1/%5BBaka%5D_Togari_1_25.png', 25, 'Togari/1/[Baka]_Togari_1_25');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (85, 21, 'http://res.cloudinary.com/baka/image/upload/v1533469436/Togari/1/%5BBaka%5D_Togari_1_26.png', 26, 'Togari/1/[Baka]_Togari_1_26');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (86, 21, 'http://res.cloudinary.com/baka/image/upload/v1533469431/Togari/1/%5BBaka%5D_Togari_1_27.png', 27, 'Togari/1/[Baka]_Togari_1_27');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (87, 21, 'http://res.cloudinary.com/baka/image/upload/v1533469435/Togari/1/%5BBaka%5D_Togari_1_28.png', 28, 'Togari/1/[Baka]_Togari_1_28');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (88, 21, 'http://res.cloudinary.com/baka/image/upload/v1533469434/Togari/1/%5BBaka%5D_Togari_1_29.png', 29, 'Togari/1/[Baka]_Togari_1_29');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (89, 21, 'http://res.cloudinary.com/baka/image/upload/v1533469433/Togari/1/%5BBaka%5D_Togari_1_30.png', 30, 'Togari/1/[Baka]_Togari_1_30');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (90, 21, 'http://res.cloudinary.com/baka/image/upload/v1533469434/Togari/1/%5BBaka%5D_Togari_1_31.png', 31, 'Togari/1/[Baka]_Togari_1_31');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (91, 21, 'http://res.cloudinary.com/baka/image/upload/v1533469436/Togari/1/%5BBaka%5D_Togari_1_32.png', 32, 'Togari/1/[Baka]_Togari_1_32');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (92, 21, 'http://res.cloudinary.com/baka/image/upload/v1533469428/Togari/1/%5BBaka%5D_Togari_1_33.png', 33, 'Togari/1/[Baka]_Togari_1_33');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (93, 21, 'http://res.cloudinary.com/baka/image/upload/v1533469430/Togari/1/%5BBaka%5D_Togari_1_34.png', 34, 'Togari/1/[Baka]_Togari_1_34');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (94, 21, 'http://res.cloudinary.com/baka/image/upload/v1533469433/Togari/1/%5BBaka%5D_Togari_1_35.png', 35, 'Togari/1/[Baka]_Togari_1_35');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (95, 21, 'http://res.cloudinary.com/baka/image/upload/v1533469435/Togari/1/%5BBaka%5D_Togari_1_36.png', 36, 'Togari/1/[Baka]_Togari_1_36');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (96, 21, 'http://res.cloudinary.com/baka/image/upload/v1533469435/Togari/1/%5BBaka%5D_Togari_1_37.png', 37, 'Togari/1/[Baka]_Togari_1_37');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (97, 21, 'http://res.cloudinary.com/baka/image/upload/v1533469434/Togari/1/%5BBaka%5D_Togari_1_38.png', 38, 'Togari/1/[Baka]_Togari_1_38');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (98, 21, 'http://res.cloudinary.com/baka/image/upload/v1533469433/Togari/1/%5BBaka%5D_Togari_1_39.png', 39, 'Togari/1/[Baka]_Togari_1_39');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (132, 23, 'http://res.cloudinary.com/baka/image/upload/v1534142762/Memesis/1/%5BBaka%5D_Memesis_1_0.png', 0, 'Memesis/1/[Baka]_Memesis_1_0');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (133, 23, 'http://res.cloudinary.com/baka/image/upload/v1534142754/Memesis/1/%5BBaka%5D_Memesis_1_1.png', 1, 'Memesis/1/[Baka]_Memesis_1_1');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (134, 23, 'http://res.cloudinary.com/baka/image/upload/v1534142759/Memesis/1/%5BBaka%5D_Memesis_1_2.png', 2, 'Memesis/1/[Baka]_Memesis_1_2');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (135, 23, 'http://res.cloudinary.com/baka/image/upload/v1534142749/Memesis/1/%5BBaka%5D_Memesis_1_3.png', 3, 'Memesis/1/[Baka]_Memesis_1_3');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (136, 23, 'http://res.cloudinary.com/baka/image/upload/v1534142758/Memesis/1/%5BBaka%5D_Memesis_1_4.png', 4, 'Memesis/1/[Baka]_Memesis_1_4');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (137, 23, 'http://res.cloudinary.com/baka/image/upload/v1534142761/Memesis/1/%5BBaka%5D_Memesis_1_5.png', 5, 'Memesis/1/[Baka]_Memesis_1_5');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (138, 23, 'http://res.cloudinary.com/baka/image/upload/v1534142751/Memesis/1/%5BBaka%5D_Memesis_1_6.png', 6, 'Memesis/1/[Baka]_Memesis_1_6');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (139, 23, 'http://res.cloudinary.com/baka/image/upload/v1534142748/Memesis/1/%5BBaka%5D_Memesis_1_7.png', 7, 'Memesis/1/[Baka]_Memesis_1_7');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (140, 23, 'http://res.cloudinary.com/baka/image/upload/v1534142748/Memesis/1/%5BBaka%5D_Memesis_1_8.png', 8, 'Memesis/1/[Baka]_Memesis_1_8');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (141, 23, 'http://res.cloudinary.com/baka/image/upload/v1534142742/Memesis/1/%5BBaka%5D_Memesis_1_9.png', 9, 'Memesis/1/[Baka]_Memesis_1_9');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (142, 23, 'http://res.cloudinary.com/baka/image/upload/v1534142756/Memesis/1/%5BBaka%5D_Memesis_1_10.png', 10, 'Memesis/1/[Baka]_Memesis_1_10');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (143, 23, 'http://res.cloudinary.com/baka/image/upload/v1534142738/Memesis/1/%5BBaka%5D_Memesis_1_11.png', 11, 'Memesis/1/[Baka]_Memesis_1_11');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (144, 23, 'http://res.cloudinary.com/baka/image/upload/v1534142752/Memesis/1/%5BBaka%5D_Memesis_1_12.png', 12, 'Memesis/1/[Baka]_Memesis_1_12');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (145, 23, 'http://res.cloudinary.com/baka/image/upload/v1534142751/Memesis/1/%5BBaka%5D_Memesis_1_13.png', 13, 'Memesis/1/[Baka]_Memesis_1_13');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (146, 23, 'http://res.cloudinary.com/baka/image/upload/v1534142752/Memesis/1/%5BBaka%5D_Memesis_1_14.png', 14, 'Memesis/1/[Baka]_Memesis_1_14');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (147, 23, 'http://res.cloudinary.com/baka/image/upload/v1534142753/Memesis/1/%5BBaka%5D_Memesis_1_15.png', 15, 'Memesis/1/[Baka]_Memesis_1_15');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (148, 23, 'http://res.cloudinary.com/baka/image/upload/v1534142745/Memesis/1/%5BBaka%5D_Memesis_1_16.png', 16, 'Memesis/1/[Baka]_Memesis_1_16');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (149, 23, 'http://res.cloudinary.com/baka/image/upload/v1534142823/Memesis/1/%5BBaka%5D_Memesis_1_17.png', 17, 'Memesis/1/[Baka]_Memesis_1_17');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (150, 23, 'http://res.cloudinary.com/baka/image/upload/v1534142821/Memesis/1/%5BBaka%5D_Memesis_1_18.png', 18, 'Memesis/1/[Baka]_Memesis_1_18');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (151, 23, 'http://res.cloudinary.com/baka/image/upload/v1534142825/Memesis/1/%5BBaka%5D_Memesis_1_19.png', 19, 'Memesis/1/[Baka]_Memesis_1_19');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (152, 23, 'http://res.cloudinary.com/baka/image/upload/v1534142814/Memesis/1/%5BBaka%5D_Memesis_1_20.png', 20, 'Memesis/1/[Baka]_Memesis_1_20');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (153, 23, 'http://res.cloudinary.com/baka/image/upload/v1534142827/Memesis/1/%5BBaka%5D_Memesis_1_21.png', 21, 'Memesis/1/[Baka]_Memesis_1_21');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (154, 23, 'http://res.cloudinary.com/baka/image/upload/v1534142823/Memesis/1/%5BBaka%5D_Memesis_1_22.png', 22, 'Memesis/1/[Baka]_Memesis_1_22');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (155, 23, 'http://res.cloudinary.com/baka/image/upload/v1534142822/Memesis/1/%5BBaka%5D_Memesis_1_23.png', 23, 'Memesis/1/[Baka]_Memesis_1_23');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (156, 23, 'http://res.cloudinary.com/baka/image/upload/v1534142817/Memesis/1/%5BBaka%5D_Memesis_1_24.png', 24, 'Memesis/1/[Baka]_Memesis_1_24');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (157, 23, 'http://res.cloudinary.com/baka/image/upload/v1534142813/Memesis/1/%5BBaka%5D_Memesis_1_25.png', 25, 'Memesis/1/[Baka]_Memesis_1_25');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (158, 23, 'http://res.cloudinary.com/baka/image/upload/v1534142822/Memesis/1/%5BBaka%5D_Memesis_1_26.png', 26, 'Memesis/1/[Baka]_Memesis_1_26');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (159, 23, 'http://res.cloudinary.com/baka/image/upload/v1534142826/Memesis/1/%5BBaka%5D_Memesis_1_27.png', 27, 'Memesis/1/[Baka]_Memesis_1_27');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (160, 23, 'http://res.cloudinary.com/baka/image/upload/v1534142824/Memesis/1/%5BBaka%5D_Memesis_1_28.png', 28, 'Memesis/1/[Baka]_Memesis_1_28');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (161, 23, 'http://res.cloudinary.com/baka/image/upload/v1534142823/Memesis/1/%5BBaka%5D_Memesis_1_29.png', 29, 'Memesis/1/[Baka]_Memesis_1_29');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (162, 23, 'http://res.cloudinary.com/baka/image/upload/v1534142824/Memesis/1/%5BBaka%5D_Memesis_1_30.png', 30, 'Memesis/1/[Baka]_Memesis_1_30');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (163, 23, 'http://res.cloudinary.com/baka/image/upload/v1534142819/Memesis/1/%5BBaka%5D_Memesis_1_31.png', 31, 'Memesis/1/[Baka]_Memesis_1_31');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (164, 23, 'http://res.cloudinary.com/baka/image/upload/v1534142833/Memesis/1/%5BBaka%5D_Memesis_1_32.png', 32, 'Memesis/1/[Baka]_Memesis_1_32');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (165, 23, 'http://res.cloudinary.com/baka/image/upload/v1534142817/Memesis/1/%5BBaka%5D_Memesis_1_33.png', 33, 'Memesis/1/[Baka]_Memesis_1_33');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (166, 23, 'http://res.cloudinary.com/baka/image/upload/v1534142821/Memesis/1/%5BBaka%5D_Memesis_1_34.png', 34, 'Memesis/1/[Baka]_Memesis_1_34');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (167, 23, 'http://res.cloudinary.com/baka/image/upload/v1534142822/Memesis/1/%5BBaka%5D_Memesis_1_35.png', 35, 'Memesis/1/[Baka]_Memesis_1_35');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (168, 23, 'http://res.cloudinary.com/baka/image/upload/v1534142825/Memesis/1/%5BBaka%5D_Memesis_1_36.png', 36, 'Memesis/1/[Baka]_Memesis_1_36');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (169, 23, 'http://res.cloudinary.com/baka/image/upload/v1534142825/Memesis/1/%5BBaka%5D_Memesis_1_37.png', 37, 'Memesis/1/[Baka]_Memesis_1_37');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (170, 23, 'http://res.cloudinary.com/baka/image/upload/v1534142819/Memesis/1/%5BBaka%5D_Memesis_1_38.png', 38, 'Memesis/1/[Baka]_Memesis_1_38');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (171, 23, 'http://res.cloudinary.com/baka/image/upload/v1534142826/Memesis/1/%5BBaka%5D_Memesis_1_39.png', 39, 'Memesis/1/[Baka]_Memesis_1_39');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (172, 23, 'http://res.cloudinary.com/baka/image/upload/v1534142821/Memesis/1/%5BBaka%5D_Memesis_1_40.png', 40, 'Memesis/1/[Baka]_Memesis_1_40');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (173, 23, 'http://res.cloudinary.com/baka/image/upload/v1534142828/Memesis/1/%5BBaka%5D_Memesis_1_41.png', 41, 'Memesis/1/[Baka]_Memesis_1_41');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (174, 23, 'http://res.cloudinary.com/baka/image/upload/v1534142829/Memesis/1/%5BBaka%5D_Memesis_1_42.png', 42, 'Memesis/1/[Baka]_Memesis_1_42');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (175, 23, 'http://res.cloudinary.com/baka/image/upload/v1534142821/Memesis/1/%5BBaka%5D_Memesis_1_43.png', 43, 'Memesis/1/[Baka]_Memesis_1_43');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (176, 23, 'http://res.cloudinary.com/baka/image/upload/v1534142821/Memesis/1/%5BBaka%5D_Memesis_1_44.png', 44, 'Memesis/1/[Baka]_Memesis_1_44');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (177, 23, 'http://res.cloudinary.com/baka/image/upload/v1534142818/Memesis/1/%5BBaka%5D_Memesis_1_45.png', 45, 'Memesis/1/[Baka]_Memesis_1_45');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (178, 23, 'http://res.cloudinary.com/baka/image/upload/v1534142822/Memesis/1/%5BBaka%5D_Memesis_1_46.png', 46, 'Memesis/1/[Baka]_Memesis_1_46');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (179, 23, 'http://res.cloudinary.com/baka/image/upload/v1534142821/Memesis/1/%5BBaka%5D_Memesis_1_47.png', 47, 'Memesis/1/[Baka]_Memesis_1_47');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (180, 24, 'http://res.cloudinary.com/baka/image/upload/v1534144626/Memesis/2/%5BBaka%5D_Memesis_2_0.png', 0, 'Memesis/2/[Baka]_Memesis_2_0');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (181, 24, 'http://res.cloudinary.com/baka/image/upload/v1534144628/Memesis/2/%5BBaka%5D_Memesis_2_1.png', 1, 'Memesis/2/[Baka]_Memesis_2_1');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (182, 24, 'http://res.cloudinary.com/baka/image/upload/v1534144634/Memesis/2/%5BBaka%5D_Memesis_2_2.png', 2, 'Memesis/2/[Baka]_Memesis_2_2');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (183, 24, 'http://res.cloudinary.com/baka/image/upload/v1534144633/Memesis/2/%5BBaka%5D_Memesis_2_3.png', 3, 'Memesis/2/[Baka]_Memesis_2_3');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (184, 24, 'http://res.cloudinary.com/baka/image/upload/v1534144631/Memesis/2/%5BBaka%5D_Memesis_2_4.png', 4, 'Memesis/2/[Baka]_Memesis_2_4');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (185, 24, 'http://res.cloudinary.com/baka/image/upload/v1534144631/Memesis/2/%5BBaka%5D_Memesis_2_5.png', 5, 'Memesis/2/[Baka]_Memesis_2_5');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (186, 24, 'http://res.cloudinary.com/baka/image/upload/v1534144630/Memesis/2/%5BBaka%5D_Memesis_2_6.png', 6, 'Memesis/2/[Baka]_Memesis_2_6');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (187, 24, 'http://res.cloudinary.com/baka/image/upload/v1534144628/Memesis/2/%5BBaka%5D_Memesis_2_7.png', 7, 'Memesis/2/[Baka]_Memesis_2_7');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (188, 24, 'http://res.cloudinary.com/baka/image/upload/v1534144623/Memesis/2/%5BBaka%5D_Memesis_2_8.png', 8, 'Memesis/2/[Baka]_Memesis_2_8');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (189, 24, 'http://res.cloudinary.com/baka/image/upload/v1534144631/Memesis/2/%5BBaka%5D_Memesis_2_9.png', 9, 'Memesis/2/[Baka]_Memesis_2_9');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (190, 24, 'http://res.cloudinary.com/baka/image/upload/v1534144631/Memesis/2/%5BBaka%5D_Memesis_2_10.png', 10, 'Memesis/2/[Baka]_Memesis_2_10');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (191, 24, 'http://res.cloudinary.com/baka/image/upload/v1534144632/Memesis/2/%5BBaka%5D_Memesis_2_11.png', 11, 'Memesis/2/[Baka]_Memesis_2_11');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (192, 24, 'http://res.cloudinary.com/baka/image/upload/v1534144633/Memesis/2/%5BBaka%5D_Memesis_2_12.png', 12, 'Memesis/2/[Baka]_Memesis_2_12');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (193, 24, 'http://res.cloudinary.com/baka/image/upload/v1534144630/Memesis/2/%5BBaka%5D_Memesis_2_13.png', 13, 'Memesis/2/[Baka]_Memesis_2_13');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (194, 24, 'http://res.cloudinary.com/baka/image/upload/v1534144634/Memesis/2/%5BBaka%5D_Memesis_2_14.png', 14, 'Memesis/2/[Baka]_Memesis_2_14');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (195, 24, 'http://res.cloudinary.com/baka/image/upload/v1534144630/Memesis/2/%5BBaka%5D_Memesis_2_15.png', 15, 'Memesis/2/[Baka]_Memesis_2_15');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (196, 24, 'http://res.cloudinary.com/baka/image/upload/v1534144631/Memesis/2/%5BBaka%5D_Memesis_2_16.png', 16, 'Memesis/2/[Baka]_Memesis_2_16');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (197, 24, 'http://res.cloudinary.com/baka/image/upload/v1534144632/Memesis/2/%5BBaka%5D_Memesis_2_17.png', 17, 'Memesis/2/[Baka]_Memesis_2_17');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (198, 24, 'http://res.cloudinary.com/baka/image/upload/v1534144630/Memesis/2/%5BBaka%5D_Memesis_2_18.png', 18, 'Memesis/2/[Baka]_Memesis_2_18');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (199, 24, 'http://res.cloudinary.com/baka/image/upload/v1534144627/Memesis/2/%5BBaka%5D_Memesis_2_19.png', 19, 'Memesis/2/[Baka]_Memesis_2_19');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (200, 24, 'http://res.cloudinary.com/baka/image/upload/v1534144628/Memesis/2/%5BBaka%5D_Memesis_2_20.png', 20, 'Memesis/2/[Baka]_Memesis_2_20');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (201, 24, 'http://res.cloudinary.com/baka/image/upload/v1534144632/Memesis/2/%5BBaka%5D_Memesis_2_21.png', 21, 'Memesis/2/[Baka]_Memesis_2_21');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (202, 24, 'http://res.cloudinary.com/baka/image/upload/v1534144628/Memesis/2/%5BBaka%5D_Memesis_2_22.png', 22, 'Memesis/2/[Baka]_Memesis_2_22');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (203, 24, 'http://res.cloudinary.com/baka/image/upload/v1534144633/Memesis/2/%5BBaka%5D_Memesis_2_23.png', 23, 'Memesis/2/[Baka]_Memesis_2_23');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (204, 24, 'http://res.cloudinary.com/baka/image/upload/v1534144630/Memesis/2/%5BBaka%5D_Memesis_2_24.png', 24, 'Memesis/2/[Baka]_Memesis_2_24');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (205, 24, 'http://res.cloudinary.com/baka/image/upload/v1534144633/Memesis/2/%5BBaka%5D_Memesis_2_25.png', 25, 'Memesis/2/[Baka]_Memesis_2_25');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (206, 24, 'http://res.cloudinary.com/baka/image/upload/v1534144631/Memesis/2/%5BBaka%5D_Memesis_2_26.png', 26, 'Memesis/2/[Baka]_Memesis_2_26');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (207, 24, 'http://res.cloudinary.com/baka/image/upload/v1534144632/Memesis/2/%5BBaka%5D_Memesis_2_27.png', 27, 'Memesis/2/[Baka]_Memesis_2_27');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (208, 24, 'http://res.cloudinary.com/baka/image/upload/v1534144627/Memesis/2/%5BBaka%5D_Memesis_2_28.png', 28, 'Memesis/2/[Baka]_Memesis_2_28');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (209, 24, 'http://res.cloudinary.com/baka/image/upload/v1534144634/Memesis/2/%5BBaka%5D_Memesis_2_29.png', 29, 'Memesis/2/[Baka]_Memesis_2_29');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (210, 24, 'http://res.cloudinary.com/baka/image/upload/v1534144631/Memesis/2/%5BBaka%5D_Memesis_2_30.png', 30, 'Memesis/2/[Baka]_Memesis_2_30');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (211, 24, 'http://res.cloudinary.com/baka/image/upload/v1534144635/Memesis/2/%5BBaka%5D_Memesis_2_31.png', 31, 'Memesis/2/[Baka]_Memesis_2_31');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (212, 24, 'http://res.cloudinary.com/baka/image/upload/v1534144630/Memesis/2/%5BBaka%5D_Memesis_2_32.png', 32, 'Memesis/2/[Baka]_Memesis_2_32');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (213, 24, 'http://res.cloudinary.com/baka/image/upload/v1534144631/Memesis/2/%5BBaka%5D_Memesis_2_33.png', 33, 'Memesis/2/[Baka]_Memesis_2_33');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (214, 24, 'http://res.cloudinary.com/baka/image/upload/v1534144628/Memesis/2/%5BBaka%5D_Memesis_2_34.png', 34, 'Memesis/2/[Baka]_Memesis_2_34');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (215, 25, 'http://res.cloudinary.com/baka/image/upload/v1550689631/Naruto/1/%5BBaka%5D_Naruto_1_0.png', 0, 'Naruto/1/[Baka]_Naruto_1_0');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (216, 25, 'http://res.cloudinary.com/baka/image/upload/v1550689629/Naruto/1/%5BBaka%5D_Naruto_1_1.png', 1, 'Naruto/1/[Baka]_Naruto_1_1');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (217, 25, 'http://res.cloudinary.com/baka/image/upload/v1550689630/Naruto/1/%5BBaka%5D_Naruto_1_2.png', 2, 'Naruto/1/[Baka]_Naruto_1_2');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (218, 25, 'http://res.cloudinary.com/baka/image/upload/v1550689631/Naruto/1/%5BBaka%5D_Naruto_1_3.png', 3, 'Naruto/1/[Baka]_Naruto_1_3');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (219, 25, 'http://res.cloudinary.com/baka/image/upload/v1550689630/Naruto/1/%5BBaka%5D_Naruto_1_4.png', 4, 'Naruto/1/[Baka]_Naruto_1_4');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (220, 39, 'http://res.cloudinary.com/baka/image/upload/v1568982843/Bleach/1/%5BBaka%5D_Bleach_1_0.png', 0, 'Bleach/1/[Baka]_Bleach_1_0');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (221, 39, 'http://res.cloudinary.com/baka/image/upload/v1568982842/Bleach/1/%5BBaka%5D_Bleach_1_1.png', 1, 'Bleach/1/[Baka]_Bleach_1_1');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (222, 39, 'http://res.cloudinary.com/baka/image/upload/v1568982841/Bleach/1/%5BBaka%5D_Bleach_1_2.png', 2, 'Bleach/1/[Baka]_Bleach_1_2');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (223, 39, 'http://res.cloudinary.com/baka/image/upload/v1568982841/Bleach/1/%5BBaka%5D_Bleach_1_3.png', 3, 'Bleach/1/[Baka]_Bleach_1_3');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (224, 39, 'http://res.cloudinary.com/baka/image/upload/v1568982841/Bleach/1/%5BBaka%5D_Bleach_1_4.png', 4, 'Bleach/1/[Baka]_Bleach_1_4');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (236, 31, 'http://res.cloudinary.com/baka/image/upload/v1568982969/My%20Hero%20Academia/0/%5BBaka%5D_My%20Hero%20Academia_0_0.png', 0, 'My Hero Academia/0/[Baka]_My Hero Academia_0_0');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (237, 31, 'http://res.cloudinary.com/baka/image/upload/v1568982968/My%20Hero%20Academia/0/%5BBaka%5D_My%20Hero%20Academia_0_1.png', 1, 'My Hero Academia/0/[Baka]_My Hero Academia_0_1');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (238, 31, 'http://res.cloudinary.com/baka/image/upload/v1568982969/My%20Hero%20Academia/0/%5BBaka%5D_My%20Hero%20Academia_0_2.png', 2, 'My Hero Academia/0/[Baka]_My Hero Academia_0_2');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (239, 31, 'http://res.cloudinary.com/baka/image/upload/v1568982969/My%20Hero%20Academia/0/%5BBaka%5D_My%20Hero%20Academia_0_3.png', 3, 'My Hero Academia/0/[Baka]_My Hero Academia_0_3');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (240, 31, 'http://res.cloudinary.com/baka/image/upload/v1568982970/My%20Hero%20Academia/0/%5BBaka%5D_My%20Hero%20Academia_0_4.png', 4, 'My Hero Academia/0/[Baka]_My Hero Academia_0_4');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (241, 31, 'http://res.cloudinary.com/baka/image/upload/v1568982970/My%20Hero%20Academia/0/%5BBaka%5D_My%20Hero%20Academia_0_5.png', 5, 'My Hero Academia/0/[Baka]_My Hero Academia_0_5');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (242, 31, 'http://res.cloudinary.com/baka/image/upload/v1568982970/My%20Hero%20Academia/0/%5BBaka%5D_My%20Hero%20Academia_0_6.png', 6, 'My Hero Academia/0/[Baka]_My Hero Academia_0_6');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (243, 31, 'http://res.cloudinary.com/baka/image/upload/v1568982970/My%20Hero%20Academia/0/%5BBaka%5D_My%20Hero%20Academia_0_7.png', 7, 'My Hero Academia/0/[Baka]_My Hero Academia_0_7');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (244, 31, 'http://res.cloudinary.com/baka/image/upload/v1568982970/My%20Hero%20Academia/0/%5BBaka%5D_My%20Hero%20Academia_0_8.png', 8, 'My Hero Academia/0/[Baka]_My Hero Academia_0_8');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (245, 31, 'http://res.cloudinary.com/baka/image/upload/v1568982970/My%20Hero%20Academia/0/%5BBaka%5D_My%20Hero%20Academia_0_9.png', 9, 'My Hero Academia/0/[Baka]_My Hero Academia_0_9');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (246, 31, 'http://res.cloudinary.com/baka/image/upload/v1568982969/My%20Hero%20Academia/0/%5BBaka%5D_My%20Hero%20Academia_0_10.png', 10, 'My Hero Academia/0/[Baka]_My Hero Academia_0_10');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (247, 40, 'http://res.cloudinary.com/baka/image/upload/v1568984482/Fary%20Tail/1/%5BBaka%5D_Fary%20Tail_1_0.png', 0, 'Fary Tail/1/[Baka]_Fary Tail_1_0');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (248, 40, 'http://res.cloudinary.com/baka/image/upload/v1568984481/Fary%20Tail/1/%5BBaka%5D_Fary%20Tail_1_1.png', 1, 'Fary Tail/1/[Baka]_Fary Tail_1_1');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (249, 40, 'http://res.cloudinary.com/baka/image/upload/v1568984482/Fary%20Tail/1/%5BBaka%5D_Fary%20Tail_1_2.png', 2, 'Fary Tail/1/[Baka]_Fary Tail_1_2');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (250, 40, 'http://res.cloudinary.com/baka/image/upload/v1568984482/Fary%20Tail/1/%5BBaka%5D_Fary%20Tail_1_3.png', 3, 'Fary Tail/1/[Baka]_Fary Tail_1_3');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (251, 40, 'http://res.cloudinary.com/baka/image/upload/v1568984483/Fary%20Tail/1/%5BBaka%5D_Fary%20Tail_1_4.png', 4, 'Fary Tail/1/[Baka]_Fary Tail_1_4');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (252, 40, 'http://res.cloudinary.com/baka/image/upload/v1568984482/Fary%20Tail/1/%5BBaka%5D_Fary%20Tail_1_5.png', 5, 'Fary Tail/1/[Baka]_Fary Tail_1_5');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (253, 40, 'http://res.cloudinary.com/baka/image/upload/v1568984483/Fary%20Tail/1/%5BBaka%5D_Fary%20Tail_1_6.png', 6, 'Fary Tail/1/[Baka]_Fary Tail_1_6');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (254, 40, 'http://res.cloudinary.com/baka/image/upload/v1568984483/Fary%20Tail/1/%5BBaka%5D_Fary%20Tail_1_7.png', 7, 'Fary Tail/1/[Baka]_Fary Tail_1_7');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (263, 43, 'http://res.cloudinary.com/baka/image/upload/v1568984627/One%20Piece/1/%5BBaka%5D_One%20Piece_1_0.png', 0, 'One Piece/1/[Baka]_One Piece_1_0');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (264, 43, 'http://res.cloudinary.com/baka/image/upload/v1568984627/One%20Piece/1/%5BBaka%5D_One%20Piece_1_1.png', 1, 'One Piece/1/[Baka]_One Piece_1_1');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (265, 43, 'http://res.cloudinary.com/baka/image/upload/v1568984626/One%20Piece/1/%5BBaka%5D_One%20Piece_1_2.png', 2, 'One Piece/1/[Baka]_One Piece_1_2');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (266, 43, 'http://res.cloudinary.com/baka/image/upload/v1568984626/One%20Piece/1/%5BBaka%5D_One%20Piece_1_3.png', 3, 'One Piece/1/[Baka]_One Piece_1_3');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (267, 43, 'http://res.cloudinary.com/baka/image/upload/v1568984627/One%20Piece/1/%5BBaka%5D_One%20Piece_1_4.png', 4, 'One Piece/1/[Baka]_One Piece_1_4');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (268, 43, 'http://res.cloudinary.com/baka/image/upload/v1568984628/One%20Piece/1/%5BBaka%5D_One%20Piece_1_5.png', 5, 'One Piece/1/[Baka]_One Piece_1_5');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (269, 46, 'http://res.cloudinary.com/baka/image/upload/v1568987016/GTO:%20Great%20Teacher%20Onizuka/1/%5BBaka%5D_GTO:%20Great%20Teacher%20Onizuka_1_0.png', 0, 'GTO: Great Teacher Onizuka/1/[Baka]_GTO: Great Teacher Onizuka_');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (270, 46, 'http://res.cloudinary.com/baka/image/upload/v1568987016/GTO:%20Great%20Teacher%20Onizuka/1/%5BBaka%5D_GTO:%20Great%20Teacher%20Onizuka_1_1.png', 1, 'GTO: Great Teacher Onizuka/1/[Baka]_GTO: Great Teacher Onizuka_');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (271, 46, 'http://res.cloudinary.com/baka/image/upload/v1568987016/GTO:%20Great%20Teacher%20Onizuka/1/%5BBaka%5D_GTO:%20Great%20Teacher%20Onizuka_1_2.png', 2, 'GTO: Great Teacher Onizuka/1/[Baka]_GTO: Great Teacher Onizuka_');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (272, 46, 'http://res.cloudinary.com/baka/image/upload/v1568987016/GTO:%20Great%20Teacher%20Onizuka/1/%5BBaka%5D_GTO:%20Great%20Teacher%20Onizuka_1_3.png', 3, 'GTO: Great Teacher Onizuka/1/[Baka]_GTO: Great Teacher Onizuka_');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (273, 46, 'http://res.cloudinary.com/baka/image/upload/v1568987017/GTO:%20Great%20Teacher%20Onizuka/1/%5BBaka%5D_GTO:%20Great%20Teacher%20Onizuka_1_4.png', 4, 'GTO: Great Teacher Onizuka/1/[Baka]_GTO: Great Teacher Onizuka_');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (274, 46, 'http://res.cloudinary.com/baka/image/upload/v1568987017/GTO:%20Great%20Teacher%20Onizuka/1/%5BBaka%5D_GTO:%20Great%20Teacher%20Onizuka_1_5.png', 5, 'GTO: Great Teacher Onizuka/1/[Baka]_GTO: Great Teacher Onizuka_');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (275, 46, 'http://res.cloudinary.com/baka/image/upload/v1568987016/GTO:%20Great%20Teacher%20Onizuka/1/%5BBaka%5D_GTO:%20Great%20Teacher%20Onizuka_1_6.png', 6, 'GTO: Great Teacher Onizuka/1/[Baka]_GTO: Great Teacher Onizuka_');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (276, 46, 'http://res.cloudinary.com/baka/image/upload/v1568987017/GTO:%20Great%20Teacher%20Onizuka/1/%5BBaka%5D_GTO:%20Great%20Teacher%20Onizuka_1_7.png', 7, 'GTO: Great Teacher Onizuka/1/[Baka]_GTO: Great Teacher Onizuka_');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (277, 47, 'http://res.cloudinary.com/baka/image/upload/v1568990964/Spice%20and%20Wolf/1/%5BBaka%5D_Spice%20and%20Wolf_1_0.png', 0, 'Spice and Wolf/1/[Baka]_Spice and Wolf_1_0');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (278, 47, 'http://res.cloudinary.com/baka/image/upload/v1568990964/Spice%20and%20Wolf/1/%5BBaka%5D_Spice%20and%20Wolf_1_1.png', 1, 'Spice and Wolf/1/[Baka]_Spice and Wolf_1_1');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (279, 47, 'http://res.cloudinary.com/baka/image/upload/v1568990965/Spice%20and%20Wolf/1/%5BBaka%5D_Spice%20and%20Wolf_1_2.png', 2, 'Spice and Wolf/1/[Baka]_Spice and Wolf_1_2');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (280, 47, 'http://res.cloudinary.com/baka/image/upload/v1568990963/Spice%20and%20Wolf/1/%5BBaka%5D_Spice%20and%20Wolf_1_3.png', 3, 'Spice and Wolf/1/[Baka]_Spice and Wolf_1_3');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (281, 47, 'http://res.cloudinary.com/baka/image/upload/v1568990963/Spice%20and%20Wolf/1/%5BBaka%5D_Spice%20and%20Wolf_1_4.png', 4, 'Spice and Wolf/1/[Baka]_Spice and Wolf_1_4');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (282, 47, 'http://res.cloudinary.com/baka/image/upload/v1568990964/Spice%20and%20Wolf/1/%5BBaka%5D_Spice%20and%20Wolf_1_5.png', 5, 'Spice and Wolf/1/[Baka]_Spice and Wolf_1_5');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (283, 47, 'http://res.cloudinary.com/baka/image/upload/v1568990964/Spice%20and%20Wolf/1/%5BBaka%5D_Spice%20and%20Wolf_1_6.png', 6, 'Spice and Wolf/1/[Baka]_Spice and Wolf_1_6');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (284, 47, 'http://res.cloudinary.com/baka/image/upload/v1568990965/Spice%20and%20Wolf/1/%5BBaka%5D_Spice%20and%20Wolf_1_7.png', 7, 'Spice and Wolf/1/[Baka]_Spice and Wolf_1_7');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (285, 47, 'http://res.cloudinary.com/baka/image/upload/v1568990965/Spice%20and%20Wolf/1/%5BBaka%5D_Spice%20and%20Wolf_1_8.png', 8, 'Spice and Wolf/1/[Baka]_Spice and Wolf_1_8');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (286, 47, 'http://res.cloudinary.com/baka/image/upload/v1568990964/Spice%20and%20Wolf/1/%5BBaka%5D_Spice%20and%20Wolf_1_9.png', 9, 'Spice and Wolf/1/[Baka]_Spice and Wolf_1_9');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (287, 48, 'http://res.cloudinary.com/baka/image/upload/v1568991141/Bakuman./1/%5BBaka%5D_Bakuman._1_0.png', 0, 'Bakuman./1/[Baka]_Bakuman._1_0');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (288, 48, 'http://res.cloudinary.com/baka/image/upload/v1568991141/Bakuman./1/%5BBaka%5D_Bakuman._1_1.png', 1, 'Bakuman./1/[Baka]_Bakuman._1_1');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (289, 48, 'http://res.cloudinary.com/baka/image/upload/v1568991140/Bakuman./1/%5BBaka%5D_Bakuman._1_2.png', 2, 'Bakuman./1/[Baka]_Bakuman._1_2');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (290, 48, 'http://res.cloudinary.com/baka/image/upload/v1568991143/Bakuman./1/%5BBaka%5D_Bakuman._1_3.png', 3, 'Bakuman./1/[Baka]_Bakuman._1_3');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (291, 48, 'http://res.cloudinary.com/baka/image/upload/v1568991142/Bakuman./1/%5BBaka%5D_Bakuman._1_4.png', 4, 'Bakuman./1/[Baka]_Bakuman._1_4');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (292, 48, 'http://res.cloudinary.com/baka/image/upload/v1568991141/Bakuman./1/%5BBaka%5D_Bakuman._1_5.png', 5, 'Bakuman./1/[Baka]_Bakuman._1_5');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (293, 48, 'http://res.cloudinary.com/baka/image/upload/v1568991141/Bakuman./1/%5BBaka%5D_Bakuman._1_6.png', 6, 'Bakuman./1/[Baka]_Bakuman._1_6');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (294, 48, 'http://res.cloudinary.com/baka/image/upload/v1568991140/Bakuman./1/%5BBaka%5D_Bakuman._1_7.png', 7, 'Bakuman./1/[Baka]_Bakuman._1_7');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (295, 49, 'http://res.cloudinary.com/baka/image/upload/v1568991785/Test%2011/1/%5BBaka%5D_Test%2011_1_0.png', 0, 'Test 11/1/[Baka]_Test 11_1_0');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (296, 49, 'http://res.cloudinary.com/baka/image/upload/v1568991786/Test%2011/1/%5BBaka%5D_Test%2011_1_1.png', 1, 'Test 11/1/[Baka]_Test 11_1_1');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (297, 49, 'http://res.cloudinary.com/baka/image/upload/v1568991785/Test%2011/1/%5BBaka%5D_Test%2011_1_2.png', 2, 'Test 11/1/[Baka]_Test 11_1_2');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (298, 49, 'http://res.cloudinary.com/baka/image/upload/v1568991785/Test%2011/1/%5BBaka%5D_Test%2011_1_3.png', 3, 'Test 11/1/[Baka]_Test 11_1_3');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (299, 49, 'http://res.cloudinary.com/baka/image/upload/v1568991785/Test%2011/1/%5BBaka%5D_Test%2011_1_4.png', 4, 'Test 11/1/[Baka]_Test 11_1_4');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (300, 49, 'http://res.cloudinary.com/baka/image/upload/v1568991785/Test%2011/1/%5BBaka%5D_Test%2011_1_5.png', 5, 'Test 11/1/[Baka]_Test 11_1_5');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (301, 49, 'http://res.cloudinary.com/baka/image/upload/v1568991787/Test%2011/1/%5BBaka%5D_Test%2011_1_6.png', 6, 'Test 11/1/[Baka]_Test 11_1_6');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (302, 49, 'http://res.cloudinary.com/baka/image/upload/v1568991785/Test%2011/1/%5BBaka%5D_Test%2011_1_7.png', 7, 'Test 11/1/[Baka]_Test 11_1_7');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (303, 50, 'http://res.cloudinary.com/baka/image/upload/v1568991810/Test%2010/1/%5BBaka%5D_Test%2010_1_0.png', 0, 'Test 10/1/[Baka]_Test 10_1_0');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (304, 50, 'http://res.cloudinary.com/baka/image/upload/v1568991808/Test%2010/1/%5BBaka%5D_Test%2010_1_1.png', 1, 'Test 10/1/[Baka]_Test 10_1_1');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (305, 50, 'http://res.cloudinary.com/baka/image/upload/v1568991809/Test%2010/1/%5BBaka%5D_Test%2010_1_2.png', 2, 'Test 10/1/[Baka]_Test 10_1_2');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (306, 50, 'http://res.cloudinary.com/baka/image/upload/v1568991809/Test%2010/1/%5BBaka%5D_Test%2010_1_3.png', 3, 'Test 10/1/[Baka]_Test 10_1_3');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (307, 50, 'http://res.cloudinary.com/baka/image/upload/v1568991809/Test%2010/1/%5BBaka%5D_Test%2010_1_4.png', 4, 'Test 10/1/[Baka]_Test 10_1_4');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (308, 50, 'http://res.cloudinary.com/baka/image/upload/v1568991809/Test%2010/1/%5BBaka%5D_Test%2010_1_5.png', 5, 'Test 10/1/[Baka]_Test 10_1_5');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (309, 50, 'http://res.cloudinary.com/baka/image/upload/v1568991808/Test%2010/1/%5BBaka%5D_Test%2010_1_6.png', 6, 'Test 10/1/[Baka]_Test 10_1_6');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (310, 50, 'http://res.cloudinary.com/baka/image/upload/v1568991808/Test%2010/1/%5BBaka%5D_Test%2010_1_7.png', 7, 'Test 10/1/[Baka]_Test 10_1_7');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (311, 51, 'http://res.cloudinary.com/baka/image/upload/v1568991834/Test%209/1/%5BBaka%5D_Test%209_1_0.png', 0, 'Test 9/1/[Baka]_Test 9_1_0');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (312, 51, 'http://res.cloudinary.com/baka/image/upload/v1568991835/Test%209/1/%5BBaka%5D_Test%209_1_1.png', 1, 'Test 9/1/[Baka]_Test 9_1_1');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (313, 51, 'http://res.cloudinary.com/baka/image/upload/v1568991834/Test%209/1/%5BBaka%5D_Test%209_1_2.png', 2, 'Test 9/1/[Baka]_Test 9_1_2');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (314, 51, 'http://res.cloudinary.com/baka/image/upload/v1568991834/Test%209/1/%5BBaka%5D_Test%209_1_3.png', 3, 'Test 9/1/[Baka]_Test 9_1_3');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (315, 51, 'http://res.cloudinary.com/baka/image/upload/v1568991834/Test%209/1/%5BBaka%5D_Test%209_1_4.png', 4, 'Test 9/1/[Baka]_Test 9_1_4');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (316, 51, 'http://res.cloudinary.com/baka/image/upload/v1568991834/Test%209/1/%5BBaka%5D_Test%209_1_5.png', 5, 'Test 9/1/[Baka]_Test 9_1_5');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (317, 51, 'http://res.cloudinary.com/baka/image/upload/v1568991835/Test%209/1/%5BBaka%5D_Test%209_1_6.png', 6, 'Test 9/1/[Baka]_Test 9_1_6');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (318, 51, 'http://res.cloudinary.com/baka/image/upload/v1568991835/Test%209/1/%5BBaka%5D_Test%209_1_7.png', 7, 'Test 9/1/[Baka]_Test 9_1_7');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (319, 52, 'http://res.cloudinary.com/baka/image/upload/v1568991860/Test%208/1/%5BBaka%5D_Test%208_1_0.png', 0, 'Test 8/1/[Baka]_Test 8_1_0');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (320, 52, 'http://res.cloudinary.com/baka/image/upload/v1568991860/Test%208/1/%5BBaka%5D_Test%208_1_1.png', 1, 'Test 8/1/[Baka]_Test 8_1_1');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (321, 52, 'http://res.cloudinary.com/baka/image/upload/v1568991860/Test%208/1/%5BBaka%5D_Test%208_1_2.png', 2, 'Test 8/1/[Baka]_Test 8_1_2');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (322, 52, 'http://res.cloudinary.com/baka/image/upload/v1568991861/Test%208/1/%5BBaka%5D_Test%208_1_3.png', 3, 'Test 8/1/[Baka]_Test 8_1_3');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (323, 52, 'http://res.cloudinary.com/baka/image/upload/v1568991861/Test%208/1/%5BBaka%5D_Test%208_1_4.png', 4, 'Test 8/1/[Baka]_Test 8_1_4');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (324, 52, 'http://res.cloudinary.com/baka/image/upload/v1568991860/Test%208/1/%5BBaka%5D_Test%208_1_5.png', 5, 'Test 8/1/[Baka]_Test 8_1_5');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (325, 52, 'http://res.cloudinary.com/baka/image/upload/v1568991860/Test%208/1/%5BBaka%5D_Test%208_1_6.png', 6, 'Test 8/1/[Baka]_Test 8_1_6');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (326, 53, 'http://res.cloudinary.com/baka/image/upload/v1568991885/Test%207/1/%5BBaka%5D_Test%207_1_0.png', 0, 'Test 7/1/[Baka]_Test 7_1_0');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (327, 53, 'http://res.cloudinary.com/baka/image/upload/v1568991885/Test%207/1/%5BBaka%5D_Test%207_1_1.png', 1, 'Test 7/1/[Baka]_Test 7_1_1');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (328, 53, 'http://res.cloudinary.com/baka/image/upload/v1568991886/Test%207/1/%5BBaka%5D_Test%207_1_2.png', 2, 'Test 7/1/[Baka]_Test 7_1_2');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (329, 53, 'http://res.cloudinary.com/baka/image/upload/v1568991884/Test%207/1/%5BBaka%5D_Test%207_1_3.png', 3, 'Test 7/1/[Baka]_Test 7_1_3');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (330, 53, 'http://res.cloudinary.com/baka/image/upload/v1568991885/Test%207/1/%5BBaka%5D_Test%207_1_4.png', 4, 'Test 7/1/[Baka]_Test 7_1_4');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (331, 53, 'http://res.cloudinary.com/baka/image/upload/v1568991885/Test%207/1/%5BBaka%5D_Test%207_1_5.png', 5, 'Test 7/1/[Baka]_Test 7_1_5');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (332, 53, 'http://res.cloudinary.com/baka/image/upload/v1568991885/Test%207/1/%5BBaka%5D_Test%207_1_6.png', 6, 'Test 7/1/[Baka]_Test 7_1_6');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (340, 55, 'http://res.cloudinary.com/baka/image/upload/v1568991987/Test%206/1/%5BBaka%5D_Test%206_1_0.png', 0, 'Test 6/1/[Baka]_Test 6_1_0');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (341, 55, 'http://res.cloudinary.com/baka/image/upload/v1568991984/Test%206/1/%5BBaka%5D_Test%206_1_1.png', 1, 'Test 6/1/[Baka]_Test 6_1_1');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (342, 55, 'http://res.cloudinary.com/baka/image/upload/v1568991985/Test%206/1/%5BBaka%5D_Test%206_1_2.png', 2, 'Test 6/1/[Baka]_Test 6_1_2');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (343, 55, 'http://res.cloudinary.com/baka/image/upload/v1568991986/Test%206/1/%5BBaka%5D_Test%206_1_3.png', 3, 'Test 6/1/[Baka]_Test 6_1_3');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (344, 55, 'http://res.cloudinary.com/baka/image/upload/v1568991984/Test%206/1/%5BBaka%5D_Test%206_1_4.png', 4, 'Test 6/1/[Baka]_Test 6_1_4');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (345, 55, 'http://res.cloudinary.com/baka/image/upload/v1568991984/Test%206/1/%5BBaka%5D_Test%206_1_5.png', 5, 'Test 6/1/[Baka]_Test 6_1_5');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (346, 55, 'http://res.cloudinary.com/baka/image/upload/v1568991983/Test%206/1/%5BBaka%5D_Test%206_1_6.png', 6, 'Test 6/1/[Baka]_Test 6_1_6');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (347, 55, 'http://res.cloudinary.com/baka/image/upload/v1568991984/Test%206/1/%5BBaka%5D_Test%206_1_7.png', 7, 'Test 6/1/[Baka]_Test 6_1_7');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (348, 55, 'http://res.cloudinary.com/baka/image/upload/v1568991983/Test%206/1/%5BBaka%5D_Test%206_1_8.png', 8, 'Test 6/1/[Baka]_Test 6_1_8');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (349, 55, 'http://res.cloudinary.com/baka/image/upload/v1568991988/Test%206/1/%5BBaka%5D_Test%206_1_9.png', 9, 'Test 6/1/[Baka]_Test 6_1_9');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (350, 55, 'http://res.cloudinary.com/baka/image/upload/v1568991983/Test%206/1/%5BBaka%5D_Test%206_1_10.png', 10, 'Test 6/1/[Baka]_Test 6_1_10');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (351, 56, 'http://res.cloudinary.com/baka/image/upload/v1568992018/Test%205/1/%5BBaka%5D_Test%205_1_0.png', 0, 'Test 5/1/[Baka]_Test 5_1_0');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (352, 56, 'http://res.cloudinary.com/baka/image/upload/v1568992019/Test%205/1/%5BBaka%5D_Test%205_1_1.png', 1, 'Test 5/1/[Baka]_Test 5_1_1');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (353, 56, 'http://res.cloudinary.com/baka/image/upload/v1568992018/Test%205/1/%5BBaka%5D_Test%205_1_2.png', 2, 'Test 5/1/[Baka]_Test 5_1_2');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (354, 56, 'http://res.cloudinary.com/baka/image/upload/v1568992018/Test%205/1/%5BBaka%5D_Test%205_1_3.png', 3, 'Test 5/1/[Baka]_Test 5_1_3');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (355, 56, 'http://res.cloudinary.com/baka/image/upload/v1568992018/Test%205/1/%5BBaka%5D_Test%205_1_4.png', 4, 'Test 5/1/[Baka]_Test 5_1_4');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (356, 56, 'http://res.cloudinary.com/baka/image/upload/v1568992019/Test%205/1/%5BBaka%5D_Test%205_1_5.png', 5, 'Test 5/1/[Baka]_Test 5_1_5');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (357, 56, 'http://res.cloudinary.com/baka/image/upload/v1568992019/Test%205/1/%5BBaka%5D_Test%205_1_6.png', 6, 'Test 5/1/[Baka]_Test 5_1_6');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (358, 57, 'http://res.cloudinary.com/baka/image/upload/v1568992039/Test%204/1/%5BBaka%5D_Test%204_1_0.png', 0, 'Test 4/1/[Baka]_Test 4_1_0');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (359, 57, 'http://res.cloudinary.com/baka/image/upload/v1568992039/Test%204/1/%5BBaka%5D_Test%204_1_1.png', 1, 'Test 4/1/[Baka]_Test 4_1_1');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (360, 57, 'http://res.cloudinary.com/baka/image/upload/v1568992039/Test%204/1/%5BBaka%5D_Test%204_1_2.png', 2, 'Test 4/1/[Baka]_Test 4_1_2');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (361, 57, 'http://res.cloudinary.com/baka/image/upload/v1568992040/Test%204/1/%5BBaka%5D_Test%204_1_3.png', 3, 'Test 4/1/[Baka]_Test 4_1_3');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (362, 57, 'http://res.cloudinary.com/baka/image/upload/v1568992039/Test%204/1/%5BBaka%5D_Test%204_1_4.png', 4, 'Test 4/1/[Baka]_Test 4_1_4');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (363, 57, 'http://res.cloudinary.com/baka/image/upload/v1568992039/Test%204/1/%5BBaka%5D_Test%204_1_5.png', 5, 'Test 4/1/[Baka]_Test 4_1_5');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (364, 57, 'http://res.cloudinary.com/baka/image/upload/v1568992039/Test%204/1/%5BBaka%5D_Test%204_1_6.png', 6, 'Test 4/1/[Baka]_Test 4_1_6');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (365, 57, 'http://res.cloudinary.com/baka/image/upload/v1568992038/Test%204/1/%5BBaka%5D_Test%204_1_7.png', 7, 'Test 4/1/[Baka]_Test 4_1_7');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (366, 58, 'http://res.cloudinary.com/baka/image/upload/v1568992055/Test%203/1/%5BBaka%5D_Test%203_1_0.png', 0, 'Test 3/1/[Baka]_Test 3_1_0');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (367, 58, 'http://res.cloudinary.com/baka/image/upload/v1568992055/Test%203/1/%5BBaka%5D_Test%203_1_1.png', 1, 'Test 3/1/[Baka]_Test 3_1_1');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (368, 58, 'http://res.cloudinary.com/baka/image/upload/v1568992054/Test%203/1/%5BBaka%5D_Test%203_1_2.png', 2, 'Test 3/1/[Baka]_Test 3_1_2');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (369, 58, 'http://res.cloudinary.com/baka/image/upload/v1568992055/Test%203/1/%5BBaka%5D_Test%203_1_3.png', 3, 'Test 3/1/[Baka]_Test 3_1_3');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (370, 58, 'http://res.cloudinary.com/baka/image/upload/v1568992055/Test%203/1/%5BBaka%5D_Test%203_1_4.png', 4, 'Test 3/1/[Baka]_Test 3_1_4');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (371, 58, 'http://res.cloudinary.com/baka/image/upload/v1568992054/Test%203/1/%5BBaka%5D_Test%203_1_5.png', 5, 'Test 3/1/[Baka]_Test 3_1_5');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (372, 58, 'http://res.cloudinary.com/baka/image/upload/v1568992054/Test%203/1/%5BBaka%5D_Test%203_1_6.png', 6, 'Test 3/1/[Baka]_Test 3_1_6');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (373, 58, 'http://res.cloudinary.com/baka/image/upload/v1568992055/Test%203/1/%5BBaka%5D_Test%203_1_7.png', 7, 'Test 3/1/[Baka]_Test 3_1_7');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (374, 58, 'http://res.cloudinary.com/baka/image/upload/v1568992054/Test%203/1/%5BBaka%5D_Test%203_1_8.png', 8, 'Test 3/1/[Baka]_Test 3_1_8');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (375, 58, 'http://res.cloudinary.com/baka/image/upload/v1568992055/Test%203/1/%5BBaka%5D_Test%203_1_9.png', 9, 'Test 3/1/[Baka]_Test 3_1_9');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (376, 58, 'http://res.cloudinary.com/baka/image/upload/v1568992055/Test%203/1/%5BBaka%5D_Test%203_1_10.png', 10, 'Test 3/1/[Baka]_Test 3_1_10');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (377, 59, 'http://res.cloudinary.com/baka/image/upload/v1568992085/Test%202/1/%5BBaka%5D_Test%202_1_0.png', 0, 'Test 2/1/[Baka]_Test 2_1_0');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (378, 59, 'http://res.cloudinary.com/baka/image/upload/v1568992085/Test%202/1/%5BBaka%5D_Test%202_1_1.png', 1, 'Test 2/1/[Baka]_Test 2_1_1');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (379, 59, 'http://res.cloudinary.com/baka/image/upload/v1568992085/Test%202/1/%5BBaka%5D_Test%202_1_2.png', 2, 'Test 2/1/[Baka]_Test 2_1_2');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (380, 59, 'http://res.cloudinary.com/baka/image/upload/v1568992086/Test%202/1/%5BBaka%5D_Test%202_1_3.png', 3, 'Test 2/1/[Baka]_Test 2_1_3');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (381, 59, 'http://res.cloudinary.com/baka/image/upload/v1568992085/Test%202/1/%5BBaka%5D_Test%202_1_4.png', 4, 'Test 2/1/[Baka]_Test 2_1_4');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (382, 59, 'http://res.cloudinary.com/baka/image/upload/v1568992085/Test%202/1/%5BBaka%5D_Test%202_1_5.png', 5, 'Test 2/1/[Baka]_Test 2_1_5');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (383, 59, 'http://res.cloudinary.com/baka/image/upload/v1568992085/Test%202/1/%5BBaka%5D_Test%202_1_6.png', 6, 'Test 2/1/[Baka]_Test 2_1_6');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (384, 59, 'http://res.cloudinary.com/baka/image/upload/v1568992085/Test%202/1/%5BBaka%5D_Test%202_1_7.png', 7, 'Test 2/1/[Baka]_Test 2_1_7');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (385, 59, 'http://res.cloudinary.com/baka/image/upload/v1568992085/Test%202/1/%5BBaka%5D_Test%202_1_8.png', 8, 'Test 2/1/[Baka]_Test 2_1_8');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (386, 59, 'http://res.cloudinary.com/baka/image/upload/v1568992085/Test%202/1/%5BBaka%5D_Test%202_1_9.png', 9, 'Test 2/1/[Baka]_Test 2_1_9');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (387, 60, 'http://res.cloudinary.com/baka/image/upload/v1568992114/Test%201/1/%5BBaka%5D_Test%201_1_0.png', 0, 'Test 1/1/[Baka]_Test 1_1_0');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (388, 60, 'http://res.cloudinary.com/baka/image/upload/v1568992114/Test%201/1/%5BBaka%5D_Test%201_1_1.png', 1, 'Test 1/1/[Baka]_Test 1_1_1');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (389, 60, 'http://res.cloudinary.com/baka/image/upload/v1568992114/Test%201/1/%5BBaka%5D_Test%201_1_2.png', 2, 'Test 1/1/[Baka]_Test 1_1_2');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (390, 60, 'http://res.cloudinary.com/baka/image/upload/v1568992114/Test%201/1/%5BBaka%5D_Test%201_1_3.png', 3, 'Test 1/1/[Baka]_Test 1_1_3');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (391, 60, 'http://res.cloudinary.com/baka/image/upload/v1568992114/Test%201/1/%5BBaka%5D_Test%201_1_4.png', 4, 'Test 1/1/[Baka]_Test 1_1_4');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (392, 60, 'http://res.cloudinary.com/baka/image/upload/v1568992114/Test%201/1/%5BBaka%5D_Test%201_1_5.png', 5, 'Test 1/1/[Baka]_Test 1_1_5');
INSERT INTO public.page (id, chapter_id, url, number, cloud_id) VALUES (393, 60, 'http://res.cloudinary.com/baka/image/upload/v1568992115/Test%201/1/%5BBaka%5D_Test%201_1_6.png', 6, 'Test 1/1/[Baka]_Test 1_1_6');


--
-- TOC entry 3084 (class 0 OID 16468)
-- Dependencies: 215
-- Data for Name: rating; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.rating (id, user_account_id, content_folder_id, value, published) VALUES (3, 7, 23, false, '2018-08-22 18:09:54.863777+02');
INSERT INTO public.rating (id, user_account_id, content_folder_id, value, published) VALUES (4, 8, 23, true, '2018-08-22 18:10:11.040454+02');
INSERT INTO public.rating (id, user_account_id, content_folder_id, value, published) VALUES (64, 6, 23, true, '2018-10-05 17:54:06.354954+02');
INSERT INTO public.rating (id, user_account_id, content_folder_id, value, published) VALUES (69, 6, 1, true, '2018-12-25 17:53:47.219405+01');
INSERT INTO public.rating (id, user_account_id, content_folder_id, value, published) VALUES (73, 6, 42, true, '2019-10-05 15:24:44.70957+02');


--
-- TOC entry 3076 (class 0 OID 16438)
-- Dependencies: 207
-- Data for Name: relation; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3078 (class 0 OID 16446)
-- Dependencies: 209
-- Data for Name: relation_type; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3086 (class 0 OID 16476)
-- Dependencies: 217
-- Data for Name: user_account; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.user_account (id, user_role_id, published, email, profile_pic, birth) VALUES (6, 5, '2018-07-25 07:07:47.049833+02', 'dennis.baans@gmail.com', 'https://res.cloudinary.com/baka/image/upload/v1535124069/profile/dummy.png', '1992-12-18');
INSERT INTO public.user_account (id, user_role_id, published, email, profile_pic, birth) VALUES (7, 4, '2018-08-06 15:55:54.446457+02', 'dragon@rajjat.de', 'https://res.cloudinary.com/baka/image/upload/v1535124069/profile/dummy.png', '2008-08-13');
INSERT INTO public.user_account (id, user_role_id, published, email, profile_pic, birth) VALUES (8, 4, '2018-08-06 15:58:47.642959+02', 'pain@sama.org', 'https://res.cloudinary.com/baka/image/upload/v1535124069/profile/dummy.png', '2018-08-06');
INSERT INTO public.user_account (id, user_role_id, published, email, profile_pic, birth) VALUES (15, 1, '2018-08-06 18:30:10.604016+02', 'master@web.de', 'https://res.cloudinary.com/baka/image/upload/v1535124069/profile/dummy.png', '2018-08-06');


--
-- TOC entry 3088 (class 0 OID 16484)
-- Dependencies: 219
-- Data for Name: user_login; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.user_login (id, username, password_salt, password_hash, hash_algorythmus, user_account_id) VALUES (4, 'Itachidhdr', 'c3a7ae7eeaf06949dc61a10494ad63d8', 'a2a103230b3884bdb28ac3ae2aab61dfe8ce74371769ec4c544af3a8f12152c09ef070c360be85fd332919762ff4e327f2df3beca9093bfca3e25f24aa6ee831', '6', 6);
INSERT INTO public.user_login (id, username, password_salt, password_hash, hash_algorythmus, user_account_id) VALUES (5, 'Dragon', 'cd0910d6004bfe6694ad751bb7017071', 'd3cac6a18d1e76b983a177279d854eec53fe42e46bdaab4012946690ea1c997fb9e7bca6099d6f122f0c52f9c9113086395a2865a0c56b5e0a775b83ce699305', '7', 7);
INSERT INTO public.user_login (id, username, password_salt, password_hash, hash_algorythmus, user_account_id) VALUES (6, 'Pain', 'e63dce9b23f0c211d16a2dd1b0318e56', '8735e60fba3c32da6a803931c94959918c1682f910659e43f00c4ca271e3bf8dd4be5aff485bb4a3ad7850590a6729e2b65b38d0c176b543b561f3b8e463401f', '8', 8);
INSERT INTO public.user_login (id, username, password_salt, password_hash, hash_algorythmus, user_account_id) VALUES (11, 'Master', '77cffa1f71d85be3731eac08b9e01df1', 'c04ae4adefb7d09dda0729c28948ebbb6dad959790e6c6149e356bf39dc2089a28b488bbff1fbe6e72c904eaf5e3af4dc645cc8ca825df0fccc8ecde1a61268a', '15', 15);


--
-- TOC entry 3103 (class 0 OID 24795)
-- Dependencies: 234
-- Data for Name: user_read_content; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.user_read_content (id, content_folder_id, content_id, read_status, page_number, published, user_account_id, edited) VALUES (14, 44, 48, 'abgeschlossen', NULL, '2019-09-27 22:09:15.237518', 6, '2019-10-06 15:31:36.450482');
INSERT INTO public.user_read_content (id, content_folder_id, content_id, read_status, page_number, published, user_account_id, edited) VALUES (16, 36, 40, 'laufend', 0, '2019-10-09 16:01:25.372856', 6, NULL);
INSERT INTO public.user_read_content (id, content_folder_id, content_id, read_status, page_number, published, user_account_id, edited) VALUES (13, 7, 39, 'laufend', 2, '2019-09-20 14:37:52.799857', 6, '2019-10-12 11:50:12.518611');
INSERT INTO public.user_read_content (id, content_folder_id, content_id, read_status, page_number, published, user_account_id, edited) VALUES (2, 23, 23, 'laufend', 0, '2018-08-22 18:34:51.783848', 6, '2019-10-03 22:41:23.313264');
INSERT INTO public.user_read_content (id, content_folder_id, content_id, read_status, page_number, published, user_account_id, edited) VALUES (11, 1, 21, 'laufend', 0, '2018-09-29 22:55:18.636154', 6, '2019-09-20 10:02:51.562167');
INSERT INTO public.user_read_content (id, content_folder_id, content_id, read_status, page_number, published, user_account_id, edited) VALUES (12, 22, 25, 'laufend', 0, '2019-02-20 20:38:34.275128', 6, '2019-09-20 10:41:58.081757');
INSERT INTO public.user_read_content (id, content_folder_id, content_id, read_status, page_number, published, user_account_id, edited) VALUES (10, 23, 24, 'laufend', 14, '2018-09-28 12:27:17.867551', 6, '2019-10-06 14:17:35.066081');
INSERT INTO public.user_read_content (id, content_folder_id, content_id, read_status, page_number, published, user_account_id, edited) VALUES (15, 37, 31, 'laufend', 0, '2019-10-06 14:18:04.371972', 6, NULL);


--
-- TOC entry 3101 (class 0 OID 24787)
-- Dependencies: 232
-- Data for Name: user_read_content_folder; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.user_read_content_folder (id, user_account_id, content_folder_id, read_status, published, edited) VALUES (2, 6, 1, 'nichtInteressiert', '2018-09-29 22:55:18.634014', '2018-12-25 17:28:25.574299');
INSERT INTO public.user_read_content_folder (id, user_account_id, content_folder_id, read_status, published, edited) VALUES (3, 6, 22, 'laufend', '2019-02-20 20:38:34.27289', NULL);
INSERT INTO public.user_read_content_folder (id, user_account_id, content_folder_id, read_status, published, edited) VALUES (1, 6, 23, 'abgeschlossen', '2018-08-29 18:20:34.455459', '2019-03-06 20:08:55.202373');
INSERT INTO public.user_read_content_folder (id, user_account_id, content_folder_id, read_status, published, edited) VALUES (4, 6, 6, 'interessiert', '2019-09-20 14:37:50.708729', NULL);
INSERT INTO public.user_read_content_folder (id, user_account_id, content_folder_id, read_status, published, edited) VALUES (5, 6, 7, 'laufend', '2019-09-20 14:37:52.797212', NULL);
INSERT INTO public.user_read_content_folder (id, user_account_id, content_folder_id, read_status, published, edited) VALUES (6, 6, 6, 'interessiert', '2019-09-27 21:27:31.920153', NULL);
INSERT INTO public.user_read_content_folder (id, user_account_id, content_folder_id, read_status, published, edited) VALUES (8, 6, 6, 'interessiert', '2019-10-05 15:23:51.880426', NULL);
INSERT INTO public.user_read_content_folder (id, user_account_id, content_folder_id, read_status, published, edited) VALUES (9, 6, 6, 'interessiert', '2019-10-05 15:48:19.650555', NULL);
INSERT INTO public.user_read_content_folder (id, user_account_id, content_folder_id, read_status, published, edited) VALUES (10, 6, 37, 'laufend', '2019-10-06 14:18:04.36945', NULL);
INSERT INTO public.user_read_content_folder (id, user_account_id, content_folder_id, read_status, published, edited) VALUES (7, 6, 44, 'abgeschlossen', '2019-09-27 22:09:15.237401', '2019-10-06 15:31:36.457156');
INSERT INTO public.user_read_content_folder (id, user_account_id, content_folder_id, read_status, published, edited) VALUES (11, 6, 36, 'laufend', '2019-10-09 16:01:25.372958', NULL);


--
-- TOC entry 3090 (class 0 OID 16507)
-- Dependencies: 221
-- Data for Name: user_role; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.user_role (id, name, visable_id) VALUES (2, 'User', 1);
INSERT INTO public.user_role (id, name, visable_id) VALUES (5, 'Admin', 4);
INSERT INTO public.user_role (id, name, visable_id) VALUES (1, 'Gast', 1);
INSERT INTO public.user_role (id, name, visable_id) VALUES (4, 'Team', 3);
INSERT INTO public.user_role (id, name, visable_id) VALUES (3, 'Premium', 2);


--
-- TOC entry 3093 (class 0 OID 16539)
-- Dependencies: 224
-- Data for Name: visable; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.visable (id, name) VALUES (1, 'Öffentlich');
INSERT INTO public.visable (id, name) VALUES (2, 'Premium');
INSERT INTO public.visable (id, name) VALUES (3, 'Team');
INSERT INTO public.visable (id, name) VALUES (4, 'Privat');


--
-- TOC entry 3091 (class 0 OID 16523)
-- Dependencies: 222
-- Data for Name: watchlist; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.watchlist (user_account_id, content_folder_id, published) VALUES (6, 1, '2018-12-25 17:27:59.479735');
INSERT INTO public.watchlist (user_account_id, content_folder_id, published) VALUES (6, 23, '2019-09-18 19:17:06.155959');
INSERT INTO public.watchlist (user_account_id, content_folder_id, published) VALUES (6, 44, '2019-09-27 22:09:20.934851');
INSERT INTO public.watchlist (user_account_id, content_folder_id, published) VALUES (6, 7, '2019-09-27 22:54:11.369133');


--
-- TOC entry 3134 (class 0 OID 0)
-- Dependencies: 235
-- Name: blog_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.blog_id_seq', 9, true);


--
-- TOC entry 3135 (class 0 OID 0)
-- Dependencies: 198
-- Name: chapter_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.chapter_id_seq', 60, true);


--
-- TOC entry 3136 (class 0 OID 0)
-- Dependencies: 204
-- Name: comic_ganre_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.comic_ganre_id_seq', 296, true);


--
-- TOC entry 3137 (class 0 OID 0)
-- Dependencies: 196
-- Name: comic_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.comic_id_seq', 55, true);


--
-- TOC entry 3138 (class 0 OID 0)
-- Dependencies: 229
-- Name: comment_reply_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.comment_reply_id_seq', 12, true);


--
-- TOC entry 3139 (class 0 OID 0)
-- Dependencies: 227
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.comments_id_seq', 16, true);


--
-- TOC entry 3140 (class 0 OID 0)
-- Dependencies: 225
-- Name: content_folder_calls_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.content_folder_calls_id_seq', 649, true);


--
-- TOC entry 3141 (class 0 OID 0)
-- Dependencies: 210
-- Name: content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.content_type_id_seq', 3, true);


--
-- TOC entry 3142 (class 0 OID 0)
-- Dependencies: 202
-- Name: genre_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.genre_id_seq', 10, true);


--
-- TOC entry 3143 (class 0 OID 0)
-- Dependencies: 200
-- Name: page_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.page_id_seq', 393, true);


--
-- TOC entry 3144 (class 0 OID 0)
-- Dependencies: 214
-- Name: rating_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.rating_id_seq', 73, true);


--
-- TOC entry 3145 (class 0 OID 0)
-- Dependencies: 206
-- Name: relation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.relation_id_seq', 1, false);


--
-- TOC entry 3146 (class 0 OID 0)
-- Dependencies: 208
-- Name: relation_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.relation_type_id_seq', 1, false);


--
-- TOC entry 3147 (class 0 OID 0)
-- Dependencies: 212
-- Name: status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.status_id_seq', 4, true);


--
-- TOC entry 3148 (class 0 OID 0)
-- Dependencies: 216
-- Name: user_account_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.user_account_id_seq', 15, true);


--
-- TOC entry 3149 (class 0 OID 0)
-- Dependencies: 218
-- Name: user_login_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.user_login_id_seq', 11, true);


--
-- TOC entry 3150 (class 0 OID 0)
-- Dependencies: 231
-- Name: user_read_content_folder_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.user_read_content_folder_id_seq', 11, true);


--
-- TOC entry 3151 (class 0 OID 0)
-- Dependencies: 233
-- Name: user_read_content_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.user_read_content_id_seq', 16, true);


--
-- TOC entry 3152 (class 0 OID 0)
-- Dependencies: 220
-- Name: user_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.user_role_id_seq', 5, true);


--
-- TOC entry 3153 (class 0 OID 0)
-- Dependencies: 223
-- Name: visable_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.visable_id_seq', 4, true);


--
-- TOC entry 2943 (class 2606 OID 24816)
-- Name: blog blog_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blog
    ADD CONSTRAINT blog_pkey PRIMARY KEY (id);


--
-- TOC entry 2905 (class 2606 OID 16404)
-- Name: content chapter_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.content
    ADD CONSTRAINT chapter_pkey PRIMARY KEY (id);


--
-- TOC entry 2911 (class 2606 OID 16435)
-- Name: content_folder_genre comic_ganre_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.content_folder_genre
    ADD CONSTRAINT comic_ganre_pkey PRIMARY KEY (id);


--
-- TOC entry 2903 (class 2606 OID 16396)
-- Name: content_folder comic_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.content_folder
    ADD CONSTRAINT comic_pkey PRIMARY KEY (id);


--
-- TOC entry 2937 (class 2606 OID 24770)
-- Name: comment_reply comment_reply_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comment_reply
    ADD CONSTRAINT comment_reply_pkey PRIMARY KEY (id);


--
-- TOC entry 2935 (class 2606 OID 16578)
-- Name: comment comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- TOC entry 2933 (class 2606 OID 16567)
-- Name: content_folder_counter content_folder_calls_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.content_folder_counter
    ADD CONSTRAINT content_folder_calls_pkey PRIMARY KEY (id);


--
-- TOC entry 2917 (class 2606 OID 16459)
-- Name: content_folder_type content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.content_folder_type
    ADD CONSTRAINT content_type_pkey PRIMARY KEY (id);


--
-- TOC entry 2921 (class 2606 OID 16548)
-- Name: user_account email; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_account
    ADD CONSTRAINT email UNIQUE (email);


--
-- TOC entry 2909 (class 2606 OID 16427)
-- Name: genre genre_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.genre
    ADD CONSTRAINT genre_pkey PRIMARY KEY (id);


--
-- TOC entry 2907 (class 2606 OID 16419)
-- Name: page page_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.page
    ADD CONSTRAINT page_pkey PRIMARY KEY (id);


--
-- TOC entry 2919 (class 2606 OID 16473)
-- Name: rating rating_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rating
    ADD CONSTRAINT rating_pkey PRIMARY KEY (id);


--
-- TOC entry 2913 (class 2606 OID 16443)
-- Name: relation relation_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.relation
    ADD CONSTRAINT relation_pkey PRIMARY KEY (id);


--
-- TOC entry 2915 (class 2606 OID 16451)
-- Name: relation_type relation_type_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.relation_type
    ADD CONSTRAINT relation_type_pkey PRIMARY KEY (id);


--
-- TOC entry 2923 (class 2606 OID 16481)
-- Name: user_account user_account_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_account
    ADD CONSTRAINT user_account_pkey PRIMARY KEY (id);


--
-- TOC entry 2925 (class 2606 OID 16489)
-- Name: user_login user_login_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_login
    ADD CONSTRAINT user_login_pkey PRIMARY KEY (id);


--
-- TOC entry 2939 (class 2606 OID 24792)
-- Name: user_read_content_folder user_read_content_folder_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_read_content_folder
    ADD CONSTRAINT user_read_content_folder_pkey PRIMARY KEY (id);


--
-- TOC entry 2941 (class 2606 OID 24800)
-- Name: user_read_content user_read_content_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_read_content
    ADD CONSTRAINT user_read_content_pkey PRIMARY KEY (id);


--
-- TOC entry 2929 (class 2606 OID 16512)
-- Name: user_role user_role_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_role
    ADD CONSTRAINT user_role_pkey PRIMARY KEY (id);


--
-- TOC entry 2927 (class 2606 OID 16546)
-- Name: user_login username; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_login
    ADD CONSTRAINT username UNIQUE (username);


--
-- TOC entry 2931 (class 2606 OID 16544)
-- Name: visable visable_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.visable
    ADD CONSTRAINT visable_pkey PRIMARY KEY (id);


-- Completed on 2019-10-13 00:48:28 CEST

--
-- PostgreSQL database dump complete
--


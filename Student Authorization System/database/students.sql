-- Table: public.student

-- DROP TABLE IF EXISTS public.student;

CREATE TABLE IF NOT EXISTS public.student
(
    id integer NOT NULL DEFAULT nextval('student_id_seq'::regclass),
    surname character varying(50) COLLATE pg_catalog."default" NOT NULL,
    name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    patronymic character varying(50) COLLATE pg_catalog."default" NOT NULL,
    birthdate date,
    telegram character varying(50) COLLATE pg_catalog."default",
    email character varying(50) COLLATE pg_catalog."default",
    phone character varying(50) COLLATE pg_catalog."default",
    git character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT student_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;


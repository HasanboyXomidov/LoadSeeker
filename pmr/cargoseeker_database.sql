PGDMP                         {            CargoSeeker    15.3    15.3 4    N           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            O           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            P           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            Q           1262    17799    CargoSeeker    DATABASE     �   CREATE DATABASE "CargoSeeker" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1251';
    DROP DATABASE "CargoSeeker";
                postgres    false            �            1259    17984    cargo    TABLE     �  CREATE TABLE public.cargo (
    id bigint NOT NULL,
    userid bigint NOT NULL,
    cargo text,
    cargo_weight real,
    cargo_volume real,
    startingtime timestamp without time zone,
    day_after_archive integer DEFAULT 0,
    startloadingplace text,
    loadinglattitude double precision,
    loadinglongtitude double precision,
    finishunloadingplace text,
    unloadinglattitude double precision,
    unloadinglongtitude double precision,
    bodytype text,
    bid real,
    payment_type text,
    description text,
    postcargoafterminut integer DEFAULT 0,
    is_active boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);
    DROP TABLE public.cargo;
       public         heap    postgres    false            �            1259    17983    cargo_id_seq    SEQUENCE     �   ALTER TABLE public.cargo ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.cargo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    221            �            1259    17954    users    TABLE     [  CREATE TABLE public.users (
    id bigint NOT NULL,
    first_name character varying(50) NOT NULL,
    second_name character varying(50),
    country text,
    tel_number character varying(15) NOT NULL,
    email text NOT NULL,
    password_hash text NOT NULL,
    salt text NOT NULL,
    user_photo_path text,
    documentpicture_id bigint,
    status text,
    last_activity timestamp without time zone,
    rating integer,
    review_id bigint,
    lattitude double precision,
    longtitude double precision,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);
    DROP TABLE public.users;
       public         heap    postgres    false            �            1259    18070    cargos_view    VIEW     �  CREATE VIEW public.cargos_view AS
 SELECT cargo.id,
    users.id AS userid,
    (((users.tel_number)::text || ' '::text) || users.email) AS user_informations,
    users.rating AS user_rating,
    cargo.cargo AS text,
    cargo.cargo_weight,
    cargo.cargo_volume,
    cargo.startingtime,
    cargo.day_after_archive,
    cargo.startloadingplace,
    cargo.loadinglattitude,
    cargo.loadinglongtitude,
    cargo.finishunloadingplace,
    cargo.unloadinglattitude,
    cargo.unloadinglongtitude,
    cargo.bodytype,
    cargo.bid,
    cargo.payment_type,
    cargo.description,
    cargo.postcargoafterminut,
    cargo.is_active,
    cargo.created_at
   FROM (public.cargo
     JOIN public.users ON ((cargo.userid = users.id)));
    DROP VIEW public.cargos_view;
       public          postgres    false    221    217    217    217    217    221    221    221    221    221    221    221    221    221    221    221    221    221    221    221    221    221    221    221            �            1259    17946    documentpictures    TABLE     �   CREATE TABLE public.documentpictures (
    id bigint NOT NULL,
    passport_image_path text,
    driverlicence_image_path text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);
 $   DROP TABLE public.documentpictures;
       public         heap    postgres    false            �            1259    17945    documentpictures_id_seq    SEQUENCE     �   ALTER TABLE public.documentpictures ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.documentpictures_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    215            �            1259    18014    getcargo    TABLE     f  CREATE TABLE public.getcargo (
    id bigint NOT NULL,
    transport_id bigint NOT NULL,
    cargo_id bigint NOT NULL,
    is_accepted boolean,
    status text,
    description text,
    bid real,
    distance_type text,
    agreement_day timestamp without time zone,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);
    DROP TABLE public.getcargo;
       public         heap    postgres    false            �            1259    18013    getcargo_id_seq    SEQUENCE     �   ALTER TABLE public.getcargo ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.getcargo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    225            �            1259    18032    gettransport    TABLE     j  CREATE TABLE public.gettransport (
    id bigint NOT NULL,
    transport_id bigint NOT NULL,
    cargo_id bigint NOT NULL,
    is_accepted boolean,
    status text,
    description text,
    bid real,
    distance_type text,
    agreement_day timestamp without time zone,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);
     DROP TABLE public.gettransport;
       public         heap    postgres    false            �            1259    18031    gettransport_id_seq    SEQUENCE     �   ALTER TABLE public.gettransport ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.gettransport_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    227            �            1259    18000 	   transport    TABLE     �  CREATE TABLE public.transport (
    id bigint NOT NULL,
    userid bigint NOT NULL,
    bodytype text,
    bodycapacity real,
    bodyvolume real,
    bodylength real,
    bodywidth real,
    bodyheight real,
    permission text,
    startinglocation text,
    endinglocation text,
    startingtime timestamp without time zone,
    archivizeafterday integer DEFAULT 2,
    payment text,
    is_active boolean,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);
    DROP TABLE public.transport;
       public         heap    postgres    false            �            1259    18080    gettransportview    VIEW     a  CREATE VIEW public.gettransportview AS
 SELECT gettransport.id,
    transport.id AS transportid,
    transport.bodytype,
    transport.bodycapacity,
    cargo.id AS cargoid,
    cargo.cargo,
    cargo.cargo_weight,
    cargo.startingtime,
    gettransport.is_accepted,
    gettransport.status,
    gettransport.description,
    gettransport.bid,
    gettransport.distance_type,
    gettransport.agreement_day,
    gettransport.created_at
   FROM ((public.gettransport
     JOIN public.transport ON ((transport.id = gettransport.transport_id)))
     JOIN public.cargo ON ((cargo.id = gettransport.cargo_id)));
 #   DROP VIEW public.gettransportview;
       public          postgres    false    221    221    221    221    223    223    223    227    227    227    227    227    227    227    227    227    227            �            1259    17971    reviews    TABLE     �   CREATE TABLE public.reviews (
    id bigint NOT NULL,
    userid bigint NOT NULL,
    review_text text NOT NULL,
    is_edited boolean,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);
    DROP TABLE public.reviews;
       public         heap    postgres    false            �            1259    17970    reviews_id_seq    SEQUENCE     �   ALTER TABLE public.reviews ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.reviews_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    219            �            1259    17999    transport_id_seq    SEQUENCE     �   ALTER TABLE public.transport ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.transport_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    223            �            1259    18075    transportviewmodel    VIEW     �  CREATE VIEW public.transportviewmodel AS
 SELECT transport.id,
    users.id AS userid,
    (((users.tel_number)::text || ' '::text) || users.email) AS user_informations,
    users.rating AS user_rating,
    transport.bodytype,
    transport.bodycapacity,
    transport.bodyvolume,
    transport.bodylength,
    transport.bodywidth,
    transport.bodyheight,
    transport.permission,
    transport.startinglocation,
    transport.endinglocation,
    transport.startingtime,
    transport.archivizeafterday,
    transport.payment,
    transport.is_active,
    transport.created_at
   FROM (public.transport
     JOIN public.users ON ((users.id = transport.userid)));
 %   DROP VIEW public.transportviewmodel;
       public          postgres    false    223    223    223    223    223    223    223    223    217    217    223    223    223    223    223    217    217    223    223    223            �            1259    17953    users_id_seq    SEQUENCE     �   ALTER TABLE public.users ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    217            E          0    17984    cargo 
   TABLE DATA           H  COPY public.cargo (id, userid, cargo, cargo_weight, cargo_volume, startingtime, day_after_archive, startloadingplace, loadinglattitude, loadinglongtitude, finishunloadingplace, unloadinglattitude, unloadinglongtitude, bodytype, bid, payment_type, description, postcargoafterminut, is_active, created_at, updated_at) FROM stdin;
    public          postgres    false    221   �N       ?          0    17946    documentpictures 
   TABLE DATA           u   COPY public.documentpictures (id, passport_image_path, driverlicence_image_path, created_at, updated_at) FROM stdin;
    public          postgres    false    215   �O       I          0    18014    getcargo 
   TABLE DATA           �   COPY public.getcargo (id, transport_id, cargo_id, is_accepted, status, description, bid, distance_type, agreement_day, created_at, updated_at) FROM stdin;
    public          postgres    false    225   �O       K          0    18032    gettransport 
   TABLE DATA           �   COPY public.gettransport (id, transport_id, cargo_id, is_accepted, status, description, bid, distance_type, agreement_day, created_at, updated_at) FROM stdin;
    public          postgres    false    227   �O       C          0    17971    reviews 
   TABLE DATA           ]   COPY public.reviews (id, userid, review_text, is_edited, created_at, updated_at) FROM stdin;
    public          postgres    false    219   eP       G          0    18000 	   transport 
   TABLE DATA           �   COPY public.transport (id, userid, bodytype, bodycapacity, bodyvolume, bodylength, bodywidth, bodyheight, permission, startinglocation, endinglocation, startingtime, archivizeafterday, payment, is_active, created_at, updated_at) FROM stdin;
    public          postgres    false    223   �P       A          0    17954    users 
   TABLE DATA           �   COPY public.users (id, first_name, second_name, country, tel_number, email, password_hash, salt, user_photo_path, documentpicture_id, status, last_activity, rating, review_id, lattitude, longtitude, created_at, updated_at) FROM stdin;
    public          postgres    false    217   Q       R           0    0    cargo_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.cargo_id_seq', 1, true);
          public          postgres    false    220            S           0    0    documentpictures_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.documentpictures_id_seq', 1, true);
          public          postgres    false    214            T           0    0    getcargo_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.getcargo_id_seq', 1, false);
          public          postgres    false    224            U           0    0    gettransport_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.gettransport_id_seq', 2, true);
          public          postgres    false    226            V           0    0    reviews_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.reviews_id_seq', 1, false);
          public          postgres    false    218            W           0    0    transport_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.transport_id_seq', 1, true);
          public          postgres    false    222            X           0    0    users_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.users_id_seq', 26, true);
          public          postgres    false    216            �           2606    17993    cargo cargo_id_key 
   CONSTRAINT     K   ALTER TABLE ONLY public.cargo
    ADD CONSTRAINT cargo_id_key UNIQUE (id);
 <   ALTER TABLE ONLY public.cargo DROP CONSTRAINT cargo_id_key;
       public            postgres    false    221            �           2606    17952 (   documentpictures documentpictures_id_key 
   CONSTRAINT     a   ALTER TABLE ONLY public.documentpictures
    ADD CONSTRAINT documentpictures_id_key UNIQUE (id);
 R   ALTER TABLE ONLY public.documentpictures DROP CONSTRAINT documentpictures_id_key;
       public            postgres    false    215            �           2606    18020    getcargo getcargo_id_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.getcargo
    ADD CONSTRAINT getcargo_id_key UNIQUE (id);
 B   ALTER TABLE ONLY public.getcargo DROP CONSTRAINT getcargo_id_key;
       public            postgres    false    225            �           2606    18038     gettransport gettransport_id_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.gettransport
    ADD CONSTRAINT gettransport_id_key UNIQUE (id);
 J   ALTER TABLE ONLY public.gettransport DROP CONSTRAINT gettransport_id_key;
       public            postgres    false    227            �           2606    17977    reviews reviews_id_key 
   CONSTRAINT     O   ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_id_key UNIQUE (id);
 @   ALTER TABLE ONLY public.reviews DROP CONSTRAINT reviews_id_key;
       public            postgres    false    219            �           2606    18007    transport transport_id_key 
   CONSTRAINT     S   ALTER TABLE ONLY public.transport
    ADD CONSTRAINT transport_id_key UNIQUE (id);
 D   ALTER TABLE ONLY public.transport DROP CONSTRAINT transport_id_key;
       public            postgres    false    223            �           2606    17964    users users_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
       public            postgres    false    217            �           2606    17960    users users_id_key 
   CONSTRAINT     K   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_id_key UNIQUE (id);
 <   ALTER TABLE ONLY public.users DROP CONSTRAINT users_id_key;
       public            postgres    false    217            �           2606    17962    users users_tel_number_key 
   CONSTRAINT     [   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_tel_number_key UNIQUE (tel_number);
 D   ALTER TABLE ONLY public.users DROP CONSTRAINT users_tel_number_key;
       public            postgres    false    217            �           2606    17994    cargo cargo_userid_fkey    FK CONSTRAINT     u   ALTER TABLE ONLY public.cargo
    ADD CONSTRAINT cargo_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(id);
 A   ALTER TABLE ONLY public.cargo DROP CONSTRAINT cargo_userid_fkey;
       public          postgres    false    217    221    3224            �           2606    18026    getcargo getcargo_cargo_id_fkey    FK CONSTRAINT        ALTER TABLE ONLY public.getcargo
    ADD CONSTRAINT getcargo_cargo_id_fkey FOREIGN KEY (cargo_id) REFERENCES public.cargo(id);
 I   ALTER TABLE ONLY public.getcargo DROP CONSTRAINT getcargo_cargo_id_fkey;
       public          postgres    false    225    221    3230            �           2606    18021 #   getcargo getcargo_transport_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.getcargo
    ADD CONSTRAINT getcargo_transport_id_fkey FOREIGN KEY (transport_id) REFERENCES public.transport(id);
 M   ALTER TABLE ONLY public.getcargo DROP CONSTRAINT getcargo_transport_id_fkey;
       public          postgres    false    223    225    3232            �           2606    18044 '   gettransport gettransport_cargo_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.gettransport
    ADD CONSTRAINT gettransport_cargo_id_fkey FOREIGN KEY (cargo_id) REFERENCES public.cargo(id);
 Q   ALTER TABLE ONLY public.gettransport DROP CONSTRAINT gettransport_cargo_id_fkey;
       public          postgres    false    221    227    3230            �           2606    18039 +   gettransport gettransport_transport_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.gettransport
    ADD CONSTRAINT gettransport_transport_id_fkey FOREIGN KEY (transport_id) REFERENCES public.transport(id);
 U   ALTER TABLE ONLY public.gettransport DROP CONSTRAINT gettransport_transport_id_fkey;
       public          postgres    false    223    227    3232            �           2606    17978    reviews reviews_userid_fkey    FK CONSTRAINT     y   ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(id);
 E   ALTER TABLE ONLY public.reviews DROP CONSTRAINT reviews_userid_fkey;
       public          postgres    false    217    219    3224            �           2606    18008    transport transport_userid_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY public.transport
    ADD CONSTRAINT transport_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(id);
 I   ALTER TABLE ONLY public.transport DROP CONSTRAINT transport_userid_fkey;
       public          postgres    false    3224    223    217            �           2606    17965 #   users users_documentpicture_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_documentpicture_id_fkey FOREIGN KEY (documentpicture_id) REFERENCES public.documentpictures(id);
 M   ALTER TABLE ONLY public.users DROP CONSTRAINT users_documentpicture_id_fkey;
       public          postgres    false    215    3220    217            E   �   x�U��
�0Dϛ��4�&]�概�Aң��ц[҈����
�43�@؎c�!�m
�U��g�Q+�W�fj���`q���[7|���)>cj��0����8əCz�<Iy���r-�:5�	��	�K�	�#�-�+M��<�r�ĕ�*!���4      ?   +   x�3�L,NIa�?N##c]s]Cs+0�&����� �r6      I      x������ � �      K   n   x�3�4�Nϼ������bNG��Ĕb�42500��
����4202�50�52S0��25�24�32�04A���2��20�320�0E�22�22�2��31324������ ���      C      x������ � �      G   �   x�U�;�0��S���k�q���ƅI"�D2n�=��(��[L���ym��р� ���t���^^u��6/e+`�v4a�4P��a-�%YΟ�1��*���8��l��S)��b�s�$��VJ}&"I      A   �  x�}�[��0���_��UN}{��R���Q�^�rB��e}�J�V�}9��|���u[�ʺ�ԵU����c��j�ݭ�3k�2a�dq�|�5xz~1o]��y��V�� ��kB�F�D���VJ��h����KӪus�M��ݛ��Y���T����Q��S�qV�����#G��LH�����0a"��ο,�e$y��M���M�_{	�K�0}�����	�㼷�������l��r��/��5�v�� '�s�����̌��t��]��j0��(5��!x�)fJR���$��a���ƺ�J�*m��-�͹�^[�_�
}�!���T�d|<�QX�H�H��Hhr�[��uE����#��a��vp/�����rR�Ǎ��Ί��݇yQ�&��.�WbP?L;������Z(�2�����UP:ZX�	,g����$�i
���b��I���qE?��     
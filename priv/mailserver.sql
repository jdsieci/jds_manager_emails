--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- Name: mailserver; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE mailserver WITH TEMPLATE = template0 ENCODING = 'UTF8';


ALTER DATABASE mailserver OWNER TO postgres;

\connect mailserver

SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- Name: altro; Type: SCHEMA; Schema: -; Owner: altro@mailserver
--

CREATE SCHEMA altro;


ALTER SCHEMA altro OWNER TO "altro@mailserver";

--
-- Name: budmk; Type: SCHEMA; Schema: -; Owner: budmk@mailserver
--

CREATE SCHEMA budmk;


ALTER SCHEMA budmk OWNER TO "budmk@mailserver";

--
-- Name: jds; Type: SCHEMA; Schema: -; Owner: jds
--

CREATE SCHEMA jds;


ALTER SCHEMA jds OWNER TO jds;

--
-- Name: kmprzedszkolak; Type: SCHEMA; Schema: -; Owner: kmprzedszkolak@mailserver
--

CREATE SCHEMA kmprzedszkolak;


ALTER SCHEMA kmprzedszkolak OWNER TO "kmprzedszkolak@mailserver";

--
-- Name: mailserver; Type: SCHEMA; Schema: -; Owner: mailserver
--

CREATE SCHEMA mailserver;


ALTER SCHEMA mailserver OWNER TO mailserver;

--
-- Name: ovum; Type: SCHEMA; Schema: -; Owner: ovum@mailserver
--

CREATE SCHEMA ovum;


ALTER SCHEMA ovum OWNER TO "ovum@mailserver";

--
-- Name: street_terror; Type: SCHEMA; Schema: -; Owner: street_terror@mailserver
--

CREATE SCHEMA street_terror;


ALTER SCHEMA street_terror OWNER TO "street_terror@mailserver";

--
-- Name: plpgsql; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: postgres
--

CREATE PROCEDURAL LANGUAGE plpgsql;


ALTER PROCEDURAL LANGUAGE plpgsql OWNER TO postgres;

SET search_path = altro, pg_catalog;

--
-- Name: vmail-mailserver_virtual_aliases(); Type: FUNCTION; Schema: altro; Owner: client
--

CREATE FUNCTION "vmail-mailserver_virtual_aliases"() RETURNS trigger
    AS $$DECLARE
id_domain INTEGER;
BEGIN
IF (TG_OP != 'DELETE')THEN
SELECT INTO id_domain mailserver FROM virtual_domains_ids WHERE id=NEW.domain_id;
END IF;
IF (TG_OP = 'INSERT') THEN
INSERT INTO mailserver.virtual_aliases(domain_id,source,destination) VALUES(id_domain,NEW.source,NEW.destination);
END IF;
IF (TG_OP = 'DELETE') THEN
DELETE FROM mailserver.virtual_aliases WHERE OLD.source=mailserver.virtual_aliases.source AND OLD.destination=destination;
END IF;
IF (TG_OP = 'UPDATE') THEN
UPDATE mailserver.virtual_aliases SET source=NEW.source, destination=NEW.destination, domain_id=id_domain
WHERE source=OLD.source AND destination=OLD.destination AND domain_id=OLD.domain_id;
END IF;
IF (TG_OP = 'DELETE') THEN
RETURN OLD;
ELSE
RETURN NEW;
END IF;
END
$$
    LANGUAGE plpgsql;


ALTER FUNCTION altro."vmail-mailserver_virtual_aliases"() OWNER TO client;

--
-- Name: vmail-mailserver_virtual_domain(); Type: FUNCTION; Schema: altro; Owner: client
--

CREATE FUNCTION "vmail-mailserver_virtual_domain"() RETURNS trigger
    AS $$DECLARE
id_domain INTEGER;
BEGIN
IF ( TG_OP != 'INSERT')THEN
SELECT INTO id_domain mailserver FROM virtual_domains_ids WHERE id=OLD.id;
END IF;
IF (TG_OP = 'INSERT') THEN
INSERT INTO mailserver.virtual_domains("name") VALUES(NEW.name);
END IF;
IF (TG_OP = 'DELETE') THEN
DELETE FROM mailserver.virtual_domains WHERE id=id_domain;
END IF;
IF (TG_OP = 'UPDATE') THEN
UPDATE mailserver.virtual_domains SET "name"=NEW.name WHERE id=id_domain;
END IF;
IF (TG_OP = 'DELETE') THEN
RETURN OLD;
ELSE
RETURN NEW;
END IF;
END
$$
    LANGUAGE plpgsql;


ALTER FUNCTION altro."vmail-mailserver_virtual_domain"() OWNER TO client;

--
-- Name: vmail-mailserver_virtual_users(); Type: FUNCTION; Schema: altro; Owner: client
--

CREATE FUNCTION "vmail-mailserver_virtual_users"() RETURNS trigger
    AS $$DECLARE
id_domain INTEGER;
BEGIN
IF (TG_OP != 'DELETE')THEN
SELECT INTO id_domain mailserver FROM virtual_domains_ids WHERE id=NEW.domain_id;
END IF;
IF (TG_OP = 'INSERT') THEN
INSERT INTO mailserver.virtual_users("user","password","domain_id") VALUES(NEW.user,NEW.password,id_domain);
END IF;
IF (TG_OP = 'DELETE') THEN
DELETE FROM mailserver.virtual_users WHERE OLD.user=mailserver.virtual_users.user AND OLD.password=mailserver.virtual_users.password;
END IF;
IF (TG_OP = 'UPDATE') THEN
UPDATE mailserver.virtual_users SET "user"=NEW.user, "password"=NEW.password, domain_id=id_domain WHERE "user"=OLD.user AND "password"=OLD.password AND "domain_id"=OLD.domain_id;
END IF;
IF (TG_OP = 'DELETE') THEN
RETURN OLD;
ELSE
RETURN NEW;
END IF;
END
$$
    LANGUAGE plpgsql;


ALTER FUNCTION altro."vmail-mailserver_virtual_users"() OWNER TO client;

SET search_path = budmk, pg_catalog;

--
-- Name: vmail-mailserver_virtual_aliases(); Type: FUNCTION; Schema: budmk; Owner: postgres
--

CREATE FUNCTION "vmail-mailserver_virtual_aliases"() RETURNS trigger
    AS $$DECLARE
  id_domain INTEGER;
BEGIN
  IF (TG_OP != 'DELETE')THEN
    SELECT INTO id_domain mailserver FROM virtual_domains_ids WHERE id=NEW.domain_id;
  END IF;
  IF (TG_OP = 'INSERT') THEN
	INSERT INTO mailserver.virtual_aliases(domain_id,source,destination) VALUES(id_domain,NEW.source,NEW.destination);
  END IF;
  IF (TG_OP = 'DELETE') THEN
	DELETE FROM mailserver.virtual_aliases WHERE OLD.source=mailserver.virtual_aliases.source AND OLD.destination=mailserver.virtual_aliases.destination;
  END IF;
  IF (TG_OP = 'UPDATE') THEN
	UPDATE mailserver.virtual_aliases SET source=NEW.source, destination=NEW.destination, domain_id=id_domain
		WHERE source=OLD.source AND destination=OLD.destination AND domain_id=OLD.domain_id;
  END IF;
  IF (TG_OP = 'DELETE') THEN
	RETURN OLD;
  ELSE
	RETURN NEW;
  END IF;
END
$$
    LANGUAGE plpgsql;


ALTER FUNCTION budmk."vmail-mailserver_virtual_aliases"() OWNER TO postgres;

--
-- Name: vmail-mailserver_virtual_domain(); Type: FUNCTION; Schema: budmk; Owner: client
--

CREATE FUNCTION "vmail-mailserver_virtual_domain"() RETURNS trigger
    AS $$DECLARE
  id_domain INTEGER;
BEGIN
  IF ( TG_OP != 'INSERT')THEN
	SELECT INTO id_domain mailserver FROM virtual_domains_ids WHERE id=OLD.id;
  END IF;
  IF (TG_OP = 'INSERT') THEN
	INSERT INTO mailserver.virtual_domains("name") VALUES(NEW.name);
  END IF;
  IF (TG_OP = 'DELETE') THEN
	DELETE FROM mailserver.virtual_domains WHERE id=id_domain;
  END IF;
  IF (TG_OP = 'UPDATE') THEN
	UPDATE mailserver.virtual_domains SET "name"=NEW.name WHERE id=id_domain;
  END IF;
  IF (TG_OP = 'DELETE') THEN
	RETURN OLD;
  ELSE
	RETURN NEW;
  END IF;
END
$$
    LANGUAGE plpgsql;


ALTER FUNCTION budmk."vmail-mailserver_virtual_domain"() OWNER TO client;

--
-- Name: vmail-mailserver_virtual_users(); Type: FUNCTION; Schema: budmk; Owner: postgres
--

CREATE FUNCTION "vmail-mailserver_virtual_users"() RETURNS trigger
    AS $$DECLARE
  id_domain INTEGER;
BEGIN
  IF (TG_OP != 'DELETE')THEN
    SELECT INTO id_domain mailserver FROM virtual_domains_ids WHERE id=NEW.domain_id;
  END IF;
  IF (TG_OP = 'INSERT') THEN
	INSERT INTO mailserver.virtual_users("user","password","domain_id") VALUES(NEW.user,NEW.password,id_domain);
  END IF;
  IF (TG_OP = 'DELETE') THEN
	DELETE FROM mailserver.virtual_users WHERE OLD.user=mailserver.virtual_users.user AND OLD.password=mailserver.virtual_users.password;
  END IF;
  IF (TG_OP = 'UPDATE') THEN
	UPDATE mailserver.virtual_users SET "user"=NEW.user, "password"=NEW.password, domain_id=id_domain WHERE "user"=OLD.user AND "password"=OLD.password AND "domain_id"=OLD.domain_id;
  END IF;
  IF (TG_OP = 'DELETE') THEN
	RETURN OLD;
  ELSE
	RETURN NEW;
  END IF;
END
$$
    LANGUAGE plpgsql;


ALTER FUNCTION budmk."vmail-mailserver_virtual_users"() OWNER TO postgres;

SET search_path = jds, pg_catalog;

--
-- Name: vmail-mailserver_virtual_aliases(); Type: FUNCTION; Schema: jds; Owner: postgres
--

CREATE FUNCTION "vmail-mailserver_virtual_aliases"() RETURNS trigger
    AS $$DECLARE
  id_domain INTEGER;
BEGIN
  IF (TG_OP != 'DELETE')THEN
    SELECT INTO id_domain mailserver FROM virtual_domains_ids WHERE id=NEW.domain_id;
  END IF;
  IF (TG_OP = 'INSERT') THEN
	INSERT INTO mailserver.virtual_aliases(domain_id,source,destination) VALUES(id_domain,NEW.source,NEW.destination);
  END IF;
  IF (TG_OP = 'DELETE') THEN
	DELETE FROM mailserver.virtual_aliases WHERE OLD.source=mailserver.virtual_aliases.source AND OLD.destination=mailserver.virtual_aliases.destination;
  END IF;
  IF (TG_OP = 'UPDATE') THEN
	UPDATE mailserver.virtual_aliases SET source=NEW.source, destination=NEW.destination, domain_id=id_domain
		WHERE source=OLD.source AND destination=OLD.destination AND domain_id=OLD.domain_id;
  END IF;
  IF (TG_OP = 'DELETE') THEN
	RETURN OLD;
  ELSE
	RETURN NEW;
  END IF;
END
$$
    LANGUAGE plpgsql;


ALTER FUNCTION jds."vmail-mailserver_virtual_aliases"() OWNER TO postgres;

--
-- Name: vmail-mailserver_virtual_domain(); Type: FUNCTION; Schema: jds; Owner: client
--

CREATE FUNCTION "vmail-mailserver_virtual_domain"() RETURNS trigger
    AS $$DECLARE
  id_domain INTEGER;
BEGIN
  IF ( TG_OP != 'INSERT')THEN
	SELECT INTO id_domain mailserver FROM virtual_domains_ids WHERE id=OLD.id;
  END IF;
  IF (TG_OP = 'INSERT') THEN
	INSERT INTO mailserver.virtual_domains("name") VALUES(NEW.name);
  END IF;
  IF (TG_OP = 'DELETE') THEN
	DELETE FROM mailserver.virtual_domains WHERE id=id_domain;
  END IF;
  IF (TG_OP = 'UPDATE') THEN
	UPDATE mailserver.virtual_domains SET "name"=NEW.name WHERE id=id_domain;
  END IF;
  IF (TG_OP = 'DELETE') THEN
	RETURN OLD;
  ELSE
	RETURN NEW;
  END IF;
END
$$
    LANGUAGE plpgsql;


ALTER FUNCTION jds."vmail-mailserver_virtual_domain"() OWNER TO client;

--
-- Name: vmail-mailserver_virtual_users(); Type: FUNCTION; Schema: jds; Owner: postgres
--

CREATE FUNCTION "vmail-mailserver_virtual_users"() RETURNS trigger
    AS $$DECLARE
  id_domain INTEGER;
BEGIN
  IF (TG_OP != 'DELETE')THEN
    SELECT INTO id_domain mailserver FROM virtual_domains_ids WHERE id=NEW.domain_id;
  END IF;
  IF (TG_OP = 'INSERT') THEN
	INSERT INTO mailserver.virtual_users("user","password","domain_id") VALUES(NEW.user,NEW.password,id_domain);
  END IF;
  IF (TG_OP = 'DELETE') THEN
	DELETE FROM mailserver.virtual_users WHERE OLD.user=mailserver.virtual_users.user AND OLD.password=mailserver.virtual_users.password;
  END IF;
  IF (TG_OP = 'UPDATE') THEN
	UPDATE mailserver.virtual_users SET "user"=NEW.user, "password"=NEW.password, domain_id=id_domain WHERE "user"=OLD.user AND "password"=OLD.password AND "domain_id"=OLD.domain_id;
  END IF;
  IF (TG_OP = 'DELETE') THEN
	RETURN OLD;
  ELSE
	RETURN NEW;
  END IF;
END
$$
    LANGUAGE plpgsql;


ALTER FUNCTION jds."vmail-mailserver_virtual_users"() OWNER TO postgres;

SET search_path = kmprzedszkolak, pg_catalog;

--
-- Name: vmail-mailserver_virtual_aliases(); Type: FUNCTION; Schema: kmprzedszkolak; Owner: client
--

CREATE FUNCTION "vmail-mailserver_virtual_aliases"() RETURNS trigger
    AS $$DECLARE
  id_domain INTEGER;
BEGIN
  IF (TG_OP != 'DELETE')THEN
    SELECT INTO id_domain mailserver FROM virtual_domains_ids WHERE id=NEW.domain_id;
  END IF;
  IF (TG_OP = 'INSERT') THEN
	INSERT INTO mailserver.virtual_aliases(domain_id,source,destination) VALUES(id_domain,NEW.source,NEW.destination);
  END IF;
  IF (TG_OP = 'DELETE') THEN
	DELETE FROM mailserver.virtual_aliases WHERE OLD.source=mailserver.virtual_aliases.source AND OLD.destination=mailserver.virtual_aliases.destination;
  END IF;
  IF (TG_OP = 'UPDATE') THEN
	UPDATE mailserver.virtual_aliases SET source=NEW.source, destination=NEW.destination, domain_id=id_domain
		WHERE source=OLD.source AND destination=OLD.destination AND domain_id=OLD.domain_id;
  END IF;
  IF (TG_OP = 'DELETE') THEN
	RETURN OLD;
  ELSE
	RETURN NEW;
  END IF;
END
$$
    LANGUAGE plpgsql;


ALTER FUNCTION kmprzedszkolak."vmail-mailserver_virtual_aliases"() OWNER TO client;

--
-- Name: vmail-mailserver_virtual_domain(); Type: FUNCTION; Schema: kmprzedszkolak; Owner: client
--

CREATE FUNCTION "vmail-mailserver_virtual_domain"() RETURNS trigger
    AS $$DECLARE
  id_domain INTEGER;
BEGIN
  IF ( TG_OP != 'INSERT')THEN
	SELECT INTO id_domain mailserver FROM virtual_domains_ids WHERE id=OLD.id;
  END IF;
  IF (TG_OP = 'INSERT') THEN
	INSERT INTO mailserver.virtual_domains("name") VALUES(NEW.name);
  END IF;
  IF (TG_OP = 'DELETE') THEN
	DELETE FROM mailserver.virtual_domains WHERE id=id_domain;
  END IF;
  IF (TG_OP = 'UPDATE') THEN
	UPDATE mailserver.virtual_domains SET "name"=NEW.name WHERE id=id_domain;
  END IF;
  IF (TG_OP = 'DELETE') THEN
	RETURN OLD;
  ELSE
	RETURN NEW;
  END IF;
END
$$
    LANGUAGE plpgsql;


ALTER FUNCTION kmprzedszkolak."vmail-mailserver_virtual_domain"() OWNER TO client;

--
-- Name: vmail-mailserver_virtual_users(); Type: FUNCTION; Schema: kmprzedszkolak; Owner: client
--

CREATE FUNCTION "vmail-mailserver_virtual_users"() RETURNS trigger
    AS $$DECLARE
  id_domain INTEGER;
BEGIN
  IF (TG_OP != 'DELETE')THEN
    SELECT INTO id_domain mailserver FROM virtual_domains_ids WHERE id=NEW.domain_id;
  END IF;
  IF (TG_OP = 'INSERT') THEN
	INSERT INTO mailserver.virtual_users("user","password","domain_id") VALUES(NEW.user,NEW.password,id_domain);
  END IF;
  IF (TG_OP = 'DELETE') THEN
	DELETE FROM mailserver.virtual_users WHERE OLD.user=mailserver.virtual_users.user AND OLD.password=mailserver.virtual_users.password;
  END IF;
  IF (TG_OP = 'UPDATE') THEN
	UPDATE mailserver.virtual_users SET "user"=NEW.user, "password"=NEW.password, domain_id=id_domain WHERE "user"=OLD.user AND "password"=OLD.password AND "domain_id"=OLD.domain_id;
  END IF;
  IF (TG_OP = 'DELETE') THEN
	RETURN OLD;
  ELSE
	RETURN NEW;
  END IF;
END
$$
    LANGUAGE plpgsql;


ALTER FUNCTION kmprzedszkolak."vmail-mailserver_virtual_users"() OWNER TO client;

SET search_path = ovum, pg_catalog;

--
-- Name: vmail-mailserver_virtual_aliases(); Type: FUNCTION; Schema: ovum; Owner: client
--

CREATE FUNCTION "vmail-mailserver_virtual_aliases"() RETURNS trigger
    AS $$DECLARE
  id_domain INTEGER;
BEGIN
  IF (TG_OP != 'DELETE')THEN
    SELECT INTO id_domain mailserver FROM virtual_domains_ids WHERE id=NEW.domain_id;
  END IF;
  IF (TG_OP = 'INSERT') THEN
	INSERT INTO mailserver.virtual_aliases(domain_id,source,destination) VALUES(id_domain,NEW.source,NEW.destination);
  END IF;
  IF (TG_OP = 'DELETE') THEN
	DELETE FROM mailserver.virtual_aliases WHERE OLD.source=mailserver.virtual_aliases.source AND OLD.destination=mailserver.virtual_aliases.destination;
  END IF;
  IF (TG_OP = 'UPDATE') THEN
	UPDATE mailserver.virtual_aliases SET source=NEW.source, destination=NEW.destination, domain_id=id_domain
		WHERE source=OLD.source AND destination=OLD.destination AND domain_id=OLD.domain_id;
  END IF;
  IF (TG_OP = 'DELETE') THEN
	RETURN OLD;
  ELSE
	RETURN NEW;
  END IF;
END
$$
    LANGUAGE plpgsql;


ALTER FUNCTION ovum."vmail-mailserver_virtual_aliases"() OWNER TO client;

--
-- Name: vmail-mailserver_virtual_domain(); Type: FUNCTION; Schema: ovum; Owner: client
--

CREATE FUNCTION "vmail-mailserver_virtual_domain"() RETURNS trigger
    AS $$DECLARE
  id_domain INTEGER;
BEGIN
  IF ( TG_OP != 'INSERT')THEN
	SELECT INTO id_domain mailserver FROM virtual_domains_ids WHERE id=OLD.id;
  END IF;
  IF (TG_OP = 'INSERT') THEN
	INSERT INTO mailserver.virtual_domains("name") VALUES(NEW.name);
  END IF;
  IF (TG_OP = 'DELETE') THEN
	DELETE FROM mailserver.virtual_domains WHERE id=id_domain;
  END IF;
  IF (TG_OP = 'UPDATE') THEN
	UPDATE mailserver.virtual_domains SET "name"=NEW.name WHERE id=id_domain;
  END IF;
  IF (TG_OP = 'DELETE') THEN
	RETURN OLD;
  ELSE
	RETURN NEW;
  END IF;
END
$$
    LANGUAGE plpgsql;


ALTER FUNCTION ovum."vmail-mailserver_virtual_domain"() OWNER TO client;

--
-- Name: vmail-mailserver_virtual_users(); Type: FUNCTION; Schema: ovum; Owner: client
--

CREATE FUNCTION "vmail-mailserver_virtual_users"() RETURNS trigger
    AS $$DECLARE
  id_domain INTEGER;
BEGIN
  IF (TG_OP != 'DELETE')THEN
    SELECT INTO id_domain mailserver FROM virtual_domains_ids WHERE id=NEW.domain_id;
  END IF;
  IF (TG_OP = 'INSERT') THEN
	INSERT INTO mailserver.virtual_users("user","password","domain_id") VALUES(NEW.user,NEW.password,id_domain);
  END IF;
  IF (TG_OP = 'DELETE') THEN
	DELETE FROM mailserver.virtual_users WHERE OLD.user=mailserver.virtual_users.user AND OLD.password=mailserver.virtual_users.password;
  END IF;
  IF (TG_OP = 'UPDATE') THEN
	UPDATE mailserver.virtual_users SET "user"=NEW.user, "password"=NEW.password, domain_id=id_domain WHERE "user"=OLD.user AND "password"=OLD.password AND "domain_id"=OLD.domain_id;
  END IF;
  IF (TG_OP = 'DELETE') THEN
	RETURN OLD;
  ELSE
	RETURN NEW;
  END IF;
END
$$
    LANGUAGE plpgsql;


ALTER FUNCTION ovum."vmail-mailserver_virtual_users"() OWNER TO client;

SET search_path = public, pg_catalog;

--
-- Name: vmail-mailserver_virtual_aliases(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "vmail-mailserver_virtual_aliases"() RETURNS trigger
    AS $$DECLARE
  id_domain INTEGER;
BEGIN
  IF (TG_OP != 'DELETE')THEN
    SELECT INTO id_domain mailserver FROM virtual_domains_ids WHERE id=NEW.domain_id;
  END IF;
  IF (TG_OP = 'INSERT') THEN
	INSERT INTO mailserver.virtual_aliases(domain_id,source,destination) VALUES(id_domain,NEW.source,NEW.destination);
  END IF;
  IF (TG_OP = 'DELETE') THEN
	DELETE FROM mailserver.virtual_aliases WHERE OLD.source=mailserver.virtual_aliases.source AND OLD.destination=mailserver.virtual_aliases.destination;
  END IF;
  IF (TG_OP = 'UPDATE') THEN
	UPDATE mailserver.virtual_aliases SET source=NEW.source, destination=NEW.destination, domain_id=id_domain
		WHERE source=OLD.source AND destination=OLD.destination AND domain_id=OLD.domain_id;
  END IF;
  IF (TG_OP = 'DELETE') THEN
	RETURN OLD;
  ELSE
	RETURN NEW;
  END IF;
END
$$
    LANGUAGE plpgsql;


ALTER FUNCTION public."vmail-mailserver_virtual_aliases"() OWNER TO postgres;

--
-- Name: vmail-mailserver_virtual_domain(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "vmail-mailserver_virtual_domain"() RETURNS trigger
    AS $$DECLARE
  id_domain INTEGER;
BEGIN
  IF ( TG_OP != 'INSERT')THEN
	SELECT INTO id_domain mailserver FROM virtual_domains_ids WHERE id=OLD.id;
  END IF;
  IF (TG_OP = 'INSERT') THEN
	INSERT INTO mailserver.virtual_domains("name") VALUES(NEW.name);
  END IF;
  IF (TG_OP = 'DELETE') THEN
	DELETE FROM mailserver.virtual_domains WHERE id=id_domain;
  END IF;
  IF (TG_OP = 'UPDATE') THEN
	UPDATE mailserver.virtual_domains SET mailserver.virtual_domains.name=NEW.name WHERE mailserver.virtual_domains.id=id_domain;
  END IF;
  IF (TG_OP = 'DELETE') THEN
	RETURN OLD;
  ELSE
	RETURN NEW;
  END IF;
END
$$
    LANGUAGE plpgsql;


ALTER FUNCTION public."vmail-mailserver_virtual_domain"() OWNER TO postgres;

--
-- Name: vmail-mailserver_virtual_users(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "vmail-mailserver_virtual_users"() RETURNS trigger
    AS $$DECLARE
  id_domain INTEGER;
BEGIN
  IF (TG_OP != 'DELETE')THEN
    SELECT INTO id_domain mailserver FROM virtual_domains_ids WHERE id=NEW.domain_id;
  END IF;
  IF (TG_OP = 'INSERT') THEN
	INSERT INTO mailserver.virtual_users("user","password","domain_id") VALUES(NEW.user,NEW.password,id_domain);
  END IF;
  IF (TG_OP = 'DELETE') THEN
	DELETE FROM mailserver.virtual_users WHERE OLD.user=mailserver.virtual_users.user AND OLD.password=mailserver.virtual_users.password;
  END IF;
  IF (TG_OP = 'UPDATE') THEN
	UPDATE mailserver.virtual_users SET "user"=NEW.user, "password"=NEW.password, domain_id=id_domain WHERE "user"=OLD.user AND "password"=OLD.password AND "domain_id"=OLD.domain_id;
  END IF;
  IF (TG_OP = 'DELETE') THEN
	RETURN OLD;
  ELSE
	RETURN NEW;
  END IF;
END
$$
    LANGUAGE plpgsql;


ALTER FUNCTION public."vmail-mailserver_virtual_users"() OWNER TO postgres;

SET search_path = street_terror, pg_catalog;

--
-- Name: vmail-mailserver_virtual_aliases(); Type: FUNCTION; Schema: street_terror; Owner: client
--

CREATE FUNCTION "vmail-mailserver_virtual_aliases"() RETURNS trigger
    AS $$DECLARE
  id_domain INTEGER;
BEGIN
  IF (TG_OP != 'DELETE')THEN
    SELECT INTO id_domain mailserver FROM virtual_domains_ids WHERE id=NEW.domain_id;
  END IF;
  IF (TG_OP = 'INSERT') THEN
	INSERT INTO mailserver.virtual_aliases(domain_id,source,destination) VALUES(id_domain,NEW.source,NEW.destination);
  END IF;
  IF (TG_OP = 'DELETE') THEN
	DELETE FROM mailserver.virtual_aliases WHERE OLD.source=mailserver.virtual_aliases.source AND OLD.destination=destination;
  END IF;
  IF (TG_OP = 'UPDATE') THEN
	UPDATE mailserver.virtual_aliases SET source=NEW.source, destination=NEW.destination, domain_id=id_domain
		WHERE source=OLD.source AND destination=OLD.destination AND domain_id=OLD.domain_id;
  END IF;
  IF (TG_OP = 'DELETE') THEN
	RETURN OLD;
  ELSE
	RETURN NEW;
  END IF;
END
$$
    LANGUAGE plpgsql;


ALTER FUNCTION street_terror."vmail-mailserver_virtual_aliases"() OWNER TO client;

--
-- Name: vmail-mailserver_virtual_domain(); Type: FUNCTION; Schema: street_terror; Owner: client
--

CREATE FUNCTION "vmail-mailserver_virtual_domain"() RETURNS trigger
    AS $$DECLARE
  id_domain INTEGER;
BEGIN
  IF ( TG_OP != 'INSERT')THEN
	SELECT INTO id_domain mailserver FROM virtual_domains_ids WHERE id=OLD.id;
  END IF;
  IF (TG_OP = 'INSERT') THEN
	INSERT INTO mailserver.virtual_domains("name") VALUES(NEW.name);
  END IF;
  IF (TG_OP = 'DELETE') THEN
	DELETE FROM mailserver.virtual_domains WHERE id=id_domain;
  END IF;
  IF (TG_OP = 'UPDATE') THEN
	UPDATE mailserver.virtual_domains SET "name"=NEW.name WHERE id=id_domain;
  END IF;
  IF (TG_OP = 'DELETE') THEN
	RETURN OLD;
  ELSE
	RETURN NEW;
  END IF;
END
$$
    LANGUAGE plpgsql;


ALTER FUNCTION street_terror."vmail-mailserver_virtual_domain"() OWNER TO client;

--
-- Name: vmail-mailserver_virtual_users(); Type: FUNCTION; Schema: street_terror; Owner: client
--

CREATE FUNCTION "vmail-mailserver_virtual_users"() RETURNS trigger
    AS $$DECLARE
  id_domain INTEGER;
BEGIN
  IF (TG_OP != 'DELETE')THEN
    SELECT INTO id_domain mailserver FROM virtual_domains_ids WHERE id=NEW.domain_id;
  END IF;
  IF (TG_OP = 'INSERT') THEN
	INSERT INTO mailserver.virtual_users("user","password","domain_id") VALUES(NEW.user,NEW.password,id_domain);
  END IF;
  IF (TG_OP = 'DELETE') THEN
	DELETE FROM mailserver.virtual_users WHERE OLD.user=mailserver.virtual_users.user AND OLD.password=mailserver.virtual_users.password;
  END IF;
  IF (TG_OP = 'UPDATE') THEN
	UPDATE mailserver.virtual_users SET "user"=NEW.user, "password"=NEW.password, domain_id=id_domain WHERE "user"=OLD.user AND "password"=OLD.password AND "domain_id"=OLD.domain_id;
  END IF;
  IF (TG_OP = 'DELETE') THEN
	RETURN OLD;
  ELSE
	RETURN NEW;
  END IF;
END
$$
    LANGUAGE plpgsql;


ALTER FUNCTION street_terror."vmail-mailserver_virtual_users"() OWNER TO client;

SET search_path = altro, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: virtual_aliases; Type: TABLE; Schema: altro; Owner: altro@mailserver; Tablespace: 
--

CREATE TABLE virtual_aliases (
    id integer NOT NULL,
    domain_id integer NOT NULL,
    source character varying DEFAULT ''::character varying,
    destination character varying
);


ALTER TABLE altro.virtual_aliases OWNER TO "altro@mailserver";

--
-- Name: virtual_aliases_id_seq; Type: SEQUENCE; Schema: altro; Owner: altro@mailserver
--

CREATE SEQUENCE virtual_aliases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE altro.virtual_aliases_id_seq OWNER TO "altro@mailserver";

--
-- Name: virtual_aliases_id_seq; Type: SEQUENCE OWNED BY; Schema: altro; Owner: altro@mailserver
--

ALTER SEQUENCE virtual_aliases_id_seq OWNED BY virtual_aliases.id;


--
-- Name: virtual_aliases_id_seq; Type: SEQUENCE SET; Schema: altro; Owner: altro@mailserver
--

SELECT pg_catalog.setval('virtual_aliases_id_seq', 1, false);


--
-- Name: virtual_domains; Type: TABLE; Schema: altro; Owner: altro@mailserver; Tablespace: 
--

CREATE TABLE virtual_domains (
    id integer NOT NULL,
    name character varying
);


ALTER TABLE altro.virtual_domains OWNER TO "altro@mailserver";

--
-- Name: virtual_domains_id_seq; Type: SEQUENCE; Schema: altro; Owner: altro@mailserver
--

CREATE SEQUENCE virtual_domains_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE altro.virtual_domains_id_seq OWNER TO "altro@mailserver";

--
-- Name: virtual_domains_id_seq; Type: SEQUENCE OWNED BY; Schema: altro; Owner: altro@mailserver
--

ALTER SEQUENCE virtual_domains_id_seq OWNED BY virtual_domains.id;


--
-- Name: virtual_domains_id_seq; Type: SEQUENCE SET; Schema: altro; Owner: altro@mailserver
--

SELECT pg_catalog.setval('virtual_domains_id_seq', 1, true);


SET search_path = mailserver, pg_catalog;

--
-- Name: virtual_domains; Type: TABLE; Schema: mailserver; Owner: mailserver; Tablespace: 
--

CREATE TABLE virtual_domains (
    id integer NOT NULL,
    name character varying
);


ALTER TABLE mailserver.virtual_domains OWNER TO mailserver;

SET search_path = altro, pg_catalog;

--
-- Name: virtual_domains_ids; Type: VIEW; Schema: altro; Owner: altro@mailserver
--

CREATE VIEW virtual_domains_ids AS
    SELECT altro.virtual_domains.id, mailserver.virtual_domains.id AS mailserver FROM (virtual_domains JOIN mailserver.virtual_domains ON (((altro.virtual_domains.name)::text = (mailserver.virtual_domains.name)::text)));


ALTER TABLE altro.virtual_domains_ids OWNER TO "altro@mailserver";

--
-- Name: virtual_users; Type: TABLE; Schema: altro; Owner: altro@mailserver; Tablespace: 
--

CREATE TABLE virtual_users (
    id integer NOT NULL,
    "user" character varying NOT NULL,
    password character varying,
    domain_id integer NOT NULL
);


ALTER TABLE altro.virtual_users OWNER TO "altro@mailserver";

--
-- Name: virtual_users_id_seq; Type: SEQUENCE; Schema: altro; Owner: altro@mailserver
--

CREATE SEQUENCE virtual_users_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE altro.virtual_users_id_seq OWNER TO "altro@mailserver";

--
-- Name: virtual_users_id_seq; Type: SEQUENCE OWNED BY; Schema: altro; Owner: altro@mailserver
--

ALTER SEQUENCE virtual_users_id_seq OWNED BY virtual_users.id;


--
-- Name: virtual_users_id_seq; Type: SEQUENCE SET; Schema: altro; Owner: altro@mailserver
--

SELECT pg_catalog.setval('virtual_users_id_seq', 2, true);


SET search_path = budmk, pg_catalog;

--
-- Name: virtual_aliases; Type: TABLE; Schema: budmk; Owner: budmk@mailserver; Tablespace: 
--

CREATE TABLE virtual_aliases (
    id integer NOT NULL,
    domain_id integer NOT NULL,
    source character varying DEFAULT ''::character varying,
    destination character varying
);


ALTER TABLE budmk.virtual_aliases OWNER TO "budmk@mailserver";

--
-- Name: virtual_aliases_id_seq; Type: SEQUENCE; Schema: budmk; Owner: budmk@mailserver
--

CREATE SEQUENCE virtual_aliases_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE budmk.virtual_aliases_id_seq OWNER TO "budmk@mailserver";

--
-- Name: virtual_aliases_id_seq; Type: SEQUENCE OWNED BY; Schema: budmk; Owner: budmk@mailserver
--

ALTER SEQUENCE virtual_aliases_id_seq OWNED BY virtual_aliases.id;


--
-- Name: virtual_aliases_id_seq; Type: SEQUENCE SET; Schema: budmk; Owner: budmk@mailserver
--

SELECT pg_catalog.setval('virtual_aliases_id_seq', 2, true);


--
-- Name: virtual_domains; Type: TABLE; Schema: budmk; Owner: budmk@mailserver; Tablespace: 
--

CREATE TABLE virtual_domains (
    id integer NOT NULL,
    name character varying
);


ALTER TABLE budmk.virtual_domains OWNER TO "budmk@mailserver";

--
-- Name: virtual_domains_id_seq; Type: SEQUENCE; Schema: budmk; Owner: budmk@mailserver
--

CREATE SEQUENCE virtual_domains_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE budmk.virtual_domains_id_seq OWNER TO "budmk@mailserver";

--
-- Name: virtual_domains_id_seq; Type: SEQUENCE OWNED BY; Schema: budmk; Owner: budmk@mailserver
--

ALTER SEQUENCE virtual_domains_id_seq OWNED BY virtual_domains.id;


--
-- Name: virtual_domains_id_seq; Type: SEQUENCE SET; Schema: budmk; Owner: budmk@mailserver
--

SELECT pg_catalog.setval('virtual_domains_id_seq', 1, true);


--
-- Name: virtual_domains_ids; Type: VIEW; Schema: budmk; Owner: budmk@mailserver
--

CREATE VIEW virtual_domains_ids AS
    SELECT budmk.virtual_domains.id, mailserver.virtual_domains.id AS mailserver FROM (virtual_domains JOIN mailserver.virtual_domains ON (((budmk.virtual_domains.name)::text = (mailserver.virtual_domains.name)::text)));


ALTER TABLE budmk.virtual_domains_ids OWNER TO "budmk@mailserver";

--
-- Name: virtual_users; Type: TABLE; Schema: budmk; Owner: budmk@mailserver; Tablespace: 
--

CREATE TABLE virtual_users (
    id integer NOT NULL,
    "user" character varying NOT NULL,
    password character varying,
    domain_id integer NOT NULL
);


ALTER TABLE budmk.virtual_users OWNER TO "budmk@mailserver";

--
-- Name: virtual_users_id_seq; Type: SEQUENCE; Schema: budmk; Owner: budmk@mailserver
--

CREATE SEQUENCE virtual_users_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE budmk.virtual_users_id_seq OWNER TO "budmk@mailserver";

--
-- Name: virtual_users_id_seq; Type: SEQUENCE OWNED BY; Schema: budmk; Owner: budmk@mailserver
--

ALTER SEQUENCE virtual_users_id_seq OWNED BY virtual_users.id;


--
-- Name: virtual_users_id_seq; Type: SEQUENCE SET; Schema: budmk; Owner: budmk@mailserver
--

SELECT pg_catalog.setval('virtual_users_id_seq', 1, true);


SET search_path = jds, pg_catalog;

--
-- Name: virtual_aliases; Type: TABLE; Schema: jds; Owner: jds; Tablespace: 
--

CREATE TABLE virtual_aliases (
    id integer NOT NULL,
    domain_id integer NOT NULL,
    source character varying DEFAULT ''::character varying,
    destination character varying
);


ALTER TABLE jds.virtual_aliases OWNER TO jds;

--
-- Name: virtual_aliases_id_seq; Type: SEQUENCE; Schema: jds; Owner: jds
--

CREATE SEQUENCE virtual_aliases_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE jds.virtual_aliases_id_seq OWNER TO jds;

--
-- Name: virtual_aliases_id_seq; Type: SEQUENCE OWNED BY; Schema: jds; Owner: jds
--

ALTER SEQUENCE virtual_aliases_id_seq OWNED BY virtual_aliases.id;


--
-- Name: virtual_aliases_id_seq; Type: SEQUENCE SET; Schema: jds; Owner: jds
--

SELECT pg_catalog.setval('virtual_aliases_id_seq', 27, true);


--
-- Name: virtual_domains; Type: TABLE; Schema: jds; Owner: jds; Tablespace: 
--

CREATE TABLE virtual_domains (
    id integer NOT NULL,
    name character varying
);


ALTER TABLE jds.virtual_domains OWNER TO jds;

--
-- Name: virtual_domains_id_seq; Type: SEQUENCE; Schema: jds; Owner: jds
--

CREATE SEQUENCE virtual_domains_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE jds.virtual_domains_id_seq OWNER TO jds;

--
-- Name: virtual_domains_id_seq; Type: SEQUENCE OWNED BY; Schema: jds; Owner: jds
--

ALTER SEQUENCE virtual_domains_id_seq OWNED BY virtual_domains.id;


--
-- Name: virtual_domains_id_seq; Type: SEQUENCE SET; Schema: jds; Owner: jds
--

SELECT pg_catalog.setval('virtual_domains_id_seq', 7, true);


--
-- Name: virtual_domains_ids; Type: VIEW; Schema: jds; Owner: jds
--

CREATE VIEW virtual_domains_ids AS
    SELECT jds.virtual_domains.id, mailserver.virtual_domains.id AS mailserver FROM (virtual_domains JOIN mailserver.virtual_domains ON (((jds.virtual_domains.name)::text = (mailserver.virtual_domains.name)::text)));


ALTER TABLE jds.virtual_domains_ids OWNER TO jds;

--
-- Name: virtual_users; Type: TABLE; Schema: jds; Owner: jds; Tablespace: 
--

CREATE TABLE virtual_users (
    id integer NOT NULL,
    "user" character varying NOT NULL,
    password character varying,
    domain_id integer NOT NULL
);


ALTER TABLE jds.virtual_users OWNER TO jds;

--
-- Name: virtual_users_id_seq; Type: SEQUENCE; Schema: jds; Owner: jds
--

CREATE SEQUENCE virtual_users_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE jds.virtual_users_id_seq OWNER TO jds;

--
-- Name: virtual_users_id_seq; Type: SEQUENCE OWNED BY; Schema: jds; Owner: jds
--

ALTER SEQUENCE virtual_users_id_seq OWNED BY virtual_users.id;


--
-- Name: virtual_users_id_seq; Type: SEQUENCE SET; Schema: jds; Owner: jds
--

SELECT pg_catalog.setval('virtual_users_id_seq', 9, true);


SET search_path = kmprzedszkolak, pg_catalog;

--
-- Name: virtual_aliases; Type: TABLE; Schema: kmprzedszkolak; Owner: kmprzedszkolak@mailserver; Tablespace: 
--

CREATE TABLE virtual_aliases (
    id integer NOT NULL,
    domain_id integer NOT NULL,
    source character varying DEFAULT ''::character varying,
    destination character varying
);


ALTER TABLE kmprzedszkolak.virtual_aliases OWNER TO "kmprzedszkolak@mailserver";

--
-- Name: virtual_aliases_id_seq; Type: SEQUENCE; Schema: kmprzedszkolak; Owner: kmprzedszkolak@mailserver
--

CREATE SEQUENCE virtual_aliases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE kmprzedszkolak.virtual_aliases_id_seq OWNER TO "kmprzedszkolak@mailserver";

--
-- Name: virtual_aliases_id_seq; Type: SEQUENCE OWNED BY; Schema: kmprzedszkolak; Owner: kmprzedszkolak@mailserver
--

ALTER SEQUENCE virtual_aliases_id_seq OWNED BY virtual_aliases.id;


--
-- Name: virtual_aliases_id_seq; Type: SEQUENCE SET; Schema: kmprzedszkolak; Owner: kmprzedszkolak@mailserver
--

SELECT pg_catalog.setval('virtual_aliases_id_seq', 1, false);


--
-- Name: virtual_domains; Type: TABLE; Schema: kmprzedszkolak; Owner: kmprzedszkolak@mailserver; Tablespace: 
--

CREATE TABLE virtual_domains (
    id integer NOT NULL,
    name character varying
);


ALTER TABLE kmprzedszkolak.virtual_domains OWNER TO "kmprzedszkolak@mailserver";

--
-- Name: virtual_domains_id_seq; Type: SEQUENCE; Schema: kmprzedszkolak; Owner: kmprzedszkolak@mailserver
--

CREATE SEQUENCE virtual_domains_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE kmprzedszkolak.virtual_domains_id_seq OWNER TO "kmprzedszkolak@mailserver";

--
-- Name: virtual_domains_id_seq; Type: SEQUENCE OWNED BY; Schema: kmprzedszkolak; Owner: kmprzedszkolak@mailserver
--

ALTER SEQUENCE virtual_domains_id_seq OWNED BY virtual_domains.id;


--
-- Name: virtual_domains_id_seq; Type: SEQUENCE SET; Schema: kmprzedszkolak; Owner: kmprzedszkolak@mailserver
--

SELECT pg_catalog.setval('virtual_domains_id_seq', 1, true);


--
-- Name: virtual_domains_ids; Type: VIEW; Schema: kmprzedszkolak; Owner: kmprzedszkolak@mailserver
--

CREATE VIEW virtual_domains_ids AS
    SELECT kmprzedszkolak.virtual_domains.id, mailserver.virtual_domains.id AS mailserver FROM (virtual_domains JOIN mailserver.virtual_domains ON (((kmprzedszkolak.virtual_domains.name)::text = (mailserver.virtual_domains.name)::text)));


ALTER TABLE kmprzedszkolak.virtual_domains_ids OWNER TO "kmprzedszkolak@mailserver";

--
-- Name: virtual_users; Type: TABLE; Schema: kmprzedszkolak; Owner: kmprzedszkolak@mailserver; Tablespace: 
--

CREATE TABLE virtual_users (
    id integer NOT NULL,
    "user" character varying NOT NULL,
    password character varying,
    domain_id integer NOT NULL
);


ALTER TABLE kmprzedszkolak.virtual_users OWNER TO "kmprzedszkolak@mailserver";

--
-- Name: virtual_users_id_seq; Type: SEQUENCE; Schema: kmprzedszkolak; Owner: kmprzedszkolak@mailserver
--

CREATE SEQUENCE virtual_users_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE kmprzedszkolak.virtual_users_id_seq OWNER TO "kmprzedszkolak@mailserver";

--
-- Name: virtual_users_id_seq; Type: SEQUENCE OWNED BY; Schema: kmprzedszkolak; Owner: kmprzedszkolak@mailserver
--

ALTER SEQUENCE virtual_users_id_seq OWNED BY virtual_users.id;


--
-- Name: virtual_users_id_seq; Type: SEQUENCE SET; Schema: kmprzedszkolak; Owner: kmprzedszkolak@mailserver
--

SELECT pg_catalog.setval('virtual_users_id_seq', 1, true);


SET search_path = mailserver, pg_catalog;

--
-- Name: virtual_aliases; Type: TABLE; Schema: mailserver; Owner: mailserver; Tablespace: 
--

CREATE TABLE virtual_aliases (
    id integer NOT NULL,
    domain_id integer NOT NULL,
    source character varying,
    destination character varying
);


ALTER TABLE mailserver.virtual_aliases OWNER TO mailserver;

--
-- Name: view_aliases; Type: VIEW; Schema: mailserver; Owner: postgres
--

CREATE VIEW view_aliases AS
    SELECT (((virtual_aliases.source)::text || '@'::text) || (virtual_domains.name)::text) AS email, virtual_aliases.destination FROM (virtual_aliases LEFT JOIN virtual_domains ON ((virtual_aliases.domain_id = virtual_domains.id)));


ALTER TABLE mailserver.view_aliases OWNER TO postgres;

--
-- Name: virtual_users; Type: TABLE; Schema: mailserver; Owner: mailserver; Tablespace: 
--

CREATE TABLE virtual_users (
    id integer NOT NULL,
    "user" character varying NOT NULL,
    password character varying,
    domain_id integer NOT NULL
);


ALTER TABLE mailserver.virtual_users OWNER TO mailserver;

--
-- Name: view_users; Type: VIEW; Schema: mailserver; Owner: postgres
--

CREATE VIEW view_users AS
    SELECT (((virtual_users."user")::text || '@'::text) || (virtual_domains.name)::text) AS email, virtual_users.password FROM (virtual_users LEFT JOIN virtual_domains ON ((virtual_users.domain_id = virtual_domains.id)));


ALTER TABLE mailserver.view_users OWNER TO postgres;

--
-- Name: virtual_aliases_id_seq; Type: SEQUENCE; Schema: mailserver; Owner: mailserver
--

CREATE SEQUENCE virtual_aliases_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE mailserver.virtual_aliases_id_seq OWNER TO mailserver;

--
-- Name: virtual_aliases_id_seq; Type: SEQUENCE OWNED BY; Schema: mailserver; Owner: mailserver
--

ALTER SEQUENCE virtual_aliases_id_seq OWNED BY virtual_aliases.id;


--
-- Name: virtual_aliases_id_seq; Type: SEQUENCE SET; Schema: mailserver; Owner: mailserver
--

SELECT pg_catalog.setval('virtual_aliases_id_seq', 30, true);


--
-- Name: virtual_domains_id_seq; Type: SEQUENCE; Schema: mailserver; Owner: mailserver
--

CREATE SEQUENCE virtual_domains_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE mailserver.virtual_domains_id_seq OWNER TO mailserver;

--
-- Name: virtual_domains_id_seq; Type: SEQUENCE OWNED BY; Schema: mailserver; Owner: mailserver
--

ALTER SEQUENCE virtual_domains_id_seq OWNED BY virtual_domains.id;


--
-- Name: virtual_domains_id_seq; Type: SEQUENCE SET; Schema: mailserver; Owner: mailserver
--

SELECT pg_catalog.setval('virtual_domains_id_seq', 12, true);


--
-- Name: virtual_users_id_seq; Type: SEQUENCE; Schema: mailserver; Owner: mailserver
--

CREATE SEQUENCE virtual_users_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE mailserver.virtual_users_id_seq OWNER TO mailserver;

--
-- Name: virtual_users_id_seq; Type: SEQUENCE OWNED BY; Schema: mailserver; Owner: mailserver
--

ALTER SEQUENCE virtual_users_id_seq OWNED BY virtual_users.id;


--
-- Name: virtual_users_id_seq; Type: SEQUENCE SET; Schema: mailserver; Owner: mailserver
--

SELECT pg_catalog.setval('virtual_users_id_seq', 50, true);


SET search_path = ovum, pg_catalog;

--
-- Name: virtual_aliases; Type: TABLE; Schema: ovum; Owner: ovum@mailserver; Tablespace: 
--

CREATE TABLE virtual_aliases (
    id integer NOT NULL,
    domain_id integer NOT NULL,
    source character varying DEFAULT ''::character varying,
    destination character varying
);


ALTER TABLE ovum.virtual_aliases OWNER TO "ovum@mailserver";

--
-- Name: virtual_aliases_id_seq; Type: SEQUENCE; Schema: ovum; Owner: ovum@mailserver
--

CREATE SEQUENCE virtual_aliases_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE ovum.virtual_aliases_id_seq OWNER TO "ovum@mailserver";

--
-- Name: virtual_aliases_id_seq; Type: SEQUENCE OWNED BY; Schema: ovum; Owner: ovum@mailserver
--

ALTER SEQUENCE virtual_aliases_id_seq OWNED BY virtual_aliases.id;


--
-- Name: virtual_aliases_id_seq; Type: SEQUENCE SET; Schema: ovum; Owner: ovum@mailserver
--

SELECT pg_catalog.setval('virtual_aliases_id_seq', 1, true);


--
-- Name: virtual_domains; Type: TABLE; Schema: ovum; Owner: ovum@mailserver; Tablespace: 
--

CREATE TABLE virtual_domains (
    id integer NOT NULL,
    name character varying
);


ALTER TABLE ovum.virtual_domains OWNER TO "ovum@mailserver";

--
-- Name: virtual_domains_id_seq; Type: SEQUENCE; Schema: ovum; Owner: ovum@mailserver
--

CREATE SEQUENCE virtual_domains_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE ovum.virtual_domains_id_seq OWNER TO "ovum@mailserver";

--
-- Name: virtual_domains_id_seq; Type: SEQUENCE OWNED BY; Schema: ovum; Owner: ovum@mailserver
--

ALTER SEQUENCE virtual_domains_id_seq OWNED BY virtual_domains.id;


--
-- Name: virtual_domains_id_seq; Type: SEQUENCE SET; Schema: ovum; Owner: ovum@mailserver
--

SELECT pg_catalog.setval('virtual_domains_id_seq', 1, true);


--
-- Name: virtual_domains_ids; Type: VIEW; Schema: ovum; Owner: ovum@mailserver
--

CREATE VIEW virtual_domains_ids AS
    SELECT ovum.virtual_domains.id, mailserver.virtual_domains.id AS mailserver FROM (virtual_domains JOIN mailserver.virtual_domains ON (((ovum.virtual_domains.name)::text = (mailserver.virtual_domains.name)::text)));


ALTER TABLE ovum.virtual_domains_ids OWNER TO "ovum@mailserver";

--
-- Name: virtual_users; Type: TABLE; Schema: ovum; Owner: ovum@mailserver; Tablespace: 
--

CREATE TABLE virtual_users (
    id integer NOT NULL,
    "user" character varying NOT NULL,
    password character varying,
    domain_id integer NOT NULL
);


ALTER TABLE ovum.virtual_users OWNER TO "ovum@mailserver";

--
-- Name: virtual_users_id_seq; Type: SEQUENCE; Schema: ovum; Owner: ovum@mailserver
--

CREATE SEQUENCE virtual_users_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE ovum.virtual_users_id_seq OWNER TO "ovum@mailserver";

--
-- Name: virtual_users_id_seq; Type: SEQUENCE OWNED BY; Schema: ovum; Owner: ovum@mailserver
--

ALTER SEQUENCE virtual_users_id_seq OWNED BY virtual_users.id;


--
-- Name: virtual_users_id_seq; Type: SEQUENCE SET; Schema: ovum; Owner: ovum@mailserver
--

SELECT pg_catalog.setval('virtual_users_id_seq', 4, true);


SET search_path = public, pg_catalog;

--
-- Name: virtual_aliases; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE virtual_aliases (
    id integer NOT NULL,
    domain_id integer NOT NULL,
    source character varying DEFAULT ''::character varying,
    destination character varying
);


ALTER TABLE public.virtual_aliases OWNER TO postgres;

--
-- Name: virtual_aliases_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE virtual_aliases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.virtual_aliases_id_seq OWNER TO postgres;

--
-- Name: virtual_aliases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE virtual_aliases_id_seq OWNED BY virtual_aliases.id;


--
-- Name: virtual_aliases_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('virtual_aliases_id_seq', 1, false);


--
-- Name: virtual_domains; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE virtual_domains (
    id integer NOT NULL,
    name character varying
);


ALTER TABLE public.virtual_domains OWNER TO postgres;

--
-- Name: virtual_domains_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE virtual_domains_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.virtual_domains_id_seq OWNER TO postgres;

--
-- Name: virtual_domains_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE virtual_domains_id_seq OWNED BY virtual_domains.id;


--
-- Name: virtual_domains_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('virtual_domains_id_seq', 1, false);


--
-- Name: virtual_users; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE virtual_users (
    id integer NOT NULL,
    "user" character varying NOT NULL,
    password character varying,
    domain_id integer NOT NULL
);


ALTER TABLE public.virtual_users OWNER TO postgres;

--
-- Name: virtual_users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE virtual_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.virtual_users_id_seq OWNER TO postgres;

--
-- Name: virtual_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE virtual_users_id_seq OWNED BY virtual_users.id;


--
-- Name: virtual_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('virtual_users_id_seq', 1, false);


SET search_path = street_terror, pg_catalog;

--
-- Name: virtual_aliases; Type: TABLE; Schema: street_terror; Owner: street_terror@mailserver; Tablespace: 
--

CREATE TABLE virtual_aliases (
    id integer NOT NULL,
    domain_id integer NOT NULL,
    source character varying DEFAULT ''::character varying,
    destination character varying
);


ALTER TABLE street_terror.virtual_aliases OWNER TO "street_terror@mailserver";

--
-- Name: virtual_aliases_id_seq; Type: SEQUENCE; Schema: street_terror; Owner: street_terror@mailserver
--

CREATE SEQUENCE virtual_aliases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE street_terror.virtual_aliases_id_seq OWNER TO "street_terror@mailserver";

--
-- Name: virtual_aliases_id_seq; Type: SEQUENCE OWNED BY; Schema: street_terror; Owner: street_terror@mailserver
--

ALTER SEQUENCE virtual_aliases_id_seq OWNED BY virtual_aliases.id;


--
-- Name: virtual_aliases_id_seq; Type: SEQUENCE SET; Schema: street_terror; Owner: street_terror@mailserver
--

SELECT pg_catalog.setval('virtual_aliases_id_seq', 1, false);


--
-- Name: virtual_domains; Type: TABLE; Schema: street_terror; Owner: street_terror@mailserver; Tablespace: 
--

CREATE TABLE virtual_domains (
    id integer NOT NULL,
    name character varying
);


ALTER TABLE street_terror.virtual_domains OWNER TO "street_terror@mailserver";

--
-- Name: virtual_domains_id_seq; Type: SEQUENCE; Schema: street_terror; Owner: street_terror@mailserver
--

CREATE SEQUENCE virtual_domains_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE street_terror.virtual_domains_id_seq OWNER TO "street_terror@mailserver";

--
-- Name: virtual_domains_id_seq; Type: SEQUENCE OWNED BY; Schema: street_terror; Owner: street_terror@mailserver
--

ALTER SEQUENCE virtual_domains_id_seq OWNED BY virtual_domains.id;


--
-- Name: virtual_domains_id_seq; Type: SEQUENCE SET; Schema: street_terror; Owner: street_terror@mailserver
--

SELECT pg_catalog.setval('virtual_domains_id_seq', 1, true);


--
-- Name: virtual_domains_ids; Type: VIEW; Schema: street_terror; Owner: street_terror@mailserver
--

CREATE VIEW virtual_domains_ids AS
    SELECT street_terror.virtual_domains.id, mailserver.virtual_domains.id AS mailserver FROM (virtual_domains JOIN mailserver.virtual_domains ON (((street_terror.virtual_domains.name)::text = (mailserver.virtual_domains.name)::text)));


ALTER TABLE street_terror.virtual_domains_ids OWNER TO "street_terror@mailserver";

--
-- Name: virtual_users; Type: TABLE; Schema: street_terror; Owner: street_terror@mailserver; Tablespace: 
--

CREATE TABLE virtual_users (
    id integer NOT NULL,
    "user" character varying NOT NULL,
    password character varying,
    domain_id integer NOT NULL
);


ALTER TABLE street_terror.virtual_users OWNER TO "street_terror@mailserver";

--
-- Name: virtual_users_id_seq; Type: SEQUENCE; Schema: street_terror; Owner: street_terror@mailserver
--

CREATE SEQUENCE virtual_users_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE street_terror.virtual_users_id_seq OWNER TO "street_terror@mailserver";

--
-- Name: virtual_users_id_seq; Type: SEQUENCE OWNED BY; Schema: street_terror; Owner: street_terror@mailserver
--

ALTER SEQUENCE virtual_users_id_seq OWNED BY virtual_users.id;


--
-- Name: virtual_users_id_seq; Type: SEQUENCE SET; Schema: street_terror; Owner: street_terror@mailserver
--

SELECT pg_catalog.setval('virtual_users_id_seq', 33, true);


SET search_path = altro, pg_catalog;

--
-- Name: id; Type: DEFAULT; Schema: altro; Owner: altro@mailserver
--

ALTER TABLE virtual_aliases ALTER COLUMN id SET DEFAULT nextval('virtual_aliases_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: altro; Owner: altro@mailserver
--

ALTER TABLE virtual_domains ALTER COLUMN id SET DEFAULT nextval('virtual_domains_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: altro; Owner: altro@mailserver
--

ALTER TABLE virtual_users ALTER COLUMN id SET DEFAULT nextval('virtual_users_id_seq'::regclass);


SET search_path = budmk, pg_catalog;

--
-- Name: id; Type: DEFAULT; Schema: budmk; Owner: budmk@mailserver
--

ALTER TABLE virtual_aliases ALTER COLUMN id SET DEFAULT nextval('virtual_aliases_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: budmk; Owner: budmk@mailserver
--

ALTER TABLE virtual_domains ALTER COLUMN id SET DEFAULT nextval('virtual_domains_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: budmk; Owner: budmk@mailserver
--

ALTER TABLE virtual_users ALTER COLUMN id SET DEFAULT nextval('virtual_users_id_seq'::regclass);


SET search_path = jds, pg_catalog;

--
-- Name: id; Type: DEFAULT; Schema: jds; Owner: jds
--

ALTER TABLE virtual_aliases ALTER COLUMN id SET DEFAULT nextval('virtual_aliases_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: jds; Owner: jds
--

ALTER TABLE virtual_domains ALTER COLUMN id SET DEFAULT nextval('virtual_domains_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: jds; Owner: jds
--

ALTER TABLE virtual_users ALTER COLUMN id SET DEFAULT nextval('virtual_users_id_seq'::regclass);


SET search_path = kmprzedszkolak, pg_catalog;

--
-- Name: id; Type: DEFAULT; Schema: kmprzedszkolak; Owner: kmprzedszkolak@mailserver
--

ALTER TABLE virtual_aliases ALTER COLUMN id SET DEFAULT nextval('virtual_aliases_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: kmprzedszkolak; Owner: kmprzedszkolak@mailserver
--

ALTER TABLE virtual_domains ALTER COLUMN id SET DEFAULT nextval('virtual_domains_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: kmprzedszkolak; Owner: kmprzedszkolak@mailserver
--

ALTER TABLE virtual_users ALTER COLUMN id SET DEFAULT nextval('virtual_users_id_seq'::regclass);


SET search_path = mailserver, pg_catalog;

--
-- Name: id; Type: DEFAULT; Schema: mailserver; Owner: mailserver
--

ALTER TABLE virtual_aliases ALTER COLUMN id SET DEFAULT nextval('virtual_aliases_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: mailserver; Owner: mailserver
--

ALTER TABLE virtual_domains ALTER COLUMN id SET DEFAULT nextval('virtual_domains_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: mailserver; Owner: mailserver
--

ALTER TABLE virtual_users ALTER COLUMN id SET DEFAULT nextval('virtual_users_id_seq'::regclass);


SET search_path = ovum, pg_catalog;

--
-- Name: id; Type: DEFAULT; Schema: ovum; Owner: ovum@mailserver
--

ALTER TABLE virtual_aliases ALTER COLUMN id SET DEFAULT nextval('virtual_aliases_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: ovum; Owner: ovum@mailserver
--

ALTER TABLE virtual_domains ALTER COLUMN id SET DEFAULT nextval('virtual_domains_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: ovum; Owner: ovum@mailserver
--

ALTER TABLE virtual_users ALTER COLUMN id SET DEFAULT nextval('virtual_users_id_seq'::regclass);


SET search_path = public, pg_catalog;

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE virtual_aliases ALTER COLUMN id SET DEFAULT nextval('virtual_aliases_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE virtual_domains ALTER COLUMN id SET DEFAULT nextval('virtual_domains_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE virtual_users ALTER COLUMN id SET DEFAULT nextval('virtual_users_id_seq'::regclass);


SET search_path = street_terror, pg_catalog;

--
-- Name: id; Type: DEFAULT; Schema: street_terror; Owner: street_terror@mailserver
--

ALTER TABLE virtual_aliases ALTER COLUMN id SET DEFAULT nextval('virtual_aliases_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: street_terror; Owner: street_terror@mailserver
--

ALTER TABLE virtual_domains ALTER COLUMN id SET DEFAULT nextval('virtual_domains_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: street_terror; Owner: street_terror@mailserver
--

ALTER TABLE virtual_users ALTER COLUMN id SET DEFAULT nextval('virtual_users_id_seq'::regclass);


SET search_path = altro, pg_catalog;

--
-- Data for Name: virtual_aliases; Type: TABLE DATA; Schema: altro; Owner: altro@mailserver
--

COPY virtual_aliases (id, domain_id, source, destination) FROM stdin;
\.


--
-- Data for Name: virtual_domains; Type: TABLE DATA; Schema: altro; Owner: altro@mailserver
--

COPY virtual_domains (id, name) FROM stdin;
1	altroinstalacje.pl
\.


--
-- Data for Name: virtual_users; Type: TABLE DATA; Schema: altro; Owner: altro@mailserver
--

COPY virtual_users (id, "user", password, domain_id) FROM stdin;
1	mk	ed6a0277c10daa4406c92a62b9886876	1
2	am	8ff5b56fa1ea212cadad4f4c20c75a1c	1
\.


SET search_path = budmk, pg_catalog;

--
-- Data for Name: virtual_aliases; Type: TABLE DATA; Schema: budmk; Owner: budmk@mailserver
--

COPY virtual_aliases (id, domain_id, source, destination) FROM stdin;
1	1	biuro	marcin.kupien@budmk.pl
2	1	budmk	marcin.kupien@budmk.pl
\.


--
-- Data for Name: virtual_domains; Type: TABLE DATA; Schema: budmk; Owner: budmk@mailserver
--

COPY virtual_domains (id, name) FROM stdin;
1	budmk.pl
\.


--
-- Data for Name: virtual_users; Type: TABLE DATA; Schema: budmk; Owner: budmk@mailserver
--

COPY virtual_users (id, "user", password, domain_id) FROM stdin;
1	marcin.kupien	0177dfb33498434ae3e0da7571f57500	1
\.


SET search_path = jds, pg_catalog;

--
-- Data for Name: virtual_aliases; Type: TABLE DATA; Schema: jds; Owner: jds
--

COPY virtual_aliases (id, domain_id, source, destination) FROM stdin;
1	1	webmaster	tofik@rgc.pl.eu.org
2	1	root	tofik@rgc.pl.eu.org
3	1	keymaker	tofik@rgc.pl.eu.org
4	1	elzbieta.drozdz	ela@rgc.pl.eu.org
5	1	jerzy.drozdz	tofik@rgc.pl.eu.org
26	6		jerzy.drozdz@jdsieci.pl
27	5		jerzy.drozdz@jdsieci.pl
10	2	keymaker	jerzy.drozdz@jdsieci.pl
11	3	keymaker	jerzy.drozdz@jdsieci.pl
12	4	keymaker	jerzy.drozdz@jdsieci.pl
13	2	webmaster	jerzy.drozdz@jdsieci.pl
14	3	webmaster	jerzy.drozdz@jdsieci.pl
15	4	webmaster	jerzy.drozdz@jdsieci.pl
16	2	root	jerzy.drozdz@jdsieci.pl
17	3	root	jerzy.drozdz@jdsieci.pl
18	4	root	jerzy.drozdz@jdsieci.pl
19	2	biuro	jerzy.drozdz@jdsieci.pl
23	2	@mail.jdsieci.pl	jerzy.drozdz@jdsieci.pl
24	2	@prime.jdsieci.pl	jerzy.drozdz@jdsieci.pl
25	2	tofik	jerzy.drozdz@jdsieci.pl
\.


--
-- Data for Name: virtual_domains; Type: TABLE DATA; Schema: jds; Owner: jds
--

COPY virtual_domains (id, name) FROM stdin;
1	rgc.pl.eu.org
2	jdsieci.pl
3	jdsieci.com.pl
5	prime.jdsieci.pl
6	mail.jdsieci.pl
4	do_not_use_jdsieci.eu
7	justynabukowska.pl
\.


--
-- Data for Name: virtual_users; Type: TABLE DATA; Schema: jds; Owner: jds
--

COPY virtual_users (id, "user", password, domain_id) FROM stdin;
1	tofik	334f306737f34bfe92812b9fa7b73642	1
2	ela	f87077094601872db991df4ef0a33e14	1
3	jerzy.drozdz	334f306737f34bfe92812b9fa7b73642	2
4	michal.plawecki	3eccb14cb977ca6fa181085e70824f94	2
5	radoslaw.nurek	b6a2bce364f2833db3c18e298ee48b9a	2
6	hyperic	14c852b9f253185811412f731863d353	2
7	hqadmin	14c852b9f253185811412f731863d353	2
8	malwina.tuzimek	4d523f2835a1556cfd349db67e550b38	2
9	jb	022531ce2fbc09ed9cc68475bdca3c89	7
\.


SET search_path = kmprzedszkolak, pg_catalog;

--
-- Data for Name: virtual_aliases; Type: TABLE DATA; Schema: kmprzedszkolak; Owner: kmprzedszkolak@mailserver
--

COPY virtual_aliases (id, domain_id, source, destination) FROM stdin;
\.


--
-- Data for Name: virtual_domains; Type: TABLE DATA; Schema: kmprzedszkolak; Owner: kmprzedszkolak@mailserver
--

COPY virtual_domains (id, name) FROM stdin;
1	kmprzedszkolak.pl
\.


--
-- Data for Name: virtual_users; Type: TABLE DATA; Schema: kmprzedszkolak; Owner: kmprzedszkolak@mailserver
--

COPY virtual_users (id, "user", password, domain_id) FROM stdin;
1	biuro	c19a29bc9ea93eddb9a93603106a6b3e	1
\.


SET search_path = mailserver, pg_catalog;

--
-- Data for Name: virtual_aliases; Type: TABLE DATA; Schema: mailserver; Owner: mailserver
--

COPY virtual_aliases (id, domain_id, source, destination) FROM stdin;
1	1	webmaster	tofik@rgc.pl.eu.org
2	1	root	tofik@rgc.pl.eu.org
3	1	keymaker	tofik@rgc.pl.eu.org
4	1	elzbieta.drozdz	ela@rgc.pl.eu.org
5	1	jerzy.drozdz	tofik@rgc.pl.eu.org
28	8		jerzy.drozdz@jdsieci.pl
29	7		jerzy.drozdz@jdsieci.pl
10	2	keymaker	jerzy.drozdz@jdsieci.pl
11	3	keymaker	jerzy.drozdz@jdsieci.pl
12	4	keymaker	jerzy.drozdz@jdsieci.pl
13	2	webmaster	jerzy.drozdz@jdsieci.pl
14	3	webmaster	jerzy.drozdz@jdsieci.pl
15	4	webmaster	jerzy.drozdz@jdsieci.pl
16	2	root	jerzy.drozdz@jdsieci.pl
17	3	root	jerzy.drozdz@jdsieci.pl
18	4	root	jerzy.drozdz@jdsieci.pl
19	2	biuro	jerzy.drozdz@jdsieci.pl
30	9	zarzad	melki@ovum.org.pl,szymanska@ovum.org.pl
25	2	tofik	jerzy.drozdz@jdsieci.pl
26	5	biuro	marcin.kupien@budmk.pl
27	5	budmk	marcin.kupien@budmk.pl
\.


--
-- Data for Name: virtual_domains; Type: TABLE DATA; Schema: mailserver; Owner: mailserver
--

COPY virtual_domains (id, name) FROM stdin;
1	rgc.pl.eu.org
2	jdsieci.pl
3	jdsieci.com.pl
5	budmk.pl
6	kmprzedszkolak.pl
7	prime.jdsieci.pl
8	mail.jdsieci.pl
4	do_not_use_jdsieci.eu
9	ovum.org.pl
10	justynabukowska.pl
11	altroinstalacje.pl
12	street-terror.pl
\.


--
-- Data for Name: virtual_users; Type: TABLE DATA; Schema: mailserver; Owner: mailserver
--

COPY virtual_users (id, "user", password, domain_id) FROM stdin;
1	tofik	334f306737f34bfe92812b9fa7b73642	1
2	ela	f87077094601872db991df4ef0a33e14	1
3	jerzy.drozdz	334f306737f34bfe92812b9fa7b73642	2
4	marcin.kupien	0177dfb33498434ae3e0da7571f57500	5
5	biuro	c19a29bc9ea93eddb9a93603106a6b3e	6
6	michal.plawecki	3eccb14cb977ca6fa181085e70824f94	2
7	radoslaw.nurek	b6a2bce364f2833db3c18e298ee48b9a	2
8	hyperic	14c852b9f253185811412f731863d353	2
9	hqadmin	14c852b9f253185811412f731863d353	2
11	melki	e484d96c2304808bd8c384d48508d0f0	9
12	zarzad	2f1b78be6ece44e4a2eb8c4e44543e53	9
13	bpo	6664dbc5e4fba781ff96e83f69a0d303	9
10	szymanska	6dde338df933a6829d308013faec29dd	9
14	malwina.tuzimek	4d523f2835a1556cfd349db67e550b38	2
15	jb	022531ce2fbc09ed9cc68475bdca3c89	10
16	mk	ed6a0277c10daa4406c92a62b9886876	11
17	am	8ff5b56fa1ea212cadad4f4c20c75a1c	11
18	noreply	24b98da368baf300c0b45fa84be00e36	12
19	administrator	ba77b39d3441c91a67e0f91faa04311a	12
20	sklep	ee841e94d898fa50507813abd28aa525	12
21	konkurs	70b260e445f75139aadedad26132b80a	12
22	zlot2013	3626675d08ac17f0c85f8aeeaee402ef	12
23	ocin	e11407b5912e40079b6cfbd7d75d2bd6	12
24	nahh	a350a1ef21590d85c965da908ce3d2d4	12
25	julian	0189f32b2f54b3befc8b1321b903f5d7	12
26	kagi	d73bbad67aa38c47008a5f8711bbb7a2	12
27	cerber	8a1e0da8b00535519f18f4bbfad09304	12
28	shady	37ab0d2d2fbe87c00b78a37a6b5d7dd7	12
29	turbinka	7b86292905d15beb226cda012b35a932	12
30	pimpek	2846ba86208907d731e9787899c39d92	12
31	crisek	aef08c348fbd0d54b3efbc0db6373416	12
32	dzwonu	ba68c1fba8c4b15e200fc6b1fb00fef5	12
33	nowik	feb02f608d913095739c811bfc483e1e	12
34	bonias	7481170a38ebe209696797c2f868abc1	12
35	mariusz	f01687d51af51cb1d7628a6c749be19f	12
36	markotny	556faaecf98ae22cba63760ca6d1ccbf	12
37	ssn774	1b3ec8b14e26addc5903ca746c7357be	12
38	marczes	641dfa562fee47f6fe600e1801ad603f	12
39	spychu	3f41b9841a3ddc7744de87807ac4446e	12
40	mugen	24c54401e0a0551f94fdfa0a1a683a9e	12
41	zimek	d9eea9b7d80abfa85e063994dfa8c454	12
42	ursek	9763bcf4f6c80ea5355243c9f3acf10c	12
43	pampersiki	43d53ec07ca679e7835e38b1fe572b6a	12
44	venom	bfe8e3bca735b243f34f79f4d6e2b17f	12
45	wojtu	b86bc54140f023445ba299595f87e767	12
46	thorn	1600878fa5f64e1f8d23a0b8f5858e1c	12
47	endriu	76e012375abd4d2b12934e034de5c6ac	12
48	mosiu	8e274437f9a9465f85757260754a9ab4	12
49	sylwia	8a8cf55d6eb599cecb603d83a89243c6	12
50	domi	0cb03afc8ac3dac3dafde2dd6a595117	12
\.


SET search_path = ovum, pg_catalog;

--
-- Data for Name: virtual_aliases; Type: TABLE DATA; Schema: ovum; Owner: ovum@mailserver
--

COPY virtual_aliases (id, domain_id, source, destination) FROM stdin;
1	1	zarzad	melki@ovum.org.pl,szymanska@ovum.org.pl
\.


--
-- Data for Name: virtual_domains; Type: TABLE DATA; Schema: ovum; Owner: ovum@mailserver
--

COPY virtual_domains (id, name) FROM stdin;
1	ovum.org.pl
\.


--
-- Data for Name: virtual_users; Type: TABLE DATA; Schema: ovum; Owner: ovum@mailserver
--

COPY virtual_users (id, "user", password, domain_id) FROM stdin;
2	melki	e484d96c2304808bd8c384d48508d0f0	1
3	zarzad	2f1b78be6ece44e4a2eb8c4e44543e53	1
4	bpo	6664dbc5e4fba781ff96e83f69a0d303	1
1	szymanska	6dde338df933a6829d308013faec29dd	1
\.


SET search_path = public, pg_catalog;

--
-- Data for Name: virtual_aliases; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY virtual_aliases (id, domain_id, source, destination) FROM stdin;
\.


--
-- Data for Name: virtual_domains; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY virtual_domains (id, name) FROM stdin;
\.


--
-- Data for Name: virtual_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY virtual_users (id, "user", password, domain_id) FROM stdin;
\.


SET search_path = street_terror, pg_catalog;

--
-- Data for Name: virtual_aliases; Type: TABLE DATA; Schema: street_terror; Owner: street_terror@mailserver
--

COPY virtual_aliases (id, domain_id, source, destination) FROM stdin;
\.


--
-- Data for Name: virtual_domains; Type: TABLE DATA; Schema: street_terror; Owner: street_terror@mailserver
--

COPY virtual_domains (id, name) FROM stdin;
1	street-terror.pl
\.


--
-- Data for Name: virtual_users; Type: TABLE DATA; Schema: street_terror; Owner: street_terror@mailserver
--

COPY virtual_users (id, "user", password, domain_id) FROM stdin;
1	noreply	24b98da368baf300c0b45fa84be00e36	1
2	administrator	ba77b39d3441c91a67e0f91faa04311a	1
3	sklep	ee841e94d898fa50507813abd28aa525	1
4	konkurs	70b260e445f75139aadedad26132b80a	1
5	zlot2013	3626675d08ac17f0c85f8aeeaee402ef	1
6	ocin	e11407b5912e40079b6cfbd7d75d2bd6	1
7	nahh	a350a1ef21590d85c965da908ce3d2d4	1
8	julian	0189f32b2f54b3befc8b1321b903f5d7	1
9	kagi	d73bbad67aa38c47008a5f8711bbb7a2	1
11	shady	37ab0d2d2fbe87c00b78a37a6b5d7dd7	1
12	turbinka	7b86292905d15beb226cda012b35a932	1
13	pimpek	2846ba86208907d731e9787899c39d92	1
14	crisek	aef08c348fbd0d54b3efbc0db6373416	1
15	dzwonu	ba68c1fba8c4b15e200fc6b1fb00fef5	1
16	nowik	feb02f608d913095739c811bfc483e1e	1
17	bonias	7481170a38ebe209696797c2f868abc1	1
18	mariusz	f01687d51af51cb1d7628a6c749be19f	1
19	markotny	556faaecf98ae22cba63760ca6d1ccbf	1
20	ssn774	1b3ec8b14e26addc5903ca746c7357be	1
21	marczes	641dfa562fee47f6fe600e1801ad603f	1
22	spychu	3f41b9841a3ddc7744de87807ac4446e	1
23	mugen	24c54401e0a0551f94fdfa0a1a683a9e	1
24	zimek	d9eea9b7d80abfa85e063994dfa8c454	1
25	ursek	9763bcf4f6c80ea5355243c9f3acf10c	1
26	pampersiki	43d53ec07ca679e7835e38b1fe572b6a	1
27	venom	bfe8e3bca735b243f34f79f4d6e2b17f	1
28	wojtu	b86bc54140f023445ba299595f87e767	1
29	thorn	1600878fa5f64e1f8d23a0b8f5858e1c	1
30	endriu	76e012375abd4d2b12934e034de5c6ac	1
31	mosiu	8e274437f9a9465f85757260754a9ab4	1
32	sylwia	8a8cf55d6eb599cecb603d83a89243c6	1
33	domi	0cb03afc8ac3dac3dafde2dd6a595117	1
10	ceber	8a1e0da8b00535519f18f4bbfad09304	1
\.


SET search_path = altro, pg_catalog;

--
-- Name: virtual_aliases_pkey; Type: CONSTRAINT; Schema: altro; Owner: altro@mailserver; Tablespace: 
--

ALTER TABLE ONLY virtual_aliases
    ADD CONSTRAINT virtual_aliases_pkey PRIMARY KEY (id);


--
-- Name: virtual_domains_pkey; Type: CONSTRAINT; Schema: altro; Owner: altro@mailserver; Tablespace: 
--

ALTER TABLE ONLY virtual_domains
    ADD CONSTRAINT virtual_domains_pkey PRIMARY KEY (id);


--
-- Name: virtual_users_pkey; Type: CONSTRAINT; Schema: altro; Owner: altro@mailserver; Tablespace: 
--

ALTER TABLE ONLY virtual_users
    ADD CONSTRAINT virtual_users_pkey PRIMARY KEY (id);


SET search_path = budmk, pg_catalog;

--
-- Name: virtual_aliases_pkey; Type: CONSTRAINT; Schema: budmk; Owner: budmk@mailserver; Tablespace: 
--

ALTER TABLE ONLY virtual_aliases
    ADD CONSTRAINT virtual_aliases_pkey PRIMARY KEY (id);


--
-- Name: virtual_domains_pkey; Type: CONSTRAINT; Schema: budmk; Owner: budmk@mailserver; Tablespace: 
--

ALTER TABLE ONLY virtual_domains
    ADD CONSTRAINT virtual_domains_pkey PRIMARY KEY (id);


--
-- Name: virtual_users_pkey; Type: CONSTRAINT; Schema: budmk; Owner: budmk@mailserver; Tablespace: 
--

ALTER TABLE ONLY virtual_users
    ADD CONSTRAINT virtual_users_pkey PRIMARY KEY (id);


SET search_path = jds, pg_catalog;

--
-- Name: virtual_aliases_pkey; Type: CONSTRAINT; Schema: jds; Owner: jds; Tablespace: 
--

ALTER TABLE ONLY virtual_aliases
    ADD CONSTRAINT virtual_aliases_pkey PRIMARY KEY (id);


--
-- Name: virtual_domains_pkey; Type: CONSTRAINT; Schema: jds; Owner: jds; Tablespace: 
--

ALTER TABLE ONLY virtual_domains
    ADD CONSTRAINT virtual_domains_pkey PRIMARY KEY (id);


--
-- Name: virtual_users_pkey; Type: CONSTRAINT; Schema: jds; Owner: jds; Tablespace: 
--

ALTER TABLE ONLY virtual_users
    ADD CONSTRAINT virtual_users_pkey PRIMARY KEY (id);


SET search_path = kmprzedszkolak, pg_catalog;

--
-- Name: virtual_aliases_pkey; Type: CONSTRAINT; Schema: kmprzedszkolak; Owner: kmprzedszkolak@mailserver; Tablespace: 
--

ALTER TABLE ONLY virtual_aliases
    ADD CONSTRAINT virtual_aliases_pkey PRIMARY KEY (id);


--
-- Name: virtual_domains_pkey; Type: CONSTRAINT; Schema: kmprzedszkolak; Owner: kmprzedszkolak@mailserver; Tablespace: 
--

ALTER TABLE ONLY virtual_domains
    ADD CONSTRAINT virtual_domains_pkey PRIMARY KEY (id);


--
-- Name: virtual_users_pkey; Type: CONSTRAINT; Schema: kmprzedszkolak; Owner: kmprzedszkolak@mailserver; Tablespace: 
--

ALTER TABLE ONLY virtual_users
    ADD CONSTRAINT virtual_users_pkey PRIMARY KEY (id);


SET search_path = mailserver, pg_catalog;

--
-- Name: virtual_aliases_pkey; Type: CONSTRAINT; Schema: mailserver; Owner: mailserver; Tablespace: 
--

ALTER TABLE ONLY virtual_aliases
    ADD CONSTRAINT virtual_aliases_pkey PRIMARY KEY (id);


--
-- Name: virtual_domains_pkey; Type: CONSTRAINT; Schema: mailserver; Owner: mailserver; Tablespace: 
--

ALTER TABLE ONLY virtual_domains
    ADD CONSTRAINT virtual_domains_pkey PRIMARY KEY (id);


--
-- Name: virtual_users_pkey; Type: CONSTRAINT; Schema: mailserver; Owner: mailserver; Tablespace: 
--

ALTER TABLE ONLY virtual_users
    ADD CONSTRAINT virtual_users_pkey PRIMARY KEY (id);


SET search_path = ovum, pg_catalog;

--
-- Name: virtual_aliases_pkey; Type: CONSTRAINT; Schema: ovum; Owner: ovum@mailserver; Tablespace: 
--

ALTER TABLE ONLY virtual_aliases
    ADD CONSTRAINT virtual_aliases_pkey PRIMARY KEY (id);


--
-- Name: virtual_domains_pkey; Type: CONSTRAINT; Schema: ovum; Owner: ovum@mailserver; Tablespace: 
--

ALTER TABLE ONLY virtual_domains
    ADD CONSTRAINT virtual_domains_pkey PRIMARY KEY (id);


--
-- Name: virtual_users_pkey; Type: CONSTRAINT; Schema: ovum; Owner: ovum@mailserver; Tablespace: 
--

ALTER TABLE ONLY virtual_users
    ADD CONSTRAINT virtual_users_pkey PRIMARY KEY (id);


SET search_path = public, pg_catalog;

--
-- Name: virtual_aliases_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY virtual_aliases
    ADD CONSTRAINT virtual_aliases_pkey PRIMARY KEY (id);


--
-- Name: virtual_domains_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY virtual_domains
    ADD CONSTRAINT virtual_domains_pkey PRIMARY KEY (id);


--
-- Name: virtual_users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY virtual_users
    ADD CONSTRAINT virtual_users_pkey PRIMARY KEY (id);


SET search_path = street_terror, pg_catalog;

--
-- Name: virtual_aliases_pkey; Type: CONSTRAINT; Schema: street_terror; Owner: street_terror@mailserver; Tablespace: 
--

ALTER TABLE ONLY virtual_aliases
    ADD CONSTRAINT virtual_aliases_pkey PRIMARY KEY (id);


--
-- Name: virtual_domains_pkey; Type: CONSTRAINT; Schema: street_terror; Owner: street_terror@mailserver; Tablespace: 
--

ALTER TABLE ONLY virtual_domains
    ADD CONSTRAINT virtual_domains_pkey PRIMARY KEY (id);


--
-- Name: virtual_users_pkey; Type: CONSTRAINT; Schema: street_terror; Owner: street_terror@mailserver; Tablespace: 
--

ALTER TABLE ONLY virtual_users
    ADD CONSTRAINT virtual_users_pkey PRIMARY KEY (id);


SET search_path = altro, pg_catalog;

--
-- Name: fki_; Type: INDEX; Schema: altro; Owner: altro@mailserver; Tablespace: 
--

CREATE INDEX fki_ ON virtual_users USING btree (domain_id);


SET search_path = budmk, pg_catalog;

--
-- Name: fki_; Type: INDEX; Schema: budmk; Owner: budmk@mailserver; Tablespace: 
--

CREATE INDEX fki_ ON virtual_users USING btree (domain_id);


SET search_path = jds, pg_catalog;

--
-- Name: fki_; Type: INDEX; Schema: jds; Owner: jds; Tablespace: 
--

CREATE INDEX fki_ ON virtual_users USING btree (domain_id);


SET search_path = kmprzedszkolak, pg_catalog;

--
-- Name: fki_; Type: INDEX; Schema: kmprzedszkolak; Owner: kmprzedszkolak@mailserver; Tablespace: 
--

CREATE INDEX fki_ ON virtual_users USING btree (domain_id);


SET search_path = mailserver, pg_catalog;

--
-- Name: fki_; Type: INDEX; Schema: mailserver; Owner: mailserver; Tablespace: 
--

CREATE INDEX fki_ ON virtual_users USING btree (domain_id);


SET search_path = ovum, pg_catalog;

--
-- Name: fki_; Type: INDEX; Schema: ovum; Owner: ovum@mailserver; Tablespace: 
--

CREATE INDEX fki_ ON virtual_users USING btree (domain_id);


SET search_path = public, pg_catalog;

--
-- Name: fki_; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_ ON virtual_users USING btree (domain_id);


SET search_path = street_terror, pg_catalog;

--
-- Name: fki_; Type: INDEX; Schema: street_terror; Owner: street_terror@mailserver; Tablespace: 
--

CREATE INDEX fki_ ON virtual_users USING btree (domain_id);


SET search_path = altro, pg_catalog;

--
-- Name: copy_virtual_alias; Type: TRIGGER; Schema: altro; Owner: altro@mailserver
--

CREATE TRIGGER copy_virtual_alias
    BEFORE INSERT OR DELETE OR UPDATE ON virtual_aliases
    FOR EACH ROW
    EXECUTE PROCEDURE "vmail-mailserver_virtual_aliases"();


--
-- Name: copy_virtual_domain; Type: TRIGGER; Schema: altro; Owner: altro@mailserver
--

CREATE TRIGGER copy_virtual_domain
    BEFORE INSERT OR DELETE OR UPDATE ON virtual_domains
    FOR EACH ROW
    EXECUTE PROCEDURE "vmail-mailserver_virtual_domain"();


--
-- Name: copy_virtual_users; Type: TRIGGER; Schema: altro; Owner: altro@mailserver
--

CREATE TRIGGER copy_virtual_users
    BEFORE INSERT OR DELETE OR UPDATE ON virtual_users
    FOR EACH ROW
    EXECUTE PROCEDURE "vmail-mailserver_virtual_users"();


SET search_path = budmk, pg_catalog;

--
-- Name: copy_virtual_alias; Type: TRIGGER; Schema: budmk; Owner: budmk@mailserver
--

CREATE TRIGGER copy_virtual_alias
    BEFORE INSERT OR DELETE OR UPDATE ON virtual_aliases
    FOR EACH ROW
    EXECUTE PROCEDURE "vmail-mailserver_virtual_aliases"();


--
-- Name: copy_virtual_domain; Type: TRIGGER; Schema: budmk; Owner: budmk@mailserver
--

CREATE TRIGGER copy_virtual_domain
    BEFORE INSERT OR DELETE OR UPDATE ON virtual_domains
    FOR EACH ROW
    EXECUTE PROCEDURE "vmail-mailserver_virtual_domain"();


--
-- Name: copy_virtual_users; Type: TRIGGER; Schema: budmk; Owner: budmk@mailserver
--

CREATE TRIGGER copy_virtual_users
    BEFORE INSERT OR DELETE OR UPDATE ON virtual_users
    FOR EACH ROW
    EXECUTE PROCEDURE "vmail-mailserver_virtual_users"();


SET search_path = jds, pg_catalog;

--
-- Name: copy_virtual_alias; Type: TRIGGER; Schema: jds; Owner: jds
--

CREATE TRIGGER copy_virtual_alias
    BEFORE INSERT OR DELETE OR UPDATE ON virtual_aliases
    FOR EACH ROW
    EXECUTE PROCEDURE "vmail-mailserver_virtual_aliases"();


--
-- Name: copy_virtual_domain; Type: TRIGGER; Schema: jds; Owner: jds
--

CREATE TRIGGER copy_virtual_domain
    BEFORE INSERT OR DELETE OR UPDATE ON virtual_domains
    FOR EACH ROW
    EXECUTE PROCEDURE "vmail-mailserver_virtual_domain"();


--
-- Name: copy_virtual_users; Type: TRIGGER; Schema: jds; Owner: jds
--

CREATE TRIGGER copy_virtual_users
    BEFORE INSERT OR DELETE OR UPDATE ON virtual_users
    FOR EACH ROW
    EXECUTE PROCEDURE "vmail-mailserver_virtual_users"();


SET search_path = kmprzedszkolak, pg_catalog;

--
-- Name: copy_virtual_alias; Type: TRIGGER; Schema: kmprzedszkolak; Owner: kmprzedszkolak@mailserver
--

CREATE TRIGGER copy_virtual_alias
    BEFORE INSERT OR DELETE OR UPDATE ON virtual_aliases
    FOR EACH ROW
    EXECUTE PROCEDURE "vmail-mailserver_virtual_aliases"();


--
-- Name: copy_virtual_domain; Type: TRIGGER; Schema: kmprzedszkolak; Owner: kmprzedszkolak@mailserver
--

CREATE TRIGGER copy_virtual_domain
    BEFORE INSERT OR DELETE OR UPDATE ON virtual_domains
    FOR EACH ROW
    EXECUTE PROCEDURE "vmail-mailserver_virtual_domain"();


--
-- Name: copy_virtual_users; Type: TRIGGER; Schema: kmprzedszkolak; Owner: kmprzedszkolak@mailserver
--

CREATE TRIGGER copy_virtual_users
    BEFORE INSERT OR DELETE OR UPDATE ON virtual_users
    FOR EACH ROW
    EXECUTE PROCEDURE "vmail-mailserver_virtual_users"();


SET search_path = ovum, pg_catalog;

--
-- Name: copy_virtual_alias; Type: TRIGGER; Schema: ovum; Owner: ovum@mailserver
--

CREATE TRIGGER copy_virtual_alias
    BEFORE INSERT OR DELETE OR UPDATE ON virtual_aliases
    FOR EACH ROW
    EXECUTE PROCEDURE "vmail-mailserver_virtual_aliases"();


--
-- Name: copy_virtual_domain; Type: TRIGGER; Schema: ovum; Owner: ovum@mailserver
--

CREATE TRIGGER copy_virtual_domain
    BEFORE INSERT OR DELETE OR UPDATE ON virtual_domains
    FOR EACH ROW
    EXECUTE PROCEDURE "vmail-mailserver_virtual_domain"();


--
-- Name: copy_virtual_users; Type: TRIGGER; Schema: ovum; Owner: ovum@mailserver
--

CREATE TRIGGER copy_virtual_users
    BEFORE INSERT OR DELETE OR UPDATE ON virtual_users
    FOR EACH ROW
    EXECUTE PROCEDURE "vmail-mailserver_virtual_users"();


SET search_path = public, pg_catalog;

--
-- Name: copy_virtual_alias; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER copy_virtual_alias
    BEFORE INSERT OR DELETE OR UPDATE ON virtual_aliases
    FOR EACH ROW
    EXECUTE PROCEDURE "vmail-mailserver_virtual_aliases"();


--
-- Name: copy_virtual_domain; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER copy_virtual_domain
    BEFORE INSERT OR DELETE OR UPDATE ON virtual_domains
    FOR EACH ROW
    EXECUTE PROCEDURE "vmail-mailserver_virtual_domain"();


--
-- Name: copy_virtual_users; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER copy_virtual_users
    BEFORE INSERT OR DELETE OR UPDATE ON virtual_users
    FOR EACH ROW
    EXECUTE PROCEDURE "vmail-mailserver_virtual_users"();


SET search_path = street_terror, pg_catalog;

--
-- Name: copy_virtual_alias; Type: TRIGGER; Schema: street_terror; Owner: street_terror@mailserver
--

CREATE TRIGGER copy_virtual_alias
    BEFORE INSERT OR DELETE OR UPDATE ON virtual_aliases
    FOR EACH ROW
    EXECUTE PROCEDURE "vmail-mailserver_virtual_aliases"();


--
-- Name: copy_virtual_domain; Type: TRIGGER; Schema: street_terror; Owner: street_terror@mailserver
--

CREATE TRIGGER copy_virtual_domain
    BEFORE INSERT OR DELETE OR UPDATE ON virtual_domains
    FOR EACH ROW
    EXECUTE PROCEDURE "vmail-mailserver_virtual_domain"();


--
-- Name: copy_virtual_users; Type: TRIGGER; Schema: street_terror; Owner: street_terror@mailserver
--

CREATE TRIGGER copy_virtual_users
    BEFORE INSERT OR DELETE OR UPDATE ON virtual_users
    FOR EACH ROW
    EXECUTE PROCEDURE "vmail-mailserver_virtual_users"();


SET search_path = altro, pg_catalog;

--
-- Name: virtual_aliases_domain_id_fkey; Type: FK CONSTRAINT; Schema: altro; Owner: altro@mailserver
--

ALTER TABLE ONLY virtual_aliases
    ADD CONSTRAINT virtual_aliases_domain_id_fkey FOREIGN KEY (domain_id) REFERENCES virtual_domains(id);


--
-- Name: virtual_users_domain_id_fkey; Type: FK CONSTRAINT; Schema: altro; Owner: altro@mailserver
--

ALTER TABLE ONLY virtual_users
    ADD CONSTRAINT virtual_users_domain_id_fkey FOREIGN KEY (domain_id) REFERENCES virtual_domains(id);


SET search_path = budmk, pg_catalog;

--
-- Name: virtual_aliases_domain_id_fkey; Type: FK CONSTRAINT; Schema: budmk; Owner: budmk@mailserver
--

ALTER TABLE ONLY virtual_aliases
    ADD CONSTRAINT virtual_aliases_domain_id_fkey FOREIGN KEY (domain_id) REFERENCES virtual_domains(id);


--
-- Name: virtual_users_domain_id_fkey; Type: FK CONSTRAINT; Schema: budmk; Owner: budmk@mailserver
--

ALTER TABLE ONLY virtual_users
    ADD CONSTRAINT virtual_users_domain_id_fkey FOREIGN KEY (domain_id) REFERENCES virtual_domains(id);


SET search_path = jds, pg_catalog;

--
-- Name: virtual_aliases_domain_id_fkey; Type: FK CONSTRAINT; Schema: jds; Owner: jds
--

ALTER TABLE ONLY virtual_aliases
    ADD CONSTRAINT virtual_aliases_domain_id_fkey FOREIGN KEY (domain_id) REFERENCES virtual_domains(id);


--
-- Name: virtual_users_domain_id_fkey; Type: FK CONSTRAINT; Schema: jds; Owner: jds
--

ALTER TABLE ONLY virtual_users
    ADD CONSTRAINT virtual_users_domain_id_fkey FOREIGN KEY (domain_id) REFERENCES virtual_domains(id);


SET search_path = kmprzedszkolak, pg_catalog;

--
-- Name: virtual_aliases_domain_id_fkey; Type: FK CONSTRAINT; Schema: kmprzedszkolak; Owner: kmprzedszkolak@mailserver
--

ALTER TABLE ONLY virtual_aliases
    ADD CONSTRAINT virtual_aliases_domain_id_fkey FOREIGN KEY (domain_id) REFERENCES virtual_domains(id);


--
-- Name: virtual_users_domain_id_fkey; Type: FK CONSTRAINT; Schema: kmprzedszkolak; Owner: kmprzedszkolak@mailserver
--

ALTER TABLE ONLY virtual_users
    ADD CONSTRAINT virtual_users_domain_id_fkey FOREIGN KEY (domain_id) REFERENCES virtual_domains(id);


SET search_path = mailserver, pg_catalog;

--
-- Name: virtual_aliases_domain_id_fkey; Type: FK CONSTRAINT; Schema: mailserver; Owner: mailserver
--

ALTER TABLE ONLY virtual_aliases
    ADD CONSTRAINT virtual_aliases_domain_id_fkey FOREIGN KEY (domain_id) REFERENCES virtual_domains(id);


--
-- Name: virtual_users_domain_id_fkey; Type: FK CONSTRAINT; Schema: mailserver; Owner: mailserver
--

ALTER TABLE ONLY virtual_users
    ADD CONSTRAINT virtual_users_domain_id_fkey FOREIGN KEY (domain_id) REFERENCES virtual_domains(id) ON UPDATE CASCADE ON DELETE CASCADE;


SET search_path = ovum, pg_catalog;

--
-- Name: virtual_aliases_domain_id_fkey; Type: FK CONSTRAINT; Schema: ovum; Owner: ovum@mailserver
--

ALTER TABLE ONLY virtual_aliases
    ADD CONSTRAINT virtual_aliases_domain_id_fkey FOREIGN KEY (domain_id) REFERENCES virtual_domains(id);


--
-- Name: virtual_users_domain_id_fkey; Type: FK CONSTRAINT; Schema: ovum; Owner: ovum@mailserver
--

ALTER TABLE ONLY virtual_users
    ADD CONSTRAINT virtual_users_domain_id_fkey FOREIGN KEY (domain_id) REFERENCES virtual_domains(id);


SET search_path = public, pg_catalog;

--
-- Name: virtual_aliases_domain_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY virtual_aliases
    ADD CONSTRAINT virtual_aliases_domain_id_fkey FOREIGN KEY (domain_id) REFERENCES virtual_domains(id);


--
-- Name: virtual_users_domain_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY virtual_users
    ADD CONSTRAINT virtual_users_domain_id_fkey FOREIGN KEY (domain_id) REFERENCES virtual_domains(id);


SET search_path = street_terror, pg_catalog;

--
-- Name: virtual_aliases_domain_id_fkey; Type: FK CONSTRAINT; Schema: street_terror; Owner: street_terror@mailserver
--

ALTER TABLE ONLY virtual_aliases
    ADD CONSTRAINT virtual_aliases_domain_id_fkey FOREIGN KEY (domain_id) REFERENCES virtual_domains(id);


--
-- Name: virtual_users_domain_id_fkey; Type: FK CONSTRAINT; Schema: street_terror; Owner: street_terror@mailserver
--

ALTER TABLE ONLY virtual_users
    ADD CONSTRAINT virtual_users_domain_id_fkey FOREIGN KEY (domain_id) REFERENCES virtual_domains(id);


--
-- Name: altro; Type: ACL; Schema: -; Owner: altro@mailserver
--

REVOKE ALL ON SCHEMA altro FROM PUBLIC;
REVOKE ALL ON SCHEMA altro FROM "altro@mailserver";
GRANT ALL ON SCHEMA altro TO "altro@mailserver";
GRANT USAGE ON SCHEMA altro TO PUBLIC;


--
-- Name: budmk; Type: ACL; Schema: -; Owner: budmk@mailserver
--

REVOKE ALL ON SCHEMA budmk FROM PUBLIC;
REVOKE ALL ON SCHEMA budmk FROM "budmk@mailserver";
GRANT ALL ON SCHEMA budmk TO "budmk@mailserver";
GRANT USAGE ON SCHEMA budmk TO PUBLIC;


--
-- Name: jds; Type: ACL; Schema: -; Owner: jds
--

REVOKE ALL ON SCHEMA jds FROM PUBLIC;
REVOKE ALL ON SCHEMA jds FROM jds;
GRANT ALL ON SCHEMA jds TO jds;
GRANT USAGE ON SCHEMA jds TO PUBLIC;


--
-- Name: kmprzedszkolak; Type: ACL; Schema: -; Owner: kmprzedszkolak@mailserver
--

REVOKE ALL ON SCHEMA kmprzedszkolak FROM PUBLIC;
REVOKE ALL ON SCHEMA kmprzedszkolak FROM "kmprzedszkolak@mailserver";
GRANT ALL ON SCHEMA kmprzedszkolak TO "kmprzedszkolak@mailserver";
GRANT USAGE ON SCHEMA kmprzedszkolak TO PUBLIC;


--
-- Name: mailserver; Type: ACL; Schema: -; Owner: mailserver
--

REVOKE ALL ON SCHEMA mailserver FROM PUBLIC;
REVOKE ALL ON SCHEMA mailserver FROM mailserver;
GRANT ALL ON SCHEMA mailserver TO mailserver;
GRANT ALL ON SCHEMA mailserver TO client WITH GRANT OPTION;


--
-- Name: ovum; Type: ACL; Schema: -; Owner: ovum@mailserver
--

REVOKE ALL ON SCHEMA ovum FROM PUBLIC;
REVOKE ALL ON SCHEMA ovum FROM "ovum@mailserver";
GRANT ALL ON SCHEMA ovum TO "ovum@mailserver";
GRANT USAGE ON SCHEMA ovum TO PUBLIC;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- Name: street_terror; Type: ACL; Schema: -; Owner: street_terror@mailserver
--

REVOKE ALL ON SCHEMA street_terror FROM PUBLIC;
REVOKE ALL ON SCHEMA street_terror FROM "street_terror@mailserver";
GRANT ALL ON SCHEMA street_terror TO "street_terror@mailserver";
GRANT USAGE ON SCHEMA street_terror TO PUBLIC;


SET search_path = altro, pg_catalog;

--
-- Name: virtual_domains; Type: ACL; Schema: altro; Owner: altro@mailserver
--

REVOKE ALL ON TABLE virtual_domains FROM PUBLIC;
REVOKE ALL ON TABLE virtual_domains FROM "altro@mailserver";
GRANT ALL ON TABLE virtual_domains TO "altro@mailserver";


SET search_path = mailserver, pg_catalog;

--
-- Name: virtual_domains; Type: ACL; Schema: mailserver; Owner: mailserver
--

REVOKE ALL ON TABLE virtual_domains FROM PUBLIC;
REVOKE ALL ON TABLE virtual_domains FROM mailserver;
GRANT ALL ON TABLE virtual_domains TO mailserver;
GRANT ALL ON TABLE virtual_domains TO client WITH GRANT OPTION;


SET search_path = budmk, pg_catalog;

--
-- Name: virtual_domains; Type: ACL; Schema: budmk; Owner: budmk@mailserver
--

REVOKE ALL ON TABLE virtual_domains FROM PUBLIC;
REVOKE ALL ON TABLE virtual_domains FROM "budmk@mailserver";
GRANT ALL ON TABLE virtual_domains TO "budmk@mailserver";


SET search_path = jds, pg_catalog;

--
-- Name: virtual_domains; Type: ACL; Schema: jds; Owner: jds
--

REVOKE ALL ON TABLE virtual_domains FROM PUBLIC;
REVOKE ALL ON TABLE virtual_domains FROM jds;
GRANT ALL ON TABLE virtual_domains TO jds;


SET search_path = kmprzedszkolak, pg_catalog;

--
-- Name: virtual_domains; Type: ACL; Schema: kmprzedszkolak; Owner: kmprzedszkolak@mailserver
--

REVOKE ALL ON TABLE virtual_domains FROM PUBLIC;
REVOKE ALL ON TABLE virtual_domains FROM "kmprzedszkolak@mailserver";
GRANT ALL ON TABLE virtual_domains TO "kmprzedszkolak@mailserver";


SET search_path = mailserver, pg_catalog;

--
-- Name: virtual_aliases; Type: ACL; Schema: mailserver; Owner: mailserver
--

REVOKE ALL ON TABLE virtual_aliases FROM PUBLIC;
REVOKE ALL ON TABLE virtual_aliases FROM mailserver;
GRANT ALL ON TABLE virtual_aliases TO mailserver;
GRANT ALL ON TABLE virtual_aliases TO client;


--
-- Name: view_aliases; Type: ACL; Schema: mailserver; Owner: postgres
--

REVOKE ALL ON TABLE view_aliases FROM PUBLIC;
REVOKE ALL ON TABLE view_aliases FROM postgres;
GRANT ALL ON TABLE view_aliases TO postgres;
GRANT SELECT ON TABLE view_aliases TO mailserver;


--
-- Name: virtual_users; Type: ACL; Schema: mailserver; Owner: mailserver
--

REVOKE ALL ON TABLE virtual_users FROM PUBLIC;
REVOKE ALL ON TABLE virtual_users FROM mailserver;
GRANT SELECT,REFERENCES,TRIGGER ON TABLE virtual_users TO mailserver WITH GRANT OPTION;
GRANT ALL ON TABLE virtual_users TO client WITH GRANT OPTION;


--
-- Name: view_users; Type: ACL; Schema: mailserver; Owner: postgres
--

REVOKE ALL ON TABLE view_users FROM PUBLIC;
REVOKE ALL ON TABLE view_users FROM postgres;
GRANT ALL ON TABLE view_users TO postgres;
GRANT SELECT ON TABLE view_users TO mailserver;


--
-- Name: virtual_aliases_id_seq; Type: ACL; Schema: mailserver; Owner: mailserver
--

REVOKE ALL ON SEQUENCE virtual_aliases_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE virtual_aliases_id_seq FROM mailserver;
GRANT ALL ON SEQUENCE virtual_aliases_id_seq TO mailserver;
GRANT SELECT,UPDATE ON SEQUENCE virtual_aliases_id_seq TO client;


--
-- Name: virtual_domains_id_seq; Type: ACL; Schema: mailserver; Owner: mailserver
--

REVOKE ALL ON SEQUENCE virtual_domains_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE virtual_domains_id_seq FROM mailserver;
GRANT ALL ON SEQUENCE virtual_domains_id_seq TO mailserver;
GRANT ALL ON SEQUENCE virtual_domains_id_seq TO client;


--
-- Name: virtual_users_id_seq; Type: ACL; Schema: mailserver; Owner: mailserver
--

REVOKE ALL ON SEQUENCE virtual_users_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE virtual_users_id_seq FROM mailserver;
GRANT ALL ON SEQUENCE virtual_users_id_seq TO mailserver;
GRANT ALL ON SEQUENCE virtual_users_id_seq TO client;


SET search_path = ovum, pg_catalog;

--
-- Name: virtual_domains; Type: ACL; Schema: ovum; Owner: ovum@mailserver
--

REVOKE ALL ON TABLE virtual_domains FROM PUBLIC;
REVOKE ALL ON TABLE virtual_domains FROM "ovum@mailserver";
GRANT ALL ON TABLE virtual_domains TO "ovum@mailserver";


SET search_path = public, pg_catalog;

--
-- Name: virtual_domains; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE virtual_domains FROM PUBLIC;
REVOKE ALL ON TABLE virtual_domains FROM postgres;
GRANT ALL ON TABLE virtual_domains TO postgres;


SET search_path = street_terror, pg_catalog;

--
-- Name: virtual_domains; Type: ACL; Schema: street_terror; Owner: street_terror@mailserver
--

REVOKE ALL ON TABLE virtual_domains FROM PUBLIC;
REVOKE ALL ON TABLE virtual_domains FROM "street_terror@mailserver";
GRANT ALL ON TABLE virtual_domains TO "street_terror@mailserver";


--
-- PostgreSQL database dump complete
--


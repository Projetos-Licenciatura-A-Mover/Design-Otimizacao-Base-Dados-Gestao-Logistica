--
-- PostgreSQL database dump
--

-- Dumped from database version 15.8
-- Dumped by pg_dump version 16.9 (Ubuntu 16.9-1.pgdg24.04+1)

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
-- Name: auth; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA auth;


ALTER SCHEMA auth OWNER TO supabase_admin;

--
-- Name: extensions; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA extensions;


ALTER SCHEMA extensions OWNER TO postgres;

--
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql;


ALTER SCHEMA graphql OWNER TO supabase_admin;

--
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql_public;


ALTER SCHEMA graphql_public OWNER TO supabase_admin;

--
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: pgbouncer
--

CREATE SCHEMA pgbouncer;


ALTER SCHEMA pgbouncer OWNER TO pgbouncer;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS '';


--
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA realtime;


ALTER SCHEMA realtime OWNER TO supabase_admin;

--
-- Name: storage; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA storage;


ALTER SCHEMA storage OWNER TO supabase_admin;

--
-- Name: vault; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA vault;


ALTER SCHEMA vault OWNER TO supabase_admin;

--
-- Name: pg_graphql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_graphql WITH SCHEMA graphql;


--
-- Name: EXTENSION pg_graphql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_graphql IS 'pg_graphql: GraphQL support';


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA extensions;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: pgjwt; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgjwt WITH SCHEMA extensions;


--
-- Name: EXTENSION pgjwt; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgjwt IS 'JSON Web Token API for Postgresql';


--
-- Name: supabase_vault; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS supabase_vault WITH SCHEMA vault;


--
-- Name: EXTENSION supabase_vault; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION supabase_vault IS 'Supabase Vault Extension';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


ALTER TYPE auth.aal_level OWNER TO supabase_auth_admin;

--
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);


ALTER TYPE auth.code_challenge_method OWNER TO supabase_auth_admin;

--
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);


ALTER TYPE auth.factor_status OWNER TO supabase_auth_admin;

--
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn',
    'phone'
);


ALTER TYPE auth.factor_type OWNER TO supabase_auth_admin;

--
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.one_time_token_type AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


ALTER TYPE auth.one_time_token_type OWNER TO supabase_auth_admin;

--
-- Name: action; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);


ALTER TYPE realtime.action OWNER TO supabase_admin;

--
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.equality_op AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in'
);


ALTER TYPE realtime.equality_op OWNER TO supabase_admin;

--
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.user_defined_filter AS (
	column_name text,
	op realtime.equality_op,
	value text
);


ALTER TYPE realtime.user_defined_filter OWNER TO supabase_admin;

--
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_column AS (
	name text,
	type_name text,
	type_oid oid,
	value jsonb,
	is_pkey boolean,
	is_selectable boolean
);


ALTER TYPE realtime.wal_column OWNER TO supabase_admin;

--
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_rls AS (
	wal jsonb,
	is_rls_enabled boolean,
	subscription_ids uuid[],
	errors text[]
);


ALTER TYPE realtime.wal_rls OWNER TO supabase_admin;

--
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.email() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


ALTER FUNCTION auth.email() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION email(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.jwt() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


ALTER FUNCTION auth.jwt() OWNER TO supabase_auth_admin;

--
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.role() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


ALTER FUNCTION auth.role() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION role(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.uid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


ALTER FUNCTION auth.uid() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION uid(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- Name: grant_pg_cron_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_cron_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_cron'
  )
  THEN
    grant usage on schema cron to postgres with grant option;

    alter default privileges in schema cron grant all on tables to postgres with grant option;
    alter default privileges in schema cron grant all on functions to postgres with grant option;
    alter default privileges in schema cron grant all on sequences to postgres with grant option;

    alter default privileges for user supabase_admin in schema cron grant all
        on sequences to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on tables to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on functions to postgres with grant option;

    grant all privileges on all tables in schema cron to postgres with grant option;
    revoke all on table cron.job from postgres;
    grant select on table cron.job to postgres with grant option;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_cron_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_cron_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_cron_access() IS 'Grants access to pg_cron';


--
-- Name: grant_pg_graphql_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_graphql_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
DECLARE
    func_is_graphql_resolve bool;
BEGIN
    func_is_graphql_resolve = (
        SELECT n.proname = 'resolve'
        FROM pg_event_trigger_ddl_commands() AS ev
        LEFT JOIN pg_catalog.pg_proc AS n
        ON ev.objid = n.oid
    );

    IF func_is_graphql_resolve
    THEN
        -- Update public wrapper to pass all arguments through to the pg_graphql resolve func
        DROP FUNCTION IF EXISTS graphql_public.graphql;
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language sql
        as $$
            select graphql.resolve(
                query := query,
                variables := coalesce(variables, '{}'),
                "operationName" := "operationName",
                extensions := extensions
            );
        $$;

        -- This hook executes when `graphql.resolve` is created. That is not necessarily the last
        -- function in the extension so we need to grant permissions on existing entities AND
        -- update default permissions to any others that are created after `graphql.resolve`
        grant usage on schema graphql to postgres, anon, authenticated, service_role;
        grant select on all tables in schema graphql to postgres, anon, authenticated, service_role;
        grant execute on all functions in schema graphql to postgres, anon, authenticated, service_role;
        grant all on all sequences in schema graphql to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on tables to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on functions to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on sequences to postgres, anon, authenticated, service_role;

        -- Allow postgres role to allow granting usage on graphql and graphql_public schemas to custom roles
        grant usage on schema graphql_public to postgres with grant option;
        grant usage on schema graphql to postgres with grant option;
    END IF;

END;
$_$;


ALTER FUNCTION extensions.grant_pg_graphql_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_graphql_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_graphql_access() IS 'Grants access to pg_graphql';


--
-- Name: grant_pg_net_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_net_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_net'
  )
  THEN
    IF NOT EXISTS (
      SELECT 1
      FROM pg_roles
      WHERE rolname = 'supabase_functions_admin'
    )
    THEN
      CREATE USER supabase_functions_admin NOINHERIT CREATEROLE LOGIN NOREPLICATION;
    END IF;

    GRANT USAGE ON SCHEMA net TO supabase_functions_admin, postgres, anon, authenticated, service_role;

    IF EXISTS (
      SELECT FROM pg_extension
      WHERE extname = 'pg_net'
      -- all versions in use on existing projects as of 2025-02-20
      -- version 0.12.0 onwards don't need these applied
      AND extversion IN ('0.2', '0.6', '0.7', '0.7.1', '0.8', '0.10.0', '0.11.0')
    ) THEN
      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

      REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
      REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

      GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
      GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
    END IF;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_net_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_net_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_net_access() IS 'Grants access to pg_net';


--
-- Name: pgrst_ddl_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_ddl_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.command_tag IN (
      'CREATE SCHEMA', 'ALTER SCHEMA'
    , 'CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO', 'ALTER TABLE'
    , 'CREATE FOREIGN TABLE', 'ALTER FOREIGN TABLE'
    , 'CREATE VIEW', 'ALTER VIEW'
    , 'CREATE MATERIALIZED VIEW', 'ALTER MATERIALIZED VIEW'
    , 'CREATE FUNCTION', 'ALTER FUNCTION'
    , 'CREATE TRIGGER'
    , 'CREATE TYPE', 'ALTER TYPE'
    , 'CREATE RULE'
    , 'COMMENT'
    )
    -- don't notify in case of CREATE TEMP table or other objects created on pg_temp
    AND cmd.schema_name is distinct from 'pg_temp'
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_ddl_watch() OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_drop_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  obj record;
BEGIN
  FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
  LOOP
    IF obj.object_type IN (
      'schema'
    , 'table'
    , 'foreign table'
    , 'view'
    , 'materialized view'
    , 'function'
    , 'trigger'
    , 'type'
    , 'rule'
    )
    AND obj.is_temporary IS false -- no pg_temp objects
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_drop_watch() OWNER TO supabase_admin;

--
-- Name: set_graphql_placeholder(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.set_graphql_placeholder() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
    graphql_is_dropped bool;
    BEGIN
    graphql_is_dropped = (
        SELECT ev.schema_name = 'graphql_public'
        FROM pg_event_trigger_dropped_objects() AS ev
        WHERE ev.schema_name = 'graphql_public'
    );

    IF graphql_is_dropped
    THEN
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language plpgsql
        as $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;
    END IF;

    END;
$_$;


ALTER FUNCTION extensions.set_graphql_placeholder() OWNER TO supabase_admin;

--
-- Name: FUNCTION set_graphql_placeholder(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.set_graphql_placeholder() IS 'Reintroduces placeholder function for graphql_public.graphql';


--
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: supabase_admin
--

CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $_$
begin
    raise debug 'PgBouncer auth request: %', p_usename;

    return query
    select 
        rolname::text, 
        case when rolvaliduntil < now() 
            then null 
            else rolpassword::text 
        end 
    from pg_authid 
    where rolname=$1 and rolcanlogin;
end;
$_$;


ALTER FUNCTION pgbouncer.get_auth(p_usename text) OWNER TO supabase_admin;

--
-- Name: apply_rls(jsonb, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer DEFAULT (1024 * 1024)) RETURNS SETOF realtime.wal_rls
    LANGUAGE plpgsql
    AS $$
declare
-- Regclass of the table e.g. public.notes
entity_ regclass = (quote_ident(wal ->> 'schema') || '.' || quote_ident(wal ->> 'table'))::regclass;

-- I, U, D, T: insert, update ...
action realtime.action = (
    case wal ->> 'action'
        when 'I' then 'INSERT'
        when 'U' then 'UPDATE'
        when 'D' then 'DELETE'
        else 'ERROR'
    end
);

-- Is row level security enabled for the table
is_rls_enabled bool = relrowsecurity from pg_class where oid = entity_;

subscriptions realtime.subscription[] = array_agg(subs)
    from
        realtime.subscription subs
    where
        subs.entity = entity_;

-- Subscription vars
roles regrole[] = array_agg(distinct us.claims_role::text)
    from
        unnest(subscriptions) us;

working_role regrole;
claimed_role regrole;
claims jsonb;

subscription_id uuid;
subscription_has_access bool;
visible_to_subscription_ids uuid[] = '{}';

-- structured info for wal's columns
columns realtime.wal_column[];
-- previous identity values for update/delete
old_columns realtime.wal_column[];

error_record_exceeds_max_size boolean = octet_length(wal::text) > max_record_bytes;

-- Primary jsonb output for record
output jsonb;

begin
perform set_config('role', null, true);

columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'columns') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

old_columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'identity') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

for working_role in select * from unnest(roles) loop

    -- Update `is_selectable` for columns and old_columns
    columns =
        array_agg(
            (
                c.name,
                c.type_name,
                c.type_oid,
                c.value,
                c.is_pkey,
                pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
            )::realtime.wal_column
        )
        from
            unnest(columns) c;

    old_columns =
            array_agg(
                (
                    c.name,
                    c.type_name,
                    c.type_oid,
                    c.value,
                    c.is_pkey,
                    pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                )::realtime.wal_column
            )
            from
                unnest(old_columns) c;

    if action <> 'DELETE' and count(1) = 0 from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            -- subscriptions is already filtered by entity
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 400: Bad Request, no primary key']
        )::realtime.wal_rls;

    -- The claims role does not have SELECT permission to the primary key of entity
    elsif action <> 'DELETE' and sum(c.is_selectable::int) <> count(1) from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 401: Unauthorized']
        )::realtime.wal_rls;

    else
        output = jsonb_build_object(
            'schema', wal ->> 'schema',
            'table', wal ->> 'table',
            'type', action,
            'commit_timestamp', to_char(
                ((wal ->> 'timestamp')::timestamptz at time zone 'utc'),
                'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'
            ),
            'columns', (
                select
                    jsonb_agg(
                        jsonb_build_object(
                            'name', pa.attname,
                            'type', pt.typname
                        )
                        order by pa.attnum asc
                    )
                from
                    pg_attribute pa
                    join pg_type pt
                        on pa.atttypid = pt.oid
                where
                    attrelid = entity_
                    and attnum > 0
                    and pg_catalog.has_column_privilege(working_role, entity_, pa.attname, 'SELECT')
            )
        )
        -- Add "record" key for insert and update
        || case
            when action in ('INSERT', 'UPDATE') then
                jsonb_build_object(
                    'record',
                    (
                        select
                            jsonb_object_agg(
                                -- if unchanged toast, get column name and value from old record
                                coalesce((c).name, (oc).name),
                                case
                                    when (c).name is null then (oc).value
                                    else (c).value
                                end
                            )
                        from
                            unnest(columns) c
                            full outer join unnest(old_columns) oc
                                on (c).name = (oc).name
                        where
                            coalesce((c).is_selectable, (oc).is_selectable)
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                    )
                )
            else '{}'::jsonb
        end
        -- Add "old_record" key for update and delete
        || case
            when action = 'UPDATE' then
                jsonb_build_object(
                        'old_record',
                        (
                            select jsonb_object_agg((c).name, (c).value)
                            from unnest(old_columns) c
                            where
                                (c).is_selectable
                                and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                        )
                    )
            when action = 'DELETE' then
                jsonb_build_object(
                    'old_record',
                    (
                        select jsonb_object_agg((c).name, (c).value)
                        from unnest(old_columns) c
                        where
                            (c).is_selectable
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                            and ( not is_rls_enabled or (c).is_pkey ) -- if RLS enabled, we can't secure deletes so filter to pkey
                    )
                )
            else '{}'::jsonb
        end;

        -- Create the prepared statement
        if is_rls_enabled and action <> 'DELETE' then
            if (select 1 from pg_prepared_statements where name = 'walrus_rls_stmt' limit 1) > 0 then
                deallocate walrus_rls_stmt;
            end if;
            execute realtime.build_prepared_statement_sql('walrus_rls_stmt', entity_, columns);
        end if;

        visible_to_subscription_ids = '{}';

        for subscription_id, claims in (
                select
                    subs.subscription_id,
                    subs.claims
                from
                    unnest(subscriptions) subs
                where
                    subs.entity = entity_
                    and subs.claims_role = working_role
                    and (
                        realtime.is_visible_through_filters(columns, subs.filters)
                        or (
                          action = 'DELETE'
                          and realtime.is_visible_through_filters(old_columns, subs.filters)
                        )
                    )
        ) loop

            if not is_rls_enabled or action = 'DELETE' then
                visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
            else
                -- Check if RLS allows the role to see the record
                perform
                    -- Trim leading and trailing quotes from working_role because set_config
                    -- doesn't recognize the role as valid if they are included
                    set_config('role', trim(both '"' from working_role::text), true),
                    set_config('request.jwt.claims', claims::text, true);

                execute 'execute walrus_rls_stmt' into subscription_has_access;

                if subscription_has_access then
                    visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
                end if;
            end if;
        end loop;

        perform set_config('role', null, true);

        return next (
            output,
            is_rls_enabled,
            visible_to_subscription_ids,
            case
                when error_record_exceeds_max_size then array['Error 413: Payload Too Large']
                else '{}'
            end
        )::realtime.wal_rls;

    end if;
end loop;

perform set_config('role', null, true);
end;
$$;


ALTER FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: broadcast_changes(text, text, text, text, text, record, record, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text DEFAULT 'ROW'::text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    -- Declare a variable to hold the JSONB representation of the row
    row_data jsonb := '{}'::jsonb;
BEGIN
    IF level = 'STATEMENT' THEN
        RAISE EXCEPTION 'function can only be triggered for each row, not for each statement';
    END IF;
    -- Check the operation type and handle accordingly
    IF operation = 'INSERT' OR operation = 'UPDATE' OR operation = 'DELETE' THEN
        row_data := jsonb_build_object('old_record', OLD, 'record', NEW, 'operation', operation, 'table', table_name, 'schema', table_schema);
        PERFORM realtime.send (row_data, event_name, topic_name);
    ELSE
        RAISE EXCEPTION 'Unexpected operation type: %', operation;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Failed to process the row: %', SQLERRM;
END;

$$;


ALTER FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) OWNER TO supabase_admin;

--
-- Name: build_prepared_statement_sql(text, regclass, realtime.wal_column[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) RETURNS text
    LANGUAGE sql
    AS $$
      /*
      Builds a sql string that, if executed, creates a prepared statement to
      tests retrive a row from *entity* by its primary key columns.
      Example
          select realtime.build_prepared_statement_sql('public.notes', '{"id"}'::text[], '{"bigint"}'::text[])
      */
          select
      'prepare ' || prepared_statement_name || ' as
          select
              exists(
                  select
                      1
                  from
                      ' || entity || '
                  where
                      ' || string_agg(quote_ident(pkc.name) || '=' || quote_nullable(pkc.value #>> '{}') , ' and ') || '
              )'
          from
              unnest(columns) pkc
          where
              pkc.is_pkey
          group by
              entity
      $$;


ALTER FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) OWNER TO supabase_admin;

--
-- Name: cast(text, regtype); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime."cast"(val text, type_ regtype) RETURNS jsonb
    LANGUAGE plpgsql IMMUTABLE
    AS $$
    declare
      res jsonb;
    begin
      execute format('select to_jsonb(%L::'|| type_::text || ')', val)  into res;
      return res;
    end
    $$;


ALTER FUNCTION realtime."cast"(val text, type_ regtype) OWNER TO supabase_admin;

--
-- Name: check_equality_op(realtime.equality_op, regtype, text, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$
      /*
      Casts *val_1* and *val_2* as type *type_* and check the *op* condition for truthiness
      */
      declare
          op_symbol text = (
              case
                  when op = 'eq' then '='
                  when op = 'neq' then '!='
                  when op = 'lt' then '<'
                  when op = 'lte' then '<='
                  when op = 'gt' then '>'
                  when op = 'gte' then '>='
                  when op = 'in' then '= any'
                  else 'UNKNOWN OP'
              end
          );
          res boolean;
      begin
          execute format(
              'select %L::'|| type_::text || ' ' || op_symbol
              || ' ( %L::'
              || (
                  case
                      when op = 'in' then type_::text || '[]'
                      else type_::text end
              )
              || ')', val_1, val_2) into res;
          return res;
      end;
      $$;


ALTER FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) OWNER TO supabase_admin;

--
-- Name: is_visible_through_filters(realtime.wal_column[], realtime.user_defined_filter[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
    /*
    Should the record be visible (true) or filtered out (false) after *filters* are applied
    */
        select
            -- Default to allowed when no filters present
            $2 is null -- no filters. this should not happen because subscriptions has a default
            or array_length($2, 1) is null -- array length of an empty array is null
            or bool_and(
                coalesce(
                    realtime.check_equality_op(
                        op:=f.op,
                        type_:=coalesce(
                            col.type_oid::regtype, -- null when wal2json version <= 2.4
                            col.type_name::regtype
                        ),
                        -- cast jsonb to text
                        val_1:=col.value #>> '{}',
                        val_2:=f.value
                    ),
                    false -- if null, filter does not match
                )
            )
        from
            unnest(filters) f
            join unnest(columns) col
                on f.column_name = col.name;
    $_$;


ALTER FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) OWNER TO supabase_admin;

--
-- Name: list_changes(name, name, integer, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) RETURNS SETOF realtime.wal_rls
    LANGUAGE sql
    SET log_min_messages TO 'fatal'
    AS $$
      with pub as (
        select
          concat_ws(
            ',',
            case when bool_or(pubinsert) then 'insert' else null end,
            case when bool_or(pubupdate) then 'update' else null end,
            case when bool_or(pubdelete) then 'delete' else null end
          ) as w2j_actions,
          coalesce(
            string_agg(
              realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
              ','
            ) filter (where ppt.tablename is not null and ppt.tablename not like '% %'),
            ''
          ) w2j_add_tables
        from
          pg_publication pp
          left join pg_publication_tables ppt
            on pp.pubname = ppt.pubname
        where
          pp.pubname = publication
        group by
          pp.pubname
        limit 1
      ),
      w2j as (
        select
          x.*, pub.w2j_add_tables
        from
          pub,
          pg_logical_slot_get_changes(
            slot_name, null, max_changes,
            'include-pk', 'true',
            'include-transaction', 'false',
            'include-timestamp', 'true',
            'include-type-oids', 'true',
            'format-version', '2',
            'actions', pub.w2j_actions,
            'add-tables', pub.w2j_add_tables
          ) x
      )
      select
        xyz.wal,
        xyz.is_rls_enabled,
        xyz.subscription_ids,
        xyz.errors
      from
        w2j,
        realtime.apply_rls(
          wal := w2j.data::jsonb,
          max_record_bytes := max_record_bytes
        ) xyz(wal, is_rls_enabled, subscription_ids, errors)
      where
        w2j.w2j_add_tables <> ''
        and xyz.subscription_ids[1] is not null
    $$;


ALTER FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: quote_wal2json(regclass); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
      select
        (
          select string_agg('' || ch,'')
          from unnest(string_to_array(nsp.nspname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
        )
        || '.'
        || (
          select string_agg('' || ch,'')
          from unnest(string_to_array(pc.relname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
          )
      from
        pg_class pc
        join pg_namespace nsp
          on pc.relnamespace = nsp.oid
      where
        pc.oid = entity
    $$;


ALTER FUNCTION realtime.quote_wal2json(entity regclass) OWNER TO supabase_admin;

--
-- Name: send(jsonb, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  BEGIN
    -- Set the topic configuration
    EXECUTE format('SET LOCAL realtime.topic TO %L', topic);

    -- Attempt to insert the message
    INSERT INTO realtime.messages (payload, event, topic, private, extension)
    VALUES (payload, event, topic, private, 'broadcast');
  EXCEPTION
    WHEN OTHERS THEN
      -- Capture and notify the error
      PERFORM pg_notify(
          'realtime:system',
          jsonb_build_object(
              'error', SQLERRM,
              'function', 'realtime.send',
              'event', event,
              'topic', topic,
              'private', private
          )::text
      );
  END;
END;
$$;


ALTER FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) OWNER TO supabase_admin;

--
-- Name: subscription_check_filters(); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.subscription_check_filters() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    /*
    Validates that the user defined filters for a subscription:
    - refer to valid columns that the claimed role may access
    - values are coercable to the correct column type
    */
    declare
        col_names text[] = coalesce(
                array_agg(c.column_name order by c.ordinal_position),
                '{}'::text[]
            )
            from
                information_schema.columns c
            where
                format('%I.%I', c.table_schema, c.table_name)::regclass = new.entity
                and pg_catalog.has_column_privilege(
                    (new.claims ->> 'role'),
                    format('%I.%I', c.table_schema, c.table_name)::regclass,
                    c.column_name,
                    'SELECT'
                );
        filter realtime.user_defined_filter;
        col_type regtype;

        in_val jsonb;
    begin
        for filter in select * from unnest(new.filters) loop
            -- Filtered column is valid
            if not filter.column_name = any(col_names) then
                raise exception 'invalid column for filter %', filter.column_name;
            end if;

            -- Type is sanitized and safe for string interpolation
            col_type = (
                select atttypid::regtype
                from pg_catalog.pg_attribute
                where attrelid = new.entity
                      and attname = filter.column_name
            );
            if col_type is null then
                raise exception 'failed to lookup type for column %', filter.column_name;
            end if;

            -- Set maximum number of entries for in filter
            if filter.op = 'in'::realtime.equality_op then
                in_val = realtime.cast(filter.value, (col_type::text || '[]')::regtype);
                if coalesce(jsonb_array_length(in_val), 0) > 100 then
                    raise exception 'too many values for `in` filter. Maximum 100';
                end if;
            else
                -- raises an exception if value is not coercable to type
                perform realtime.cast(filter.value, col_type);
            end if;

        end loop;

        -- Apply consistent order to filters so the unique constraint on
        -- (subscription_id, entity, filters) can't be tricked by a different filter order
        new.filters = coalesce(
            array_agg(f order by f.column_name, f.op, f.value),
            '{}'
        ) from unnest(new.filters) f;

        return new;
    end;
    $$;


ALTER FUNCTION realtime.subscription_check_filters() OWNER TO supabase_admin;

--
-- Name: to_regrole(text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
    LANGUAGE sql IMMUTABLE
    AS $$ select role_name::regrole $$;


ALTER FUNCTION realtime.to_regrole(role_name text) OWNER TO supabase_admin;

--
-- Name: topic(); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.topic() RETURNS text
    LANGUAGE sql STABLE
    AS $$
select nullif(current_setting('realtime.topic', true), '')::text;
$$;


ALTER FUNCTION realtime.topic() OWNER TO supabase_realtime_admin;

--
-- Name: can_insert_object(text, text, uuid, jsonb); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;


ALTER FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) OWNER TO supabase_storage_admin;

--
-- Name: extension(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
_filename text;
BEGIN
	select string_to_array(name, '/') into _parts;
	select _parts[array_length(_parts,1)] into _filename;
	-- @todo return the last part instead of 2
	return reverse(split_part(reverse(_filename), '.', 1));
END
$$;


ALTER FUNCTION storage.extension(name text) OWNER TO supabase_storage_admin;

--
-- Name: filename(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[array_length(_parts,1)];
END
$$;


ALTER FUNCTION storage.filename(name text) OWNER TO supabase_storage_admin;

--
-- Name: foldername(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[1:array_length(_parts,1)-1];
END
$$;


ALTER FUNCTION storage.foldername(name text) OWNER TO supabase_storage_admin;

--
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::int) as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


ALTER FUNCTION storage.get_size_by_bucket() OWNER TO supabase_storage_admin;

--
-- Name: list_multipart_uploads_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, next_key_token text DEFAULT ''::text, next_upload_token text DEFAULT ''::text) RETURNS TABLE(key text, id text, created_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;
END;
$_$;


ALTER FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text) OWNER TO supabase_storage_admin;

--
-- Name: list_objects_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, start_after text DEFAULT ''::text, next_token text DEFAULT ''::text) RETURNS TABLE(name text, id uuid, metadata jsonb, updated_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(name COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                        substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1)))
                    ELSE
                        name
                END AS name, id, metadata, updated_at
            FROM
                storage.objects
            WHERE
                bucket_id = $5 AND
                name ILIKE $1 || ''%'' AND
                CASE
                    WHEN $6 != '''' THEN
                    name COLLATE "C" > $6
                ELSE true END
                AND CASE
                    WHEN $4 != '''' THEN
                        CASE
                            WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                                substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                name COLLATE "C" > $4
                            END
                    ELSE
                        true
                END
            ORDER BY
                name COLLATE "C" ASC) as e order by name COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_token, bucket_id, start_after;
END;
$_$;


ALTER FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text) OWNER TO supabase_storage_admin;

--
-- Name: operation(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.operation() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);
END;
$$;


ALTER FUNCTION storage.operation() OWNER TO supabase_storage_admin;

--
-- Name: search(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
  v_order_by text;
  v_sort_order text;
begin
  case
    when sortcolumn = 'name' then
      v_order_by = 'name';
    when sortcolumn = 'updated_at' then
      v_order_by = 'updated_at';
    when sortcolumn = 'created_at' then
      v_order_by = 'created_at';
    when sortcolumn = 'last_accessed_at' then
      v_order_by = 'last_accessed_at';
    else
      v_order_by = 'name';
  end case;

  case
    when sortorder = 'asc' then
      v_sort_order = 'asc';
    when sortorder = 'desc' then
      v_sort_order = 'desc';
    else
      v_sort_order = 'asc';
  end case;

  v_order_by = v_order_by || ' ' || v_sort_order;

  return query execute
    'with folders as (
       select path_tokens[$1] as folder
       from storage.objects
         where objects.name ilike $2 || $3 || ''%''
           and bucket_id = $4
           and array_length(objects.path_tokens, 1) <> $1
       group by folder
       order by folder ' || v_sort_order || '
     )
     (select folder as "name",
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[$1] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where objects.name ilike $2 || $3 || ''%''
       and bucket_id = $4
       and array_length(objects.path_tokens, 1) = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


ALTER FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;


ALTER FUNCTION storage.update_updated_at_column() OWNER TO supabase_storage_admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE auth.audit_log_entries OWNER TO supabase_auth_admin;

--
-- Name: TABLE audit_log_entries; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';


--
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.flow_state (
    id uuid NOT NULL,
    user_id uuid,
    auth_code text NOT NULL,
    code_challenge_method auth.code_challenge_method NOT NULL,
    code_challenge text NOT NULL,
    provider_type text NOT NULL,
    provider_access_token text,
    provider_refresh_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    authentication_method text NOT NULL,
    auth_code_issued_at timestamp with time zone
);


ALTER TABLE auth.flow_state OWNER TO supabase_auth_admin;

--
-- Name: TABLE flow_state; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.flow_state IS 'stores metadata for pkce logins';


--
-- Name: identities; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.identities (
    provider_id text NOT NULL,
    user_id uuid NOT NULL,
    identity_data jsonb NOT NULL,
    provider text NOT NULL,
    last_sign_in_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    email text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE auth.identities OWNER TO supabase_auth_admin;

--
-- Name: TABLE identities; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';


--
-- Name: COLUMN identities.email; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- Name: instances; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE auth.instances OWNER TO supabase_auth_admin;

--
-- Name: TABLE instances; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';


--
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);


ALTER TABLE auth.mfa_amr_claims OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_amr_claims; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_challenges (
    id uuid NOT NULL,
    factor_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    verified_at timestamp with time zone,
    ip_address inet NOT NULL,
    otp_code text,
    web_authn_session_data jsonb
);


ALTER TABLE auth.mfa_challenges OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_challenges; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';


--
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_factors (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    friendly_name text,
    factor_type auth.factor_type NOT NULL,
    status auth.factor_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    secret text,
    phone text,
    last_challenged_at timestamp with time zone,
    web_authn_credential jsonb,
    web_authn_aaguid uuid
);


ALTER TABLE auth.mfa_factors OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_factors; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';


--
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.one_time_tokens (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token_type auth.one_time_token_type NOT NULL,
    token_hash text NOT NULL,
    relates_to text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT one_time_tokens_token_hash_check CHECK ((char_length(token_hash) > 0))
);


ALTER TABLE auth.one_time_tokens OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.refresh_tokens (
    instance_id uuid,
    id bigint NOT NULL,
    token character varying(255),
    user_id character varying(255),
    revoked boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    parent character varying(255),
    session_id uuid
);


ALTER TABLE auth.refresh_tokens OWNER TO supabase_auth_admin;

--
-- Name: TABLE refresh_tokens; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: supabase_auth_admin
--

CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE auth.refresh_tokens_id_seq OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: supabase_auth_admin
--

ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;


--
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_providers (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    entity_id text NOT NULL,
    metadata_xml text NOT NULL,
    metadata_url text,
    attribute_mapping jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name_id_format text,
    CONSTRAINT "entity_id not empty" CHECK ((char_length(entity_id) > 0)),
    CONSTRAINT "metadata_url not empty" CHECK (((metadata_url = NULL::text) OR (char_length(metadata_url) > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK ((char_length(metadata_xml) > 0))
);


ALTER TABLE auth.saml_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';


--
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_relay_states (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    request_id text NOT NULL,
    for_email text,
    redirect_to text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    flow_state_id uuid,
    CONSTRAINT "request_id not empty" CHECK ((char_length(request_id) > 0))
);


ALTER TABLE auth.saml_relay_states OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_relay_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE auth.schema_migrations OWNER TO supabase_auth_admin;

--
-- Name: TABLE schema_migrations; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';


--
-- Name: sessions; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sessions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    factor_id uuid,
    aal auth.aal_level,
    not_after timestamp with time zone,
    refreshed_at timestamp without time zone,
    user_agent text,
    ip inet,
    tag text
);


ALTER TABLE auth.sessions OWNER TO supabase_auth_admin;

--
-- Name: TABLE sessions; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';


--
-- Name: COLUMN sessions.not_after; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);


ALTER TABLE auth.sso_domains OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_domains; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);


ALTER TABLE auth.sso_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- Name: COLUMN sso_providers.resource_id; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- Name: users; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_anonymous boolean DEFAULT false NOT NULL,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);


ALTER TABLE auth.users OWNER TO supabase_auth_admin;

--
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';


--
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- Name: __EFMigrationsHistory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."__EFMigrationsHistory" (
    "MigrationId" character varying(150) NOT NULL,
    "ProductVersion" character varying(32) NOT NULL
);


ALTER TABLE public."__EFMigrationsHistory" OWNER TO postgres;

--
-- Name: alerts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alerts (
    id integer NOT NULL,
    description text NOT NULL,
    "timestamp" timestamp with time zone NOT NULL
);


ALTER TABLE public.alerts OWNER TO postgres;

--
-- Name: alerts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.alerts ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.alerts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_tokens (
    id integer NOT NULL,
    user_id integer NOT NULL,
    token text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    expires_at timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_tokens OWNER TO postgres;

--
-- Name: authtokens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_tokens ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.authtokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: event_logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_logs (
    id integer NOT NULL,
    type text NOT NULL,
    message text NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    source text NOT NULL
);


ALTER TABLE public.event_logs OWNER TO postgres;

--
-- Name: eventlogs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.event_logs ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.eventlogs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: execute_logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.execute_logs (
    id integer NOT NULL,
    log jsonb NOT NULL,
    atualizado_em timestamp with time zone NOT NULL
);


ALTER TABLE public.execute_logs OWNER TO postgres;

--
-- Name: execute_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.execute_logs ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.execute_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: inputs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inputs (
    id integer NOT NULL,
    name character varying NOT NULL,
    content jsonb NOT NULL,
    is_used boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.inputs OWNER TO postgres;

--
-- Name: inputs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.inputs ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.inputs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: locations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.locations (
    id integer NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    latitude double precision NOT NULL,
    longitude double precision NOT NULL,
    task_id integer
);


ALTER TABLE public.locations OWNER TO postgres;

--
-- Name: locations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.locations ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.locations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: maintenance_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.maintenance_types (
    id integer NOT NULL,
    type text NOT NULL,
    description text NOT NULL
);


ALTER TABLE public.maintenance_types OWNER TO postgres;

--
-- Name: maintenances; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.maintenances (
    id integer NOT NULL,
    moto_id integer NOT NULL,
    type_id integer NOT NULL,
    date timestamp with time zone NOT NULL
);


ALTER TABLE public.maintenances OWNER TO postgres;

--
-- Name: maintenances_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.maintenances ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.maintenances_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: maintenancetypes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.maintenance_types ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.maintenancetypes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: motorcycle_alerts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.motorcycle_alerts (
    moto_id integer NOT NULL,
    alert_id integer NOT NULL,
    "AlertId1" integer
);


ALTER TABLE public.motorcycle_alerts OWNER TO postgres;

--
-- Name: motorcycles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.motorcycles (
    id integer NOT NULL,
    brand text NOT NULL,
    model text NOT NULL,
    battery_status integer DEFAULT 0 NOT NULL,
    km double precision,
    status text NOT NULL,
    battery_capacity double precision DEFAULT 0.0 NOT NULL,
    battery_degradation double precision DEFAULT 0.0 NOT NULL
);


ALTER TABLE public.motorcycles OWNER TO postgres;

--
-- Name: motorcycles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.motorcycles ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.motorcycles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notifications (
    id integer NOT NULL,
    user_id integer NOT NULL,
    message text NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    is_read boolean NOT NULL
);


ALTER TABLE public.notifications OWNER TO postgres;

--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.notifications ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: performance_report; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.performance_report (
    id integer NOT NULL,
    description text NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    moto_id integer NOT NULL
);


ALTER TABLE public.performance_report OWNER TO postgres;

--
-- Name: performance_report_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.performance_report ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.performance_report_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: results; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.results (
    id integer NOT NULL,
    file_output text NOT NULL,
    algorithm_name text NOT NULL,
    route jsonb NOT NULL,
    cost double precision NOT NULL,
    input_id integer DEFAULT 0 NOT NULL,
    estimated_energy double precision
);


ALTER TABLE public.results OWNER TO postgres;

--
-- Name: results_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.results ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.results_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: route_points; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.route_points (
    id integer NOT NULL,
    route_id integer NOT NULL,
    latitude double precision NOT NULL,
    longitude double precision NOT NULL,
    stop_order integer NOT NULL
);


ALTER TABLE public.route_points OWNER TO postgres;

--
-- Name: routepoints_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.route_points ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.routepoints_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: routes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.routes (
    id integer NOT NULL,
    task_id integer NOT NULL,
    distance_km double precision,
    estimated_delivery_time interval
);


ALTER TABLE public.routes OWNER TO postgres;

--
-- Name: routes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.routes ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.routes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: services; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.services (
    id integer NOT NULL,
    type text NOT NULL,
    date timestamp with time zone NOT NULL,
    description text NOT NULL,
    status text NOT NULL,
    user_id integer NOT NULL,
    moto_id integer NOT NULL
);


ALTER TABLE public.services OWNER TO postgres;

--
-- Name: services_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.services ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.services_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: task_histories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.task_histories (
    id integer NOT NULL,
    task_id integer NOT NULL,
    status text NOT NULL,
    "timestamp" timestamp with time zone NOT NULL
);


ALTER TABLE public.task_histories OWNER TO postgres;

--
-- Name: taskhistories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.task_histories ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.taskhistories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: tasks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tasks (
    id integer NOT NULL,
    type text NOT NULL,
    creation_date timestamp with time zone NOT NULL,
    deadline timestamp with time zone,
    description text NOT NULL,
    status text NOT NULL,
    user_id integer NOT NULL,
    service_id integer,
    "UserId1" integer
);


ALTER TABLE public.tasks OWNER TO postgres;

--
-- Name: tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.tasks ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: user_alerts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_alerts (
    user_id integer NOT NULL,
    alert_id integer NOT NULL
);


ALTER TABLE public.user_alerts OWNER TO postgres;

--
-- Name: user_motorcycle; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_motorcycle (
    moto_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.user_motorcycle OWNER TO postgres;

--
-- Name: user_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_types (
    id integer NOT NULL,
    type character varying(50) NOT NULL
);


ALTER TABLE public.user_types OWNER TO postgres;

--
-- Name: user_types_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.user_types ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.user_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    password text NOT NULL,
    type_id integer
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.users ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: messages; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.messages (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
)
PARTITION BY RANGE (inserted_at);


ALTER TABLE realtime.messages OWNER TO supabase_realtime_admin;

--
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE realtime.schema_migrations OWNER TO supabase_admin;

--
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.subscription (
    id bigint NOT NULL,
    subscription_id uuid NOT NULL,
    entity regclass NOT NULL,
    filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
    claims jsonb NOT NULL,
    claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


ALTER TABLE realtime.subscription OWNER TO supabase_admin;

--
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME realtime.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: buckets; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text
);


ALTER TABLE storage.buckets OWNER TO supabase_storage_admin;

--
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: migrations; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE storage.migrations OWNER TO supabase_storage_admin;

--
-- Name: objects; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text,
    owner_id text,
    user_metadata jsonb
);


ALTER TABLE storage.objects OWNER TO supabase_storage_admin;

--
-- Name: COLUMN objects.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads (
    id text NOT NULL,
    in_progress_size bigint DEFAULT 0 NOT NULL,
    upload_signature text NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    version text NOT NULL,
    owner_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_metadata jsonb
);


ALTER TABLE storage.s3_multipart_uploads OWNER TO supabase_storage_admin;

--
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads_parts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    upload_id text NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    part_number integer NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    etag text NOT NULL,
    owner_id text,
    version text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.s3_multipart_uploads_parts OWNER TO supabase_storage_admin;

--
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);


--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) FROM stdin;
\.


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.flow_state (id, user_id, auth_code, code_challenge_method, code_challenge, provider_type, provider_access_token, provider_refresh_token, created_at, updated_at, authentication_method, auth_code_issued_at) FROM stdin;
\.


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) FROM stdin;
\.


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.instances (id, uuid, raw_base_config, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) FROM stdin;
\.


--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_challenges (id, factor_id, created_at, verified_at, ip_address, otp_code, web_authn_session_data) FROM stdin;
\.


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_factors (id, user_id, friendly_name, factor_type, status, created_at, updated_at, secret, phone, last_challenged_at, web_authn_credential, web_authn_aaguid) FROM stdin;
\.


--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.one_time_tokens (id, user_id, token_type, token_hash, relates_to, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) FROM stdin;
\.


--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_providers (id, sso_provider_id, entity_id, metadata_xml, metadata_url, attribute_mapping, created_at, updated_at, name_id_format) FROM stdin;
\.


--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_relay_states (id, sso_provider_id, request_id, for_email, redirect_to, created_at, updated_at, flow_state_id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.schema_migrations (version) FROM stdin;
20171026211738
20171026211808
20171026211834
20180103212743
20180108183307
20180119214651
20180125194653
00
20210710035447
20210722035447
20210730183235
20210909172000
20210927181326
20211122151130
20211124214934
20211202183645
20220114185221
20220114185340
20220224000811
20220323170000
20220429102000
20220531120530
20220614074223
20220811173540
20221003041349
20221003041400
20221011041400
20221020193600
20221021073300
20221021082433
20221027105023
20221114143122
20221114143410
20221125140132
20221208132122
20221215195500
20221215195800
20221215195900
20230116124310
20230116124412
20230131181311
20230322519590
20230402418590
20230411005111
20230508135423
20230523124323
20230818113222
20230914180801
20231027141322
20231114161723
20231117164230
20240115144230
20240214120130
20240306115329
20240314092811
20240427152123
20240612123726
20240729123726
20240802193726
20240806073726
20241009103726
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag) FROM stdin;
\.


--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_domains (id, sso_provider_id, domain, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_providers (id, resource_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) FROM stdin;
\.


--
-- Data for Name: __EFMigrationsHistory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."__EFMigrationsHistory" ("MigrationId", "ProductVersion") FROM stdin;
20250430160549_InitialCreate	9.0.4
20250505172134_AddExtraIndexes	9.0.4
20250505201742_Taskupdate	9.0.4
20250506160531_BatteryStatus	9.0.4
20250507104654_FixBatteryStatusColumnName	9.0.4
20250507105746_battery_status	9.0.4
20250507111512_user_moto	9.0.4
20250507113615_MaintenancetypeFix	9.0.4
20250507115822_MaintenancesFix	9.0.4
20250507121505_UserAlertsFix	9.0.4
20250507133833_PartialTables	9.0.4
20250507141243_AllFix	9.0.4
20250507143626_Fix_MotorcycleAlert_Keys	9.0.4
20250507144300_Fix_MotorcycleAlert	9.0.4
20250507144656_FixMotorcycleAlertRelation	9.0.4
20250521134044_UpdateMotorcycle	9.0.4
20250524233843_resultes	9.0.4
20250525003624_executelogs	9.0.4
20250603225858_inputesandresultesupdate	9.0.4
20250603231331_nameupdateInput	9.0.4
20250610161728_estimated_energy	9.0.4
\.


--
-- Data for Name: alerts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alerts (id, description, "timestamp") FROM stdin;
1	Necessária revisão urgente	2025-06-10 20:01:00.818807+00
2	Nível baixo de bateria detetado	2025-06-10 20:01:00.818807+00
\.


--
-- Data for Name: auth_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_tokens (id, user_id, token, created_at, expires_at) FROM stdin;
1	1	token123	2025-06-10 20:03:48.330989+00	2025-06-17 20:03:48.330989+00
2	2	token456	2025-06-10 20:03:48.330989+00	2025-06-17 20:03:48.330989+00
\.


--
-- Data for Name: event_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.event_logs (id, type, message, "timestamp", source) FROM stdin;
1	INFO	Serviço iniciado com sucesso.	2025-06-10 20:03:52.625019+00	Sistema
2	ERRO	Falha na ligação à API externa.	2025-06-10 20:03:52.625019+00	API Externa
\.


--
-- Data for Name: execute_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.execute_logs (id, log, atualizado_em) FROM stdin;
1	[{"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Caminho encontrado: [0]\\nDistância total: 0.01 km\\nEnergia estimada: 0.111111111 kWh", "algoritmo": "dijkstra.py", "timestamp": "2025-06-05 01:20:07.786", "input_file": "input_20250605_012007_533116_61a42f.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota ótima: [0, 1, 2, 10, 0]\\nDistância total: 0.05 km", "algoritmo": "branch_and_bound.py", "timestamp": "2025-06-05 01:20:07.849", "input_file": "input_20250605_012007_533116_61a42f.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Caminho encontrado: [0, 1, 0]\\nDistância total: 0.03 km", "algoritmo": "savings.py", "timestamp": "2025-06-05 01:20:07.916", "input_file": "input_20250605_012007_533116_61a42f.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota: [0, 10, 2, 1, 0]\\nDistância: 0.05 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "nearest_neighbor.py", "timestamp": "2025-06-05 01:20:07.987", "input_file": "input_20250605_012007_533116_61a42f.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Roteamento: [[0, 1, 2, 10, 0]]\\nDistância total: 0.05 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "tabu_search.py", "timestamp": "2025-06-05 01:20:08.047", "input_file": "input_20250605_012007_533116_61a42f.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota encontrada: [0, 10, 2, 1, 0]\\nCusto total: 0.05 km", "algoritmo": "grasp.py", "timestamp": "2025-06-05 01:20:08.124", "input_file": "input_20250605_012007_533116_61a42f.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Caminho encontrado: [0]\\nDistância total: 0.01 km\\nEnergia estimada: 0.0 kWh", "algoritmo": "dijkstra.py", "timestamp": "2025-06-05 01:24:17.078", "input_file": "input_20250605_012416_168291_8dd32c.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota ótima: [0, 1, 2, 10, 0]\\nDistância total: 0.05 km", "algoritmo": "branch_and_bound.py", "timestamp": "2025-06-05 01:24:17.135", "input_file": "input_20250605_012416_168291_8dd32c.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Caminho encontrado: [0, 1, 0]\\nDistância total: 0.03 km", "algoritmo": "savings.py", "timestamp": "2025-06-05 01:24:17.205", "input_file": "input_20250605_012416_168291_8dd32c.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota: [0, 10, 2, 1, 0]\\nDistância: 0.05 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "nearest_neighbor.py", "timestamp": "2025-06-05 01:24:17.288", "input_file": "input_20250605_012416_168291_8dd32c.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Roteamento: [[0, 1, 2, 10, 0]]\\nDistância total: 0.05 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "tabu_search.py", "timestamp": "2025-06-05 01:24:17.361", "input_file": "input_20250605_012416_168291_8dd32c.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota encontrada: [0, 10, 2, 1, 0]\\nCusto total: 0.05 km", "algoritmo": "grasp.py", "timestamp": "2025-06-05 01:24:17.444", "input_file": "input_20250605_012416_168291_8dd32c.json"}, {"input": {"nodes": [{"x": -8.63062, "y": 41.159744999999994, "id": 0, "is_depot": true}, {"x": -8.620659999999999, "y": 41.170639, "id": 1, "demand": 200, "time_window": [28800, 39600]}, {"x": -8.64004, "y": 41.149558, "id": 2}, {"x": -8.635465, "y": 41.154031, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 542, "end_node": 0, "start_node": 0, "battery_kwh": 70}]}, "output": "Caminho encontrado: [0]\\nDistância total: 0.01 km\\nEnergia estimada: 0.0 kWh", "algoritmo": "dijkstra.py", "timestamp": "2025-06-05 01:24:17.545", "input_file": "input_20250605_012416_222465_22fd0a.json"}, {"input": {"nodes": [{"x": -8.63062, "y": 41.159744999999994, "id": 0, "is_depot": true}, {"x": -8.620659999999999, "y": 41.170639, "id": 1, "demand": 200, "time_window": [28800, 39600]}, {"x": -8.64004, "y": 41.149558, "id": 2}, {"x": -8.635465, "y": 41.154031, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 542, "end_node": 0, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota ótima: [0, 1, 10, 2, 0]\\nDistância total: 0.06 km", "algoritmo": "branch_and_bound.py", "timestamp": "2025-06-05 01:24:17.609", "input_file": "input_20250605_012416_222465_22fd0a.json"}, {"input": {"nodes": [{"x": -8.63062, "y": 41.159744999999994, "id": 0, "is_depot": true}, {"x": -8.620659999999999, "y": 41.170639, "id": 1, "demand": 200, "time_window": [28800, 39600]}, {"x": -8.64004, "y": 41.149558, "id": 2}, {"x": -8.635465, "y": 41.154031, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 542, "end_node": 0, "start_node": 0, "battery_kwh": 70}]}, "output": "Caminho encontrado: [0, 1, 0]\\nDistância total: 0.03 km", "algoritmo": "savings.py", "timestamp": "2025-06-05 01:24:17.687", "input_file": "input_20250605_012416_222465_22fd0a.json"}, {"input": {"nodes": [{"x": -8.63062, "y": 41.159744999999994, "id": 0, "is_depot": true}, {"x": -8.620659999999999, "y": 41.170639, "id": 1, "demand": 200, "time_window": [28800, 39600]}, {"x": -8.64004, "y": 41.149558, "id": 2}, {"x": -8.635465, "y": 41.154031, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 542, "end_node": 0, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota: [0, 10, 2, 1, 0]\\nDistância: 0.06 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "nearest_neighbor.py", "timestamp": "2025-06-05 01:24:17.758", "input_file": "input_20250605_012416_222465_22fd0a.json"}, {"input": {"nodes": [{"x": -8.63062, "y": 41.159744999999994, "id": 0, "is_depot": true}, {"x": -8.620659999999999, "y": 41.170639, "id": 1, "demand": 200, "time_window": [28800, 39600]}, {"x": -8.64004, "y": 41.149558, "id": 2}, {"x": -8.635465, "y": 41.154031, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 542, "end_node": 0, "start_node": 0, "battery_kwh": 70}]}, "output": "Roteamento: [[0, 1, 10, 2, 0]]\\nDistância total: 0.06 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "tabu_search.py", "timestamp": "2025-06-05 01:24:17.819", "input_file": "input_20250605_012416_222465_22fd0a.json"}, {"input": {"nodes": [{"x": -8.63062, "y": 41.159744999999994, "id": 0, "is_depot": true}, {"x": -8.620659999999999, "y": 41.170639, "id": 1, "demand": 200, "time_window": [28800, 39600]}, {"x": -8.64004, "y": 41.149558, "id": 2}, {"x": -8.635465, "y": 41.154031, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 542, "end_node": 0, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota encontrada: [0, 10, 2, 1, 0]\\nCusto total: 0.06 km", "algoritmo": "grasp.py", "timestamp": "2025-06-05 01:24:17.896", "input_file": "input_20250605_012416_222465_22fd0a.json"}, {"input": {"nodes": [{"x": -8.629290000000001, "y": 41.159439, "id": 0, "is_depot": true}, {"x": -8.62093, "y": 41.169368, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639674000000001, "y": 41.14991, "id": 2, "demand": 150, "service_time": 300}, {"x": -8.635093, "y": 41.154154, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 482, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Caminho encontrado: [0]\\nDistância total: 0.01 km\\nEnergia estimada: 0.0 kWh", "algoritmo": "dijkstra.py", "timestamp": "2025-06-05 01:24:17.995", "input_file": "input_20250605_012416_277937_6129a6.json"}, {"input": {"nodes": [{"x": -8.629290000000001, "y": 41.159439, "id": 0, "is_depot": true}, {"x": -8.62093, "y": 41.169368, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639674000000001, "y": 41.14991, "id": 2, "demand": 150, "service_time": 300}, {"x": -8.635093, "y": 41.154154, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 482, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Rota ótima: [0, 1, 2, 10, 0]\\nDistância total: 0.05 km", "algoritmo": "branch_and_bound.py", "timestamp": "2025-06-05 01:24:18.052", "input_file": "input_20250605_012416_277937_6129a6.json"}, {"input": {"nodes": [{"x": -8.629290000000001, "y": 41.159439, "id": 0, "is_depot": true}, {"x": -8.62093, "y": 41.169368, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639674000000001, "y": 41.14991, "id": 2, "demand": 150, "service_time": 300}, {"x": -8.635093, "y": 41.154154, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 482, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Caminho encontrado: [0, 1, 2, 0]\\nDistância total: 0.05 km", "algoritmo": "savings.py", "timestamp": "2025-06-05 01:24:18.118", "input_file": "input_20250605_012416_277937_6129a6.json"}, {"input": {"nodes": [{"x": -8.629290000000001, "y": 41.159439, "id": 0, "is_depot": true}, {"x": -8.62093, "y": 41.169368, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639674000000001, "y": 41.14991, "id": 2, "demand": 150, "service_time": 300}, {"x": -8.635093, "y": 41.154154, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 482, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Rota: [0, 10, 2, 1, 0]\\nDistância: 0.05 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "nearest_neighbor.py", "timestamp": "2025-06-05 01:24:18.198", "input_file": "input_20250605_012416_277937_6129a6.json"}, {"input": {"nodes": [{"x": -8.629290000000001, "y": 41.159439, "id": 0, "is_depot": true}, {"x": -8.62093, "y": 41.169368, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639674000000001, "y": 41.14991, "id": 2, "demand": 150, "service_time": 300}, {"x": -8.635093, "y": 41.154154, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "config": {"time_limit": 60, "tabu_tenure": 15}, "vehicles": [{"id": 1, "capacity": 482, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Roteamento: [[0, 1, 2, 10, 0]]\\nDistância total: 0.05 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "tabu_search.py", "timestamp": "2025-06-05 01:24:18.275", "input_file": "input_20250605_012416_277937_6129a6.json"}, {"input": {"nodes": [{"x": -8.629290000000001, "y": 41.159439, "id": 0, "is_depot": true}, {"x": -8.62093, "y": 41.169368, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639674000000001, "y": 41.14991, "id": 2, "demand": 150, "service_time": 300}, {"x": -8.635093, "y": 41.154154, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "config": {"time_limit": 60, "tabu_tenure": 15}, "vehicles": [{"id": 1, "capacity": 482, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Rota encontrada: [0, 10, 2, 1, 0]\\nCusto total: 0.05 km", "algoritmo": "grasp.py", "timestamp": "2025-06-05 01:24:18.353", "input_file": "input_20250605_012416_277937_6129a6.json"}, {"input": {"nodes": [{"x": -8.629090000000001, "y": 41.159751, "id": 0, "is_depot": true}, {"x": -8.619287, "y": 41.170083, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.640284000000001, "y": 41.149693, "id": 2, "demand": 150}, {"x": -8.635999, "y": 41.155701, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 513, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Caminho encontrado: [0]\\nDistância total: 0.01 km\\nEnergia estimada: 0.0 kWh", "algoritmo": "dijkstra.py", "timestamp": "2025-06-05 01:24:18.450", "input_file": "input_20250605_012416_332944_1f1aa8.json"}, {"input": {"nodes": [{"x": -8.629090000000001, "y": 41.159751, "id": 0, "is_depot": true}, {"x": -8.619287, "y": 41.170083, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.640284000000001, "y": 41.149693, "id": 2, "demand": 150}, {"x": -8.635999, "y": 41.155701, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 513, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota ótima: [0, 1, 10, 2, 0]\\nDistância total: 0.06 km", "algoritmo": "branch_and_bound.py", "timestamp": "2025-06-05 01:24:18.509", "input_file": "input_20250605_012416_332944_1f1aa8.json"}, {"input": {"nodes": [{"x": -8.629090000000001, "y": 41.159751, "id": 0, "is_depot": true}, {"x": -8.619287, "y": 41.170083, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.640284000000001, "y": 41.149693, "id": 2, "demand": 150}, {"x": -8.635999, "y": 41.155701, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 513, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Caminho encontrado: [0, 1, 2, 0]\\nDistância total: 0.06 km", "algoritmo": "savings.py", "timestamp": "2025-06-05 01:24:18.577", "input_file": "input_20250605_012416_332944_1f1aa8.json"}, {"input": {"nodes": [{"x": -8.629090000000001, "y": 41.159751, "id": 0, "is_depot": true}, {"x": -8.619287, "y": 41.170083, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.640284000000001, "y": 41.149693, "id": 2, "demand": 150}, {"x": -8.635999, "y": 41.155701, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 513, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota: [0, 10, 2, 1, 0]\\nDistância: 0.06 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "nearest_neighbor.py", "timestamp": "2025-06-05 01:24:18.647", "input_file": "input_20250605_012416_332944_1f1aa8.json"}, {"input": {"nodes": [{"x": -8.629090000000001, "y": 41.159751, "id": 0, "is_depot": true}, {"x": -8.619287, "y": 41.170083, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.640284000000001, "y": 41.149693, "id": 2, "demand": 150}, {"x": -8.635999, "y": 41.155701, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 513, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Roteamento: [[0, 1, 10, 2, 0]]\\nDistância total: 0.06 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "tabu_search.py", "timestamp": "2025-06-05 01:24:18.710", "input_file": "input_20250605_012416_332944_1f1aa8.json"}, {"input": {"nodes": [{"x": -8.629090000000001, "y": 41.159751, "id": 0, "is_depot": true}, {"x": -8.619287, "y": 41.170083, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.640284000000001, "y": 41.149693, "id": 2, "demand": 150}, {"x": -8.635999, "y": 41.155701, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 513, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota encontrada: [0, 10, 2, 1, 0]\\nCusto total: 0.06 km", "algoritmo": "grasp.py", "timestamp": "2025-06-05 01:24:18.791", "input_file": "input_20250605_012416_332944_1f1aa8.json"}, {"input": {"nodes": [{"x": -8.629134, "y": 41.160951999999995, "id": 0, "is_depot": true}, {"x": -8.620451, "y": 41.170649000000004, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.639610000000001, "y": 41.149675, "id": 2, "demand": 150}, {"x": -8.63503, "y": 41.154454, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 529, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Caminho encontrado: [0]\\nDistância total: 0.01 km\\nEnergia estimada: 0.0 kWh", "algoritmo": "dijkstra.py", "timestamp": "2025-06-05 01:24:18.885", "input_file": "input_20250605_012416_386179_beee5e.json"}, {"input": {"nodes": [{"x": -8.629134, "y": 41.160951999999995, "id": 0, "is_depot": true}, {"x": -8.620451, "y": 41.170649000000004, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.639610000000001, "y": 41.149675, "id": 2, "demand": 150}, {"x": -8.63503, "y": 41.154454, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 529, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota ótima: [0, 1, 2, 10, 0]\\nDistância total: 0.06 km", "algoritmo": "branch_and_bound.py", "timestamp": "2025-06-05 01:24:18.941", "input_file": "input_20250605_012416_386179_beee5e.json"}, {"input": {"nodes": [{"x": -8.629134, "y": 41.160951999999995, "id": 0, "is_depot": true}, {"x": -8.620451, "y": 41.170649000000004, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.639610000000001, "y": 41.149675, "id": 2, "demand": 150}, {"x": -8.63503, "y": 41.154454, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 529, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Caminho encontrado: [0, 1, 2, 0]\\nDistância total: 0.06 km", "algoritmo": "savings.py", "timestamp": "2025-06-05 01:24:19.004", "input_file": "input_20250605_012416_386179_beee5e.json"}, {"input": {"nodes": [{"x": -8.629134, "y": 41.160951999999995, "id": 0, "is_depot": true}, {"x": -8.620451, "y": 41.170649000000004, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.639610000000001, "y": 41.149675, "id": 2, "demand": 150}, {"x": -8.63503, "y": 41.154454, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 529, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota: [0, 10, 2, 1, 0]\\nDistância: 0.06 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "nearest_neighbor.py", "timestamp": "2025-06-05 01:24:19.085", "input_file": "input_20250605_012416_386179_beee5e.json"}, {"input": {"nodes": [{"x": -8.629134, "y": 41.160951999999995, "id": 0, "is_depot": true}, {"x": -8.620451, "y": 41.170649000000004, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.639610000000001, "y": 41.149675, "id": 2, "demand": 150}, {"x": -8.63503, "y": 41.154454, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 529, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Roteamento: [[0, 1, 2, 10, 0]]\\nDistância total: 0.06 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "tabu_search.py", "timestamp": "2025-06-05 01:24:19.149", "input_file": "input_20250605_012416_386179_beee5e.json"}, {"input": {"nodes": [{"x": -8.629134, "y": 41.160951999999995, "id": 0, "is_depot": true}, {"x": -8.620451, "y": 41.170649000000004, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.639610000000001, "y": 41.149675, "id": 2, "demand": 150}, {"x": -8.63503, "y": 41.154454, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 529, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota encontrada: [0, 10, 2, 1, 0]\\nCusto total: 0.06 km", "algoritmo": "grasp.py", "timestamp": "2025-06-05 01:24:19.230", "input_file": "input_20250605_012416_386179_beee5e.json"}, {"input": {"nodes": [{"x": -8.630600000000001, "y": 41.16018699999999, "id": 0, "is_depot": true}, {"x": -8.620757, "y": 41.170898, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.639717000000001, "y": 41.149474999999995, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635965, "y": 41.155971, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 465, "end_node": 0, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Caminho encontrado: [0]\\nDistância total: 0.01 km\\nEnergia estimada: 0.0 kWh", "algoritmo": "dijkstra.py", "timestamp": "2025-06-05 01:24:19.331", "input_file": "input_20250605_012416_440992_d39a8c.json"}, {"input": {"nodes": [{"x": -8.630600000000001, "y": 41.16018699999999, "id": 0, "is_depot": true}, {"x": -8.620757, "y": 41.170898, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.639717000000001, "y": 41.149474999999995, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635965, "y": 41.155971, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 465, "end_node": 0, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Rota ótima: [0, 1, 10, 2, 0]\\nDistância total: 0.06 km", "algoritmo": "branch_and_bound.py", "timestamp": "2025-06-05 01:24:19.387", "input_file": "input_20250605_012416_440992_d39a8c.json"}, {"input": {"nodes": [{"x": -8.630600000000001, "y": 41.16018699999999, "id": 0, "is_depot": true}, {"x": -8.620757, "y": 41.170898, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.639717000000001, "y": 41.149474999999995, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635965, "y": 41.155971, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 465, "end_node": 0, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Caminho encontrado: [0, 1, 2, 0]\\nDistância total: 0.06 km", "algoritmo": "savings.py", "timestamp": "2025-06-05 01:24:19.453", "input_file": "input_20250605_012416_440992_d39a8c.json"}, {"input": {"nodes": [{"x": -8.630600000000001, "y": 41.16018699999999, "id": 0, "is_depot": true}, {"x": -8.620757, "y": 41.170898, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.639717000000001, "y": 41.149474999999995, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635965, "y": 41.155971, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 465, "end_node": 0, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Rota: [0, 10, 2, 1, 0]\\nDistância: 0.06 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "nearest_neighbor.py", "timestamp": "2025-06-05 01:24:19.524", "input_file": "input_20250605_012416_440992_d39a8c.json"}, {"input": {"nodes": [{"x": -8.630600000000001, "y": 41.16018699999999, "id": 0, "is_depot": true}, {"x": -8.620757, "y": 41.170898, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.639717000000001, "y": 41.149474999999995, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635965, "y": 41.155971, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "config": {"time_limit": 60, "tabu_tenure": 15}, "vehicles": [{"id": 1, "capacity": 465, "end_node": 0, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Roteamento: [[0, 1, 10, 2, 0]]\\nDistância total: 0.06 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "tabu_search.py", "timestamp": "2025-06-05 01:24:19.595", "input_file": "input_20250605_012416_440992_d39a8c.json"}, {"input": {"nodes": [{"x": -8.630600000000001, "y": 41.16018699999999, "id": 0, "is_depot": true}, {"x": -8.620757, "y": 41.170898, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.639717000000001, "y": 41.149474999999995, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635965, "y": 41.155971, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "config": {"time_limit": 60, "tabu_tenure": 15}, "vehicles": [{"id": 1, "capacity": 465, "end_node": 0, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Rota encontrada: [0, 10, 2, 1, 0]\\nCusto total: 0.06 km", "algoritmo": "grasp.py", "timestamp": "2025-06-05 01:24:19.669", "input_file": "input_20250605_012416_440992_d39a8c.json"}, {"input": {"nodes": [{"x": -8.630618, "y": 41.160377, "id": 0, "is_depot": true}, {"x": -8.619323, "y": 41.169292, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.640521000000001, "y": 41.150453, "id": 2, "demand": 150}, {"x": -8.63557, "y": 41.15417, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 542, "end_node": 0, "start_node": 0}]}, "output": "", "algoritmo": "dijkstra.py", "timestamp": "2025-06-05 01:24:19.777", "input_file": "input_20250605_012416_497003_e3cd13.json"}, {"input": {"nodes": [{"x": -8.630618, "y": 41.160377, "id": 0, "is_depot": true}, {"x": -8.619323, "y": 41.169292, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.640521000000001, "y": 41.150453, "id": 2, "demand": 150}, {"x": -8.63557, "y": 41.15417, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 542, "end_node": 0, "start_node": 0}]}, "output": "Rota ótima: [0, 1, 10, 2, 0]\\nDistância total: 0.06 km", "algoritmo": "branch_and_bound.py", "timestamp": "2025-06-05 01:24:19.835", "input_file": "input_20250605_012416_497003_e3cd13.json"}, {"input": {"nodes": [{"x": -8.630618, "y": 41.160377, "id": 0, "is_depot": true}, {"x": -8.619323, "y": 41.169292, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.640521000000001, "y": 41.150453, "id": 2, "demand": 150}, {"x": -8.63557, "y": 41.15417, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 542, "end_node": 0, "start_node": 0}]}, "output": "", "algoritmo": "savings.py", "timestamp": "2025-06-05 01:24:19.917", "input_file": "input_20250605_012416_497003_e3cd13.json"}, {"input": {"nodes": [{"x": -8.630618, "y": 41.160377, "id": 0, "is_depot": true}, {"x": -8.619323, "y": 41.169292, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.640521000000001, "y": 41.150453, "id": 2, "demand": 150}, {"x": -8.63557, "y": 41.15417, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 542, "end_node": 0, "start_node": 0}]}, "output": "", "algoritmo": "nearest_neighbor.py", "timestamp": "2025-06-05 01:24:20.011", "input_file": "input_20250605_012416_497003_e3cd13.json"}, {"input": {"nodes": [{"x": -8.630618, "y": 41.160377, "id": 0, "is_depot": true}, {"x": -8.619323, "y": 41.169292, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.640521000000001, "y": 41.150453, "id": 2, "demand": 150}, {"x": -8.63557, "y": 41.15417, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 542, "end_node": 0, "start_node": 0}]}, "output": "", "algoritmo": "tabu_search.py", "timestamp": "2025-06-05 01:24:20.092", "input_file": "input_20250605_012416_497003_e3cd13.json"}, {"input": {"nodes": [{"x": -8.630618, "y": 41.160377, "id": 0, "is_depot": true}, {"x": -8.619323, "y": 41.169292, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.640521000000001, "y": 41.150453, "id": 2, "demand": 150}, {"x": -8.63557, "y": 41.15417, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 542, "end_node": 0, "start_node": 0}]}, "output": "Rota encontrada: [0, 10, 2, 1, 0]\\nCusto total: 0.06 km", "algoritmo": "grasp.py", "timestamp": "2025-06-05 01:24:20.169", "input_file": "input_20250605_012416_497003_e3cd13.json"}, {"input": {"nodes": [{"x": -8.630416, "y": 41.159955, "id": 0, "is_depot": true}, {"x": -8.619769, "y": 41.169702, "id": 1, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.640294, "y": 41.150850999999996, "id": 2, "demand": 150}, {"x": -8.63561, "y": 41.155334, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 533, "end_node": 0, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Caminho encontrado: [0]\\nDistância total: 0.01 km\\nEnergia estimada: 0.0 kWh", "algoritmo": "dijkstra.py", "timestamp": "2025-06-05 01:24:20.270", "input_file": "input_20250605_012416_551333_89acdc.json"}, {"input": {"nodes": [{"x": -8.630416, "y": 41.159955, "id": 0, "is_depot": true}, {"x": -8.619769, "y": 41.169702, "id": 1, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.640294, "y": 41.150850999999996, "id": 2, "demand": 150}, {"x": -8.63561, "y": 41.155334, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 533, "end_node": 0, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Rota ótima: [0, 1, 10, 2, 0]\\nDistância total: 0.06 km", "algoritmo": "branch_and_bound.py", "timestamp": "2025-06-05 01:24:20.328", "input_file": "input_20250605_012416_551333_89acdc.json"}, {"input": {"nodes": [{"x": -8.630416, "y": 41.159955, "id": 0, "is_depot": true}, {"x": -8.619769, "y": 41.169702, "id": 1, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.640294, "y": 41.150850999999996, "id": 2, "demand": 150}, {"x": -8.63561, "y": 41.155334, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 533, "end_node": 0, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Caminho encontrado: [0, 2, 0]\\nDistância total: 0.03 km", "algoritmo": "savings.py", "timestamp": "2025-06-05 01:24:20.393", "input_file": "input_20250605_012416_551333_89acdc.json"}, {"input": {"nodes": [{"x": -8.630416, "y": 41.159955, "id": 0, "is_depot": true}, {"x": -8.619769, "y": 41.169702, "id": 1, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.640294, "y": 41.150850999999996, "id": 2, "demand": 150}, {"x": -8.63561, "y": 41.155334, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 533, "end_node": 0, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Rota: [0, 10, 2, 1, 0]\\nDistância: 0.06 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "nearest_neighbor.py", "timestamp": "2025-06-05 01:24:20.464", "input_file": "input_20250605_012416_551333_89acdc.json"}, {"input": {"nodes": [{"x": -8.630416, "y": 41.159955, "id": 0, "is_depot": true}, {"x": -8.619769, "y": 41.169702, "id": 1, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.640294, "y": 41.150850999999996, "id": 2, "demand": 150}, {"x": -8.63561, "y": 41.155334, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "config": {"time_limit": 60, "tabu_tenure": 15}, "vehicles": [{"id": 1, "capacity": 533, "end_node": 0, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Roteamento: [[0, 1, 10, 2, 0]]\\nDistância total: 0.06 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "tabu_search.py", "timestamp": "2025-06-05 01:24:20.537", "input_file": "input_20250605_012416_551333_89acdc.json"}, {"input": {"nodes": [{"x": -8.630416, "y": 41.159955, "id": 0, "is_depot": true}, {"x": -8.619769, "y": 41.169702, "id": 1, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.640294, "y": 41.150850999999996, "id": 2, "demand": 150}, {"x": -8.63561, "y": 41.155334, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "config": {"time_limit": 60, "tabu_tenure": 15}, "vehicles": [{"id": 1, "capacity": 533, "end_node": 0, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Rota encontrada: [0, 10, 2, 1, 0]\\nCusto total: 0.06 km", "algoritmo": "grasp.py", "timestamp": "2025-06-05 01:24:20.622", "input_file": "input_20250605_012416_551333_89acdc.json"}, {"input": {"nodes": [{"x": -8.630245, "y": 41.160408, "id": 0, "is_depot": true}, {"x": -8.62056, "y": 41.169250000000005, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639249000000001, "y": 41.149754, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.634412, "y": 41.154892000000004, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Caminho encontrado: [0]\\nDistância total: 0.01 km\\nEnergia estimada: 0.0 kWh", "algoritmo": "dijkstra.py", "timestamp": "2025-06-05 01:24:20.724", "input_file": "input_20250605_012416_605697_88396b.json"}, {"input": {"nodes": [{"x": -8.630245, "y": 41.160408, "id": 0, "is_depot": true}, {"x": -8.62056, "y": 41.169250000000005, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639249000000001, "y": 41.149754, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.634412, "y": 41.154892000000004, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota ótima: [0, 1, 10, 2, 0]\\nDistância total: 0.05 km", "algoritmo": "branch_and_bound.py", "timestamp": "2025-06-05 01:24:20.782", "input_file": "input_20250605_012416_605697_88396b.json"}, {"input": {"nodes": [{"x": -8.630245, "y": 41.160408, "id": 0, "is_depot": true}, {"x": -8.62056, "y": 41.169250000000005, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639249000000001, "y": 41.149754, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.634412, "y": 41.154892000000004, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Caminho encontrado: [0, 1, 2, 0]\\nDistância total: 0.05 km", "algoritmo": "savings.py", "timestamp": "2025-06-05 01:24:20.848", "input_file": "input_20250605_012416_605697_88396b.json"}, {"input": {"nodes": [{"x": -8.630245, "y": 41.160408, "id": 0, "is_depot": true}, {"x": -8.62056, "y": 41.169250000000005, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639249000000001, "y": 41.149754, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.634412, "y": 41.154892000000004, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota: [0, 10, 2, 1, 0]\\nDistância: 0.05 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "nearest_neighbor.py", "timestamp": "2025-06-05 01:24:20.925", "input_file": "input_20250605_012416_605697_88396b.json"}, {"input": {"nodes": [{"x": -8.630245, "y": 41.160408, "id": 0, "is_depot": true}, {"x": -8.62056, "y": 41.169250000000005, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639249000000001, "y": 41.149754, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.634412, "y": 41.154892000000004, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Roteamento: [[0, 1, 10, 2, 0]]\\nDistância total: 0.05 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "tabu_search.py", "timestamp": "2025-06-05 01:24:20.991", "input_file": "input_20250605_012416_605697_88396b.json"}, {"input": {"nodes": [{"x": -8.630245, "y": 41.160408, "id": 0, "is_depot": true}, {"x": -8.62056, "y": 41.169250000000005, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639249000000001, "y": 41.149754, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.634412, "y": 41.154892000000004, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota encontrada: [0, 10, 2, 1, 0]\\nCusto total: 0.05 km", "algoritmo": "grasp.py", "timestamp": "2025-06-05 01:24:21.069", "input_file": "input_20250605_012416_605697_88396b.json"}, {"input": {"nodes": [{"x": -8.630584, "y": 41.160399999999996, "id": 0, "is_depot": true}, {"x": -8.620752, "y": 41.169569, "id": 1, "service_time": 300}, {"x": -8.640030000000001, "y": 41.149164999999996, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635398, "y": 41.154677, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 510, "end_node": 0, "start_node": 0}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "", "algoritmo": "dijkstra.py", "timestamp": "2025-06-05 01:24:21.191", "input_file": "input_20250605_012416_661657_cf2b7b.json"}, {"input": {"nodes": [{"x": -8.630584, "y": 41.160399999999996, "id": 0, "is_depot": true}, {"x": -8.620752, "y": 41.169569, "id": 1, "service_time": 300}, {"x": -8.640030000000001, "y": 41.149164999999996, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635398, "y": 41.154677, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 510, "end_node": 0, "start_node": 0}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Rota ótima: [0, 1, 2, 10, 0]\\nDistância total: 0.06 km", "algoritmo": "branch_and_bound.py", "timestamp": "2025-06-05 01:24:21.252", "input_file": "input_20250605_012416_661657_cf2b7b.json"}, {"input": {"nodes": [{"x": -8.630584, "y": 41.160399999999996, "id": 0, "is_depot": true}, {"x": -8.620752, "y": 41.169569, "id": 1, "service_time": 300}, {"x": -8.640030000000001, "y": 41.149164999999996, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635398, "y": 41.154677, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 510, "end_node": 0, "start_node": 0}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "", "algoritmo": "savings.py", "timestamp": "2025-06-05 01:24:21.330", "input_file": "input_20250605_012416_661657_cf2b7b.json"}, {"input": {"nodes": [{"x": -8.630584, "y": 41.160399999999996, "id": 0, "is_depot": true}, {"x": -8.620752, "y": 41.169569, "id": 1, "service_time": 300}, {"x": -8.640030000000001, "y": 41.149164999999996, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635398, "y": 41.154677, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 510, "end_node": 0, "start_node": 0}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "", "algoritmo": "nearest_neighbor.py", "timestamp": "2025-06-05 01:24:21.418", "input_file": "input_20250605_012416_661657_cf2b7b.json"}, {"input": {"nodes": [{"x": -8.630584, "y": 41.160399999999996, "id": 0, "is_depot": true}, {"x": -8.620752, "y": 41.169569, "id": 1, "service_time": 300}, {"x": -8.640030000000001, "y": 41.149164999999996, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635398, "y": 41.154677, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "config": {"time_limit": 60, "tabu_tenure": 15}, "vehicles": [{"id": 1, "capacity": 510, "end_node": 0, "start_node": 0}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "", "algoritmo": "tabu_search.py", "timestamp": "2025-06-05 01:24:21.504", "input_file": "input_20250605_012416_661657_cf2b7b.json"}, {"input": {"nodes": [{"x": -8.630584, "y": 41.160399999999996, "id": 0, "is_depot": true}, {"x": -8.620752, "y": 41.169569, "id": 1, "service_time": 300}, {"x": -8.640030000000001, "y": 41.149164999999996, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635398, "y": 41.154677, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "config": {"time_limit": 60, "tabu_tenure": 15}, "vehicles": [{"id": 1, "capacity": 510, "end_node": 0, "start_node": 0}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Rota encontrada: [0, 10, 2, 1, 0]\\nCusto total: 0.06 km", "algoritmo": "grasp.py", "timestamp": "2025-06-05 01:24:21.580", "input_file": "input_20250605_012416_661657_cf2b7b.json"}, {"input": {"nodes": [{"x": -8.63, "y": 41.16, "id": 0, "is_depot": true}, {"x": -8.62, "y": 41.17, "id": 1, "demand": 100, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.64, "y": 41.15, "id": 2, "demand": 80, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635, "y": 41.155, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "end_id": 0, "start_id": 0, "vehicles": [{"id": 1, "capacity": 300, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "charger_power_kw": 50, "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]], "is_charging_station": true}, "output": "Caminho encontrado: [0]\\nDistância total: 0 km\\nEnergia estimada: 0.0 kWh", "algoritmo": "dijkstra.py", "timestamp": "2025-06-05 01:24:21.680", "input_file": "input_20250605_012416_715239_0f0707.json"}, {"input": {"nodes": [{"x": -8.63, "y": 41.16, "id": 0, "is_depot": true}, {"x": -8.62, "y": 41.17, "id": 1, "demand": 100, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.64, "y": 41.15, "id": 2, "demand": 80, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635, "y": 41.155, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "demand": [0, 100, 80, 0], "vehicles": [{"id": 1, "capacity": 300, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "time_window": [[0, 86400], [28800, 39600], [32400, 45000], [0, 86400]], "service_time": [0, 300, 300, 0], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Rota ótima: [0, 1, 2, 10, 0]\\nDistância total: 0.06 km", "algoritmo": "branch_and_bound.py", "timestamp": "2025-06-05 01:24:21.754", "input_file": "input_20250605_012416_715239_0f0707.json"}, {"input": {"nodes": [{"x": -8.63, "y": 41.16, "id": 0, "is_depot": true}, {"x": -8.62, "y": 41.17, "id": 1, "demand": 100, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.64, "y": 41.15, "id": 2, "demand": 80, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635, "y": 41.155, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "demand": [0, 100, 80, 0], "vehicles": [{"id": 1, "capacity": 300, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "time_window": [[0, 86400], [28800, 39600], [32400, 45000], [0, 86400]], "service_time": [0, 300, 300, 0], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Caminho encontrado: [0, 1, 2, 0]\\nDistância total: 0.06 km", "algoritmo": "savings.py", "timestamp": "2025-06-05 01:24:21.826", "input_file": "input_20250605_012416_715239_0f0707.json"}, {"input": {"nodes": [{"x": -8.63, "y": 41.16, "id": 0, "is_depot": true}, {"x": -8.62, "y": 41.17, "id": 1, "demand": 100, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.64, "y": 41.15, "id": 2, "demand": 80, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635, "y": 41.155, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "demand": [0, 100, 80, 0], "vehicles": [{"id": 1, "capacity": 300, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "time_window": [[0, 86400], [28800, 39600], [32400, 45000], [0, 86400]], "service_time": [0, 300, 300, 0], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Rota: [0, 10, 2, 1, 0]\\nDistância: 0.06 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "nearest_neighbor.py", "timestamp": "2025-06-05 01:24:21.907", "input_file": "input_20250605_012416_715239_0f0707.json"}, {"input": {"nodes": [{"x": -8.63, "y": 41.16, "id": 0, "is_depot": true}, {"x": -8.62, "y": 41.17, "id": 1, "demand": 100, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.64, "y": 41.15, "id": 2, "demand": 80, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635, "y": 41.155, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "config": {"time_limit": 60, "tabu_tenure": 10}, "demand": [0, 100, 80, 0], "end_id": 0, "start_id": 0, "vehicles": [{"id": 1, "capacity": 300, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "time_window": [[0, 86400], [28800, 39600], [32400, 45000], [0, 86400]], "service_time": [0, 300, 300, 0], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "charger_power_kw": 50, "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]], "is_charging_station": true}, "output": "Roteamento: [[0, 1, 2, 10, 0]]\\nDistância total: 0.06 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "tabu_search.py", "timestamp": "2025-06-05 01:24:21.977", "input_file": "input_20250605_012416_715239_0f0707.json"}, {"input": {"nodes": [{"x": -8.63, "y": 41.16, "id": 0, "is_depot": true}, {"x": -8.62, "y": 41.17, "id": 1, "demand": 100, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.64, "y": 41.15, "id": 2, "demand": 80, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635, "y": 41.155, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "config": {"time_limit": 60, "tabu_tenure": 10}, "demand": [0, 100, 80, 0], "end_id": 0, "start_id": 0, "vehicles": [{"id": 1, "capacity": 300, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "time_window": [[0, 86400], [28800, 39600], [32400, 45000], [0, 86400]], "service_time": [0, 300, 300, 0], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "charger_power_kw": 50, "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]], "is_charging_station": true}, "output": "Rota encontrada: [0, 10, 2, 1, 0]\\nCusto total: 0.06 km", "algoritmo": "grasp.py", "timestamp": "2025-06-05 01:24:22.052", "input_file": "input_20250605_012416_715239_0f0707.json"}, {"input": {"nodes": [{"x": -8.63, "y": 41.16, "id": 0, "is_depot": true}, {"x": -8.62, "y": 41.17, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.64, "y": 41.15, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635, "y": 41.155, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 500, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Caminho encontrado: [0]\\nDistância total: 0.01 km\\nEnergia estimada: 0.0 kWh", "algoritmo": "dijkstra.py", "timestamp": "2025-06-05 01:24:22.153", "input_file": "input_20250605_012416_768260_28b3d5.json"}, {"input": {"nodes": [{"x": -8.63, "y": 41.16, "id": 0, "is_depot": true}, {"x": -8.62, "y": 41.17, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.64, "y": 41.15, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635, "y": 41.155, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 500, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Rota ótima: [0, 1, 2, 10, 0]\\nDistância total: 0.06 km", "algoritmo": "branch_and_bound.py", "timestamp": "2025-06-05 01:24:22.210", "input_file": "input_20250605_012416_768260_28b3d5.json"}, {"input": {"nodes": [{"x": -8.63, "y": 41.16, "id": 0, "is_depot": true}, {"x": -8.62, "y": 41.17, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.64, "y": 41.15, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635, "y": 41.155, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 500, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Caminho encontrado: [0, 1, 2, 0]\\nDistância total: 0.06 km", "algoritmo": "savings.py", "timestamp": "2025-06-05 01:24:22.275", "input_file": "input_20250605_012416_768260_28b3d5.json"}, {"input": {"nodes": [{"x": -8.63, "y": 41.16, "id": 0, "is_depot": true}, {"x": -8.62, "y": 41.17, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.64, "y": 41.15, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635, "y": 41.155, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 500, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Rota: [0, 10, 2, 1, 0]\\nDistância: 0.06 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "nearest_neighbor.py", "timestamp": "2025-06-05 01:24:22.357", "input_file": "input_20250605_012416_768260_28b3d5.json"}, {"input": {"nodes": [{"x": -8.63, "y": 41.16, "id": 0, "is_depot": true}, {"x": -8.62, "y": 41.17, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.64, "y": 41.15, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635, "y": 41.155, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "config": {"time_limit": 60, "tabu_tenure": 15}, "vehicles": [{"id": 1, "capacity": 500, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Roteamento: [[0, 1, 2, 10, 0]]\\nDistância total: 0.06 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "tabu_search.py", "timestamp": "2025-06-05 01:24:22.434", "input_file": "input_20250605_012416_768260_28b3d5.json"}, {"input": {"nodes": [{"x": -8.63, "y": 41.16, "id": 0, "is_depot": true}, {"x": -8.62, "y": 41.17, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.64, "y": 41.15, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635, "y": 41.155, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "config": {"time_limit": 60, "tabu_tenure": 15}, "vehicles": [{"id": 1, "capacity": 500, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Rota encontrada: [0, 10, 2, 1, 0]\\nCusto total: 0.06 km", "algoritmo": "grasp.py", "timestamp": "2025-06-05 01:24:22.510", "input_file": "input_20250605_012416_768260_28b3d5.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Caminho encontrado: [0]\\nDistância total: 0.01 km\\nEnergia estimada: 0.0 kWh", "algoritmo": "dijkstra.py", "timestamp": "2025-06-05 01:24:22.598", "input_file": "input_20250605_012416_821109_4597a5.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota ótima: [0, 1, 2, 10, 0]\\nDistância total: 0.05 km", "algoritmo": "branch_and_bound.py", "timestamp": "2025-06-05 01:24:22.659", "input_file": "input_20250605_012416_821109_4597a5.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Caminho encontrado: [0, 1, 0]\\nDistância total: 0.03 km", "algoritmo": "savings.py", "timestamp": "2025-06-05 01:24:22.723", "input_file": "input_20250605_012416_821109_4597a5.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota: [0, 10, 2, 1, 0]\\nDistância: 0.05 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "nearest_neighbor.py", "timestamp": "2025-06-05 01:24:22.795", "input_file": "input_20250605_012416_821109_4597a5.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Roteamento: [[0, 1, 2, 10, 0]]\\nDistância total: 0.05 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "tabu_search.py", "timestamp": "2025-06-05 01:24:22.854", "input_file": "input_20250605_012416_821109_4597a5.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota encontrada: [0, 10, 2, 1, 0]\\nCusto total: 0.05 km", "algoritmo": "grasp.py", "timestamp": "2025-06-05 01:24:22.931", "input_file": "input_20250605_012416_821109_4597a5.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Caminho encontrado: [0]\\nDistância total: 0.01 km\\nEnergia estimada: 0.0 kWh", "algoritmo": "dijkstra.py", "timestamp": "2025-06-05 01:27:12.675", "input_file": "input_20250605_012712_439749_7f7d32.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota ótima: [0, 1, 2, 10, 0]\\nDistância total: 0.05 km", "algoritmo": "branch_and_bound.py", "timestamp": "2025-06-05 01:27:12.730", "input_file": "input_20250605_012712_439749_7f7d32.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Caminho encontrado: [0, 1, 0]\\nDistância total: 0.03 km", "algoritmo": "savings.py", "timestamp": "2025-06-05 01:27:12.791", "input_file": "input_20250605_012712_439749_7f7d32.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota: [0, 10, 2, 1, 0]\\nDistância: 0.05 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "nearest_neighbor.py", "timestamp": "2025-06-05 01:27:12.859", "input_file": "input_20250605_012712_439749_7f7d32.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Roteamento: [[0, 1, 2, 10, 0]]\\nDistância total: 0.05 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "tabu_search.py", "timestamp": "2025-06-05 01:27:12.915", "input_file": "input_20250605_012712_439749_7f7d32.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota encontrada: [0, 10, 2, 1, 0]\\nCusto total: 0.05 km", "algoritmo": "grasp.py", "timestamp": "2025-06-05 01:27:12.987", "input_file": "input_20250605_012712_439749_7f7d32.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Caminho encontrado: [0]\\nDistância total: 0.01 km\\nEnergia estimada: 0.0 kWh", "algoritmo": "dijkstra.py", "timestamp": "2025-06-11 17:58:25.295", "input_file": "input_20250611_175824_967889_db0f91.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota ótima: [0, 1, 2, 10, 0]\\nDistância total: 0.05 km", "algoritmo": "branch_and_bound.py", "timestamp": "2025-06-11 17:58:25.359", "input_file": "input_20250611_175824_967889_db0f91.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Caminho encontrado: [0, 1, 0]\\nDistância total: 0.03 km", "algoritmo": "savings.py", "timestamp": "2025-06-11 17:58:25.427", "input_file": "input_20250611_175824_967889_db0f91.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota: [0, 10, 2, 1, 0]\\nDistância: 0.05 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "nearest_neighbor.py", "timestamp": "2025-06-11 17:58:25.509", "input_file": "input_20250611_175824_967889_db0f91.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Roteamento: [[0, 1, 2, 10, 0]]\\nDistância total: 0.05 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "tabu_search.py", "timestamp": "2025-06-11 17:58:25.575", "input_file": "input_20250611_175824_967889_db0f91.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota encontrada: [0, 10, 2, 1, 0]\\nCusto total: 0.05 km", "algoritmo": "grasp.py", "timestamp": "2025-06-11 17:58:25.659", "input_file": "input_20250611_175824_967889_db0f91.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Caminho encontrado: [0]\\nDistância total: 0.01 km\\nEnergia estimada: 0.0 kWh", "algoritmo": "dijkstra.py", "timestamp": "2025-06-11 17:59:31.151", "input_file": "input_20250611_175930_315075_41c02b.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota ótima: [0, 1, 2, 10, 0]\\nDistância total: 0.05 km", "algoritmo": "branch_and_bound.py", "timestamp": "2025-06-11 17:59:31.223", "input_file": "input_20250611_175930_315075_41c02b.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Caminho encontrado: [0, 1, 0]\\nDistância total: 0.03 km", "algoritmo": "savings.py", "timestamp": "2025-06-11 17:59:31.305", "input_file": "input_20250611_175930_315075_41c02b.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota: [0, 10, 2, 1, 0]\\nDistância: 0.05 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "nearest_neighbor.py", "timestamp": "2025-06-11 17:59:31.386", "input_file": "input_20250611_175930_315075_41c02b.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Roteamento: [[0, 1, 2, 10, 0]]\\nDistância total: 0.05 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "tabu_search.py", "timestamp": "2025-06-11 17:59:31.451", "input_file": "input_20250611_175930_315075_41c02b.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota encontrada: [0, 10, 2, 1, 0]\\nCusto total: 0.05 km", "algoritmo": "grasp.py", "timestamp": "2025-06-11 17:59:31.543", "input_file": "input_20250611_175930_315075_41c02b.json"}, {"input": {"nodes": [{"x": -8.63062, "y": 41.159744999999994, "id": 0, "is_depot": true}, {"x": -8.620659999999999, "y": 41.170639, "id": 1, "demand": 200, "time_window": [28800, 39600]}, {"x": -8.64004, "y": 41.149558, "id": 2}, {"x": -8.635465, "y": 41.154031, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 542, "end_node": 0, "start_node": 0, "battery_kwh": 70}]}, "output": "Caminho encontrado: [0]\\nDistância total: 0.01 km\\nEnergia estimada: 0.0 kWh", "algoritmo": "dijkstra.py", "timestamp": "2025-06-11 17:59:31.649", "input_file": "input_20250611_175930_363641_5a869c.json"}, {"input": {"nodes": [{"x": -8.63062, "y": 41.159744999999994, "id": 0, "is_depot": true}, {"x": -8.620659999999999, "y": 41.170639, "id": 1, "demand": 200, "time_window": [28800, 39600]}, {"x": -8.64004, "y": 41.149558, "id": 2}, {"x": -8.635465, "y": 41.154031, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 542, "end_node": 0, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota ótima: [0, 1, 10, 2, 0]\\nDistância total: 0.06 km", "algoritmo": "branch_and_bound.py", "timestamp": "2025-06-11 17:59:31.714", "input_file": "input_20250611_175930_363641_5a869c.json"}, {"input": {"nodes": [{"x": -8.63062, "y": 41.159744999999994, "id": 0, "is_depot": true}, {"x": -8.620659999999999, "y": 41.170639, "id": 1, "demand": 200, "time_window": [28800, 39600]}, {"x": -8.64004, "y": 41.149558, "id": 2}, {"x": -8.635465, "y": 41.154031, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 542, "end_node": 0, "start_node": 0, "battery_kwh": 70}]}, "output": "Caminho encontrado: [0, 1, 0]\\nDistância total: 0.03 km", "algoritmo": "savings.py", "timestamp": "2025-06-11 17:59:31.784", "input_file": "input_20250611_175930_363641_5a869c.json"}, {"input": {"nodes": [{"x": -8.63062, "y": 41.159744999999994, "id": 0, "is_depot": true}, {"x": -8.620659999999999, "y": 41.170639, "id": 1, "demand": 200, "time_window": [28800, 39600]}, {"x": -8.64004, "y": 41.149558, "id": 2}, {"x": -8.635465, "y": 41.154031, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 542, "end_node": 0, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota: [0, 10, 2, 1, 0]\\nDistância: 0.06 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "nearest_neighbor.py", "timestamp": "2025-06-11 17:59:31.865", "input_file": "input_20250611_175930_363641_5a869c.json"}, {"input": {"nodes": [{"x": -8.63062, "y": 41.159744999999994, "id": 0, "is_depot": true}, {"x": -8.620659999999999, "y": 41.170639, "id": 1, "demand": 200, "time_window": [28800, 39600]}, {"x": -8.64004, "y": 41.149558, "id": 2}, {"x": -8.635465, "y": 41.154031, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 542, "end_node": 0, "start_node": 0, "battery_kwh": 70}]}, "output": "Roteamento: [[0, 1, 10, 2, 0]]\\nDistância total: 0.06 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "tabu_search.py", "timestamp": "2025-06-11 17:59:31.934", "input_file": "input_20250611_175930_363641_5a869c.json"}, {"input": {"nodes": [{"x": -8.63062, "y": 41.159744999999994, "id": 0, "is_depot": true}, {"x": -8.620659999999999, "y": 41.170639, "id": 1, "demand": 200, "time_window": [28800, 39600]}, {"x": -8.64004, "y": 41.149558, "id": 2}, {"x": -8.635465, "y": 41.154031, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 542, "end_node": 0, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota encontrada: [0, 10, 2, 1, 0]\\nCusto total: 0.06 km", "algoritmo": "grasp.py", "timestamp": "2025-06-11 17:59:32.020", "input_file": "input_20250611_175930_363641_5a869c.json"}, {"input": {"nodes": [{"x": -8.629290000000001, "y": 41.159439, "id": 0, "is_depot": true}, {"x": -8.62093, "y": 41.169368, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639674000000001, "y": 41.14991, "id": 2, "demand": 150, "service_time": 300}, {"x": -8.635093, "y": 41.154154, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 482, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Caminho encontrado: [0]\\nDistância total: 0.01 km\\nEnergia estimada: 0.0 kWh", "algoritmo": "dijkstra.py", "timestamp": "2025-06-11 17:59:32.131", "input_file": "input_20250611_175930_408522_d8ac65.json"}, {"input": {"nodes": [{"x": -8.629290000000001, "y": 41.159439, "id": 0, "is_depot": true}, {"x": -8.62093, "y": 41.169368, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639674000000001, "y": 41.14991, "id": 2, "demand": 150, "service_time": 300}, {"x": -8.635093, "y": 41.154154, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 482, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Rota ótima: [0, 1, 2, 10, 0]\\nDistância total: 0.05 km", "algoritmo": "branch_and_bound.py", "timestamp": "2025-06-11 17:59:32.199", "input_file": "input_20250611_175930_408522_d8ac65.json"}, {"input": {"nodes": [{"x": -8.629290000000001, "y": 41.159439, "id": 0, "is_depot": true}, {"x": -8.62093, "y": 41.169368, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639674000000001, "y": 41.14991, "id": 2, "demand": 150, "service_time": 300}, {"x": -8.635093, "y": 41.154154, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 482, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Caminho encontrado: [0, 1, 2, 0]\\nDistância total: 0.05 km", "algoritmo": "savings.py", "timestamp": "2025-06-11 17:59:32.271", "input_file": "input_20250611_175930_408522_d8ac65.json"}, {"input": {"nodes": [{"x": -8.629290000000001, "y": 41.159439, "id": 0, "is_depot": true}, {"x": -8.62093, "y": 41.169368, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639674000000001, "y": 41.14991, "id": 2, "demand": 150, "service_time": 300}, {"x": -8.635093, "y": 41.154154, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 482, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Rota: [0, 10, 2, 1, 0]\\nDistância: 0.05 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "nearest_neighbor.py", "timestamp": "2025-06-11 17:59:32.350", "input_file": "input_20250611_175930_408522_d8ac65.json"}, {"input": {"nodes": [{"x": -8.629290000000001, "y": 41.159439, "id": 0, "is_depot": true}, {"x": -8.62093, "y": 41.169368, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639674000000001, "y": 41.14991, "id": 2, "demand": 150, "service_time": 300}, {"x": -8.635093, "y": 41.154154, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "config": {"time_limit": 60, "tabu_tenure": 15}, "vehicles": [{"id": 1, "capacity": 482, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Roteamento: [[0, 1, 2, 10, 0]]\\nDistância total: 0.05 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "tabu_search.py", "timestamp": "2025-06-11 17:59:32.431", "input_file": "input_20250611_175930_408522_d8ac65.json"}, {"input": {"nodes": [{"x": -8.629290000000001, "y": 41.159439, "id": 0, "is_depot": true}, {"x": -8.62093, "y": 41.169368, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639674000000001, "y": 41.14991, "id": 2, "demand": 150, "service_time": 300}, {"x": -8.635093, "y": 41.154154, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "config": {"time_limit": 60, "tabu_tenure": 15}, "vehicles": [{"id": 1, "capacity": 482, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Rota encontrada: [0, 10, 2, 1, 0]\\nCusto total: 0.05 km", "algoritmo": "grasp.py", "timestamp": "2025-06-11 17:59:32.519", "input_file": "input_20250611_175930_408522_d8ac65.json"}, {"input": {"nodes": [{"x": -8.629090000000001, "y": 41.159751, "id": 0, "is_depot": true}, {"x": -8.619287, "y": 41.170083, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.640284000000001, "y": 41.149693, "id": 2, "demand": 150}, {"x": -8.635999, "y": 41.155701, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 513, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Caminho encontrado: [0]\\nDistância total: 0.01 km\\nEnergia estimada: 0.0 kWh", "algoritmo": "dijkstra.py", "timestamp": "2025-06-11 17:59:32.639", "input_file": "input_20250611_175930_459624_2c08ca.json"}, {"input": {"nodes": [{"x": -8.629090000000001, "y": 41.159751, "id": 0, "is_depot": true}, {"x": -8.619287, "y": 41.170083, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.640284000000001, "y": 41.149693, "id": 2, "demand": 150}, {"x": -8.635999, "y": 41.155701, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 513, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota ótima: [0, 1, 10, 2, 0]\\nDistância total: 0.06 km", "algoritmo": "branch_and_bound.py", "timestamp": "2025-06-11 17:59:32.705", "input_file": "input_20250611_175930_459624_2c08ca.json"}, {"input": {"nodes": [{"x": -8.629090000000001, "y": 41.159751, "id": 0, "is_depot": true}, {"x": -8.619287, "y": 41.170083, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.640284000000001, "y": 41.149693, "id": 2, "demand": 150}, {"x": -8.635999, "y": 41.155701, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 513, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Caminho encontrado: [0, 1, 2, 0]\\nDistância total: 0.06 km", "algoritmo": "savings.py", "timestamp": "2025-06-11 17:59:32.773", "input_file": "input_20250611_175930_459624_2c08ca.json"}, {"input": {"nodes": [{"x": -8.629090000000001, "y": 41.159751, "id": 0, "is_depot": true}, {"x": -8.619287, "y": 41.170083, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.640284000000001, "y": 41.149693, "id": 2, "demand": 150}, {"x": -8.635999, "y": 41.155701, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 513, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota: [0, 10, 2, 1, 0]\\nDistância: 0.06 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "nearest_neighbor.py", "timestamp": "2025-06-11 17:59:32.852", "input_file": "input_20250611_175930_459624_2c08ca.json"}, {"input": {"nodes": [{"x": -8.629090000000001, "y": 41.159751, "id": 0, "is_depot": true}, {"x": -8.619287, "y": 41.170083, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.640284000000001, "y": 41.149693, "id": 2, "demand": 150}, {"x": -8.635999, "y": 41.155701, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 513, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Roteamento: [[0, 1, 10, 2, 0]]\\nDistância total: 0.06 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "tabu_search.py", "timestamp": "2025-06-11 17:59:32.915", "input_file": "input_20250611_175930_459624_2c08ca.json"}, {"input": {"nodes": [{"x": -8.629090000000001, "y": 41.159751, "id": 0, "is_depot": true}, {"x": -8.619287, "y": 41.170083, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.640284000000001, "y": 41.149693, "id": 2, "demand": 150}, {"x": -8.635999, "y": 41.155701, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 513, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota encontrada: [0, 10, 2, 1, 0]\\nCusto total: 0.06 km", "algoritmo": "grasp.py", "timestamp": "2025-06-11 17:59:33.001", "input_file": "input_20250611_175930_459624_2c08ca.json"}, {"input": {"nodes": [{"x": -8.629134, "y": 41.160951999999995, "id": 0, "is_depot": true}, {"x": -8.620451, "y": 41.170649000000004, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.639610000000001, "y": 41.149675, "id": 2, "demand": 150}, {"x": -8.63503, "y": 41.154454, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 529, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Caminho encontrado: [0]\\nDistância total: 0.01 km\\nEnergia estimada: 0.0 kWh", "algoritmo": "dijkstra.py", "timestamp": "2025-06-11 17:59:33.114", "input_file": "input_20250611_175930_504016_a4c0e2.json"}, {"input": {"nodes": [{"x": -8.629134, "y": 41.160951999999995, "id": 0, "is_depot": true}, {"x": -8.620451, "y": 41.170649000000004, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.639610000000001, "y": 41.149675, "id": 2, "demand": 150}, {"x": -8.63503, "y": 41.154454, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 529, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota ótima: [0, 1, 2, 10, 0]\\nDistância total: 0.06 km", "algoritmo": "branch_and_bound.py", "timestamp": "2025-06-11 17:59:33.180", "input_file": "input_20250611_175930_504016_a4c0e2.json"}, {"input": {"nodes": [{"x": -8.629134, "y": 41.160951999999995, "id": 0, "is_depot": true}, {"x": -8.620451, "y": 41.170649000000004, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.639610000000001, "y": 41.149675, "id": 2, "demand": 150}, {"x": -8.63503, "y": 41.154454, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 529, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Caminho encontrado: [0, 1, 2, 0]\\nDistância total: 0.06 km", "algoritmo": "savings.py", "timestamp": "2025-06-11 17:59:33.251", "input_file": "input_20250611_175930_504016_a4c0e2.json"}, {"input": {"nodes": [{"x": -8.629134, "y": 41.160951999999995, "id": 0, "is_depot": true}, {"x": -8.620451, "y": 41.170649000000004, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.639610000000001, "y": 41.149675, "id": 2, "demand": 150}, {"x": -8.63503, "y": 41.154454, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 529, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota: [0, 10, 2, 1, 0]\\nDistância: 0.06 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "nearest_neighbor.py", "timestamp": "2025-06-11 17:59:33.330", "input_file": "input_20250611_175930_504016_a4c0e2.json"}, {"input": {"nodes": [{"x": -8.629134, "y": 41.160951999999995, "id": 0, "is_depot": true}, {"x": -8.620451, "y": 41.170649000000004, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.639610000000001, "y": 41.149675, "id": 2, "demand": 150}, {"x": -8.63503, "y": 41.154454, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 529, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Roteamento: [[0, 1, 2, 10, 0]]\\nDistância total: 0.06 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "tabu_search.py", "timestamp": "2025-06-11 17:59:33.393", "input_file": "input_20250611_175930_504016_a4c0e2.json"}, {"input": {"nodes": [{"x": -8.629134, "y": 41.160951999999995, "id": 0, "is_depot": true}, {"x": -8.620451, "y": 41.170649000000004, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.639610000000001, "y": 41.149675, "id": 2, "demand": 150}, {"x": -8.63503, "y": 41.154454, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 529, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota encontrada: [0, 10, 2, 1, 0]\\nCusto total: 0.06 km", "algoritmo": "grasp.py", "timestamp": "2025-06-11 17:59:33.477", "input_file": "input_20250611_175930_504016_a4c0e2.json"}, {"input": {"nodes": [{"x": -8.630600000000001, "y": 41.16018699999999, "id": 0, "is_depot": true}, {"x": -8.620757, "y": 41.170898, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.639717000000001, "y": 41.149474999999995, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635965, "y": 41.155971, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 465, "end_node": 0, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Caminho encontrado: [0]\\nDistância total: 0.01 km\\nEnergia estimada: 0.0 kWh", "algoritmo": "dijkstra.py", "timestamp": "2025-06-11 17:59:33.587", "input_file": "input_20250611_175930_554192_f2e237.json"}, {"input": {"nodes": [{"x": -8.630600000000001, "y": 41.16018699999999, "id": 0, "is_depot": true}, {"x": -8.620757, "y": 41.170898, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.639717000000001, "y": 41.149474999999995, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635965, "y": 41.155971, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 465, "end_node": 0, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Rota ótima: [0, 1, 10, 2, 0]\\nDistância total: 0.06 km", "algoritmo": "branch_and_bound.py", "timestamp": "2025-06-11 17:59:33.652", "input_file": "input_20250611_175930_554192_f2e237.json"}, {"input": {"nodes": [{"x": -8.630600000000001, "y": 41.16018699999999, "id": 0, "is_depot": true}, {"x": -8.620757, "y": 41.170898, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.639717000000001, "y": 41.149474999999995, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635965, "y": 41.155971, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 465, "end_node": 0, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Caminho encontrado: [0, 1, 2, 0]\\nDistância total: 0.06 km", "algoritmo": "savings.py", "timestamp": "2025-06-11 17:59:33.721", "input_file": "input_20250611_175930_554192_f2e237.json"}, {"input": {"nodes": [{"x": -8.630600000000001, "y": 41.16018699999999, "id": 0, "is_depot": true}, {"x": -8.620757, "y": 41.170898, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.639717000000001, "y": 41.149474999999995, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635965, "y": 41.155971, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 465, "end_node": 0, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Rota: [0, 10, 2, 1, 0]\\nDistância: 0.06 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "nearest_neighbor.py", "timestamp": "2025-06-11 17:59:33.804", "input_file": "input_20250611_175930_554192_f2e237.json"}, {"input": {"nodes": [{"x": -8.630600000000001, "y": 41.16018699999999, "id": 0, "is_depot": true}, {"x": -8.620757, "y": 41.170898, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.639717000000001, "y": 41.149474999999995, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635965, "y": 41.155971, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "config": {"time_limit": 60, "tabu_tenure": 15}, "vehicles": [{"id": 1, "capacity": 465, "end_node": 0, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Roteamento: [[0, 1, 10, 2, 0]]\\nDistância total: 0.06 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "tabu_search.py", "timestamp": "2025-06-11 17:59:33.881", "input_file": "input_20250611_175930_554192_f2e237.json"}, {"input": {"nodes": [{"x": -8.630600000000001, "y": 41.16018699999999, "id": 0, "is_depot": true}, {"x": -8.620757, "y": 41.170898, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.639717000000001, "y": 41.149474999999995, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635965, "y": 41.155971, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "config": {"time_limit": 60, "tabu_tenure": 15}, "vehicles": [{"id": 1, "capacity": 465, "end_node": 0, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Rota encontrada: [0, 10, 2, 1, 0]\\nCusto total: 0.06 km", "algoritmo": "grasp.py", "timestamp": "2025-06-11 17:59:33.966", "input_file": "input_20250611_175930_554192_f2e237.json"}, {"input": {"nodes": [{"x": -8.630618, "y": 41.160377, "id": 0, "is_depot": true}, {"x": -8.619323, "y": 41.169292, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.640521000000001, "y": 41.150453, "id": 2, "demand": 150}, {"x": -8.63557, "y": 41.15417, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 542, "end_node": 0, "start_node": 0}]}, "output": "", "algoritmo": "dijkstra.py", "timestamp": "2025-06-11 17:59:34.111", "input_file": "input_20250611_175930_602850_7a67c8.json"}, {"input": {"nodes": [{"x": -8.630618, "y": 41.160377, "id": 0, "is_depot": true}, {"x": -8.619323, "y": 41.169292, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.640521000000001, "y": 41.150453, "id": 2, "demand": 150}, {"x": -8.63557, "y": 41.15417, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 542, "end_node": 0, "start_node": 0}]}, "output": "Rota ótima: [0, 1, 10, 2, 0]\\nDistância total: 0.06 km", "algoritmo": "branch_and_bound.py", "timestamp": "2025-06-11 17:59:34.178", "input_file": "input_20250611_175930_602850_7a67c8.json"}, {"input": {"nodes": [{"x": -8.630618, "y": 41.160377, "id": 0, "is_depot": true}, {"x": -8.619323, "y": 41.169292, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.640521000000001, "y": 41.150453, "id": 2, "demand": 150}, {"x": -8.63557, "y": 41.15417, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 542, "end_node": 0, "start_node": 0}]}, "output": "", "algoritmo": "savings.py", "timestamp": "2025-06-11 17:59:34.268", "input_file": "input_20250611_175930_602850_7a67c8.json"}, {"input": {"nodes": [{"x": -8.630618, "y": 41.160377, "id": 0, "is_depot": true}, {"x": -8.619323, "y": 41.169292, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.640521000000001, "y": 41.150453, "id": 2, "demand": 150}, {"x": -8.63557, "y": 41.15417, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 542, "end_node": 0, "start_node": 0}]}, "output": "", "algoritmo": "nearest_neighbor.py", "timestamp": "2025-06-11 17:59:34.362", "input_file": "input_20250611_175930_602850_7a67c8.json"}, {"input": {"nodes": [{"x": -8.630618, "y": 41.160377, "id": 0, "is_depot": true}, {"x": -8.619323, "y": 41.169292, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.640521000000001, "y": 41.150453, "id": 2, "demand": 150}, {"x": -8.63557, "y": 41.15417, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 542, "end_node": 0, "start_node": 0}]}, "output": "", "algoritmo": "tabu_search.py", "timestamp": "2025-06-11 17:59:34.444", "input_file": "input_20250611_175930_602850_7a67c8.json"}, {"input": {"nodes": [{"x": -8.630618, "y": 41.160377, "id": 0, "is_depot": true}, {"x": -8.619323, "y": 41.169292, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.640521000000001, "y": 41.150453, "id": 2, "demand": 150}, {"x": -8.63557, "y": 41.15417, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 542, "end_node": 0, "start_node": 0}]}, "output": "Rota encontrada: [0, 10, 2, 1, 0]\\nCusto total: 0.06 km", "algoritmo": "grasp.py", "timestamp": "2025-06-11 17:59:34.532", "input_file": "input_20250611_175930_602850_7a67c8.json"}, {"input": {"nodes": [{"x": -8.630416, "y": 41.159955, "id": 0, "is_depot": true}, {"x": -8.619769, "y": 41.169702, "id": 1, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.640294, "y": 41.150850999999996, "id": 2, "demand": 150}, {"x": -8.63561, "y": 41.155334, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 533, "end_node": 0, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Caminho encontrado: [0]\\nDistância total: 0.01 km\\nEnergia estimada: 0.0 kWh", "algoritmo": "dijkstra.py", "timestamp": "2025-06-11 17:59:34.658", "input_file": "input_20250611_175930_656616_c5a054.json"}, {"input": {"nodes": [{"x": -8.630416, "y": 41.159955, "id": 0, "is_depot": true}, {"x": -8.619769, "y": 41.169702, "id": 1, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.640294, "y": 41.150850999999996, "id": 2, "demand": 150}, {"x": -8.63561, "y": 41.155334, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 533, "end_node": 0, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Rota ótima: [0, 1, 10, 2, 0]\\nDistância total: 0.06 km", "algoritmo": "branch_and_bound.py", "timestamp": "2025-06-11 17:59:34.729", "input_file": "input_20250611_175930_656616_c5a054.json"}, {"input": {"nodes": [{"x": -8.630416, "y": 41.159955, "id": 0, "is_depot": true}, {"x": -8.619769, "y": 41.169702, "id": 1, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.640294, "y": 41.150850999999996, "id": 2, "demand": 150}, {"x": -8.63561, "y": 41.155334, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 533, "end_node": 0, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Caminho encontrado: [0, 2, 0]\\nDistância total: 0.03 km", "algoritmo": "savings.py", "timestamp": "2025-06-11 17:59:34.813", "input_file": "input_20250611_175930_656616_c5a054.json"}, {"input": {"nodes": [{"x": -8.630416, "y": 41.159955, "id": 0, "is_depot": true}, {"x": -8.619769, "y": 41.169702, "id": 1, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.640294, "y": 41.150850999999996, "id": 2, "demand": 150}, {"x": -8.63561, "y": 41.155334, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 533, "end_node": 0, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Rota: [0, 10, 2, 1, 0]\\nDistância: 0.06 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "nearest_neighbor.py", "timestamp": "2025-06-11 17:59:34.898", "input_file": "input_20250611_175930_656616_c5a054.json"}, {"input": {"nodes": [{"x": -8.630416, "y": 41.159955, "id": 0, "is_depot": true}, {"x": -8.619769, "y": 41.169702, "id": 1, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.640294, "y": 41.150850999999996, "id": 2, "demand": 150}, {"x": -8.63561, "y": 41.155334, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "config": {"time_limit": 60, "tabu_tenure": 15}, "vehicles": [{"id": 1, "capacity": 533, "end_node": 0, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Roteamento: [[0, 1, 10, 2, 0]]\\nDistância total: 0.06 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "tabu_search.py", "timestamp": "2025-06-11 17:59:34.971", "input_file": "input_20250611_175930_656616_c5a054.json"}, {"input": {"nodes": [{"x": -8.630416, "y": 41.159955, "id": 0, "is_depot": true}, {"x": -8.619769, "y": 41.169702, "id": 1, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.640294, "y": 41.150850999999996, "id": 2, "demand": 150}, {"x": -8.63561, "y": 41.155334, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "config": {"time_limit": 60, "tabu_tenure": 15}, "vehicles": [{"id": 1, "capacity": 533, "end_node": 0, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Rota encontrada: [0, 10, 2, 1, 0]\\nCusto total: 0.06 km", "algoritmo": "grasp.py", "timestamp": "2025-06-11 17:59:35.059", "input_file": "input_20250611_175930_656616_c5a054.json"}, {"input": {"nodes": [{"x": -8.630245, "y": 41.160408, "id": 0, "is_depot": true}, {"x": -8.62056, "y": 41.169250000000005, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639249000000001, "y": 41.149754, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.634412, "y": 41.154892000000004, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Caminho encontrado: [0]\\nDistância total: 0.01 km\\nEnergia estimada: 0.0 kWh", "algoritmo": "dijkstra.py", "timestamp": "2025-06-11 17:59:35.177", "input_file": "input_20250611_175930_705017_1a8e38.json"}, {"input": {"nodes": [{"x": -8.630245, "y": 41.160408, "id": 0, "is_depot": true}, {"x": -8.62056, "y": 41.169250000000005, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639249000000001, "y": 41.149754, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.634412, "y": 41.154892000000004, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota ótima: [0, 1, 10, 2, 0]\\nDistância total: 0.05 km", "algoritmo": "branch_and_bound.py", "timestamp": "2025-06-11 17:59:35.246", "input_file": "input_20250611_175930_705017_1a8e38.json"}, {"input": {"nodes": [{"x": -8.630245, "y": 41.160408, "id": 0, "is_depot": true}, {"x": -8.62056, "y": 41.169250000000005, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639249000000001, "y": 41.149754, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.634412, "y": 41.154892000000004, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Caminho encontrado: [0, 1, 2, 0]\\nDistância total: 0.05 km", "algoritmo": "savings.py", "timestamp": "2025-06-11 17:59:35.313", "input_file": "input_20250611_175930_705017_1a8e38.json"}, {"input": {"nodes": [{"x": -8.630245, "y": 41.160408, "id": 0, "is_depot": true}, {"x": -8.62056, "y": 41.169250000000005, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639249000000001, "y": 41.149754, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.634412, "y": 41.154892000000004, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota: [0, 10, 2, 1, 0]\\nDistância: 0.05 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "nearest_neighbor.py", "timestamp": "2025-06-11 17:59:35.393", "input_file": "input_20250611_175930_705017_1a8e38.json"}, {"input": {"nodes": [{"x": -8.630245, "y": 41.160408, "id": 0, "is_depot": true}, {"x": -8.62056, "y": 41.169250000000005, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639249000000001, "y": 41.149754, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.634412, "y": 41.154892000000004, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Roteamento: [[0, 1, 10, 2, 0]]\\nDistância total: 0.05 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "tabu_search.py", "timestamp": "2025-06-11 17:59:35.458", "input_file": "input_20250611_175930_705017_1a8e38.json"}, {"input": {"nodes": [{"x": -8.630245, "y": 41.160408, "id": 0, "is_depot": true}, {"x": -8.62056, "y": 41.169250000000005, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639249000000001, "y": 41.149754, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.634412, "y": 41.154892000000004, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota encontrada: [0, 10, 2, 1, 0]\\nCusto total: 0.05 km", "algoritmo": "grasp.py", "timestamp": "2025-06-11 17:59:35.540", "input_file": "input_20250611_175930_705017_1a8e38.json"}, {"input": {"nodes": [{"x": -8.630584, "y": 41.160399999999996, "id": 0, "is_depot": true}, {"x": -8.620752, "y": 41.169569, "id": 1, "service_time": 300}, {"x": -8.640030000000001, "y": 41.149164999999996, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635398, "y": 41.154677, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 510, "end_node": 0, "start_node": 0}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "", "algoritmo": "dijkstra.py", "timestamp": "2025-06-11 17:59:35.668", "input_file": "input_20250611_175930_749559_7f34ba.json"}, {"input": {"nodes": [{"x": -8.630584, "y": 41.160399999999996, "id": 0, "is_depot": true}, {"x": -8.620752, "y": 41.169569, "id": 1, "service_time": 300}, {"x": -8.640030000000001, "y": 41.149164999999996, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635398, "y": 41.154677, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 510, "end_node": 0, "start_node": 0}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Rota ótima: [0, 1, 2, 10, 0]\\nDistância total: 0.06 km", "algoritmo": "branch_and_bound.py", "timestamp": "2025-06-11 17:59:35.731", "input_file": "input_20250611_175930_749559_7f34ba.json"}, {"input": {"nodes": [{"x": -8.630584, "y": 41.160399999999996, "id": 0, "is_depot": true}, {"x": -8.620752, "y": 41.169569, "id": 1, "service_time": 300}, {"x": -8.640030000000001, "y": 41.149164999999996, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635398, "y": 41.154677, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 510, "end_node": 0, "start_node": 0}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "", "algoritmo": "savings.py", "timestamp": "2025-06-11 17:59:35.816", "input_file": "input_20250611_175930_749559_7f34ba.json"}, {"input": {"nodes": [{"x": -8.630584, "y": 41.160399999999996, "id": 0, "is_depot": true}, {"x": -8.620752, "y": 41.169569, "id": 1, "service_time": 300}, {"x": -8.640030000000001, "y": 41.149164999999996, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635398, "y": 41.154677, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 510, "end_node": 0, "start_node": 0}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "", "algoritmo": "nearest_neighbor.py", "timestamp": "2025-06-11 17:59:35.915", "input_file": "input_20250611_175930_749559_7f34ba.json"}, {"input": {"nodes": [{"x": -8.630584, "y": 41.160399999999996, "id": 0, "is_depot": true}, {"x": -8.620752, "y": 41.169569, "id": 1, "service_time": 300}, {"x": -8.640030000000001, "y": 41.149164999999996, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635398, "y": 41.154677, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "config": {"time_limit": 60, "tabu_tenure": 15}, "vehicles": [{"id": 1, "capacity": 510, "end_node": 0, "start_node": 0}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "", "algoritmo": "tabu_search.py", "timestamp": "2025-06-11 17:59:36.007", "input_file": "input_20250611_175930_749559_7f34ba.json"}, {"input": {"nodes": [{"x": -8.630584, "y": 41.160399999999996, "id": 0, "is_depot": true}, {"x": -8.620752, "y": 41.169569, "id": 1, "service_time": 300}, {"x": -8.640030000000001, "y": 41.149164999999996, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635398, "y": 41.154677, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "config": {"time_limit": 60, "tabu_tenure": 15}, "vehicles": [{"id": 1, "capacity": 510, "end_node": 0, "start_node": 0}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Rota encontrada: [0, 10, 2, 1, 0]\\nCusto total: 0.06 km", "algoritmo": "grasp.py", "timestamp": "2025-06-11 17:59:36.092", "input_file": "input_20250611_175930_749559_7f34ba.json"}, {"input": {"nodes": [{"x": -8.63, "y": 41.16, "id": 0, "is_depot": true}, {"x": -8.62, "y": 41.17, "id": 1, "demand": 100, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.64, "y": 41.15, "id": 2, "demand": 80, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635, "y": 41.155, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "end_id": 0, "start_id": 0, "vehicles": [{"id": 1, "capacity": 300, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "charger_power_kw": 50, "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]], "is_charging_station": true}, "output": "Caminho encontrado: [0]\\nDistância total: 0 km\\nEnergia estimada: 0.0 kWh", "algoritmo": "dijkstra.py", "timestamp": "2025-06-11 17:59:36.210", "input_file": "input_20250611_175930_798401_c3ea85.json"}, {"input": {"nodes": [{"x": -8.63, "y": 41.16, "id": 0, "is_depot": true}, {"x": -8.62, "y": 41.17, "id": 1, "demand": 100, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.64, "y": 41.15, "id": 2, "demand": 80, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635, "y": 41.155, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "demand": [0, 100, 80, 0], "vehicles": [{"id": 1, "capacity": 300, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "time_window": [[0, 86400], [28800, 39600], [32400, 45000], [0, 86400]], "service_time": [0, 300, 300, 0], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Rota ótima: [0, 1, 2, 10, 0]\\nDistância total: 0.06 km", "algoritmo": "branch_and_bound.py", "timestamp": "2025-06-11 17:59:36.290", "input_file": "input_20250611_175930_798401_c3ea85.json"}, {"input": {"nodes": [{"x": -8.63, "y": 41.16, "id": 0, "is_depot": true}, {"x": -8.62, "y": 41.17, "id": 1, "demand": 100, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.64, "y": 41.15, "id": 2, "demand": 80, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635, "y": 41.155, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "demand": [0, 100, 80, 0], "vehicles": [{"id": 1, "capacity": 300, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "time_window": [[0, 86400], [28800, 39600], [32400, 45000], [0, 86400]], "service_time": [0, 300, 300, 0], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Caminho encontrado: [0, 1, 2, 0]\\nDistância total: 0.06 km", "algoritmo": "savings.py", "timestamp": "2025-06-11 17:59:36.360", "input_file": "input_20250611_175930_798401_c3ea85.json"}, {"input": {"nodes": [{"x": -8.63, "y": 41.16, "id": 0, "is_depot": true}, {"x": -8.62, "y": 41.17, "id": 1, "demand": 100, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.64, "y": 41.15, "id": 2, "demand": 80, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635, "y": 41.155, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "demand": [0, 100, 80, 0], "vehicles": [{"id": 1, "capacity": 300, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "time_window": [[0, 86400], [28800, 39600], [32400, 45000], [0, 86400]], "service_time": [0, 300, 300, 0], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Rota: [0, 10, 2, 1, 0]\\nDistância: 0.06 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "nearest_neighbor.py", "timestamp": "2025-06-11 17:59:36.438", "input_file": "input_20250611_175930_798401_c3ea85.json"}, {"input": {"nodes": [{"x": -8.63, "y": 41.16, "id": 0, "is_depot": true}, {"x": -8.62, "y": 41.17, "id": 1, "demand": 100, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.64, "y": 41.15, "id": 2, "demand": 80, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635, "y": 41.155, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "config": {"time_limit": 60, "tabu_tenure": 10}, "demand": [0, 100, 80, 0], "end_id": 0, "start_id": 0, "vehicles": [{"id": 1, "capacity": 300, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "time_window": [[0, 86400], [28800, 39600], [32400, 45000], [0, 86400]], "service_time": [0, 300, 300, 0], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "charger_power_kw": 50, "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]], "is_charging_station": true}, "output": "Roteamento: [[0, 1, 2, 10, 0]]\\nDistância total: 0.06 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "tabu_search.py", "timestamp": "2025-06-11 17:59:36.513", "input_file": "input_20250611_175930_798401_c3ea85.json"}, {"input": {"nodes": [{"x": -8.63, "y": 41.16, "id": 0, "is_depot": true}, {"x": -8.62, "y": 41.17, "id": 1, "demand": 100, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.64, "y": 41.15, "id": 2, "demand": 80, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635, "y": 41.155, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "config": {"time_limit": 60, "tabu_tenure": 10}, "demand": [0, 100, 80, 0], "end_id": 0, "start_id": 0, "vehicles": [{"id": 1, "capacity": 300, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "time_window": [[0, 86400], [28800, 39600], [32400, 45000], [0, 86400]], "service_time": [0, 300, 300, 0], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "charger_power_kw": 50, "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]], "is_charging_station": true}, "output": "Rota encontrada: [0, 10, 2, 1, 0]\\nCusto total: 0.06 km", "algoritmo": "grasp.py", "timestamp": "2025-06-11 17:59:36.597", "input_file": "input_20250611_175930_798401_c3ea85.json"}, {"input": {"nodes": [{"x": -8.63, "y": 41.16, "id": 0, "is_depot": true}, {"x": -8.62, "y": 41.17, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.64, "y": 41.15, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635, "y": 41.155, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 500, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Caminho encontrado: [0]\\nDistância total: 0.01 km\\nEnergia estimada: 0.0 kWh", "algoritmo": "dijkstra.py", "timestamp": "2025-06-11 17:59:36.711", "input_file": "input_20250611_175930_843738_28be7a.json"}, {"input": {"nodes": [{"x": -8.63, "y": 41.16, "id": 0, "is_depot": true}, {"x": -8.62, "y": 41.17, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.64, "y": 41.15, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635, "y": 41.155, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 500, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Rota ótima: [0, 1, 2, 10, 0]\\nDistância total: 0.06 km", "algoritmo": "branch_and_bound.py", "timestamp": "2025-06-11 17:59:36.774", "input_file": "input_20250611_175930_843738_28be7a.json"}, {"input": {"nodes": [{"x": -8.63, "y": 41.16, "id": 0, "is_depot": true}, {"x": -8.62, "y": 41.17, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.64, "y": 41.15, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635, "y": 41.155, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 500, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Caminho encontrado: [0, 1, 2, 0]\\nDistância total: 0.06 km", "algoritmo": "savings.py", "timestamp": "2025-06-11 17:59:36.842", "input_file": "input_20250611_175930_843738_28be7a.json"}, {"input": {"nodes": [{"x": -8.63, "y": 41.16, "id": 0, "is_depot": true}, {"x": -8.62, "y": 41.17, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.64, "y": 41.15, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635, "y": 41.155, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 500, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Rota: [0, 10, 2, 1, 0]\\nDistância: 0.06 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "nearest_neighbor.py", "timestamp": "2025-06-11 17:59:36.922", "input_file": "input_20250611_175930_843738_28be7a.json"}, {"input": {"nodes": [{"x": -8.63, "y": 41.16, "id": 0, "is_depot": true}, {"x": -8.62, "y": 41.17, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.64, "y": 41.15, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635, "y": 41.155, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "config": {"time_limit": 60, "tabu_tenure": 15}, "vehicles": [{"id": 1, "capacity": 500, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Roteamento: [[0, 1, 2, 10, 0]]\\nDistância total: 0.06 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "tabu_search.py", "timestamp": "2025-06-11 17:59:36.998", "input_file": "input_20250611_175930_843738_28be7a.json"}, {"input": {"nodes": [{"x": -8.63, "y": 41.16, "id": 0, "is_depot": true}, {"x": -8.62, "y": 41.17, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.64, "y": 41.15, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635, "y": 41.155, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "config": {"time_limit": 60, "tabu_tenure": 15}, "vehicles": [{"id": 1, "capacity": 500, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Rota encontrada: [0, 10, 2, 1, 0]\\nCusto total: 0.06 km", "algoritmo": "grasp.py", "timestamp": "2025-06-11 17:59:37.084", "input_file": "input_20250611_175930_843738_28be7a.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Caminho encontrado: [0]\\nDistância total: 0.01 km\\nEnergia estimada: 0.0 kWh", "algoritmo": "dijkstra.py", "timestamp": "2025-06-11 17:59:37.180", "input_file": "input_20250611_175930_892935_61faf0.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota ótima: [0, 1, 2, 10, 0]\\nDistância total: 0.05 km", "algoritmo": "branch_and_bound.py", "timestamp": "2025-06-11 17:59:37.244", "input_file": "input_20250611_175930_892935_61faf0.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Caminho encontrado: [0, 1, 0]\\nDistância total: 0.03 km", "algoritmo": "savings.py", "timestamp": "2025-06-11 17:59:37.315", "input_file": "input_20250611_175930_892935_61faf0.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota: [0, 10, 2, 1, 0]\\nDistância: 0.05 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "nearest_neighbor.py", "timestamp": "2025-06-11 17:59:37.397", "input_file": "input_20250611_175930_892935_61faf0.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Roteamento: [[0, 1, 2, 10, 0]]\\nDistância total: 0.05 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "tabu_search.py", "timestamp": "2025-06-11 17:59:37.463", "input_file": "input_20250611_175930_892935_61faf0.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota encontrada: [0, 10, 2, 1, 0]\\nCusto total: 0.05 km", "algoritmo": "grasp.py", "timestamp": "2025-06-11 17:59:37.561", "input_file": "input_20250611_175930_892935_61faf0.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Caminho encontrado: [0]\\nDistância total: 0.01 km\\nEnergia estimada: 0.0 kWh", "algoritmo": "dijkstra.py", "timestamp": "2025-06-11 18:00:42.989", "input_file": "input_20250611_180042_012129_052126.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota ótima: [0, 1, 2, 10, 0]\\nDistância total: 0.05 km", "algoritmo": "branch_and_bound.py", "timestamp": "2025-06-11 18:00:43.052", "input_file": "input_20250611_180042_012129_052126.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Caminho encontrado: [0, 1, 0]\\nDistância total: 0.03 km", "algoritmo": "savings.py", "timestamp": "2025-06-11 18:00:43.121", "input_file": "input_20250611_180042_012129_052126.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota: [0, 10, 2, 1, 0]\\nDistância: 0.05 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "nearest_neighbor.py", "timestamp": "2025-06-11 18:00:43.204", "input_file": "input_20250611_180042_012129_052126.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Roteamento: [[0, 1, 2, 10, 0]]\\nDistância total: 0.05 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "tabu_search.py", "timestamp": "2025-06-11 18:00:43.268", "input_file": "input_20250611_180042_012129_052126.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota encontrada: [0, 10, 2, 1, 0]\\nCusto total: 0.05 km", "algoritmo": "grasp.py", "timestamp": "2025-06-11 18:00:43.357", "input_file": "input_20250611_180042_012129_052126.json"}, {"input": {"nodes": [{"x": -8.63062, "y": 41.159744999999994, "id": 0, "is_depot": true}, {"x": -8.620659999999999, "y": 41.170639, "id": 1, "demand": 200, "time_window": [28800, 39600]}, {"x": -8.64004, "y": 41.149558, "id": 2}, {"x": -8.635465, "y": 41.154031, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 542, "end_node": 0, "start_node": 0, "battery_kwh": 70}]}, "output": "Caminho encontrado: [0]\\nDistância total: 0.01 km\\nEnergia estimada: 0.0 kWh", "algoritmo": "dijkstra.py", "timestamp": "2025-06-11 18:00:43.457", "input_file": "input_20250611_180042_072016_afe6e7.json"}, {"input": {"nodes": [{"x": -8.63062, "y": 41.159744999999994, "id": 0, "is_depot": true}, {"x": -8.620659999999999, "y": 41.170639, "id": 1, "demand": 200, "time_window": [28800, 39600]}, {"x": -8.64004, "y": 41.149558, "id": 2}, {"x": -8.635465, "y": 41.154031, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 542, "end_node": 0, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota ótima: [0, 1, 10, 2, 0]\\nDistância total: 0.06 km", "algoritmo": "branch_and_bound.py", "timestamp": "2025-06-11 18:00:43.520", "input_file": "input_20250611_180042_072016_afe6e7.json"}, {"input": {"nodes": [{"x": -8.63062, "y": 41.159744999999994, "id": 0, "is_depot": true}, {"x": -8.620659999999999, "y": 41.170639, "id": 1, "demand": 200, "time_window": [28800, 39600]}, {"x": -8.64004, "y": 41.149558, "id": 2}, {"x": -8.635465, "y": 41.154031, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 542, "end_node": 0, "start_node": 0, "battery_kwh": 70}]}, "output": "Caminho encontrado: [0, 1, 0]\\nDistância total: 0.03 km", "algoritmo": "savings.py", "timestamp": "2025-06-11 18:00:43.617", "input_file": "input_20250611_180042_072016_afe6e7.json"}, {"input": {"nodes": [{"x": -8.63062, "y": 41.159744999999994, "id": 0, "is_depot": true}, {"x": -8.620659999999999, "y": 41.170639, "id": 1, "demand": 200, "time_window": [28800, 39600]}, {"x": -8.64004, "y": 41.149558, "id": 2}, {"x": -8.635465, "y": 41.154031, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 542, "end_node": 0, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota: [0, 10, 2, 1, 0]\\nDistância: 0.06 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "nearest_neighbor.py", "timestamp": "2025-06-11 18:00:43.787", "input_file": "input_20250611_180042_072016_afe6e7.json"}, {"input": {"nodes": [{"x": -8.63062, "y": 41.159744999999994, "id": 0, "is_depot": true}, {"x": -8.620659999999999, "y": 41.170639, "id": 1, "demand": 200, "time_window": [28800, 39600]}, {"x": -8.64004, "y": 41.149558, "id": 2}, {"x": -8.635465, "y": 41.154031, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 542, "end_node": 0, "start_node": 0, "battery_kwh": 70}]}, "output": "Roteamento: [[0, 1, 10, 2, 0]]\\nDistância total: 0.06 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "tabu_search.py", "timestamp": "2025-06-11 18:00:43.866", "input_file": "input_20250611_180042_072016_afe6e7.json"}, {"input": {"nodes": [{"x": -8.63062, "y": 41.159744999999994, "id": 0, "is_depot": true}, {"x": -8.620659999999999, "y": 41.170639, "id": 1, "demand": 200, "time_window": [28800, 39600]}, {"x": -8.64004, "y": 41.149558, "id": 2}, {"x": -8.635465, "y": 41.154031, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 542, "end_node": 0, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota encontrada: [0, 10, 2, 1, 0]\\nCusto total: 0.06 km", "algoritmo": "grasp.py", "timestamp": "2025-06-11 18:00:43.951", "input_file": "input_20250611_180042_072016_afe6e7.json"}, {"input": {"nodes": [{"x": -8.629290000000001, "y": 41.159439, "id": 0, "is_depot": true}, {"x": -8.62093, "y": 41.169368, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639674000000001, "y": 41.14991, "id": 2, "demand": 150, "service_time": 300}, {"x": -8.635093, "y": 41.154154, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 482, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Caminho encontrado: [0]\\nDistância total: 0.01 km\\nEnergia estimada: 0.0 kWh", "algoritmo": "dijkstra.py", "timestamp": "2025-06-11 18:00:44.051", "input_file": "input_20250611_180042_126786_c3b6e7.json"}, {"input": {"nodes": [{"x": -8.629290000000001, "y": 41.159439, "id": 0, "is_depot": true}, {"x": -8.62093, "y": 41.169368, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639674000000001, "y": 41.14991, "id": 2, "demand": 150, "service_time": 300}, {"x": -8.635093, "y": 41.154154, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 482, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Rota ótima: [0, 1, 2, 10, 0]\\nDistância total: 0.05 km", "algoritmo": "branch_and_bound.py", "timestamp": "2025-06-11 18:00:44.120", "input_file": "input_20250611_180042_126786_c3b6e7.json"}, {"input": {"nodes": [{"x": -8.629290000000001, "y": 41.159439, "id": 0, "is_depot": true}, {"x": -8.62093, "y": 41.169368, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639674000000001, "y": 41.14991, "id": 2, "demand": 150, "service_time": 300}, {"x": -8.635093, "y": 41.154154, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 482, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Caminho encontrado: [0, 1, 2, 0]\\nDistância total: 0.05 km", "algoritmo": "savings.py", "timestamp": "2025-06-11 18:00:44.188", "input_file": "input_20250611_180042_126786_c3b6e7.json"}, {"input": {"nodes": [{"x": -8.629290000000001, "y": 41.159439, "id": 0, "is_depot": true}, {"x": -8.62093, "y": 41.169368, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639674000000001, "y": 41.14991, "id": 2, "demand": 150, "service_time": 300}, {"x": -8.635093, "y": 41.154154, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 482, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Rota: [0, 10, 2, 1, 0]\\nDistância: 0.05 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "nearest_neighbor.py", "timestamp": "2025-06-11 18:00:44.268", "input_file": "input_20250611_180042_126786_c3b6e7.json"}, {"input": {"nodes": [{"x": -8.629290000000001, "y": 41.159439, "id": 0, "is_depot": true}, {"x": -8.62093, "y": 41.169368, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639674000000001, "y": 41.14991, "id": 2, "demand": 150, "service_time": 300}, {"x": -8.635093, "y": 41.154154, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "config": {"time_limit": 60, "tabu_tenure": 15}, "vehicles": [{"id": 1, "capacity": 482, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Roteamento: [[0, 1, 2, 10, 0]]\\nDistância total: 0.05 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "tabu_search.py", "timestamp": "2025-06-11 18:00:44.332", "input_file": "input_20250611_180042_126786_c3b6e7.json"}, {"input": {"nodes": [{"x": -8.629290000000001, "y": 41.159439, "id": 0, "is_depot": true}, {"x": -8.62093, "y": 41.169368, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639674000000001, "y": 41.14991, "id": 2, "demand": 150, "service_time": 300}, {"x": -8.635093, "y": 41.154154, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "config": {"time_limit": 60, "tabu_tenure": 15}, "vehicles": [{"id": 1, "capacity": 482, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Rota encontrada: [0, 10, 2, 1, 0]\\nCusto total: 0.05 km", "algoritmo": "grasp.py", "timestamp": "2025-06-11 18:00:44.413", "input_file": "input_20250611_180042_126786_c3b6e7.json"}, {"input": {"nodes": [{"x": -8.629090000000001, "y": 41.159751, "id": 0, "is_depot": true}, {"x": -8.619287, "y": 41.170083, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.640284000000001, "y": 41.149693, "id": 2, "demand": 150}, {"x": -8.635999, "y": 41.155701, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 513, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Caminho encontrado: [0]\\nDistância total: 0.01 km\\nEnergia estimada: 0.0 kWh", "algoritmo": "dijkstra.py", "timestamp": "2025-06-11 18:00:44.509", "input_file": "input_20250611_180042_187017_669953.json"}, {"input": {"nodes": [{"x": -8.629090000000001, "y": 41.159751, "id": 0, "is_depot": true}, {"x": -8.619287, "y": 41.170083, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.640284000000001, "y": 41.149693, "id": 2, "demand": 150}, {"x": -8.635999, "y": 41.155701, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 513, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota ótima: [0, 1, 10, 2, 0]\\nDistância total: 0.06 km", "algoritmo": "branch_and_bound.py", "timestamp": "2025-06-11 18:00:44.571", "input_file": "input_20250611_180042_187017_669953.json"}, {"input": {"nodes": [{"x": -8.629090000000001, "y": 41.159751, "id": 0, "is_depot": true}, {"x": -8.619287, "y": 41.170083, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.640284000000001, "y": 41.149693, "id": 2, "demand": 150}, {"x": -8.635999, "y": 41.155701, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 513, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Caminho encontrado: [0, 1, 2, 0]\\nDistância total: 0.06 km", "algoritmo": "savings.py", "timestamp": "2025-06-11 18:00:44.637", "input_file": "input_20250611_180042_187017_669953.json"}, {"input": {"nodes": [{"x": -8.629090000000001, "y": 41.159751, "id": 0, "is_depot": true}, {"x": -8.619287, "y": 41.170083, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.640284000000001, "y": 41.149693, "id": 2, "demand": 150}, {"x": -8.635999, "y": 41.155701, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 513, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota: [0, 10, 2, 1, 0]\\nDistância: 0.06 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "nearest_neighbor.py", "timestamp": "2025-06-11 18:00:44.715", "input_file": "input_20250611_180042_187017_669953.json"}, {"input": {"nodes": [{"x": -8.629090000000001, "y": 41.159751, "id": 0, "is_depot": true}, {"x": -8.619287, "y": 41.170083, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.640284000000001, "y": 41.149693, "id": 2, "demand": 150}, {"x": -8.635999, "y": 41.155701, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 513, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Roteamento: [[0, 1, 10, 2, 0]]\\nDistância total: 0.06 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "tabu_search.py", "timestamp": "2025-06-11 18:00:44.779", "input_file": "input_20250611_180042_187017_669953.json"}, {"input": {"nodes": [{"x": -8.629090000000001, "y": 41.159751, "id": 0, "is_depot": true}, {"x": -8.619287, "y": 41.170083, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.640284000000001, "y": 41.149693, "id": 2, "demand": 150}, {"x": -8.635999, "y": 41.155701, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 513, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota encontrada: [0, 10, 2, 1, 0]\\nCusto total: 0.06 km", "algoritmo": "grasp.py", "timestamp": "2025-06-11 18:00:44.865", "input_file": "input_20250611_180042_187017_669953.json"}, {"input": {"nodes": [{"x": -8.629134, "y": 41.160951999999995, "id": 0, "is_depot": true}, {"x": -8.620451, "y": 41.170649000000004, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.639610000000001, "y": 41.149675, "id": 2, "demand": 150}, {"x": -8.63503, "y": 41.154454, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 529, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Caminho encontrado: [0]\\nDistância total: 0.01 km\\nEnergia estimada: 0.0 kWh", "algoritmo": "dijkstra.py", "timestamp": "2025-06-11 18:00:44.990", "input_file": "input_20250611_180042_246972_5630d6.json"}, {"input": {"nodes": [{"x": -8.629134, "y": 41.160951999999995, "id": 0, "is_depot": true}, {"x": -8.620451, "y": 41.170649000000004, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.639610000000001, "y": 41.149675, "id": 2, "demand": 150}, {"x": -8.63503, "y": 41.154454, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 529, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota ótima: [0, 1, 2, 10, 0]\\nDistância total: 0.06 km", "algoritmo": "branch_and_bound.py", "timestamp": "2025-06-11 18:00:45.073", "input_file": "input_20250611_180042_246972_5630d6.json"}, {"input": {"nodes": [{"x": -8.629134, "y": 41.160951999999995, "id": 0, "is_depot": true}, {"x": -8.620451, "y": 41.170649000000004, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.639610000000001, "y": 41.149675, "id": 2, "demand": 150}, {"x": -8.63503, "y": 41.154454, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 529, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Caminho encontrado: [0, 1, 2, 0]\\nDistância total: 0.06 km", "algoritmo": "savings.py", "timestamp": "2025-06-11 18:00:45.150", "input_file": "input_20250611_180042_246972_5630d6.json"}, {"input": {"nodes": [{"x": -8.629134, "y": 41.160951999999995, "id": 0, "is_depot": true}, {"x": -8.620451, "y": 41.170649000000004, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.639610000000001, "y": 41.149675, "id": 2, "demand": 150}, {"x": -8.63503, "y": 41.154454, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 529, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota: [0, 10, 2, 1, 0]\\nDistância: 0.06 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "nearest_neighbor.py", "timestamp": "2025-06-11 18:00:45.230", "input_file": "input_20250611_180042_246972_5630d6.json"}, {"input": {"nodes": [{"x": -8.629134, "y": 41.160951999999995, "id": 0, "is_depot": true}, {"x": -8.620451, "y": 41.170649000000004, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.639610000000001, "y": 41.149675, "id": 2, "demand": 150}, {"x": -8.63503, "y": 41.154454, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 529, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Roteamento: [[0, 1, 2, 10, 0]]\\nDistância total: 0.06 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "tabu_search.py", "timestamp": "2025-06-11 18:00:45.300", "input_file": "input_20250611_180042_246972_5630d6.json"}, {"input": {"nodes": [{"x": -8.629134, "y": 41.160951999999995, "id": 0, "is_depot": true}, {"x": -8.620451, "y": 41.170649000000004, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.639610000000001, "y": 41.149675, "id": 2, "demand": 150}, {"x": -8.63503, "y": 41.154454, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 529, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota encontrada: [0, 10, 2, 1, 0]\\nCusto total: 0.06 km", "algoritmo": "grasp.py", "timestamp": "2025-06-11 18:00:45.393", "input_file": "input_20250611_180042_246972_5630d6.json"}, {"input": {"nodes": [{"x": -8.630600000000001, "y": 41.16018699999999, "id": 0, "is_depot": true}, {"x": -8.620757, "y": 41.170898, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.639717000000001, "y": 41.149474999999995, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635965, "y": 41.155971, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 465, "end_node": 0, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Caminho encontrado: [0]\\nDistância total: 0.01 km\\nEnergia estimada: 0.0 kWh", "algoritmo": "dijkstra.py", "timestamp": "2025-06-11 18:00:45.497", "input_file": "input_20250611_180042_309300_0cda8d.json"}, {"input": {"nodes": [{"x": -8.630600000000001, "y": 41.16018699999999, "id": 0, "is_depot": true}, {"x": -8.620757, "y": 41.170898, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.639717000000001, "y": 41.149474999999995, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635965, "y": 41.155971, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 465, "end_node": 0, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Rota ótima: [0, 1, 10, 2, 0]\\nDistância total: 0.06 km", "algoritmo": "branch_and_bound.py", "timestamp": "2025-06-11 18:00:45.558", "input_file": "input_20250611_180042_309300_0cda8d.json"}, {"input": {"nodes": [{"x": -8.630600000000001, "y": 41.16018699999999, "id": 0, "is_depot": true}, {"x": -8.620757, "y": 41.170898, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.639717000000001, "y": 41.149474999999995, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635965, "y": 41.155971, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 465, "end_node": 0, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Caminho encontrado: [0, 1, 2, 0]\\nDistância total: 0.06 km", "algoritmo": "savings.py", "timestamp": "2025-06-11 18:00:45.633", "input_file": "input_20250611_180042_309300_0cda8d.json"}, {"input": {"nodes": [{"x": -8.630600000000001, "y": 41.16018699999999, "id": 0, "is_depot": true}, {"x": -8.620757, "y": 41.170898, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.639717000000001, "y": 41.149474999999995, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635965, "y": 41.155971, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 465, "end_node": 0, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Rota: [0, 10, 2, 1, 0]\\nDistância: 0.06 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "nearest_neighbor.py", "timestamp": "2025-06-11 18:00:45.719", "input_file": "input_20250611_180042_309300_0cda8d.json"}, {"input": {"nodes": [{"x": -8.630600000000001, "y": 41.16018699999999, "id": 0, "is_depot": true}, {"x": -8.620757, "y": 41.170898, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.639717000000001, "y": 41.149474999999995, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635965, "y": 41.155971, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "config": {"time_limit": 60, "tabu_tenure": 15}, "vehicles": [{"id": 1, "capacity": 465, "end_node": 0, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Roteamento: [[0, 1, 10, 2, 0]]\\nDistância total: 0.06 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "tabu_search.py", "timestamp": "2025-06-11 18:00:45.783", "input_file": "input_20250611_180042_309300_0cda8d.json"}, {"input": {"nodes": [{"x": -8.630600000000001, "y": 41.16018699999999, "id": 0, "is_depot": true}, {"x": -8.620757, "y": 41.170898, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.639717000000001, "y": 41.149474999999995, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635965, "y": 41.155971, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "config": {"time_limit": 60, "tabu_tenure": 15}, "vehicles": [{"id": 1, "capacity": 465, "end_node": 0, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Rota encontrada: [0, 10, 2, 1, 0]\\nCusto total: 0.06 km", "algoritmo": "grasp.py", "timestamp": "2025-06-11 18:00:45.866", "input_file": "input_20250611_180042_309300_0cda8d.json"}, {"input": {"nodes": [{"x": -8.630618, "y": 41.160377, "id": 0, "is_depot": true}, {"x": -8.619323, "y": 41.169292, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.640521000000001, "y": 41.150453, "id": 2, "demand": 150}, {"x": -8.63557, "y": 41.15417, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 542, "end_node": 0, "start_node": 0}]}, "output": "", "algoritmo": "dijkstra.py", "timestamp": "2025-06-11 18:00:45.986", "input_file": "input_20250611_180042_380858_7f62cf.json"}, {"input": {"nodes": [{"x": -8.630618, "y": 41.160377, "id": 0, "is_depot": true}, {"x": -8.619323, "y": 41.169292, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.640521000000001, "y": 41.150453, "id": 2, "demand": 150}, {"x": -8.63557, "y": 41.15417, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 542, "end_node": 0, "start_node": 0}]}, "output": "Rota ótima: [0, 1, 10, 2, 0]\\nDistância total: 0.06 km", "algoritmo": "branch_and_bound.py", "timestamp": "2025-06-11 18:00:46.051", "input_file": "input_20250611_180042_380858_7f62cf.json"}, {"input": {"nodes": [{"x": -8.630618, "y": 41.160377, "id": 0, "is_depot": true}, {"x": -8.619323, "y": 41.169292, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.640521000000001, "y": 41.150453, "id": 2, "demand": 150}, {"x": -8.63557, "y": 41.15417, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 542, "end_node": 0, "start_node": 0}]}, "output": "", "algoritmo": "savings.py", "timestamp": "2025-06-11 18:00:46.140", "input_file": "input_20250611_180042_380858_7f62cf.json"}, {"input": {"nodes": [{"x": -8.630618, "y": 41.160377, "id": 0, "is_depot": true}, {"x": -8.619323, "y": 41.169292, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.640521000000001, "y": 41.150453, "id": 2, "demand": 150}, {"x": -8.63557, "y": 41.15417, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 542, "end_node": 0, "start_node": 0}]}, "output": "", "algoritmo": "nearest_neighbor.py", "timestamp": "2025-06-11 18:00:46.237", "input_file": "input_20250611_180042_380858_7f62cf.json"}, {"input": {"nodes": [{"x": -8.630618, "y": 41.160377, "id": 0, "is_depot": true}, {"x": -8.619323, "y": 41.169292, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.640521000000001, "y": 41.150453, "id": 2, "demand": 150}, {"x": -8.63557, "y": 41.15417, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 542, "end_node": 0, "start_node": 0}]}, "output": "", "algoritmo": "tabu_search.py", "timestamp": "2025-06-11 18:00:46.328", "input_file": "input_20250611_180042_380858_7f62cf.json"}, {"input": {"nodes": [{"x": -8.630618, "y": 41.160377, "id": 0, "is_depot": true}, {"x": -8.619323, "y": 41.169292, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.640521000000001, "y": 41.150453, "id": 2, "demand": 150}, {"x": -8.63557, "y": 41.15417, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 542, "end_node": 0, "start_node": 0}]}, "output": "Rota encontrada: [0, 10, 2, 1, 0]\\nCusto total: 0.06 km", "algoritmo": "grasp.py", "timestamp": "2025-06-11 18:00:46.425", "input_file": "input_20250611_180042_380858_7f62cf.json"}, {"input": {"nodes": [{"x": -8.630416, "y": 41.159955, "id": 0, "is_depot": true}, {"x": -8.619769, "y": 41.169702, "id": 1, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.640294, "y": 41.150850999999996, "id": 2, "demand": 150}, {"x": -8.63561, "y": 41.155334, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 533, "end_node": 0, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Caminho encontrado: [0]\\nDistância total: 0.01 km\\nEnergia estimada: 0.0 kWh", "algoritmo": "dijkstra.py", "timestamp": "2025-06-11 18:00:46.522", "input_file": "input_20250611_180042_438295_8dd0bf.json"}, {"input": {"nodes": [{"x": -8.630416, "y": 41.159955, "id": 0, "is_depot": true}, {"x": -8.619769, "y": 41.169702, "id": 1, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.640294, "y": 41.150850999999996, "id": 2, "demand": 150}, {"x": -8.63561, "y": 41.155334, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 533, "end_node": 0, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Rota ótima: [0, 1, 10, 2, 0]\\nDistância total: 0.06 km", "algoritmo": "branch_and_bound.py", "timestamp": "2025-06-11 18:00:46.581", "input_file": "input_20250611_180042_438295_8dd0bf.json"}, {"input": {"nodes": [{"x": -8.630416, "y": 41.159955, "id": 0, "is_depot": true}, {"x": -8.619769, "y": 41.169702, "id": 1, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.640294, "y": 41.150850999999996, "id": 2, "demand": 150}, {"x": -8.63561, "y": 41.155334, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 533, "end_node": 0, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Caminho encontrado: [0, 2, 0]\\nDistância total: 0.03 km", "algoritmo": "savings.py", "timestamp": "2025-06-11 18:00:46.649", "input_file": "input_20250611_180042_438295_8dd0bf.json"}, {"input": {"nodes": [{"x": -8.630416, "y": 41.159955, "id": 0, "is_depot": true}, {"x": -8.619769, "y": 41.169702, "id": 1, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.640294, "y": 41.150850999999996, "id": 2, "demand": 150}, {"x": -8.63561, "y": 41.155334, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 533, "end_node": 0, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Rota: [0, 10, 2, 1, 0]\\nDistância: 0.06 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "nearest_neighbor.py", "timestamp": "2025-06-11 18:00:46.734", "input_file": "input_20250611_180042_438295_8dd0bf.json"}, {"input": {"nodes": [{"x": -8.630416, "y": 41.159955, "id": 0, "is_depot": true}, {"x": -8.619769, "y": 41.169702, "id": 1, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.640294, "y": 41.150850999999996, "id": 2, "demand": 150}, {"x": -8.63561, "y": 41.155334, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "config": {"time_limit": 60, "tabu_tenure": 15}, "vehicles": [{"id": 1, "capacity": 533, "end_node": 0, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Roteamento: [[0, 1, 10, 2, 0]]\\nDistância total: 0.06 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "tabu_search.py", "timestamp": "2025-06-11 18:00:46.803", "input_file": "input_20250611_180042_438295_8dd0bf.json"}, {"input": {"nodes": [{"x": -8.630416, "y": 41.159955, "id": 0, "is_depot": true}, {"x": -8.619769, "y": 41.169702, "id": 1, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.640294, "y": 41.150850999999996, "id": 2, "demand": 150}, {"x": -8.63561, "y": 41.155334, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "config": {"time_limit": 60, "tabu_tenure": 15}, "vehicles": [{"id": 1, "capacity": 533, "end_node": 0, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Rota encontrada: [0, 10, 2, 1, 0]\\nCusto total: 0.06 km", "algoritmo": "grasp.py", "timestamp": "2025-06-11 18:00:46.890", "input_file": "input_20250611_180042_438295_8dd0bf.json"}, {"input": {"nodes": [{"x": -8.630245, "y": 41.160408, "id": 0, "is_depot": true}, {"x": -8.62056, "y": 41.169250000000005, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639249000000001, "y": 41.149754, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.634412, "y": 41.154892000000004, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Caminho encontrado: [0]\\nDistância total: 0.01 km\\nEnergia estimada: 0.0 kWh", "algoritmo": "dijkstra.py", "timestamp": "2025-06-11 18:00:46.991", "input_file": "input_20250611_180042_496422_68f0e6.json"}, {"input": {"nodes": [{"x": -8.630245, "y": 41.160408, "id": 0, "is_depot": true}, {"x": -8.62056, "y": 41.169250000000005, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639249000000001, "y": 41.149754, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.634412, "y": 41.154892000000004, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota ótima: [0, 1, 10, 2, 0]\\nDistância total: 0.05 km", "algoritmo": "branch_and_bound.py", "timestamp": "2025-06-11 18:00:47.058", "input_file": "input_20250611_180042_496422_68f0e6.json"}, {"input": {"nodes": [{"x": -8.630245, "y": 41.160408, "id": 0, "is_depot": true}, {"x": -8.62056, "y": 41.169250000000005, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639249000000001, "y": 41.149754, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.634412, "y": 41.154892000000004, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Caminho encontrado: [0, 1, 2, 0]\\nDistância total: 0.05 km", "algoritmo": "savings.py", "timestamp": "2025-06-11 18:00:47.132", "input_file": "input_20250611_180042_496422_68f0e6.json"}, {"input": {"nodes": [{"x": -8.630245, "y": 41.160408, "id": 0, "is_depot": true}, {"x": -8.62056, "y": 41.169250000000005, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639249000000001, "y": 41.149754, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.634412, "y": 41.154892000000004, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota: [0, 10, 2, 1, 0]\\nDistância: 0.05 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "nearest_neighbor.py", "timestamp": "2025-06-11 18:00:47.210", "input_file": "input_20250611_180042_496422_68f0e6.json"}, {"input": {"nodes": [{"x": -8.630245, "y": 41.160408, "id": 0, "is_depot": true}, {"x": -8.62056, "y": 41.169250000000005, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639249000000001, "y": 41.149754, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.634412, "y": 41.154892000000004, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Roteamento: [[0, 1, 10, 2, 0]]\\nDistância total: 0.05 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "tabu_search.py", "timestamp": "2025-06-11 18:00:47.274", "input_file": "input_20250611_180042_496422_68f0e6.json"}, {"input": {"nodes": [{"x": -8.630245, "y": 41.160408, "id": 0, "is_depot": true}, {"x": -8.62056, "y": 41.169250000000005, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639249000000001, "y": 41.149754, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.634412, "y": 41.154892000000004, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota encontrada: [0, 10, 2, 1, 0]\\nCusto total: 0.05 km", "algoritmo": "grasp.py", "timestamp": "2025-06-11 18:00:47.358", "input_file": "input_20250611_180042_496422_68f0e6.json"}, {"input": {"nodes": [{"x": -8.630584, "y": 41.160399999999996, "id": 0, "is_depot": true}, {"x": -8.620752, "y": 41.169569, "id": 1, "service_time": 300}, {"x": -8.640030000000001, "y": 41.149164999999996, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635398, "y": 41.154677, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 510, "end_node": 0, "start_node": 0}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "", "algoritmo": "dijkstra.py", "timestamp": "2025-06-11 18:00:47.488", "input_file": "input_20250611_180042_554676_08eca5.json"}, {"input": {"nodes": [{"x": -8.630584, "y": 41.160399999999996, "id": 0, "is_depot": true}, {"x": -8.620752, "y": 41.169569, "id": 1, "service_time": 300}, {"x": -8.640030000000001, "y": 41.149164999999996, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635398, "y": 41.154677, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 510, "end_node": 0, "start_node": 0}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Rota ótima: [0, 1, 2, 10, 0]\\nDistância total: 0.06 km", "algoritmo": "branch_and_bound.py", "timestamp": "2025-06-11 18:00:47.548", "input_file": "input_20250611_180042_554676_08eca5.json"}, {"input": {"nodes": [{"x": -8.630584, "y": 41.160399999999996, "id": 0, "is_depot": true}, {"x": -8.620752, "y": 41.169569, "id": 1, "service_time": 300}, {"x": -8.640030000000001, "y": 41.149164999999996, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635398, "y": 41.154677, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 510, "end_node": 0, "start_node": 0}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "", "algoritmo": "savings.py", "timestamp": "2025-06-11 18:00:47.641", "input_file": "input_20250611_180042_554676_08eca5.json"}, {"input": {"nodes": [{"x": -8.630584, "y": 41.160399999999996, "id": 0, "is_depot": true}, {"x": -8.620752, "y": 41.169569, "id": 1, "service_time": 300}, {"x": -8.640030000000001, "y": 41.149164999999996, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635398, "y": 41.154677, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 510, "end_node": 0, "start_node": 0}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "", "algoritmo": "nearest_neighbor.py", "timestamp": "2025-06-11 18:00:47.762", "input_file": "input_20250611_180042_554676_08eca5.json"}, {"input": {"nodes": [{"x": -8.630584, "y": 41.160399999999996, "id": 0, "is_depot": true}, {"x": -8.620752, "y": 41.169569, "id": 1, "service_time": 300}, {"x": -8.640030000000001, "y": 41.149164999999996, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635398, "y": 41.154677, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "config": {"time_limit": 60, "tabu_tenure": 15}, "vehicles": [{"id": 1, "capacity": 510, "end_node": 0, "start_node": 0}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "", "algoritmo": "tabu_search.py", "timestamp": "2025-06-11 18:00:47.841", "input_file": "input_20250611_180042_554676_08eca5.json"}, {"input": {"nodes": [{"x": -8.630584, "y": 41.160399999999996, "id": 0, "is_depot": true}, {"x": -8.620752, "y": 41.169569, "id": 1, "service_time": 300}, {"x": -8.640030000000001, "y": 41.149164999999996, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635398, "y": 41.154677, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "config": {"time_limit": 60, "tabu_tenure": 15}, "vehicles": [{"id": 1, "capacity": 510, "end_node": 0, "start_node": 0}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Rota encontrada: [0, 10, 2, 1, 0]\\nCusto total: 0.06 km", "algoritmo": "grasp.py", "timestamp": "2025-06-11 18:00:47.921", "input_file": "input_20250611_180042_554676_08eca5.json"}, {"input": {"nodes": [{"x": -8.63, "y": 41.16, "id": 0, "is_depot": true}, {"x": -8.62, "y": 41.17, "id": 1, "demand": 100, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.64, "y": 41.15, "id": 2, "demand": 80, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635, "y": 41.155, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "end_id": 0, "start_id": 0, "vehicles": [{"id": 1, "capacity": 300, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "charger_power_kw": 50, "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]], "is_charging_station": true}, "output": "Caminho encontrado: [0]\\nDistância total: 0 km\\nEnergia estimada: 0.0 kWh", "algoritmo": "dijkstra.py", "timestamp": "2025-06-11 18:00:48.046", "input_file": "input_20250611_180042_612530_8ed075.json"}, {"input": {"nodes": [{"x": -8.63, "y": 41.16, "id": 0, "is_depot": true}, {"x": -8.62, "y": 41.17, "id": 1, "demand": 100, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.64, "y": 41.15, "id": 2, "demand": 80, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635, "y": 41.155, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "demand": [0, 100, 80, 0], "vehicles": [{"id": 1, "capacity": 300, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "time_window": [[0, 86400], [28800, 39600], [32400, 45000], [0, 86400]], "service_time": [0, 300, 300, 0], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Rota ótima: [0, 1, 2, 10, 0]\\nDistância total: 0.06 km", "algoritmo": "branch_and_bound.py", "timestamp": "2025-06-11 18:00:48.109", "input_file": "input_20250611_180042_612530_8ed075.json"}, {"input": {"nodes": [{"x": -8.63, "y": 41.16, "id": 0, "is_depot": true}, {"x": -8.62, "y": 41.17, "id": 1, "demand": 100, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.64, "y": 41.15, "id": 2, "demand": 80, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635, "y": 41.155, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "demand": [0, 100, 80, 0], "vehicles": [{"id": 1, "capacity": 300, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "time_window": [[0, 86400], [28800, 39600], [32400, 45000], [0, 86400]], "service_time": [0, 300, 300, 0], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Caminho encontrado: [0, 1, 2, 0]\\nDistância total: 0.06 km", "algoritmo": "savings.py", "timestamp": "2025-06-11 18:00:48.176", "input_file": "input_20250611_180042_612530_8ed075.json"}, {"input": {"nodes": [{"x": -8.63, "y": 41.16, "id": 0, "is_depot": true}, {"x": -8.62, "y": 41.17, "id": 1, "demand": 100, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.64, "y": 41.15, "id": 2, "demand": 80, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635, "y": 41.155, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "demand": [0, 100, 80, 0], "vehicles": [{"id": 1, "capacity": 300, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "time_window": [[0, 86400], [28800, 39600], [32400, 45000], [0, 86400]], "service_time": [0, 300, 300, 0], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Rota: [0, 10, 2, 1, 0]\\nDistância: 0.06 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "nearest_neighbor.py", "timestamp": "2025-06-11 18:00:48.257", "input_file": "input_20250611_180042_612530_8ed075.json"}, {"input": {"nodes": [{"x": -8.63, "y": 41.16, "id": 0, "is_depot": true}, {"x": -8.62, "y": 41.17, "id": 1, "demand": 100, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.64, "y": 41.15, "id": 2, "demand": 80, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635, "y": 41.155, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "config": {"time_limit": 60, "tabu_tenure": 10}, "demand": [0, 100, 80, 0], "end_id": 0, "start_id": 0, "vehicles": [{"id": 1, "capacity": 300, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "time_window": [[0, 86400], [28800, 39600], [32400, 45000], [0, 86400]], "service_time": [0, 300, 300, 0], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "charger_power_kw": 50, "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]], "is_charging_station": true}, "output": "Roteamento: [[0, 1, 2, 10, 0]]\\nDistância total: 0.06 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "tabu_search.py", "timestamp": "2025-06-11 18:00:48.322", "input_file": "input_20250611_180042_612530_8ed075.json"}, {"input": {"nodes": [{"x": -8.63, "y": 41.16, "id": 0, "is_depot": true}, {"x": -8.62, "y": 41.17, "id": 1, "demand": 100, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.64, "y": 41.15, "id": 2, "demand": 80, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635, "y": 41.155, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "config": {"time_limit": 60, "tabu_tenure": 10}, "demand": [0, 100, 80, 0], "end_id": 0, "start_id": 0, "vehicles": [{"id": 1, "capacity": 300, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "time_window": [[0, 86400], [28800, 39600], [32400, 45000], [0, 86400]], "service_time": [0, 300, 300, 0], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "charger_power_kw": 50, "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]], "is_charging_station": true}, "output": "Rota encontrada: [0, 10, 2, 1, 0]\\nCusto total: 0.06 km", "algoritmo": "grasp.py", "timestamp": "2025-06-11 18:00:48.405", "input_file": "input_20250611_180042_612530_8ed075.json"}, {"input": {"nodes": [{"x": -8.63, "y": 41.16, "id": 0, "is_depot": true}, {"x": -8.62, "y": 41.17, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.64, "y": 41.15, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635, "y": 41.155, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 500, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Caminho encontrado: [0]\\nDistância total: 0.01 km\\nEnergia estimada: 0.0 kWh", "algoritmo": "dijkstra.py", "timestamp": "2025-06-11 18:00:48.507", "input_file": "input_20250611_180042_671403_72918b.json"}, {"input": {"nodes": [{"x": -8.63, "y": 41.16, "id": 0, "is_depot": true}, {"x": -8.62, "y": 41.17, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.64, "y": 41.15, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635, "y": 41.155, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 500, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Rota ótima: [0, 1, 2, 10, 0]\\nDistância total: 0.06 km", "algoritmo": "branch_and_bound.py", "timestamp": "2025-06-11 18:00:48.569", "input_file": "input_20250611_180042_671403_72918b.json"}, {"input": {"nodes": [{"x": -8.63, "y": 41.16, "id": 0, "is_depot": true}, {"x": -8.62, "y": 41.17, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.64, "y": 41.15, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635, "y": 41.155, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 500, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Caminho encontrado: [0, 1, 2, 0]\\nDistância total: 0.06 km", "algoritmo": "savings.py", "timestamp": "2025-06-11 18:00:48.635", "input_file": "input_20250611_180042_671403_72918b.json"}, {"input": {"nodes": [{"x": -8.63, "y": 41.16, "id": 0, "is_depot": true}, {"x": -8.62, "y": 41.17, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.64, "y": 41.15, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635, "y": 41.155, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 500, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Rota: [0, 10, 2, 1, 0]\\nDistância: 0.06 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "nearest_neighbor.py", "timestamp": "2025-06-11 18:00:48.712", "input_file": "input_20250611_180042_671403_72918b.json"}, {"input": {"nodes": [{"x": -8.63, "y": 41.16, "id": 0, "is_depot": true}, {"x": -8.62, "y": 41.17, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.64, "y": 41.15, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635, "y": 41.155, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "config": {"time_limit": 60, "tabu_tenure": 15}, "vehicles": [{"id": 1, "capacity": 500, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Roteamento: [[0, 1, 2, 10, 0]]\\nDistância total: 0.06 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "tabu_search.py", "timestamp": "2025-06-11 18:00:48.774", "input_file": "input_20250611_180042_671403_72918b.json"}, {"input": {"nodes": [{"x": -8.63, "y": 41.16, "id": 0, "is_depot": true}, {"x": -8.62, "y": 41.17, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.64, "y": 41.15, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635, "y": 41.155, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "config": {"time_limit": 60, "tabu_tenure": 15}, "vehicles": [{"id": 1, "capacity": 500, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}, "output": "Rota encontrada: [0, 10, 2, 1, 0]\\nCusto total: 0.06 km", "algoritmo": "grasp.py", "timestamp": "2025-06-11 18:00:48.858", "input_file": "input_20250611_180042_671403_72918b.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Caminho encontrado: [0]\\nDistância total: 0.01 km\\nEnergia estimada: 0.0 kWh", "algoritmo": "dijkstra.py", "timestamp": "2025-06-11 18:00:48.960", "input_file": "input_20250611_180042_727802_11ace6.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota ótima: [0, 1, 2, 10, 0]\\nDistância total: 0.05 km", "algoritmo": "branch_and_bound.py", "timestamp": "2025-06-11 18:00:49.023", "input_file": "input_20250611_180042_727802_11ace6.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Caminho encontrado: [0, 1, 0]\\nDistância total: 0.03 km", "algoritmo": "savings.py", "timestamp": "2025-06-11 18:00:49.088", "input_file": "input_20250611_180042_727802_11ace6.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota: [0, 10, 2, 1, 0]\\nDistância: 0.05 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "nearest_neighbor.py", "timestamp": "2025-06-11 18:00:49.178", "input_file": "input_20250611_180042_727802_11ace6.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Roteamento: [[0, 1, 2, 10, 0]]\\nDistância total: 0.05 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "tabu_search.py", "timestamp": "2025-06-11 18:00:49.251", "input_file": "input_20250611_180042_727802_11ace6.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota encontrada: [0, 10, 2, 1, 0]\\nCusto total: 0.05 km", "algoritmo": "grasp.py", "timestamp": "2025-06-11 18:00:49.336", "input_file": "input_20250611_180042_727802_11ace6.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Caminho encontrado: [0]\\nDistância total: 0.01 km\\nEnergia estimada: 0.0 kWh", "algoritmo": "dijkstra.py", "timestamp": "2025-06-11 18:01:12.830", "input_file": "input_20250611_180112_586667_a740ab.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota ótima: [0, 1, 2, 10, 0]\\nDistância total: 0.05 km", "algoritmo": "branch_and_bound.py", "timestamp": "2025-06-11 18:01:12.890", "input_file": "input_20250611_180112_586667_a740ab.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Caminho encontrado: [0, 1, 0]\\nDistância total: 0.03 km", "algoritmo": "savings.py", "timestamp": "2025-06-11 18:01:12.963", "input_file": "input_20250611_180112_586667_a740ab.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota: [0, 10, 2, 1, 0]\\nDistância: 0.05 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "nearest_neighbor.py", "timestamp": "2025-06-11 18:01:13.043", "input_file": "input_20250611_180112_586667_a740ab.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Roteamento: [[0, 1, 2, 10, 0]]\\nDistância total: 0.05 km\\nEnergia estimada: 0.01 kWh", "algoritmo": "tabu_search.py", "timestamp": "2025-06-11 18:01:13.108", "input_file": "input_20250611_180112_586667_a740ab.json"}, {"input": {"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}, "output": "Rota encontrada: [0, 10, 2, 1, 0]\\nCusto total: 0.05 km", "algoritmo": "grasp.py", "timestamp": "2025-06-11 18:01:13.187", "input_file": "input_20250611_180112_586667_a740ab.json"}]	2025-06-11 17:01:16.451973+00
\.


--
-- Data for Name: inputs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inputs (id, name, content, is_used, created_at) FROM stdin;
1	inputFINAL.json	{"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}	t	2025-06-11 16:58:18.014985+00
2	input1.json	{"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "algorithm": "tabu_search"}	t	2025-06-11 16:59:22.787539+00
3	input2.json	{"nodes": [{"x": -8.63062, "y": 41.159744999999994, "id": 0, "is_depot": true}, {"x": -8.620659999999999, "y": 41.170639, "id": 1, "demand": 200, "time_window": [28800, 39600]}, {"x": -8.64004, "y": 41.149558, "id": 2}, {"x": -8.635465, "y": 41.154031, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 542, "end_node": 0, "start_node": 0, "battery_kwh": 70}], "algorithm": "tabu_search"}	t	2025-06-11 16:59:22.787539+00
4	input3.json	{"nodes": [{"x": -8.629290000000001, "y": 41.159439, "id": 0, "is_depot": true}, {"x": -8.62093, "y": 41.169368, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639674000000001, "y": 41.14991, "id": 2, "demand": 150, "service_time": 300}, {"x": -8.635093, "y": 41.154154, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "config": {"time_limit": 60, "tabu_tenure": 15}, "vehicles": [{"id": 1, "capacity": 482, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "algorithm": "tabu_search", "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}	t	2025-06-11 16:59:22.787539+00
5	input4.json	{"nodes": [{"x": -8.629090000000001, "y": 41.159751, "id": 0, "is_depot": true}, {"x": -8.619287, "y": 41.170083, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.640284000000001, "y": 41.149693, "id": 2, "demand": 150}, {"x": -8.635999, "y": 41.155701, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 513, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "algorithm": "tabu_search"}	t	2025-06-11 16:59:22.787539+00
6	input5.json	{"nodes": [{"x": -8.629134, "y": 41.160951999999995, "id": 0, "is_depot": true}, {"x": -8.620451, "y": 41.170649000000004, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.639610000000001, "y": 41.149675, "id": 2, "demand": 150}, {"x": -8.63503, "y": 41.154454, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 529, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "algorithm": "tabu_search"}	t	2025-06-11 16:59:22.787539+00
7	input6.json	{"nodes": [{"x": -8.630600000000001, "y": 41.16018699999999, "id": 0, "is_depot": true}, {"x": -8.620757, "y": 41.170898, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.639717000000001, "y": 41.149474999999995, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635965, "y": 41.155971, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "config": {"time_limit": 60, "tabu_tenure": 15}, "vehicles": [{"id": 1, "capacity": 465, "end_node": 0, "start_node": 0, "battery_kwh": 70}], "algorithm": "tabu_search", "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}	t	2025-06-11 16:59:22.787539+00
8	input7.json	{"nodes": [{"x": -8.630618, "y": 41.160377, "id": 0, "is_depot": true}, {"x": -8.619323, "y": 41.169292, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.640521000000001, "y": 41.150453, "id": 2, "demand": 150}, {"x": -8.63557, "y": 41.15417, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 542, "end_node": 0, "start_node": 0}], "algorithm": "tabu_search"}	t	2025-06-11 16:59:22.787539+00
9	input8.json	{"nodes": [{"x": -8.630416, "y": 41.159955, "id": 0, "is_depot": true}, {"x": -8.619769, "y": 41.169702, "id": 1, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.640294, "y": 41.150850999999996, "id": 2, "demand": 150}, {"x": -8.63561, "y": 41.155334, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "config": {"time_limit": 60, "tabu_tenure": 15}, "vehicles": [{"id": 1, "capacity": 533, "end_node": 0, "start_node": 0, "battery_kwh": 70}], "algorithm": "tabu_search", "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}	t	2025-06-11 16:59:22.787539+00
10	input9.json	{"nodes": [{"x": -8.630245, "y": 41.160408, "id": 0, "is_depot": true}, {"x": -8.62056, "y": 41.169250000000005, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639249000000001, "y": 41.149754, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.634412, "y": 41.154892000000004, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "algorithm": "tabu_search"}	t	2025-06-11 16:59:22.787539+00
11	input10.json	{"nodes": [{"x": -8.630584, "y": 41.160399999999996, "id": 0, "is_depot": true}, {"x": -8.620752, "y": 41.169569, "id": 1, "service_time": 300}, {"x": -8.640030000000001, "y": 41.149164999999996, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635398, "y": 41.154677, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "config": {"time_limit": 60, "tabu_tenure": 15}, "vehicles": [{"id": 1, "capacity": 510, "end_node": 0, "start_node": 0}], "algorithm": "tabu_search", "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}	t	2025-06-11 16:59:22.787539+00
12	inputs11.json	{"nodes": [{"x": -8.63, "y": 41.16, "id": 0, "is_depot": true}, {"x": -8.62, "y": 41.17, "id": 1, "demand": 100, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.64, "y": 41.15, "id": 2, "demand": 80, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635, "y": 41.155, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "config": {"time_limit": 60, "tabu_tenure": 10}, "demand": [0, 100, 80, 0], "end_id": 0, "start_id": 0, "vehicles": [{"id": 1, "capacity": 300, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "time_window": [[0, 86400], [28800, 39600], [32400, 45000], [0, 86400]], "service_time": [0, 300, 300, 0], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "charger_power_kw": 50, "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]], "is_charging_station": true}	t	2025-06-11 16:59:22.787539+00
13	inputs.json	{"nodes": [{"x": -8.63, "y": 41.16, "id": 0, "is_depot": true}, {"x": -8.62, "y": 41.17, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.64, "y": 41.15, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635, "y": 41.155, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "config": {"time_limit": 60, "tabu_tenure": 15}, "vehicles": [{"id": 1, "capacity": 500, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "algorithm": "tabu_search", "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}	t	2025-06-11 16:59:22.787539+00
14	inputFINAL.json	{"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}	t	2025-06-11 16:59:22.787539+00
15	input1.json	{"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "algorithm": "tabu_search"}	t	2025-06-11 17:00:23.951778+00
16	input2.json	{"nodes": [{"x": -8.63062, "y": 41.159744999999994, "id": 0, "is_depot": true}, {"x": -8.620659999999999, "y": 41.170639, "id": 1, "demand": 200, "time_window": [28800, 39600]}, {"x": -8.64004, "y": 41.149558, "id": 2}, {"x": -8.635465, "y": 41.154031, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 542, "end_node": 0, "start_node": 0, "battery_kwh": 70}], "algorithm": "tabu_search"}	t	2025-06-11 17:00:23.951778+00
28	inputFINAL.json	{"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}	t	2025-06-11 17:01:07.110659+00
17	input3.json	{"nodes": [{"x": -8.629290000000001, "y": 41.159439, "id": 0, "is_depot": true}, {"x": -8.62093, "y": 41.169368, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639674000000001, "y": 41.14991, "id": 2, "demand": 150, "service_time": 300}, {"x": -8.635093, "y": 41.154154, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "config": {"time_limit": 60, "tabu_tenure": 15}, "vehicles": [{"id": 1, "capacity": 482, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "algorithm": "tabu_search", "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}	t	2025-06-11 17:00:23.951778+00
18	input4.json	{"nodes": [{"x": -8.629090000000001, "y": 41.159751, "id": 0, "is_depot": true}, {"x": -8.619287, "y": 41.170083, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.640284000000001, "y": 41.149693, "id": 2, "demand": 150}, {"x": -8.635999, "y": 41.155701, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 513, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "algorithm": "tabu_search"}	t	2025-06-11 17:00:23.951778+00
19	input5.json	{"nodes": [{"x": -8.629134, "y": 41.160951999999995, "id": 0, "is_depot": true}, {"x": -8.620451, "y": 41.170649000000004, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.639610000000001, "y": 41.149675, "id": 2, "demand": 150}, {"x": -8.63503, "y": 41.154454, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 529, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "algorithm": "tabu_search"}	t	2025-06-11 17:00:23.951778+00
20	input6.json	{"nodes": [{"x": -8.630600000000001, "y": 41.16018699999999, "id": 0, "is_depot": true}, {"x": -8.620757, "y": 41.170898, "id": 1, "demand": 200, "service_time": 300}, {"x": -8.639717000000001, "y": 41.149474999999995, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635965, "y": 41.155971, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "config": {"time_limit": 60, "tabu_tenure": 15}, "vehicles": [{"id": 1, "capacity": 465, "end_node": 0, "start_node": 0, "battery_kwh": 70}], "algorithm": "tabu_search", "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}	t	2025-06-11 17:00:23.951778+00
21	input7.json	{"nodes": [{"x": -8.630618, "y": 41.160377, "id": 0, "is_depot": true}, {"x": -8.619323, "y": 41.169292, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.640521000000001, "y": 41.150453, "id": 2, "demand": 150}, {"x": -8.63557, "y": 41.15417, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 542, "end_node": 0, "start_node": 0}], "algorithm": "tabu_search"}	t	2025-06-11 17:00:23.951778+00
22	input8.json	{"nodes": [{"x": -8.630416, "y": 41.159955, "id": 0, "is_depot": true}, {"x": -8.619769, "y": 41.169702, "id": 1, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.640294, "y": 41.150850999999996, "id": 2, "demand": 150}, {"x": -8.63561, "y": 41.155334, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "config": {"time_limit": 60, "tabu_tenure": 15}, "vehicles": [{"id": 1, "capacity": 533, "end_node": 0, "start_node": 0, "battery_kwh": 70}], "algorithm": "tabu_search", "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}	t	2025-06-11 17:00:23.951778+00
23	input9.json	{"nodes": [{"x": -8.630245, "y": 41.160408, "id": 0, "is_depot": true}, {"x": -8.62056, "y": 41.169250000000005, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639249000000001, "y": 41.149754, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.634412, "y": 41.154892000000004, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "algorithm": "tabu_search"}	t	2025-06-11 17:00:23.951778+00
24	input10.json	{"nodes": [{"x": -8.630584, "y": 41.160399999999996, "id": 0, "is_depot": true}, {"x": -8.620752, "y": 41.169569, "id": 1, "service_time": 300}, {"x": -8.640030000000001, "y": 41.149164999999996, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635398, "y": 41.154677, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "config": {"time_limit": 60, "tabu_tenure": 15}, "vehicles": [{"id": 1, "capacity": 510, "end_node": 0, "start_node": 0}], "algorithm": "tabu_search", "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}	t	2025-06-11 17:00:23.951778+00
25	inputs11.json	{"nodes": [{"x": -8.63, "y": 41.16, "id": 0, "is_depot": true}, {"x": -8.62, "y": 41.17, "id": 1, "demand": 100, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.64, "y": 41.15, "id": 2, "demand": 80, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635, "y": 41.155, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "config": {"time_limit": 60, "tabu_tenure": 10}, "demand": [0, 100, 80, 0], "end_id": 0, "start_id": 0, "vehicles": [{"id": 1, "capacity": 300, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "time_window": [[0, 86400], [28800, 39600], [32400, 45000], [0, 86400]], "service_time": [0, 300, 300, 0], "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "charger_power_kw": 50, "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]], "is_charging_station": true}	t	2025-06-11 17:00:23.951778+00
26	inputs.json	{"nodes": [{"x": -8.63, "y": 41.16, "id": 0, "is_depot": true}, {"x": -8.62, "y": 41.17, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.64, "y": 41.15, "id": 2, "demand": 150, "time_window": [32400, 45000], "service_time": 300}, {"x": -8.635, "y": 41.155, "id": 10, "charger_power_kw": 50, "is_charging_station": true}], "config": {"time_limit": 60, "tabu_tenure": 15}, "vehicles": [{"id": 1, "capacity": 500, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}], "algorithm": "tabu_search", "energy_matrix": [[0, 2.1, 1.8, 0.5], [2.1, 0, 3.0, 1.2], [1.8, 3.0, 0, 1.0], [0.5, 1.2, 1.0, 0]], "travel_time_matrix": [[0, 780, 690, 180], [780, 0, 1080, 420], [690, 1080, 0, 360], [180, 420, 360, 0]]}	t	2025-06-11 17:00:23.951778+00
27	inputFINAL.json	{"nodes": [{"x": -8.630699, "y": 41.159653999999996, "id": 0, "is_depot": true}, {"x": -8.620080999999999, "y": 41.169441, "id": 1, "demand": 200, "time_window": [28800, 39600], "service_time": 300}, {"x": -8.639608, "y": 41.150171, "id": 2, "time_window": [32400, 45000]}, {"x": -8.634504, "y": 41.155732, "id": 10, "charger_power_kw": null, "is_charging_station": true}], "vehicles": [{"id": 1, "capacity": 484, "end_node": 0, "speed_kph": 40, "start_node": 0, "battery_kwh": 70}]}	t	2025-06-11 17:00:23.951778+00
\.


--
-- Data for Name: locations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.locations (id, "timestamp", latitude, longitude, task_id) FROM stdin;
1	2025-06-10 19:03:36.05524+00	41.2952	-7.7387	1
2	2025-06-10 20:03:36.05524+00	41.3	-7.744	1
3	2025-06-10 19:03:36.05524+00	41.2952	-7.7387	2
4	2025-06-10 20:03:36.05524+00	41.3071	-7.7485	2
5	2025-06-10 19:03:36.05524+00	41.2952	-7.7387	3
6	2025-06-10 20:03:36.05524+00	41.3124	-7.7463	3
7	2025-06-10 19:03:36.05524+00	41.2952	-7.7387	4
8	2025-06-10 20:03:36.05524+00	41.2918	-7.7533	4
9	2025-06-10 19:03:36.05524+00	41.2952	-7.7387	5
10	2025-06-10 20:03:36.05524+00	41.2872	-7.7223	5
11	2025-06-10 19:03:36.05524+00	41.2952	-7.7387	6
12	2025-06-10 20:03:36.05524+00	41.3047	-7.7305	6
\.


--
-- Data for Name: maintenance_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.maintenance_types (id, type, description) FROM stdin;
1	Revisão geral	Inspeção completa da mota elétrica
2	Verificação dos travões	Verificação e substituição das pastilhas ou discos de travão
3	Verificação da suspensão	Inspeção e manutenção das suspensões dianteira e traseira
4	Verificação do sistema eléctrico	Inspeção da bateria, luzes, cablagem e conectores
5	Verificação da bateria	Avaliação do estado, limpeza dos terminais e análise de desempenho da bateria
6	Atualização de software	Instalação de atualizações de firmware ou software da mota
7	Verificação dos pneus	Inspeção do estado e pressão dos pneus
8	Verificação do carregador	Testes e inspeção do carregador e cabos de carregamento
\.


--
-- Data for Name: maintenances; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.maintenances (id, moto_id, type_id, date) FROM stdin;
1	3	1	2025-06-10 20:00:55.955516+00
2	4	2	2025-06-10 20:00:55.955516+00
3	7	3	2025-06-10 20:00:55.955516+00
4	12	4	2025-06-10 20:00:55.955516+00
5	15	5	2025-06-10 20:00:55.955516+00
\.


--
-- Data for Name: motorcycle_alerts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.motorcycle_alerts (moto_id, alert_id, "AlertId1") FROM stdin;
2	2	\N
6	1	\N
\.


--
-- Data for Name: motorcycles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.motorcycles (id, brand, model, battery_status, km, status, battery_capacity, battery_degradation) FROM stdin;
1	Super Soco	TC Max	87	12430.5	disponivel	3.2	1.7
2	NIU	NQi GT	20	8500.2	em uso	2.4	4.2
3	Silence	S01	91	17320.9	em manutenção	5.6	2.9
4	Askoll	eS3	74	10570.1	em manutenção	2.8	3.5
5	Super Soco	CUx	99	9540.7	disponivel	1.8	1.2
6	NIU	MQi+	54	6350	em uso	2	5.1
7	Silence	S02	79	11200.8	em manutenção	5.6	2
8	Askoll	eS2	68	13760.3	em uso	2.1	4
9	Super Soco	TSX	84	14350.6	disponivel	1.6	1.5
10	NIU	UQi GT	47	4280.5	em uso	1.5	5.8
11	Silence	S03	92	19220.9	disponivel	7	2.3
12	Askoll	eS1	55	7210.1	em manutenção	1	4.9
13	Super Soco	TS	78	9880.3	disponivel	1.6	1.9
14	NIU	Gova G3	60	11250.7	em uso	2.7	4.4
15	Silence	S01 Plus	90	16710.8	em manutenção	5.6	2.7
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notifications (id, user_id, message, "timestamp", is_read) FROM stdin;
1	2	Tarefa urgente atribuída.	2025-06-10 20:03:44.72236+00	f
2	6	Manutenção marcada para a sua mota.	2025-06-10 20:03:44.72236+00	t
\.


--
-- Data for Name: performance_report; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.performance_report (id, description, "timestamp", moto_id) FROM stdin;
1	Autonomia abaixo do esperado	2025-06-10 20:03:41.36321+00	2
2	Desempenho satisfatório	2025-06-10 20:03:41.36321+00	6
\.


--
-- Data for Name: results; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.results (id, file_output, algorithm_name, route, cost, input_id, estimated_energy) FROM stdin;
1	output_input_20250611_175824_967889_db0f91.json	dijkstra	[0]	0.01	1	0
2	output_input_20250611_175824_967889_db0f91.json	branch_and_bound	[0, 1, 2, 10, 0]	0.05	1	\N
3	output_input_20250611_175824_967889_db0f91.json	savings	[0, 1, 0]	0.03	1	\N
4	output_input_20250611_175824_967889_db0f91.json	nearest_neighbor	[0, 10, 2, 1, 0]	0.05	1	0.01
5	output_input_20250611_175824_967889_db0f91.json	tabu_search	[0, 1, 2, 10, 0]	0.05	1	0.01
6	output_input_20250611_175824_967889_db0f91.json	grasp	[0, 10, 2, 1, 0]	0.05	1	\N
7	output_input_20250611_175930_315075_41c02b.json	dijkstra	[0]	0.01	2	0
8	output_input_20250611_175930_315075_41c02b.json	branch_and_bound	[0, 1, 2, 10, 0]	0.05	2	\N
9	output_input_20250611_175930_315075_41c02b.json	savings	[0, 1, 0]	0.03	2	\N
10	output_input_20250611_175930_315075_41c02b.json	nearest_neighbor	[0, 10, 2, 1, 0]	0.05	2	0.01
11	output_input_20250611_175930_315075_41c02b.json	tabu_search	[0, 1, 2, 10, 0]	0.05	2	0.01
12	output_input_20250611_175930_315075_41c02b.json	grasp	[0, 10, 2, 1, 0]	0.05	2	\N
13	output_input_20250611_175930_363641_5a869c.json	dijkstra	[0]	0.01	3	0
14	output_input_20250611_175930_363641_5a869c.json	branch_and_bound	[0, 1, 10, 2, 0]	0.06	3	\N
15	output_input_20250611_175930_363641_5a869c.json	savings	[0, 1, 0]	0.03	3	\N
16	output_input_20250611_175930_363641_5a869c.json	nearest_neighbor	[0, 10, 2, 1, 0]	0.06	3	0.01
17	output_input_20250611_175930_363641_5a869c.json	tabu_search	[0, 1, 10, 2, 0]	0.06	3	0.01
18	output_input_20250611_175930_363641_5a869c.json	grasp	[0, 10, 2, 1, 0]	0.06	3	\N
19	output_input_20250611_175930_408522_d8ac65.json	dijkstra	[0]	0.01	4	0
20	output_input_20250611_175930_408522_d8ac65.json	branch_and_bound	[0, 1, 2, 10, 0]	0.05	4	\N
21	output_input_20250611_175930_408522_d8ac65.json	savings	[0, 1, 2, 0]	0.05	4	\N
22	output_input_20250611_175930_408522_d8ac65.json	nearest_neighbor	[0, 10, 2, 1, 0]	0.05	4	0.01
23	output_input_20250611_175930_408522_d8ac65.json	tabu_search	[0, 1, 2, 10, 0]	0.05	4	0.01
24	output_input_20250611_175930_408522_d8ac65.json	grasp	[0, 10, 2, 1, 0]	0.05	4	\N
25	output_input_20250611_175930_459624_2c08ca.json	dijkstra	[0]	0.01	5	0
26	output_input_20250611_175930_459624_2c08ca.json	branch_and_bound	[0, 1, 10, 2, 0]	0.06	5	\N
27	output_input_20250611_175930_459624_2c08ca.json	savings	[0, 1, 2, 0]	0.06	5	\N
28	output_input_20250611_175930_459624_2c08ca.json	nearest_neighbor	[0, 10, 2, 1, 0]	0.06	5	0.01
29	output_input_20250611_175930_459624_2c08ca.json	tabu_search	[0, 1, 10, 2, 0]	0.06	5	0.01
30	output_input_20250611_175930_459624_2c08ca.json	grasp	[0, 10, 2, 1, 0]	0.06	5	\N
31	output_input_20250611_175930_504016_a4c0e2.json	dijkstra	[0]	0.01	6	0
32	output_input_20250611_175930_504016_a4c0e2.json	branch_and_bound	[0, 1, 2, 10, 0]	0.06	6	\N
33	output_input_20250611_175930_504016_a4c0e2.json	savings	[0, 1, 2, 0]	0.06	6	\N
34	output_input_20250611_175930_504016_a4c0e2.json	nearest_neighbor	[0, 10, 2, 1, 0]	0.06	6	0.01
35	output_input_20250611_175930_504016_a4c0e2.json	tabu_search	[0, 1, 2, 10, 0]	0.06	6	0.01
36	output_input_20250611_175930_504016_a4c0e2.json	grasp	[0, 10, 2, 1, 0]	0.06	6	\N
37	output_input_20250611_175930_554192_f2e237.json	dijkstra	[0]	0.01	7	0
38	output_input_20250611_175930_554192_f2e237.json	branch_and_bound	[0, 1, 10, 2, 0]	0.06	7	\N
39	output_input_20250611_175930_554192_f2e237.json	savings	[0, 1, 2, 0]	0.06	7	\N
40	output_input_20250611_175930_554192_f2e237.json	nearest_neighbor	[0, 10, 2, 1, 0]	0.06	7	0.01
41	output_input_20250611_175930_554192_f2e237.json	tabu_search	[0, 1, 10, 2, 0]	0.06	7	0.01
42	output_input_20250611_175930_554192_f2e237.json	grasp	[0, 10, 2, 1, 0]	0.06	7	\N
43	output_input_20250611_175930_602850_7a67c8.json	branch_and_bound	[0, 1, 10, 2, 0]	0.06	8	\N
44	output_input_20250611_175930_602850_7a67c8.json	grasp	[0, 10, 2, 1, 0]	0.06	8	\N
45	output_input_20250611_175930_656616_c5a054.json	dijkstra	[0]	0.01	9	0
46	output_input_20250611_175930_656616_c5a054.json	branch_and_bound	[0, 1, 10, 2, 0]	0.06	9	\N
47	output_input_20250611_175930_656616_c5a054.json	savings	[0, 2, 0]	0.03	9	\N
48	output_input_20250611_175930_656616_c5a054.json	nearest_neighbor	[0, 10, 2, 1, 0]	0.06	9	0.01
49	output_input_20250611_175930_656616_c5a054.json	tabu_search	[0, 1, 10, 2, 0]	0.06	9	0.01
50	output_input_20250611_175930_656616_c5a054.json	grasp	[0, 10, 2, 1, 0]	0.06	9	\N
51	output_input_20250611_175930_705017_1a8e38.json	dijkstra	[0]	0.01	10	0
52	output_input_20250611_175930_705017_1a8e38.json	branch_and_bound	[0, 1, 10, 2, 0]	0.05	10	\N
53	output_input_20250611_175930_705017_1a8e38.json	savings	[0, 1, 2, 0]	0.05	10	\N
54	output_input_20250611_175930_705017_1a8e38.json	nearest_neighbor	[0, 10, 2, 1, 0]	0.05	10	0.01
55	output_input_20250611_175930_705017_1a8e38.json	tabu_search	[0, 1, 10, 2, 0]	0.05	10	0.01
56	output_input_20250611_175930_705017_1a8e38.json	grasp	[0, 10, 2, 1, 0]	0.05	10	\N
57	output_input_20250611_175930_749559_7f34ba.json	branch_and_bound	[0, 1, 2, 10, 0]	0.06	11	\N
58	output_input_20250611_175930_749559_7f34ba.json	grasp	[0, 10, 2, 1, 0]	0.06	11	\N
59	output_input_20250611_175930_798401_c3ea85.json	dijkstra	[0]	0	12	0
60	output_input_20250611_175930_798401_c3ea85.json	branch_and_bound	[0, 1, 2, 10, 0]	0.06	12	\N
61	output_input_20250611_175930_798401_c3ea85.json	savings	[0, 1, 2, 0]	0.06	12	\N
62	output_input_20250611_175930_798401_c3ea85.json	nearest_neighbor	[0, 10, 2, 1, 0]	0.06	12	0.01
63	output_input_20250611_175930_798401_c3ea85.json	tabu_search	[0, 1, 2, 10, 0]	0.06	12	0.01
64	output_input_20250611_175930_798401_c3ea85.json	grasp	[0, 10, 2, 1, 0]	0.06	12	\N
65	output_input_20250611_175930_843738_28be7a.json	dijkstra	[0]	0.01	13	0
66	output_input_20250611_175930_843738_28be7a.json	branch_and_bound	[0, 1, 2, 10, 0]	0.06	13	\N
67	output_input_20250611_175930_843738_28be7a.json	savings	[0, 1, 2, 0]	0.06	13	\N
68	output_input_20250611_175930_843738_28be7a.json	nearest_neighbor	[0, 10, 2, 1, 0]	0.06	13	0.01
69	output_input_20250611_175930_843738_28be7a.json	tabu_search	[0, 1, 2, 10, 0]	0.06	13	0.01
70	output_input_20250611_175930_843738_28be7a.json	grasp	[0, 10, 2, 1, 0]	0.06	13	\N
71	output_input_20250611_175930_892935_61faf0.json	dijkstra	[0]	0.01	14	0
72	output_input_20250611_175930_892935_61faf0.json	branch_and_bound	[0, 1, 2, 10, 0]	0.05	14	\N
73	output_input_20250611_175930_892935_61faf0.json	savings	[0, 1, 0]	0.03	14	\N
74	output_input_20250611_175930_892935_61faf0.json	nearest_neighbor	[0, 10, 2, 1, 0]	0.05	14	0.01
75	output_input_20250611_175930_892935_61faf0.json	tabu_search	[0, 1, 2, 10, 0]	0.05	14	0.01
76	output_input_20250611_175930_892935_61faf0.json	grasp	[0, 10, 2, 1, 0]	0.05	14	\N
77	output_input_20250611_180042_012129_052126.json	dijkstra	[0]	0.01	15	0
78	output_input_20250611_180042_012129_052126.json	branch_and_bound	[0, 1, 2, 10, 0]	0.05	15	\N
79	output_input_20250611_180042_012129_052126.json	savings	[0, 1, 0]	0.03	15	\N
80	output_input_20250611_180042_012129_052126.json	nearest_neighbor	[0, 10, 2, 1, 0]	0.05	15	0.01
81	output_input_20250611_180042_012129_052126.json	tabu_search	[0, 1, 2, 10, 0]	0.05	15	0.01
82	output_input_20250611_180042_012129_052126.json	grasp	[0, 10, 2, 1, 0]	0.05	15	\N
83	output_input_20250611_180042_072016_afe6e7.json	dijkstra	[0]	0.01	16	0
84	output_input_20250611_180042_072016_afe6e7.json	branch_and_bound	[0, 1, 10, 2, 0]	0.06	16	\N
85	output_input_20250611_180042_072016_afe6e7.json	savings	[0, 1, 0]	0.03	16	\N
86	output_input_20250611_180042_072016_afe6e7.json	nearest_neighbor	[0, 10, 2, 1, 0]	0.06	16	0.01
87	output_input_20250611_180042_072016_afe6e7.json	tabu_search	[0, 1, 10, 2, 0]	0.06	16	0.01
88	output_input_20250611_180042_072016_afe6e7.json	grasp	[0, 10, 2, 1, 0]	0.06	16	\N
89	output_input_20250611_180042_126786_c3b6e7.json	dijkstra	[0]	0.01	17	0
90	output_input_20250611_180042_126786_c3b6e7.json	branch_and_bound	[0, 1, 2, 10, 0]	0.05	17	\N
91	output_input_20250611_180042_126786_c3b6e7.json	savings	[0, 1, 2, 0]	0.05	17	\N
92	output_input_20250611_180042_126786_c3b6e7.json	nearest_neighbor	[0, 10, 2, 1, 0]	0.05	17	0.01
93	output_input_20250611_180042_126786_c3b6e7.json	tabu_search	[0, 1, 2, 10, 0]	0.05	17	0.01
94	output_input_20250611_180042_126786_c3b6e7.json	grasp	[0, 10, 2, 1, 0]	0.05	17	\N
95	output_input_20250611_180042_187017_669953.json	dijkstra	[0]	0.01	18	0
96	output_input_20250611_180042_187017_669953.json	branch_and_bound	[0, 1, 10, 2, 0]	0.06	18	\N
97	output_input_20250611_180042_187017_669953.json	savings	[0, 1, 2, 0]	0.06	18	\N
98	output_input_20250611_180042_187017_669953.json	nearest_neighbor	[0, 10, 2, 1, 0]	0.06	18	0.01
99	output_input_20250611_180042_187017_669953.json	tabu_search	[0, 1, 10, 2, 0]	0.06	18	0.01
100	output_input_20250611_180042_187017_669953.json	grasp	[0, 10, 2, 1, 0]	0.06	18	\N
101	output_input_20250611_180042_246972_5630d6.json	dijkstra	[0]	0.01	19	0
102	output_input_20250611_180042_246972_5630d6.json	branch_and_bound	[0, 1, 2, 10, 0]	0.06	19	\N
103	output_input_20250611_180042_246972_5630d6.json	savings	[0, 1, 2, 0]	0.06	19	\N
104	output_input_20250611_180042_246972_5630d6.json	nearest_neighbor	[0, 10, 2, 1, 0]	0.06	19	0.01
105	output_input_20250611_180042_246972_5630d6.json	tabu_search	[0, 1, 2, 10, 0]	0.06	19	0.01
106	output_input_20250611_180042_246972_5630d6.json	grasp	[0, 10, 2, 1, 0]	0.06	19	\N
107	output_input_20250611_180042_309300_0cda8d.json	dijkstra	[0]	0.01	20	0
108	output_input_20250611_180042_309300_0cda8d.json	branch_and_bound	[0, 1, 10, 2, 0]	0.06	20	\N
109	output_input_20250611_180042_309300_0cda8d.json	savings	[0, 1, 2, 0]	0.06	20	\N
110	output_input_20250611_180042_309300_0cda8d.json	nearest_neighbor	[0, 10, 2, 1, 0]	0.06	20	0.01
111	output_input_20250611_180042_309300_0cda8d.json	tabu_search	[0, 1, 10, 2, 0]	0.06	20	0.01
112	output_input_20250611_180042_309300_0cda8d.json	grasp	[0, 10, 2, 1, 0]	0.06	20	\N
113	output_input_20250611_180042_380858_7f62cf.json	branch_and_bound	[0, 1, 10, 2, 0]	0.06	21	\N
114	output_input_20250611_180042_380858_7f62cf.json	grasp	[0, 10, 2, 1, 0]	0.06	21	\N
115	output_input_20250611_180042_438295_8dd0bf.json	dijkstra	[0]	0.01	22	0
116	output_input_20250611_180042_438295_8dd0bf.json	branch_and_bound	[0, 1, 10, 2, 0]	0.06	22	\N
117	output_input_20250611_180042_438295_8dd0bf.json	savings	[0, 2, 0]	0.03	22	\N
118	output_input_20250611_180042_438295_8dd0bf.json	nearest_neighbor	[0, 10, 2, 1, 0]	0.06	22	0.01
119	output_input_20250611_180042_438295_8dd0bf.json	tabu_search	[0, 1, 10, 2, 0]	0.06	22	0.01
120	output_input_20250611_180042_438295_8dd0bf.json	grasp	[0, 10, 2, 1, 0]	0.06	22	\N
121	output_input_20250611_180042_496422_68f0e6.json	dijkstra	[0]	0.01	23	0
122	output_input_20250611_180042_496422_68f0e6.json	branch_and_bound	[0, 1, 10, 2, 0]	0.05	23	\N
123	output_input_20250611_180042_496422_68f0e6.json	savings	[0, 1, 2, 0]	0.05	23	\N
124	output_input_20250611_180042_496422_68f0e6.json	nearest_neighbor	[0, 10, 2, 1, 0]	0.05	23	0.01
125	output_input_20250611_180042_496422_68f0e6.json	tabu_search	[0, 1, 10, 2, 0]	0.05	23	0.01
126	output_input_20250611_180042_496422_68f0e6.json	grasp	[0, 10, 2, 1, 0]	0.05	23	\N
127	output_input_20250611_180042_554676_08eca5.json	branch_and_bound	[0, 1, 2, 10, 0]	0.06	24	\N
128	output_input_20250611_180042_554676_08eca5.json	grasp	[0, 10, 2, 1, 0]	0.06	24	\N
129	output_input_20250611_180042_612530_8ed075.json	dijkstra	[0]	0	25	0
130	output_input_20250611_180042_612530_8ed075.json	branch_and_bound	[0, 1, 2, 10, 0]	0.06	25	\N
131	output_input_20250611_180042_612530_8ed075.json	savings	[0, 1, 2, 0]	0.06	25	\N
132	output_input_20250611_180042_612530_8ed075.json	nearest_neighbor	[0, 10, 2, 1, 0]	0.06	25	0.01
133	output_input_20250611_180042_612530_8ed075.json	tabu_search	[0, 1, 2, 10, 0]	0.06	25	0.01
134	output_input_20250611_180042_612530_8ed075.json	grasp	[0, 10, 2, 1, 0]	0.06	25	\N
135	output_input_20250611_180042_671403_72918b.json	dijkstra	[0]	0.01	26	0
136	output_input_20250611_180042_671403_72918b.json	branch_and_bound	[0, 1, 2, 10, 0]	0.06	26	\N
137	output_input_20250611_180042_671403_72918b.json	savings	[0, 1, 2, 0]	0.06	26	\N
138	output_input_20250611_180042_671403_72918b.json	nearest_neighbor	[0, 10, 2, 1, 0]	0.06	26	0.01
139	output_input_20250611_180042_671403_72918b.json	tabu_search	[0, 1, 2, 10, 0]	0.06	26	0.01
140	output_input_20250611_180042_671403_72918b.json	grasp	[0, 10, 2, 1, 0]	0.06	26	\N
141	output_input_20250611_180042_727802_11ace6.json	dijkstra	[0]	0.01	27	0
142	output_input_20250611_180042_727802_11ace6.json	branch_and_bound	[0, 1, 2, 10, 0]	0.05	27	\N
143	output_input_20250611_180042_727802_11ace6.json	savings	[0, 1, 0]	0.03	27	\N
144	output_input_20250611_180042_727802_11ace6.json	nearest_neighbor	[0, 10, 2, 1, 0]	0.05	27	0.01
145	output_input_20250611_180042_727802_11ace6.json	tabu_search	[0, 1, 2, 10, 0]	0.05	27	0.01
146	output_input_20250611_180042_727802_11ace6.json	grasp	[0, 10, 2, 1, 0]	0.05	27	\N
147	output_input_20250611_180112_586667_a740ab.json	dijkstra	[0]	0.01	28	0
148	output_input_20250611_180112_586667_a740ab.json	branch_and_bound	[0, 1, 2, 10, 0]	0.05	28	\N
149	output_input_20250611_180112_586667_a740ab.json	savings	[0, 1, 0]	0.03	28	\N
150	output_input_20250611_180112_586667_a740ab.json	nearest_neighbor	[0, 10, 2, 1, 0]	0.05	28	0.01
151	output_input_20250611_180112_586667_a740ab.json	tabu_search	[0, 1, 2, 10, 0]	0.05	28	0.01
152	output_input_20250611_180112_586667_a740ab.json	grasp	[0, 10, 2, 1, 0]	0.05	28	\N
\.


--
-- Data for Name: route_points; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.route_points (id, route_id, latitude, longitude, stop_order) FROM stdin;
1	1	41.2952	-7.7387	1
2	1	41.3	-7.744	2
3	2	41.2952	-7.7387	1
4	2	41.3071	-7.7485	2
5	3	41.2952	-7.7387	1
6	3	41.3124	-7.7463	2
7	4	41.2952	-7.7387	1
8	4	41.2918	-7.7533	2
9	5	41.2952	-7.7387	1
10	5	41.2872	-7.7223	2
11	6	41.2952	-7.7387	1
12	6	41.3047	-7.7305	2
\.


--
-- Data for Name: routes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.routes (id, task_id, distance_km, estimated_delivery_time) FROM stdin;
1	1	4.2	00:13:00
2	2	7.1	00:22:00
3	3	2.9	00:09:00
4	4	5.5	00:15:00
5	5	6.3	00:18:00
6	6	3.7	00:11:00
\.


--
-- Data for Name: services; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.services (id, type, date, description, status, user_id, moto_id) FROM stdin;
1	Entrega	2025-06-10 20:01:12.413761+00	Entrega de encomenda	Pendente	3	2
2	Recolha	2025-06-10 20:01:12.413761+00	Recolha no cliente B	Concluído	9	6
3	Entrega	2025-06-10 20:01:12.413761+00	Entrega de encomenda	Pendente	12	8
4	Entrega	2025-06-10 20:01:12.413761+00	Entrega de encomenda	Pendente	15	10
5	Entrega	2025-06-10 20:01:12.413761+00	Entrega de encomenda	Pendente	18	12
6	Entrega	2025-06-10 20:01:12.413761+00	Entrega de encomenda	Pendente	19	14
\.


--
-- Data for Name: task_histories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.task_histories (id, task_id, status, "timestamp") FROM stdin;
1	1	Aberta	2025-06-10 18:02:39.579391+00
2	1	Em progresso	2025-06-10 20:02:39.579391+00
3	2	Aberta	2025-06-09 20:02:39.579391+00
4	2	Concluída	2025-06-10 20:02:39.579391+00
5	3	Aberta	2025-06-10 18:02:39.579391+00
6	3	Em progresso	2025-06-10 20:02:39.579391+00
7	4	Aberta	2025-06-10 18:02:39.579391+00
8	4	Em progresso	2025-06-10 20:02:39.579391+00
9	5	Aberta	2025-06-10 18:02:39.579391+00
10	5	Em progresso	2025-06-10 20:02:39.579391+00
11	6	Aberta	2025-06-10 18:02:39.579391+00
12	6	Em progresso	2025-06-10 20:02:39.579391+00
\.


--
-- Data for Name: tasks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tasks (id, type, creation_date, deadline, description, status, user_id, service_id, "UserId1") FROM stdin;
1	Entrega	2025-06-10 20:01:21.709646+00	2025-06-11 20:01:21.709646+00	Entrega no cliente João	Aberta	3	1	\N
2	Recolha 	2025-06-10 20:01:21.709646+00	2025-06-12 20:01:21.709646+00	Recolher no centro de logística	Concluída	9	2	\N
3	Entrega	2025-06-10 20:01:21.709646+00	2025-06-11 20:01:21.709646+00	Entrega no cliente Marco	Aberta	12	3	\N
4	Entrega	2025-06-10 20:01:21.709646+00	2025-06-11 20:01:21.709646+00	Entrega no cliente Pedro	Aberta	15	4	\N
5	Entrega	2025-06-10 20:01:21.709646+00	2025-06-11 20:01:21.709646+00	Entrega no cliente José	Aberta	18	5	\N
6	Entrega	2025-06-10 20:01:21.709646+00	2025-06-11 20:01:21.709646+00	Entrega no cliente Maria	Aberta	19	6	\N
\.


--
-- Data for Name: user_alerts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_alerts (user_id, alert_id) FROM stdin;
3	2
9	1
\.


--
-- Data for Name: user_motorcycle; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_motorcycle (moto_id, user_id) FROM stdin;
2	3
6	9
8	12
10	15
12	18
14	19
\.


--
-- Data for Name: user_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_types (id, type) FROM stdin;
1	Admin
2	Operator
3	Courier
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, email, password, type_id) FROM stdin;
1	Ana Silva	ana.silva@gmail.com	Xp2@#f6T	1
2	Carlos Souza	carlos.souza@gmail.com	D9mW5!tL	2
3	Maria Oliveira	maria.oliveira@gmail.com	Q3dYz9Kp	3
4	João Pereira	joao.pereira@gmail.com	B8hNc1!R	1
5	Clara Costa	clara.costa@gmail.com	Z7tXu5Vw	2
6	Ricardo Almeida	ricardo.almeida@gmail.com	N2bE9pL@	3
7	Fernanda Lima	fernanda.lima@gmail.com	Q1rWi7Af	1
8	Paulo Martins	paulo.martins@gmail.com	L6yXt3Cv	2
9	Patrícia Mendes	patricia.mendes@gmail.com	V4bWt8Qs	3
10	Luís Santos	luis.santos@gmail.com	R0dKm5!A	1
11	Juliana Barbosa	juliana.barbosa@gmail.com	S3hXp7Zz	2
12	Eduardo Rocha	eduardo.rocha@gmail.com	F8cWd0J#	3
13	Beatriz Ferreira	beatriz.ferreira@gmail.com	G1kPv2@Z	1
14	Gustavo Oliveira	gustavo.oliveira@gmail.com	X4rTh9&Y	2
15	Larissa Costa	larissa.costa@gmail.com	J6yWp1Kr	3
16	Felipe Souza	felipe.souza@gmail.com	M7tYz8@D	1
17	Tatiane Silva	tatiane.silva@gmail.com	P9qVs5E#	2
18	Bruno Lima	bruno.lima@gmail.com	Z5hRj1P9	3
19	Mariana Alves	mariana.alves@gmail.com	I4pQx7N@	3
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.schema_migrations (version, inserted_at) FROM stdin;
20211116024918	2025-05-06 14:02:40
20211116045059	2025-05-06 14:02:42
20211116050929	2025-05-06 14:02:44
20211116051442	2025-05-06 14:02:46
20211116212300	2025-05-06 14:02:48
20211116213355	2025-05-06 14:02:49
20211116213934	2025-05-06 14:02:51
20211116214523	2025-05-06 14:02:53
20211122062447	2025-05-06 14:02:55
20211124070109	2025-05-06 14:02:56
20211202204204	2025-05-06 14:02:58
20211202204605	2025-05-06 14:02:59
20211210212804	2025-05-06 14:03:05
20211228014915	2025-05-06 14:03:06
20220107221237	2025-05-06 14:03:08
20220228202821	2025-05-06 14:03:10
20220312004840	2025-05-06 14:03:11
20220603231003	2025-05-06 14:03:14
20220603232444	2025-05-06 14:03:15
20220615214548	2025-05-06 14:03:17
20220712093339	2025-05-06 14:03:19
20220908172859	2025-05-06 14:03:20
20220916233421	2025-05-06 14:03:22
20230119133233	2025-05-06 14:03:24
20230128025114	2025-05-06 14:03:26
20230128025212	2025-05-06 14:03:27
20230227211149	2025-05-06 14:03:29
20230228184745	2025-05-06 14:03:31
20230308225145	2025-05-06 14:03:32
20230328144023	2025-05-06 14:03:34
20231018144023	2025-05-06 14:03:36
20231204144023	2025-05-06 14:03:38
20231204144024	2025-05-06 14:03:40
20231204144025	2025-05-06 14:03:42
20240108234812	2025-05-06 14:03:43
20240109165339	2025-05-06 14:03:45
20240227174441	2025-05-06 14:03:48
20240311171622	2025-05-06 14:03:50
20240321100241	2025-05-06 14:03:54
20240401105812	2025-05-06 14:03:58
20240418121054	2025-05-06 14:04:00
20240523004032	2025-05-06 14:04:06
20240618124746	2025-05-06 14:04:07
20240801235015	2025-05-06 14:04:09
20240805133720	2025-05-06 14:04:11
20240827160934	2025-05-06 14:04:12
20240919163303	2025-05-06 14:04:15
20240919163305	2025-05-06 14:04:16
20241019105805	2025-05-06 14:04:18
20241030150047	2025-05-06 14:04:24
20241108114728	2025-05-06 14:04:26
20241121104152	2025-05-06 14:04:28
20241130184212	2025-05-06 14:04:29
20241220035512	2025-05-06 14:04:31
20241220123912	2025-05-06 14:04:33
20241224161212	2025-05-06 14:04:34
20250107150512	2025-05-06 14:04:36
20250110162412	2025-05-06 14:04:37
20250123174212	2025-05-06 14:04:39
20250128220012	2025-05-06 14:04:41
20250506224012	2025-05-25 00:34:57
20250523164012	2025-05-28 15:10:54
\.


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.subscription (id, subscription_id, entity, filters, claims, created_at) FROM stdin;
\.


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.migrations (id, name, hash, executed_at) FROM stdin;
0	create-migrations-table	e18db593bcde2aca2a408c4d1100f6abba2195df	2025-05-06 14:02:37.579638
1	initialmigration	6ab16121fbaa08bbd11b712d05f358f9b555d777	2025-05-06 14:02:37.589981
2	storage-schema	5c7968fd083fcea04050c1b7f6253c9771b99011	2025-05-06 14:02:37.596433
3	pathtoken-column	2cb1b0004b817b29d5b0a971af16bafeede4b70d	2025-05-06 14:02:37.620178
4	add-migrations-rls	427c5b63fe1c5937495d9c635c263ee7a5905058	2025-05-06 14:02:37.643514
5	add-size-functions	79e081a1455b63666c1294a440f8ad4b1e6a7f84	2025-05-06 14:02:37.650014
6	change-column-name-in-get-size	f93f62afdf6613ee5e7e815b30d02dc990201044	2025-05-06 14:02:37.658338
7	add-rls-to-buckets	e7e7f86adbc51049f341dfe8d30256c1abca17aa	2025-05-06 14:02:37.665444
8	add-public-to-buckets	fd670db39ed65f9d08b01db09d6202503ca2bab3	2025-05-06 14:02:37.672442
9	fix-search-function	3a0af29f42e35a4d101c259ed955b67e1bee6825	2025-05-06 14:02:37.681064
10	search-files-search-function	68dc14822daad0ffac3746a502234f486182ef6e	2025-05-06 14:02:37.688064
11	add-trigger-to-auto-update-updated_at-column	7425bdb14366d1739fa8a18c83100636d74dcaa2	2025-05-06 14:02:37.695386
12	add-automatic-avif-detection-flag	8e92e1266eb29518b6a4c5313ab8f29dd0d08df9	2025-05-06 14:02:37.706683
13	add-bucket-custom-limits	cce962054138135cd9a8c4bcd531598684b25e7d	2025-05-06 14:02:37.713768
14	use-bytes-for-max-size	941c41b346f9802b411f06f30e972ad4744dad27	2025-05-06 14:02:37.720832
15	add-can-insert-object-function	934146bc38ead475f4ef4b555c524ee5d66799e5	2025-05-06 14:02:37.751018
16	add-version	76debf38d3fd07dcfc747ca49096457d95b1221b	2025-05-06 14:02:37.758062
17	drop-owner-foreign-key	f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101	2025-05-06 14:02:37.764358
18	add_owner_id_column_deprecate_owner	e7a511b379110b08e2f214be852c35414749fe66	2025-05-06 14:02:37.771034
19	alter-default-value-objects-id	02e5e22a78626187e00d173dc45f58fa66a4f043	2025-05-06 14:02:37.781023
20	list-objects-with-delimiter	cd694ae708e51ba82bf012bba00caf4f3b6393b7	2025-05-06 14:02:37.789324
21	s3-multipart-uploads	8c804d4a566c40cd1e4cc5b3725a664a9303657f	2025-05-06 14:02:37.805211
22	s3-multipart-uploads-big-ints	9737dc258d2397953c9953d9b86920b8be0cdb73	2025-05-06 14:02:37.836898
23	optimize-search-function	9d7e604cddc4b56a5422dc68c9313f4a1b6f132c	2025-05-06 14:02:37.865074
24	operation-function	8312e37c2bf9e76bbe841aa5fda889206d2bf8aa	2025-05-06 14:02:37.87193
25	custom-metadata	d974c6057c3db1c1f847afa0e291e6165693b990	2025-05-06 14:02:37.878262
\.


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads (id, in_progress_size, upload_signature, bucket_id, key, version, owner_id, created_at, user_metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads_parts (id, upload_id, size, part_number, bucket_id, key, etag, owner_id, version, created_at) FROM stdin;
\.


--
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: supabase_admin
--

COPY vault.secrets (id, name, description, secret, key_id, nonce, created_at, updated_at) FROM stdin;
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 1, false);


--
-- Name: alerts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.alerts_id_seq', 2, true);


--
-- Name: authtokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.authtokens_id_seq', 2, true);


--
-- Name: eventlogs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.eventlogs_id_seq', 2, true);


--
-- Name: execute_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.execute_logs_id_seq', 1, false);


--
-- Name: inputs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inputs_id_seq', 28, true);


--
-- Name: locations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.locations_id_seq', 12, true);


--
-- Name: maintenances_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.maintenances_id_seq', 5, true);


--
-- Name: maintenancetypes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.maintenancetypes_id_seq', 8, true);


--
-- Name: motorcycles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.motorcycles_id_seq', 15, true);


--
-- Name: notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notifications_id_seq', 2, true);


--
-- Name: performance_report_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.performance_report_id_seq', 2, true);


--
-- Name: results_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.results_id_seq', 152, true);


--
-- Name: routepoints_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.routepoints_id_seq', 12, true);


--
-- Name: routes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.routes_id_seq', 6, true);


--
-- Name: services_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.services_id_seq', 6, true);


--
-- Name: taskhistories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.taskhistories_id_seq', 12, true);


--
-- Name: tasks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tasks_id_seq', 6, true);


--
-- Name: user_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_types_id_seq', 3, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 19, true);


--
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: supabase_admin
--

SELECT pg_catalog.setval('realtime.subscription_id_seq', 1, false);


--
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);


--
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);


--
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);


--
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_provider_id_provider_unique UNIQUE (provider_id, provider);


--
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);


--
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);


--
-- Name: mfa_factors mfa_factors_last_challenged_at_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_last_challenged_at_key UNIQUE (last_challenged_at);


--
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);


--
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);


--
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);


--
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);


--
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);


--
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: __EFMigrationsHistory PK___EFMigrationsHistory; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."__EFMigrationsHistory"
    ADD CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY ("MigrationId");


--
-- Name: motorcycle_alerts PK_motorcycle_alerts; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.motorcycle_alerts
    ADD CONSTRAINT "PK_motorcycle_alerts" PRIMARY KEY (moto_id, alert_id);


--
-- Name: user_alerts PK_user_alerts; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_alerts
    ADD CONSTRAINT "PK_user_alerts" PRIMARY KEY (user_id, alert_id);


--
-- Name: user_motorcycle PK_user_motorcycle; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_motorcycle
    ADD CONSTRAINT "PK_user_motorcycle" PRIMARY KEY (moto_id, user_id);


--
-- Name: alerts pk_alerts; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alerts
    ADD CONSTRAINT pk_alerts PRIMARY KEY (id);


--
-- Name: auth_tokens pk_authtokens; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_tokens
    ADD CONSTRAINT pk_authtokens PRIMARY KEY (id);


--
-- Name: event_logs pk_eventlogs; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_logs
    ADD CONSTRAINT pk_eventlogs PRIMARY KEY (id);


--
-- Name: execute_logs pk_executelogs; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.execute_logs
    ADD CONSTRAINT pk_executelogs PRIMARY KEY (id);


--
-- Name: inputs pk_inputs; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inputs
    ADD CONSTRAINT pk_inputs PRIMARY KEY (id);


--
-- Name: locations pk_locations; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT pk_locations PRIMARY KEY (id);


--
-- Name: maintenances pk_maintenances; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.maintenances
    ADD CONSTRAINT pk_maintenances PRIMARY KEY (id);


--
-- Name: maintenance_types pk_maintenancetypes; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.maintenance_types
    ADD CONSTRAINT pk_maintenancetypes PRIMARY KEY (id);


--
-- Name: motorcycles pk_motorcycles; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.motorcycles
    ADD CONSTRAINT pk_motorcycles PRIMARY KEY (id);


--
-- Name: notifications pk_notifications; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT pk_notifications PRIMARY KEY (id);


--
-- Name: performance_report pk_performancereports; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.performance_report
    ADD CONSTRAINT pk_performancereports PRIMARY KEY (id);


--
-- Name: results pk_resultes; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.results
    ADD CONSTRAINT pk_resultes PRIMARY KEY (id);


--
-- Name: route_points pk_routepoints; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.route_points
    ADD CONSTRAINT pk_routepoints PRIMARY KEY (id);


--
-- Name: routes pk_routes; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.routes
    ADD CONSTRAINT pk_routes PRIMARY KEY (id);


--
-- Name: services pk_services; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT pk_services PRIMARY KEY (id);


--
-- Name: task_histories pk_taskhistories; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_histories
    ADD CONSTRAINT pk_taskhistories PRIMARY KEY (id);


--
-- Name: tasks pk_tasks; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT pk_tasks PRIMARY KEY (id);


--
-- Name: users pk_users; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT pk_users PRIMARY KEY (id);


--
-- Name: user_types pk_usertypes; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_types
    ADD CONSTRAINT pk_usertypes PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.subscription
    ADD CONSTRAINT pk_subscription PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);


--
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);


--
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);


--
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);


--
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);


--
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);


--
-- Name: INDEX identities_email_idx; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';


--
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);


--
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);


--
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);


--
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);


--
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);


--
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);


--
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);


--
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);


--
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);


--
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);


--
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);


--
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);


--
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);


--
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);


--
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);


--
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);


--
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);


--
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);


--
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);


--
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);


--
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));


--
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);


--
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));


--
-- Name: unique_phone_factor_per_user; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX unique_phone_factor_per_user ON auth.mfa_factors USING btree (user_id, phone);


--
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);


--
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);


--
-- Name: INDEX users_email_partial_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));


--
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);


--
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);


--
-- Name: IX_maintenances_moto_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_maintenances_moto_id" ON public.maintenances USING btree (moto_id);


--
-- Name: IX_motorcycle_alerts_AlertId1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_motorcycle_alerts_AlertId1" ON public.motorcycle_alerts USING btree ("AlertId1");


--
-- Name: IX_services_moto_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_services_moto_id" ON public.services USING btree (moto_id);


--
-- Name: IX_tasks_UserId1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_tasks_UserId1" ON public.tasks USING btree ("UserId1");


--
-- Name: IX_users_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IX_users_email" ON public.users USING btree (email);


--
-- Name: ix_authtokens_userid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_authtokens_userid ON public.auth_tokens USING btree (user_id);


--
-- Name: ix_locations_taskid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_locations_taskid ON public.locations USING btree (task_id);


--
-- Name: ix_maintenances_typeid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_maintenances_typeid ON public.maintenances USING btree (type_id);


--
-- Name: ix_motorcyclealerts_alertid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_motorcyclealerts_alertid ON public.motorcycle_alerts USING btree (alert_id);


--
-- Name: ix_notifications_userid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_notifications_userid ON public.notifications USING btree (user_id);


--
-- Name: ix_performancereports_motoid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_performancereports_motoid ON public.performance_report USING btree (moto_id);


--
-- Name: ix_resultes_inputid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_resultes_inputid ON public.results USING btree (input_id);


--
-- Name: ix_routepoints_routeid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_routepoints_routeid ON public.route_points USING btree (route_id);


--
-- Name: ix_routes_taskid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_routes_taskid ON public.routes USING btree (task_id);


--
-- Name: ix_services_userid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_services_userid ON public.services USING btree (user_id);


--
-- Name: ix_taskhistories_taskid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_taskhistories_taskid ON public.task_histories USING btree (task_id);


--
-- Name: ix_tasks_serviceid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_tasks_serviceid ON public.tasks USING btree (service_id);


--
-- Name: ix_tasks_userid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_tasks_userid ON public.tasks USING btree (user_id);


--
-- Name: ix_useralerts_alertid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_useralerts_alertid ON public.user_alerts USING btree (alert_id);


--
-- Name: ix_usermotorcycles_userid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_usermotorcycles_userid ON public.user_motorcycle USING btree (user_id);


--
-- Name: ix_users_typeid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_users_typeid ON public.users USING btree (type_id);


--
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING btree (entity);


--
-- Name: subscription_subscription_id_entity_filters_key; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_key ON realtime.subscription USING btree (subscription_id, entity, filters);


--
-- Name: bname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);


--
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);


--
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);


--
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");


--
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);


--
-- Name: subscription tr_check_filters; Type: TRIGGER; Schema: realtime; Owner: supabase_admin
--

CREATE TRIGGER tr_check_filters BEFORE INSERT OR UPDATE ON realtime.subscription FOR EACH ROW EXECUTE FUNCTION realtime.subscription_check_filters();


--
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();


--
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;


--
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_flow_state_id_fkey FOREIGN KEY (flow_state_id) REFERENCES auth.flow_state(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: motorcycle_alerts FK_motorcycle_alerts_alerts_AlertId1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.motorcycle_alerts
    ADD CONSTRAINT "FK_motorcycle_alerts_alerts_AlertId1" FOREIGN KEY ("AlertId1") REFERENCES public.alerts(id);


--
-- Name: tasks FK_tasks_users_UserId1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT "FK_tasks_users_UserId1" FOREIGN KEY ("UserId1") REFERENCES public.users(id);


--
-- Name: auth_tokens fk_authtokens_users_userid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_tokens
    ADD CONSTRAINT fk_authtokens_users_userid FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: locations fk_locations_tasks_taskid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT fk_locations_tasks_taskid FOREIGN KEY (task_id) REFERENCES public.tasks(id) ON DELETE CASCADE;


--
-- Name: maintenances fk_maintenances_maintenancetypes_typeid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.maintenances
    ADD CONSTRAINT fk_maintenances_maintenancetypes_typeid FOREIGN KEY (type_id) REFERENCES public.maintenance_types(id) ON DELETE CASCADE;


--
-- Name: maintenances fk_maintenances_motorcycles_motorcycleid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.maintenances
    ADD CONSTRAINT fk_maintenances_motorcycles_motorcycleid FOREIGN KEY (moto_id) REFERENCES public.motorcycles(id) ON DELETE CASCADE;


--
-- Name: motorcycle_alerts fk_motorcyclealerts_alerts_alertid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.motorcycle_alerts
    ADD CONSTRAINT fk_motorcyclealerts_alerts_alertid FOREIGN KEY (alert_id) REFERENCES public.alerts(id) ON DELETE CASCADE;


--
-- Name: motorcycle_alerts fk_motorcyclealerts_motorcycles_motorcycleid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.motorcycle_alerts
    ADD CONSTRAINT fk_motorcyclealerts_motorcycles_motorcycleid FOREIGN KEY (moto_id) REFERENCES public.motorcycles(id) ON DELETE CASCADE;


--
-- Name: notifications fk_notifications_users_userid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT fk_notifications_users_userid FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: performance_report fk_performancereports_motorcycles_motoid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.performance_report
    ADD CONSTRAINT fk_performancereports_motorcycles_motoid FOREIGN KEY (moto_id) REFERENCES public.motorcycles(id) ON DELETE CASCADE;


--
-- Name: results fk_resultes_inputs_inputid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.results
    ADD CONSTRAINT fk_resultes_inputs_inputid FOREIGN KEY (input_id) REFERENCES public.inputs(id) ON DELETE CASCADE;


--
-- Name: route_points fk_routepoints_routes_routeid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.route_points
    ADD CONSTRAINT fk_routepoints_routes_routeid FOREIGN KEY (route_id) REFERENCES public.routes(id) ON DELETE CASCADE;


--
-- Name: routes fk_routes_tasks_taskid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.routes
    ADD CONSTRAINT fk_routes_tasks_taskid FOREIGN KEY (task_id) REFERENCES public.tasks(id) ON DELETE CASCADE;


--
-- Name: services fk_services_motorcycles_motorcycleid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT fk_services_motorcycles_motorcycleid FOREIGN KEY (moto_id) REFERENCES public.motorcycles(id) ON DELETE CASCADE;


--
-- Name: services fk_services_users_userid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT fk_services_users_userid FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: task_histories fk_taskhistories_tasks_taskid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_histories
    ADD CONSTRAINT fk_taskhistories_tasks_taskid FOREIGN KEY (task_id) REFERENCES public.tasks(id) ON DELETE CASCADE;


--
-- Name: tasks fk_tasks_services_serviceid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT fk_tasks_services_serviceid FOREIGN KEY (service_id) REFERENCES public.services(id) ON DELETE SET NULL;


--
-- Name: tasks fk_tasks_users_userid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT fk_tasks_users_userid FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: user_alerts fk_useralerts_alerts_alertid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_alerts
    ADD CONSTRAINT fk_useralerts_alerts_alertid FOREIGN KEY (alert_id) REFERENCES public.alerts(id) ON DELETE CASCADE;


--
-- Name: user_alerts fk_useralerts_users_userid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_alerts
    ADD CONSTRAINT fk_useralerts_users_userid FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: user_motorcycle fk_usermotorcycles_motorcycles_motorcycleid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_motorcycle
    ADD CONSTRAINT fk_usermotorcycles_motorcycles_motorcycleid FOREIGN KEY (moto_id) REFERENCES public.motorcycles(id) ON DELETE CASCADE;


--
-- Name: user_motorcycle fk_usermotorcycles_users_userid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_motorcycle
    ADD CONSTRAINT fk_usermotorcycles_users_userid FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: users fk_users_usertypes_typeid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_users_usertypes_typeid FOREIGN KEY (type_id) REFERENCES public.user_types(id);


--
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;


--
-- Name: audit_log_entries; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.audit_log_entries ENABLE ROW LEVEL SECURITY;

--
-- Name: flow_state; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.flow_state ENABLE ROW LEVEL SECURITY;

--
-- Name: identities; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.identities ENABLE ROW LEVEL SECURITY;

--
-- Name: instances; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.instances ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_amr_claims; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_amr_claims ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_challenges; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_challenges ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_factors; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_factors ENABLE ROW LEVEL SECURITY;

--
-- Name: one_time_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.one_time_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: refresh_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.refresh_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_relay_states; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_relay_states ENABLE ROW LEVEL SECURITY;

--
-- Name: schema_migrations; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.schema_migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: sessions; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sessions ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_domains; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_domains ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: users; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;

--
-- Name: messages; Type: ROW SECURITY; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE realtime.messages ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;

--
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: postgres
--

CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime OWNER TO postgres;

--
-- Name: SCHEMA auth; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA auth TO anon;
GRANT USAGE ON SCHEMA auth TO authenticated;
GRANT USAGE ON SCHEMA auth TO service_role;
GRANT ALL ON SCHEMA auth TO supabase_auth_admin;
GRANT ALL ON SCHEMA auth TO dashboard_user;
GRANT USAGE ON SCHEMA auth TO postgres;


--
-- Name: SCHEMA extensions; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA extensions TO anon;
GRANT USAGE ON SCHEMA extensions TO authenticated;
GRANT USAGE ON SCHEMA extensions TO service_role;
GRANT ALL ON SCHEMA extensions TO dashboard_user;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- Name: SCHEMA realtime; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA realtime TO postgres;
GRANT USAGE ON SCHEMA realtime TO anon;
GRANT USAGE ON SCHEMA realtime TO authenticated;
GRANT USAGE ON SCHEMA realtime TO service_role;
GRANT ALL ON SCHEMA realtime TO supabase_realtime_admin;


--
-- Name: SCHEMA storage; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA storage TO postgres;
GRANT USAGE ON SCHEMA storage TO anon;
GRANT USAGE ON SCHEMA storage TO authenticated;
GRANT USAGE ON SCHEMA storage TO service_role;
GRANT ALL ON SCHEMA storage TO supabase_storage_admin;
GRANT ALL ON SCHEMA storage TO dashboard_user;


--
-- Name: SCHEMA vault; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA vault TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA vault TO service_role;


--
-- Name: FUNCTION email(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.email() TO dashboard_user;
GRANT ALL ON FUNCTION auth.email() TO postgres;


--
-- Name: FUNCTION jwt(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.jwt() TO postgres;
GRANT ALL ON FUNCTION auth.jwt() TO dashboard_user;


--
-- Name: FUNCTION role(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.role() TO dashboard_user;
GRANT ALL ON FUNCTION auth.role() TO postgres;


--
-- Name: FUNCTION uid(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.uid() TO dashboard_user;
GRANT ALL ON FUNCTION auth.uid() TO postgres;


--
-- Name: FUNCTION algorithm_sign(signables text, secret text, algorithm text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.algorithm_sign(signables text, secret text, algorithm text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.algorithm_sign(signables text, secret text, algorithm text) TO dashboard_user;


--
-- Name: FUNCTION armor(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.armor(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO dashboard_user;


--
-- Name: FUNCTION armor(bytea, text[], text[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO dashboard_user;


--
-- Name: FUNCTION crypt(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.crypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO dashboard_user;


--
-- Name: FUNCTION dearmor(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.dearmor(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO dashboard_user;


--
-- Name: FUNCTION decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION decrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION digest(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION digest(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.digest(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO dashboard_user;


--
-- Name: FUNCTION encrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION encrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION gen_random_bytes(integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO dashboard_user;


--
-- Name: FUNCTION gen_random_uuid(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO dashboard_user;


--
-- Name: FUNCTION gen_salt(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_salt(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO dashboard_user;


--
-- Name: FUNCTION gen_salt(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO dashboard_user;


--
-- Name: FUNCTION grant_pg_cron_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_cron_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO dashboard_user;


--
-- Name: FUNCTION grant_pg_graphql_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.grant_pg_graphql_access() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION grant_pg_net_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_net_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO dashboard_user;


--
-- Name: FUNCTION hmac(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION hmac(text, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements_reset(userid oid, dbid oid, queryid bigint); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint) TO dashboard_user;


--
-- Name: FUNCTION pgp_armor_headers(text, OUT key text, OUT value text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO dashboard_user;


--
-- Name: FUNCTION pgp_key_id(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgrst_ddl_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_ddl_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgrst_drop_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_drop_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION set_graphql_placeholder(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.set_graphql_placeholder() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION sign(payload json, secret text, algorithm text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.sign(payload json, secret text, algorithm text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.sign(payload json, secret text, algorithm text) TO dashboard_user;


--
-- Name: FUNCTION try_cast_double(inp text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.try_cast_double(inp text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.try_cast_double(inp text) TO dashboard_user;


--
-- Name: FUNCTION url_decode(data text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.url_decode(data text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.url_decode(data text) TO dashboard_user;


--
-- Name: FUNCTION url_encode(data bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.url_encode(data bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.url_encode(data bytea) TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v1(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v1mc(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v3(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v4(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v5(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO dashboard_user;


--
-- Name: FUNCTION uuid_nil(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_nil() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_dns(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_oid(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_url(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_x500(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO dashboard_user;


--
-- Name: FUNCTION verify(token text, secret text, algorithm text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.verify(token text, secret text, algorithm text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.verify(token text, secret text, algorithm text) TO dashboard_user;


--
-- Name: FUNCTION graphql("operationName" text, query text, variables jsonb, extensions jsonb); Type: ACL; Schema: graphql_public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO postgres;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO anon;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO authenticated;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO service_role;


--
-- Name: FUNCTION get_auth(p_usename text); Type: ACL; Schema: pgbouncer; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgbouncer.get_auth(p_usename text) FROM PUBLIC;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO pgbouncer;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO postgres;


--
-- Name: FUNCTION apply_rls(wal jsonb, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO supabase_realtime_admin;


--
-- Name: FUNCTION broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO postgres;
GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO dashboard_user;


--
-- Name: FUNCTION build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO postgres;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO anon;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO service_role;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION "cast"(val text, type_ regtype); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO postgres;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO dashboard_user;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO anon;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO authenticated;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO service_role;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO supabase_realtime_admin;


--
-- Name: FUNCTION check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO postgres;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO anon;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO authenticated;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO service_role;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO supabase_realtime_admin;


--
-- Name: FUNCTION is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO postgres;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO anon;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO service_role;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO supabase_realtime_admin;


--
-- Name: FUNCTION quote_wal2json(entity regclass); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO postgres;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO anon;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO authenticated;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO service_role;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO supabase_realtime_admin;


--
-- Name: FUNCTION send(payload jsonb, event text, topic text, private boolean); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO postgres;
GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO dashboard_user;


--
-- Name: FUNCTION subscription_check_filters(); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO postgres;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO dashboard_user;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO anon;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO authenticated;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO service_role;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO supabase_realtime_admin;


--
-- Name: FUNCTION to_regrole(role_name text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO postgres;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO anon;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO authenticated;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO service_role;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO supabase_realtime_admin;


--
-- Name: FUNCTION topic(); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.topic() TO postgres;
GRANT ALL ON FUNCTION realtime.topic() TO dashboard_user;


--
-- Name: FUNCTION can_insert_object(bucketid text, name text, owner uuid, metadata jsonb); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) TO postgres;


--
-- Name: FUNCTION extension(name text); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.extension(name text) TO postgres;


--
-- Name: FUNCTION filename(name text); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.filename(name text) TO postgres;


--
-- Name: FUNCTION foldername(name text); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.foldername(name text) TO postgres;


--
-- Name: FUNCTION get_size_by_bucket(); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.get_size_by_bucket() TO postgres;


--
-- Name: FUNCTION list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text) TO postgres;


--
-- Name: FUNCTION list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text) TO postgres;


--
-- Name: FUNCTION operation(); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.operation() TO postgres;


--
-- Name: FUNCTION search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) TO postgres;


--
-- Name: FUNCTION update_updated_at_column(); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.update_updated_at_column() TO postgres;


--
-- Name: FUNCTION _crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO service_role;


--
-- Name: FUNCTION create_secret(new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- Name: FUNCTION update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- Name: TABLE audit_log_entries; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.audit_log_entries TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.audit_log_entries TO postgres;
GRANT SELECT ON TABLE auth.audit_log_entries TO postgres WITH GRANT OPTION;


--
-- Name: TABLE flow_state; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.flow_state TO postgres;
GRANT SELECT ON TABLE auth.flow_state TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.flow_state TO dashboard_user;


--
-- Name: TABLE identities; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.identities TO postgres;
GRANT SELECT ON TABLE auth.identities TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.identities TO dashboard_user;


--
-- Name: TABLE instances; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.instances TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.instances TO postgres;
GRANT SELECT ON TABLE auth.instances TO postgres WITH GRANT OPTION;


--
-- Name: TABLE mfa_amr_claims; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_amr_claims TO postgres;
GRANT SELECT ON TABLE auth.mfa_amr_claims TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_amr_claims TO dashboard_user;


--
-- Name: TABLE mfa_challenges; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_challenges TO postgres;
GRANT SELECT ON TABLE auth.mfa_challenges TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_challenges TO dashboard_user;


--
-- Name: TABLE mfa_factors; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_factors TO postgres;
GRANT SELECT ON TABLE auth.mfa_factors TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_factors TO dashboard_user;


--
-- Name: TABLE one_time_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.one_time_tokens TO postgres;
GRANT SELECT ON TABLE auth.one_time_tokens TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.one_time_tokens TO dashboard_user;


--
-- Name: TABLE refresh_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.refresh_tokens TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.refresh_tokens TO postgres;
GRANT SELECT ON TABLE auth.refresh_tokens TO postgres WITH GRANT OPTION;


--
-- Name: SEQUENCE refresh_tokens_id_seq; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO dashboard_user;
GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO postgres;


--
-- Name: TABLE saml_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.saml_providers TO postgres;
GRANT SELECT ON TABLE auth.saml_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_providers TO dashboard_user;


--
-- Name: TABLE saml_relay_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.saml_relay_states TO postgres;
GRANT SELECT ON TABLE auth.saml_relay_states TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_relay_states TO dashboard_user;


--
-- Name: TABLE sessions; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sessions TO postgres;
GRANT SELECT ON TABLE auth.sessions TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sessions TO dashboard_user;


--
-- Name: TABLE sso_domains; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sso_domains TO postgres;
GRANT SELECT ON TABLE auth.sso_domains TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_domains TO dashboard_user;


--
-- Name: TABLE sso_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sso_providers TO postgres;
GRANT SELECT ON TABLE auth.sso_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_providers TO dashboard_user;


--
-- Name: TABLE users; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.users TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.users TO postgres;
GRANT SELECT ON TABLE auth.users TO postgres WITH GRANT OPTION;


--
-- Name: TABLE pg_stat_statements; Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON TABLE extensions.pg_stat_statements TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements TO dashboard_user;


--
-- Name: TABLE pg_stat_statements_info; Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON TABLE extensions.pg_stat_statements_info TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements_info TO dashboard_user;


--
-- Name: TABLE messages; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON TABLE realtime.messages TO postgres;
GRANT ALL ON TABLE realtime.messages TO dashboard_user;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO authenticated;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO service_role;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.schema_migrations TO postgres;
GRANT ALL ON TABLE realtime.schema_migrations TO dashboard_user;
GRANT SELECT ON TABLE realtime.schema_migrations TO anon;
GRANT SELECT ON TABLE realtime.schema_migrations TO authenticated;
GRANT SELECT ON TABLE realtime.schema_migrations TO service_role;
GRANT ALL ON TABLE realtime.schema_migrations TO supabase_realtime_admin;


--
-- Name: TABLE subscription; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.subscription TO postgres;
GRANT ALL ON TABLE realtime.subscription TO dashboard_user;
GRANT SELECT ON TABLE realtime.subscription TO anon;
GRANT SELECT ON TABLE realtime.subscription TO authenticated;
GRANT SELECT ON TABLE realtime.subscription TO service_role;
GRANT ALL ON TABLE realtime.subscription TO supabase_realtime_admin;


--
-- Name: SEQUENCE subscription_id_seq; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO postgres;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO dashboard_user;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO anon;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO authenticated;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO service_role;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO supabase_realtime_admin;


--
-- Name: TABLE buckets; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.buckets TO anon;
GRANT ALL ON TABLE storage.buckets TO authenticated;
GRANT ALL ON TABLE storage.buckets TO service_role;
GRANT ALL ON TABLE storage.buckets TO postgres;


--
-- Name: TABLE objects; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.objects TO anon;
GRANT ALL ON TABLE storage.objects TO authenticated;
GRANT ALL ON TABLE storage.objects TO service_role;
GRANT ALL ON TABLE storage.objects TO postgres;


--
-- Name: TABLE s3_multipart_uploads; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO anon;
GRANT ALL ON TABLE storage.s3_multipart_uploads TO postgres;


--
-- Name: TABLE s3_multipart_uploads_parts; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads_parts TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO anon;
GRANT ALL ON TABLE storage.s3_multipart_uploads_parts TO postgres;


--
-- Name: TABLE secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.secrets TO service_role;


--
-- Name: TABLE decrypted_secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.decrypted_secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.decrypted_secrets TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON SEQUENCES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON FUNCTIONS TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON TABLES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO service_role;


--
-- Name: issue_graphql_placeholder; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_graphql_placeholder ON sql_drop
         WHEN TAG IN ('DROP EXTENSION')
   EXECUTE FUNCTION extensions.set_graphql_placeholder();


ALTER EVENT TRIGGER issue_graphql_placeholder OWNER TO supabase_admin;

--
-- Name: issue_pg_cron_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_cron_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_cron_access();


ALTER EVENT TRIGGER issue_pg_cron_access OWNER TO supabase_admin;

--
-- Name: issue_pg_graphql_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_graphql_access ON ddl_command_end
         WHEN TAG IN ('CREATE FUNCTION')
   EXECUTE FUNCTION extensions.grant_pg_graphql_access();


ALTER EVENT TRIGGER issue_pg_graphql_access OWNER TO supabase_admin;

--
-- Name: issue_pg_net_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_net_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_net_access();


ALTER EVENT TRIGGER issue_pg_net_access OWNER TO supabase_admin;

--
-- Name: pgrst_ddl_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_ddl_watch ON ddl_command_end
   EXECUTE FUNCTION extensions.pgrst_ddl_watch();


ALTER EVENT TRIGGER pgrst_ddl_watch OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_drop_watch ON sql_drop
   EXECUTE FUNCTION extensions.pgrst_drop_watch();


ALTER EVENT TRIGGER pgrst_drop_watch OWNER TO supabase_admin;

--
-- PostgreSQL database dump complete
--


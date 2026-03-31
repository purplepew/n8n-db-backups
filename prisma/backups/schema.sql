


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


COMMENT ON SCHEMA "public" IS 'standard public schema';



CREATE EXTENSION IF NOT EXISTS "pg_graphql" WITH SCHEMA "graphql";






CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";






CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";





SET default_tablespace = '';

SET default_table_access_method = "heap";


CREATE TABLE IF NOT EXISTS "public"."auth_identity" (
    "userId" "uuid",
    "providerId" character varying(64) NOT NULL,
    "providerType" character varying(32) NOT NULL,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE "public"."auth_identity" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."auth_provider_sync_history" (
    "id" integer NOT NULL,
    "providerType" character varying(32) NOT NULL,
    "runMode" "text" NOT NULL,
    "status" "text" NOT NULL,
    "startedAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "endedAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "scanned" integer NOT NULL,
    "created" integer NOT NULL,
    "updated" integer NOT NULL,
    "disabled" integer NOT NULL,
    "error" "text"
);


ALTER TABLE "public"."auth_provider_sync_history" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."auth_provider_sync_history_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."auth_provider_sync_history_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."auth_provider_sync_history_id_seq" OWNED BY "public"."auth_provider_sync_history"."id";



CREATE TABLE IF NOT EXISTS "public"."credentials_entity" (
    "name" character varying(128) NOT NULL,
    "data" "text" NOT NULL,
    "type" character varying(128) NOT NULL,
    "nodesAccess" json NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "id" character varying(36) NOT NULL
);


ALTER TABLE "public"."credentials_entity" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."event_destinations" (
    "id" "uuid" NOT NULL,
    "destination" "jsonb" NOT NULL,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE "public"."event_destinations" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."execution_data" (
    "executionId" integer NOT NULL,
    "workflowData" json NOT NULL,
    "data" "text" NOT NULL
);


ALTER TABLE "public"."execution_data" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."execution_entity" (
    "id" integer NOT NULL,
    "finished" boolean NOT NULL,
    "mode" character varying NOT NULL,
    "retryOf" character varying,
    "retrySuccessId" character varying,
    "startedAt" timestamp without time zone NOT NULL,
    "stoppedAt" timestamp without time zone,
    "waitTill" timestamp without time zone,
    "status" character varying,
    "workflowId" character varying(36)
);


ALTER TABLE "public"."execution_entity" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."execution_entity_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."execution_entity_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."execution_entity_id_seq" OWNED BY "public"."execution_entity"."id";



CREATE TABLE IF NOT EXISTS "public"."execution_metadata" (
    "id" integer NOT NULL,
    "executionId" integer NOT NULL,
    "key" "text" NOT NULL,
    "value" "text" NOT NULL
);


ALTER TABLE "public"."execution_metadata" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."execution_metadata_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."execution_metadata_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."execution_metadata_id_seq" OWNED BY "public"."execution_metadata"."id";



CREATE TABLE IF NOT EXISTS "public"."installed_nodes" (
    "name" character varying(200) NOT NULL,
    "type" character varying(200) NOT NULL,
    "latestVersion" integer DEFAULT 1 NOT NULL,
    "package" character varying(241) NOT NULL
);


ALTER TABLE "public"."installed_nodes" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."installed_packages" (
    "packageName" character varying(214) NOT NULL,
    "installedVersion" character varying(50) NOT NULL,
    "authorName" character varying(70),
    "authorEmail" character varying(70),
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE "public"."installed_packages" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."migrations" (
    "id" integer NOT NULL,
    "timestamp" bigint NOT NULL,
    "name" character varying NOT NULL
);


ALTER TABLE "public"."migrations" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."migrations_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."migrations_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."migrations_id_seq" OWNED BY "public"."migrations"."id";



CREATE TABLE IF NOT EXISTS "public"."role" (
    "id" integer NOT NULL,
    "name" character varying(32) NOT NULL,
    "scope" character varying(255) NOT NULL,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE "public"."role" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."role_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."role_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."role_id_seq" OWNED BY "public"."role"."id";



CREATE TABLE IF NOT EXISTS "public"."settings" (
    "key" character varying(255) NOT NULL,
    "value" "text" NOT NULL,
    "loadOnStartup" boolean DEFAULT false NOT NULL
);


ALTER TABLE "public"."settings" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."shared_credentials" (
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "roleId" integer NOT NULL,
    "userId" "uuid" NOT NULL,
    "credentialsId" character varying(36) NOT NULL
);


ALTER TABLE "public"."shared_credentials" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."shared_workflow" (
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "roleId" integer NOT NULL,
    "userId" "uuid" NOT NULL,
    "workflowId" character varying(36) NOT NULL
);


ALTER TABLE "public"."shared_workflow" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."tag_entity" (
    "name" character varying(24) NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "id" character varying(36) NOT NULL
);


ALTER TABLE "public"."tag_entity" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."user" (
    "id" "uuid" DEFAULT "uuid_in"((OVERLAY(OVERLAY("md5"(((("random"())::"text" || ':'::"text") || ("clock_timestamp"())::"text")) PLACING '4'::"text" FROM 13) PLACING "to_hex"(("floor"((("random"() * (((11 - 8) + 1))::double precision) + (8)::double precision)))::integer) FROM 17))::"cstring") NOT NULL,
    "email" character varying(255),
    "firstName" character varying(32),
    "lastName" character varying(32),
    "password" character varying(255),
    "personalizationAnswers" json,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "globalRoleId" integer NOT NULL,
    "settings" json,
    "apiKey" character varying(255),
    "disabled" boolean DEFAULT false NOT NULL
);


ALTER TABLE "public"."user" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."variables" (
    "key" character varying(50) NOT NULL,
    "type" character varying(50) DEFAULT 'string'::character varying NOT NULL,
    "value" character varying(255),
    "id" character varying(36) NOT NULL
);


ALTER TABLE "public"."variables" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."webhook_entity" (
    "webhookPath" character varying NOT NULL,
    "method" character varying NOT NULL,
    "node" character varying NOT NULL,
    "webhookId" character varying,
    "pathLength" integer,
    "workflowId" character varying(36) NOT NULL
);


ALTER TABLE "public"."webhook_entity" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."workflow_entity" (
    "name" character varying(128) NOT NULL,
    "active" boolean NOT NULL,
    "nodes" json NOT NULL,
    "connections" json NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "updatedAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    "settings" json,
    "staticData" json,
    "pinData" json,
    "versionId" character(36),
    "triggerCount" integer DEFAULT 0 NOT NULL,
    "id" character varying(36) NOT NULL
);


ALTER TABLE "public"."workflow_entity" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."workflow_statistics" (
    "count" integer DEFAULT 0,
    "latestEvent" timestamp without time zone,
    "name" character varying(128) NOT NULL,
    "workflowId" character varying(36) NOT NULL
);


ALTER TABLE "public"."workflow_statistics" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."workflows_tags" (
    "workflowId" character varying(36) NOT NULL,
    "tagId" character varying(36) NOT NULL
);


ALTER TABLE "public"."workflows_tags" OWNER TO "postgres";


ALTER TABLE ONLY "public"."auth_provider_sync_history" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."auth_provider_sync_history_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."execution_entity" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."execution_entity_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."execution_metadata" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."execution_metadata_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."migrations" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."migrations_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."role" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."role_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."installed_packages"
    ADD CONSTRAINT "PK_08cc9197c39b028c1e9beca225940576fd1a5804" PRIMARY KEY ("packageName");



ALTER TABLE ONLY "public"."migrations"
    ADD CONSTRAINT "PK_8c82d7f526340ab734260ea46be" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."installed_nodes"
    ADD CONSTRAINT "PK_8ebd28194e4f792f96b5933423fc439df97d9689" PRIMARY KEY ("name");



ALTER TABLE ONLY "public"."webhook_entity"
    ADD CONSTRAINT "PK_b21ace2e13596ccd87dc9bf4ea6" PRIMARY KEY ("webhookPath", "method");



ALTER TABLE ONLY "public"."settings"
    ADD CONSTRAINT "PK_dc0fe14e6d9943f268e7b119f69ab8bd" PRIMARY KEY ("key");



ALTER TABLE ONLY "public"."role"
    ADD CONSTRAINT "PK_e853ce24e8200abe5721d2c6ac552b73" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."user"
    ADD CONSTRAINT "PK_ea8f538c94b6e352418254ed6474a81f" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."role"
    ADD CONSTRAINT "UQ_5b49d0f504f7ef31045a1fb2eb8" UNIQUE ("scope", "name");



ALTER TABLE ONLY "public"."user"
    ADD CONSTRAINT "UQ_e12875dfb3b1d92d7d7c5377e2" UNIQUE ("email");



ALTER TABLE ONLY "public"."auth_identity"
    ADD CONSTRAINT "auth_identity_pkey" PRIMARY KEY ("providerId", "providerType");



ALTER TABLE ONLY "public"."auth_provider_sync_history"
    ADD CONSTRAINT "auth_provider_sync_history_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."credentials_entity"
    ADD CONSTRAINT "credentials_entity_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."event_destinations"
    ADD CONSTRAINT "event_destinations_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."execution_metadata"
    ADD CONSTRAINT "execution_metadata_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."execution_entity"
    ADD CONSTRAINT "pk_e3e63bbf986767844bbe1166d4e" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."shared_credentials"
    ADD CONSTRAINT "pk_shared_credentials_id" PRIMARY KEY ("userId", "credentialsId");



ALTER TABLE ONLY "public"."shared_workflow"
    ADD CONSTRAINT "pk_shared_workflow_id" PRIMARY KEY ("userId", "workflowId");



ALTER TABLE ONLY "public"."workflow_statistics"
    ADD CONSTRAINT "pk_workflow_statistics" PRIMARY KEY ("workflowId", "name");



ALTER TABLE ONLY "public"."workflows_tags"
    ADD CONSTRAINT "pk_workflows_tags" PRIMARY KEY ("workflowId", "tagId");



ALTER TABLE ONLY "public"."tag_entity"
    ADD CONSTRAINT "tag_entity_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."variables"
    ADD CONSTRAINT "variables_key_key" UNIQUE ("key");



ALTER TABLE ONLY "public"."variables"
    ADD CONSTRAINT "variables_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."workflow_entity"
    ADD CONSTRAINT "workflow_entity_pkey" PRIMARY KEY ("id");



CREATE INDEX "IDX_6d44376da6c1058b5e81ed8a154e1fee106046eb" ON "public"."execution_metadata" USING "btree" ("executionId");



CREATE INDEX "IDX_85b981df7b444f905f8bf50747" ON "public"."execution_entity" USING "btree" ("waitTill", "id");



CREATE UNIQUE INDEX "UQ_ie0zomxves9w3p774drfrkxtj5" ON "public"."user" USING "btree" ("apiKey");



CREATE INDEX "idx_07fde106c0b471d8cc80a64fc8" ON "public"."credentials_entity" USING "btree" ("type");



CREATE INDEX "idx_16f4436789e804e3e1c9eeb240" ON "public"."webhook_entity" USING "btree" ("webhookId", "method", "pathLength");



CREATE UNIQUE INDEX "idx_812eb05f7451ca757fb98444ce" ON "public"."tag_entity" USING "btree" ("name");



CREATE INDEX "idx_execution_entity_workflow_id_id" ON "public"."execution_entity" USING "btree" ("workflowId", "id");



CREATE INDEX "idx_shared_credentials_credentials_id" ON "public"."shared_credentials" USING "btree" ("credentialsId");



CREATE INDEX "idx_shared_workflow_workflow_id" ON "public"."shared_workflow" USING "btree" ("workflowId");



CREATE INDEX "idx_workflows_tags_workflow_id" ON "public"."workflows_tags" USING "btree" ("workflowId");



CREATE UNIQUE INDEX "pk_credentials_entity_id" ON "public"."credentials_entity" USING "btree" ("id");



CREATE UNIQUE INDEX "pk_tag_entity_id" ON "public"."tag_entity" USING "btree" ("id");



CREATE UNIQUE INDEX "pk_variables_id" ON "public"."variables" USING "btree" ("id");



CREATE UNIQUE INDEX "pk_workflow_entity_id" ON "public"."workflow_entity" USING "btree" ("id");



ALTER TABLE ONLY "public"."shared_workflow"
    ADD CONSTRAINT "FK_3540da03964527aa24ae014b780" FOREIGN KEY ("roleId") REFERENCES "public"."role"("id");



ALTER TABLE ONLY "public"."shared_credentials"
    ADD CONSTRAINT "FK_484f0327e778648dd04f1d70493" FOREIGN KEY ("userId") REFERENCES "public"."user"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."installed_nodes"
    ADD CONSTRAINT "FK_73f857fc5dce682cef8a99c11dbddbc969618951" FOREIGN KEY ("package") REFERENCES "public"."installed_packages"("packageName") ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY "public"."shared_workflow"
    ADD CONSTRAINT "FK_82b2fd9ec4e3e24209af8160282" FOREIGN KEY ("userId") REFERENCES "public"."user"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."shared_credentials"
    ADD CONSTRAINT "FK_c68e056637562000b68f480815a" FOREIGN KEY ("roleId") REFERENCES "public"."role"("id");



ALTER TABLE ONLY "public"."user"
    ADD CONSTRAINT "FK_f0609be844f9200ff4365b1bb3d" FOREIGN KEY ("globalRoleId") REFERENCES "public"."role"("id");



ALTER TABLE ONLY "public"."auth_identity"
    ADD CONSTRAINT "auth_identity_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."user"("id");



ALTER TABLE ONLY "public"."execution_data"
    ADD CONSTRAINT "execution_data_fk" FOREIGN KEY ("executionId") REFERENCES "public"."execution_entity"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."execution_metadata"
    ADD CONSTRAINT "execution_metadata_fk" FOREIGN KEY ("executionId") REFERENCES "public"."execution_entity"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."execution_entity"
    ADD CONSTRAINT "fk_execution_entity_workflow_id" FOREIGN KEY ("workflowId") REFERENCES "public"."workflow_entity"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."shared_credentials"
    ADD CONSTRAINT "fk_shared_credentials_credentials_id" FOREIGN KEY ("credentialsId") REFERENCES "public"."credentials_entity"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."shared_workflow"
    ADD CONSTRAINT "fk_shared_workflow_workflow_id" FOREIGN KEY ("workflowId") REFERENCES "public"."workflow_entity"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."webhook_entity"
    ADD CONSTRAINT "fk_webhook_entity_workflow_id" FOREIGN KEY ("workflowId") REFERENCES "public"."workflow_entity"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."workflow_statistics"
    ADD CONSTRAINT "fk_workflow_statistics_workflow_id" FOREIGN KEY ("workflowId") REFERENCES "public"."workflow_entity"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."workflows_tags"
    ADD CONSTRAINT "fk_workflows_tags_tag_id" FOREIGN KEY ("tagId") REFERENCES "public"."tag_entity"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."workflows_tags"
    ADD CONSTRAINT "fk_workflows_tags_workflow_id" FOREIGN KEY ("workflowId") REFERENCES "public"."workflow_entity"("id") ON DELETE CASCADE;





ALTER PUBLICATION "supabase_realtime" OWNER TO "postgres";


GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";








































































































































































GRANT ALL ON TABLE "public"."auth_identity" TO "anon";
GRANT ALL ON TABLE "public"."auth_identity" TO "authenticated";
GRANT ALL ON TABLE "public"."auth_identity" TO "service_role";



GRANT ALL ON TABLE "public"."auth_provider_sync_history" TO "anon";
GRANT ALL ON TABLE "public"."auth_provider_sync_history" TO "authenticated";
GRANT ALL ON TABLE "public"."auth_provider_sync_history" TO "service_role";



GRANT ALL ON SEQUENCE "public"."auth_provider_sync_history_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."auth_provider_sync_history_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."auth_provider_sync_history_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."credentials_entity" TO "anon";
GRANT ALL ON TABLE "public"."credentials_entity" TO "authenticated";
GRANT ALL ON TABLE "public"."credentials_entity" TO "service_role";



GRANT ALL ON TABLE "public"."event_destinations" TO "anon";
GRANT ALL ON TABLE "public"."event_destinations" TO "authenticated";
GRANT ALL ON TABLE "public"."event_destinations" TO "service_role";



GRANT ALL ON TABLE "public"."execution_data" TO "anon";
GRANT ALL ON TABLE "public"."execution_data" TO "authenticated";
GRANT ALL ON TABLE "public"."execution_data" TO "service_role";



GRANT ALL ON TABLE "public"."execution_entity" TO "anon";
GRANT ALL ON TABLE "public"."execution_entity" TO "authenticated";
GRANT ALL ON TABLE "public"."execution_entity" TO "service_role";



GRANT ALL ON SEQUENCE "public"."execution_entity_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."execution_entity_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."execution_entity_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."execution_metadata" TO "anon";
GRANT ALL ON TABLE "public"."execution_metadata" TO "authenticated";
GRANT ALL ON TABLE "public"."execution_metadata" TO "service_role";



GRANT ALL ON SEQUENCE "public"."execution_metadata_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."execution_metadata_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."execution_metadata_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."installed_nodes" TO "anon";
GRANT ALL ON TABLE "public"."installed_nodes" TO "authenticated";
GRANT ALL ON TABLE "public"."installed_nodes" TO "service_role";



GRANT ALL ON TABLE "public"."installed_packages" TO "anon";
GRANT ALL ON TABLE "public"."installed_packages" TO "authenticated";
GRANT ALL ON TABLE "public"."installed_packages" TO "service_role";



GRANT ALL ON TABLE "public"."migrations" TO "anon";
GRANT ALL ON TABLE "public"."migrations" TO "authenticated";
GRANT ALL ON TABLE "public"."migrations" TO "service_role";



GRANT ALL ON SEQUENCE "public"."migrations_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."migrations_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."migrations_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."role" TO "anon";
GRANT ALL ON TABLE "public"."role" TO "authenticated";
GRANT ALL ON TABLE "public"."role" TO "service_role";



GRANT ALL ON SEQUENCE "public"."role_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."role_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."role_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."settings" TO "anon";
GRANT ALL ON TABLE "public"."settings" TO "authenticated";
GRANT ALL ON TABLE "public"."settings" TO "service_role";



GRANT ALL ON TABLE "public"."shared_credentials" TO "anon";
GRANT ALL ON TABLE "public"."shared_credentials" TO "authenticated";
GRANT ALL ON TABLE "public"."shared_credentials" TO "service_role";



GRANT ALL ON TABLE "public"."shared_workflow" TO "anon";
GRANT ALL ON TABLE "public"."shared_workflow" TO "authenticated";
GRANT ALL ON TABLE "public"."shared_workflow" TO "service_role";



GRANT ALL ON TABLE "public"."tag_entity" TO "anon";
GRANT ALL ON TABLE "public"."tag_entity" TO "authenticated";
GRANT ALL ON TABLE "public"."tag_entity" TO "service_role";



GRANT ALL ON TABLE "public"."user" TO "anon";
GRANT ALL ON TABLE "public"."user" TO "authenticated";
GRANT ALL ON TABLE "public"."user" TO "service_role";



GRANT ALL ON TABLE "public"."variables" TO "anon";
GRANT ALL ON TABLE "public"."variables" TO "authenticated";
GRANT ALL ON TABLE "public"."variables" TO "service_role";



GRANT ALL ON TABLE "public"."webhook_entity" TO "anon";
GRANT ALL ON TABLE "public"."webhook_entity" TO "authenticated";
GRANT ALL ON TABLE "public"."webhook_entity" TO "service_role";



GRANT ALL ON TABLE "public"."workflow_entity" TO "anon";
GRANT ALL ON TABLE "public"."workflow_entity" TO "authenticated";
GRANT ALL ON TABLE "public"."workflow_entity" TO "service_role";



GRANT ALL ON TABLE "public"."workflow_statistics" TO "anon";
GRANT ALL ON TABLE "public"."workflow_statistics" TO "authenticated";
GRANT ALL ON TABLE "public"."workflow_statistics" TO "service_role";



GRANT ALL ON TABLE "public"."workflows_tags" TO "anon";
GRANT ALL ON TABLE "public"."workflows_tags" TO "authenticated";
GRANT ALL ON TABLE "public"."workflows_tags" TO "service_role";









ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "service_role";
































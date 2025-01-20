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
-- Name: uuid_generate_v8(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.uuid_generate_v8() RETURNS uuid
    LANGUAGE plpgsql
    AS $$
      declare
        timestamp    timestamptz;
        microseconds int;
      begin
        timestamp    = clock_timestamp();
        microseconds = (cast(extract(microseconds from timestamp)::int - (floor(extract(milliseconds from timestamp))::int * 1000) as double precision) * 4.096)::int;

        -- use random v4 uuid as starting point (which has the same variant we need)
        -- then overlay timestamp
        -- then set version 8 and add microseconds
        return encode(
          set_byte(
            set_byte(
              overlay(uuid_send(gen_random_uuid())
                      placing substring(int8send(floor(extract(epoch from timestamp) * 1000)::bigint) from 3)
                      from 1 for 6
              ),
              6, (b'1000' || (microseconds >> 8)::bit(4))::bit(8)::int
            ),
            7, microseconds::bit(8)::int
          ),
          'hex')::uuid;
      end
      $$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: active_admin_comments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.active_admin_comments (
    id uuid DEFAULT public.uuid_generate_v8() NOT NULL,
    namespace character varying,
    body text,
    resource_type character varying,
    resource_id bigint,
    author_type character varying,
    author_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: active_storage_attachments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.active_storage_attachments (
    id uuid DEFAULT public.uuid_generate_v8() NOT NULL,
    name character varying NOT NULL,
    record_type character varying NOT NULL,
    record_id uuid NOT NULL,
    blob_id uuid NOT NULL,
    team_id uuid,
    created_at timestamp(6) without time zone NOT NULL
);


--
-- Name: active_storage_blobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.active_storage_blobs (
    id uuid DEFAULT public.uuid_generate_v8() NOT NULL,
    key character varying NOT NULL,
    filename character varying NOT NULL,
    content_type character varying,
    metadata text,
    service_name character varying NOT NULL,
    byte_size bigint NOT NULL,
    checksum character varying,
    team_id uuid,
    created_at timestamp(6) without time zone NOT NULL
);


--
-- Name: active_storage_variant_records; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.active_storage_variant_records (
    id uuid DEFAULT public.uuid_generate_v8() NOT NULL,
    blob_id uuid NOT NULL,
    variation_digest character varying NOT NULL,
    team_id uuid
);


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: custom_events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.custom_events (
    id uuid DEFAULT public.uuid_generate_v8() NOT NULL,
    team_id uuid NOT NULL,
    name character varying,
    description text,
    custom_scenario_id uuid NOT NULL,
    trigger_keywords jsonb,
    sequence_order integer DEFAULT 0 NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: custom_scenarios; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.custom_scenarios (
    id uuid DEFAULT public.uuid_generate_v8() NOT NULL,
    team_id uuid NOT NULL,
    name character varying,
    description text,
    status character varying DEFAULT 'draft'::character varying NOT NULL,
    exercise_type_id bigint NOT NULL,
    source_text text,
    created_by_id uuid,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: exercise_artifacts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.exercise_artifacts (
    id uuid DEFAULT public.uuid_generate_v8() NOT NULL,
    team_id uuid NOT NULL,
    exercise_id uuid NOT NULL,
    artifact_type integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: exercise_events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.exercise_events (
    id uuid DEFAULT public.uuid_generate_v8() NOT NULL,
    team_id uuid NOT NULL,
    exercise_id uuid NOT NULL,
    event_type character varying,
    event_id uuid,
    triggered_at timestamp(6) without time zone,
    status character varying DEFAULT 'pending'::character varying NOT NULL,
    relative_event_time bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: exercise_objective_assignments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.exercise_objective_assignments (
    id uuid DEFAULT public.uuid_generate_v8() NOT NULL,
    team_id uuid NOT NULL,
    exercise_id uuid NOT NULL,
    exercise_objective_id bigint NOT NULL,
    priority integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: exercise_objectives; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.exercise_objectives (
    id bigint NOT NULL,
    name character varying,
    description text,
    enabled boolean DEFAULT true NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: exercise_objectives_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.exercise_objectives_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: exercise_objectives_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.exercise_objectives_id_seq OWNED BY public.exercise_objectives.id;


--
-- Name: exercise_participants; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.exercise_participants (
    id uuid DEFAULT public.uuid_generate_v8() NOT NULL,
    team_id uuid NOT NULL,
    exercise_id uuid NOT NULL,
    name character varying,
    user_id uuid,
    role character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: exercise_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.exercise_types (
    id bigint NOT NULL,
    name character varying,
    description text,
    enabled boolean DEFAULT true NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: exercise_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.exercise_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: exercise_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.exercise_types_id_seq OWNED BY public.exercise_types.id;


--
-- Name: exercises; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.exercises (
    id uuid DEFAULT public.uuid_generate_v8() NOT NULL,
    team_id uuid NOT NULL,
    name character varying NOT NULL,
    purpose text,
    status character varying DEFAULT 'not_started'::character varying NOT NULL,
    exercise_type_id bigint NOT NULL,
    scenario_type character varying,
    scenario_id uuid,
    exercise_date timestamp(6) without time zone,
    context_data jsonb,
    created_by_id uuid,
    in_progress_at timestamp(6) without time zone,
    exercised_at timestamp(6) without time zone,
    retrospecting_at timestamp(6) without time zone,
    retrospected_at timestamp(6) without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: flipper_features; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.flipper_features (
    id bigint NOT NULL,
    key character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: flipper_features_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.flipper_features_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: flipper_features_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.flipper_features_id_seq OWNED BY public.flipper_features.id;


--
-- Name: flipper_gates; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.flipper_gates (
    id bigint NOT NULL,
    feature_key character varying NOT NULL,
    key character varying NOT NULL,
    value text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: flipper_gates_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.flipper_gates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: flipper_gates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.flipper_gates_id_seq OWNED BY public.flipper_gates.id;


--
-- Name: interactions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.interactions (
    id uuid DEFAULT public.uuid_generate_v8() NOT NULL,
    team_id uuid NOT NULL,
    exercise_id uuid NOT NULL,
    exercise_event_id uuid NOT NULL,
    interaction_type integer,
    user_id uuid NOT NULL,
    user_input jsonb,
    ai_response jsonb,
    response_confidence numeric(8,6),
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: memberships; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.memberships (
    id uuid DEFAULT public.uuid_generate_v8() NOT NULL,
    team_id uuid NOT NULL,
    user_id uuid NOT NULL,
    role character varying DEFAULT 'owner'::character varying NOT NULL,
    preferences jsonb,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: predefined_event_transitions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.predefined_event_transitions (
    id uuid DEFAULT public.uuid_generate_v8() NOT NULL,
    from_event_id uuid NOT NULL,
    to_event_id uuid NOT NULL,
    condition jsonb,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: predefined_events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.predefined_events (
    id uuid DEFAULT public.uuid_generate_v8() NOT NULL,
    name character varying,
    description text,
    predefined_scenario_id uuid NOT NULL,
    trigger_conditions jsonb,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: predefined_scenarios; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.predefined_scenarios (
    id uuid DEFAULT public.uuid_generate_v8() NOT NULL,
    name character varying,
    description text,
    enabled boolean DEFAULT true NOT NULL,
    exercise_type_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    starting_scenario_event_id uuid
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: teams; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.teams (
    id uuid DEFAULT public.uuid_generate_v8() NOT NULL,
    name character varying NOT NULL,
    slug character varying NOT NULL,
    status character varying DEFAULT 'active'::character varying NOT NULL,
    is_test boolean DEFAULT false NOT NULL,
    timezone character varying DEFAULT 'America/New_York'::character varying NOT NULL,
    disabled_at timestamp(6) without time zone,
    suspended_at timestamp(6) without time zone,
    settings jsonb,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id uuid DEFAULT public.uuid_generate_v8() NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    name character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp(6) without time zone,
    remember_created_at timestamp(6) without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp(6) without time zone,
    last_sign_in_at timestamp(6) without time zone,
    current_sign_in_ip character varying,
    last_sign_in_ip character varying,
    confirmation_token character varying,
    confirmed_at timestamp(6) without time zone,
    confirmation_sent_at timestamp(6) without time zone,
    unconfirmed_email character varying,
    failed_attempts integer DEFAULT 0 NOT NULL,
    unlock_token character varying,
    locked_at timestamp(6) without time zone,
    sys_roles character varying[] DEFAULT '{}'::character varying[] NOT NULL,
    settings jsonb,
    last_team_id uuid,
    disabled_at timestamp(6) without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: versions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.versions (
    id uuid DEFAULT public.uuid_generate_v8() NOT NULL,
    item_type character varying NOT NULL,
    item_id character varying NOT NULL,
    event character varying NOT NULL,
    whodunnit character varying,
    team_id uuid,
    object jsonb,
    object_changes jsonb,
    created_at timestamp(6) without time zone
);


--
-- Name: exercise_objectives id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exercise_objectives ALTER COLUMN id SET DEFAULT nextval('public.exercise_objectives_id_seq'::regclass);


--
-- Name: exercise_types id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exercise_types ALTER COLUMN id SET DEFAULT nextval('public.exercise_types_id_seq'::regclass);


--
-- Name: flipper_features id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.flipper_features ALTER COLUMN id SET DEFAULT nextval('public.flipper_features_id_seq'::regclass);


--
-- Name: flipper_gates id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.flipper_gates ALTER COLUMN id SET DEFAULT nextval('public.flipper_gates_id_seq'::regclass);


--
-- Name: active_admin_comments active_admin_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_admin_comments
    ADD CONSTRAINT active_admin_comments_pkey PRIMARY KEY (id);


--
-- Name: active_storage_attachments active_storage_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT active_storage_attachments_pkey PRIMARY KEY (id);


--
-- Name: active_storage_blobs active_storage_blobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_blobs
    ADD CONSTRAINT active_storage_blobs_pkey PRIMARY KEY (id);


--
-- Name: active_storage_variant_records active_storage_variant_records_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT active_storage_variant_records_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: custom_events custom_events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.custom_events
    ADD CONSTRAINT custom_events_pkey PRIMARY KEY (id);


--
-- Name: custom_scenarios custom_scenarios_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.custom_scenarios
    ADD CONSTRAINT custom_scenarios_pkey PRIMARY KEY (id);


--
-- Name: exercise_artifacts exercise_artifacts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exercise_artifacts
    ADD CONSTRAINT exercise_artifacts_pkey PRIMARY KEY (id);


--
-- Name: exercise_events exercise_events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exercise_events
    ADD CONSTRAINT exercise_events_pkey PRIMARY KEY (id);


--
-- Name: exercise_objective_assignments exercise_objective_assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exercise_objective_assignments
    ADD CONSTRAINT exercise_objective_assignments_pkey PRIMARY KEY (id);


--
-- Name: exercise_objectives exercise_objectives_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exercise_objectives
    ADD CONSTRAINT exercise_objectives_pkey PRIMARY KEY (id);


--
-- Name: exercise_participants exercise_participants_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exercise_participants
    ADD CONSTRAINT exercise_participants_pkey PRIMARY KEY (id);


--
-- Name: exercise_types exercise_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exercise_types
    ADD CONSTRAINT exercise_types_pkey PRIMARY KEY (id);


--
-- Name: exercises exercises_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exercises
    ADD CONSTRAINT exercises_pkey PRIMARY KEY (id);


--
-- Name: flipper_features flipper_features_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.flipper_features
    ADD CONSTRAINT flipper_features_pkey PRIMARY KEY (id);


--
-- Name: flipper_gates flipper_gates_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.flipper_gates
    ADD CONSTRAINT flipper_gates_pkey PRIMARY KEY (id);


--
-- Name: interactions interactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.interactions
    ADD CONSTRAINT interactions_pkey PRIMARY KEY (id);


--
-- Name: memberships memberships_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.memberships
    ADD CONSTRAINT memberships_pkey PRIMARY KEY (id);


--
-- Name: predefined_event_transitions predefined_event_transitions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.predefined_event_transitions
    ADD CONSTRAINT predefined_event_transitions_pkey PRIMARY KEY (id);


--
-- Name: predefined_events predefined_events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.predefined_events
    ADD CONSTRAINT predefined_events_pkey PRIMARY KEY (id);


--
-- Name: predefined_scenarios predefined_scenarios_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.predefined_scenarios
    ADD CONSTRAINT predefined_scenarios_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: versions versions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.versions
    ADD CONSTRAINT versions_pkey PRIMARY KEY (id);


--
-- Name: index_active_admin_comments_on_author; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_active_admin_comments_on_author ON public.active_admin_comments USING btree (author_type, author_id);


--
-- Name: index_active_admin_comments_on_namespace; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_active_admin_comments_on_namespace ON public.active_admin_comments USING btree (namespace);


--
-- Name: index_active_admin_comments_on_resource; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_active_admin_comments_on_resource ON public.active_admin_comments USING btree (resource_type, resource_id);


--
-- Name: index_active_storage_attachments_on_blob_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_active_storage_attachments_on_blob_id ON public.active_storage_attachments USING btree (blob_id);


--
-- Name: index_active_storage_attachments_on_team_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_active_storage_attachments_on_team_id ON public.active_storage_attachments USING btree (team_id);


--
-- Name: index_active_storage_attachments_uniqueness; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_active_storage_attachments_uniqueness ON public.active_storage_attachments USING btree (record_type, record_id, name, blob_id);


--
-- Name: index_active_storage_blobs_on_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_active_storage_blobs_on_key ON public.active_storage_blobs USING btree (key);


--
-- Name: index_active_storage_blobs_on_team_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_active_storage_blobs_on_team_id ON public.active_storage_blobs USING btree (team_id);


--
-- Name: index_active_storage_variant_records_on_team_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_active_storage_variant_records_on_team_id ON public.active_storage_variant_records USING btree (team_id);


--
-- Name: index_active_storage_variant_records_uniqueness; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_active_storage_variant_records_uniqueness ON public.active_storage_variant_records USING btree (blob_id, variation_digest);


--
-- Name: index_custom_events_on_custom_scenario_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_custom_events_on_custom_scenario_id ON public.custom_events USING btree (custom_scenario_id);


--
-- Name: index_custom_events_on_team_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_custom_events_on_team_id ON public.custom_events USING btree (team_id);


--
-- Name: index_custom_scenarios_on_created_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_custom_scenarios_on_created_by_id ON public.custom_scenarios USING btree (created_by_id);


--
-- Name: index_custom_scenarios_on_exercise_type_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_custom_scenarios_on_exercise_type_id ON public.custom_scenarios USING btree (exercise_type_id);


--
-- Name: index_custom_scenarios_on_team_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_custom_scenarios_on_team_id ON public.custom_scenarios USING btree (team_id);


--
-- Name: index_exercise_artifacts_on_exercise_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_exercise_artifacts_on_exercise_id ON public.exercise_artifacts USING btree (exercise_id);


--
-- Name: index_exercise_artifacts_on_team_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_exercise_artifacts_on_team_id ON public.exercise_artifacts USING btree (team_id);


--
-- Name: index_exercise_events_on_event_type_and_event_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_exercise_events_on_event_type_and_event_id ON public.exercise_events USING btree (event_type, event_id);


--
-- Name: index_exercise_events_on_exercise_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_exercise_events_on_exercise_id ON public.exercise_events USING btree (exercise_id);


--
-- Name: index_exercise_events_on_team_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_exercise_events_on_team_id ON public.exercise_events USING btree (team_id);


--
-- Name: index_exercise_objective_assignments_on_exercise_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_exercise_objective_assignments_on_exercise_id ON public.exercise_objective_assignments USING btree (exercise_id);


--
-- Name: index_exercise_objective_assignments_on_exercise_objective_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_exercise_objective_assignments_on_exercise_objective_id ON public.exercise_objective_assignments USING btree (exercise_objective_id);


--
-- Name: index_exercise_objective_assignments_on_team_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_exercise_objective_assignments_on_team_id ON public.exercise_objective_assignments USING btree (team_id);


--
-- Name: index_exercise_participants_on_exercise_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_exercise_participants_on_exercise_id ON public.exercise_participants USING btree (exercise_id);


--
-- Name: index_exercise_participants_on_team_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_exercise_participants_on_team_id ON public.exercise_participants USING btree (team_id);


--
-- Name: index_exercise_participants_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_exercise_participants_on_user_id ON public.exercise_participants USING btree (user_id);


--
-- Name: index_exercises_on_created_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_exercises_on_created_by_id ON public.exercises USING btree (created_by_id);


--
-- Name: index_exercises_on_exercise_type_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_exercises_on_exercise_type_id ON public.exercises USING btree (exercise_type_id);


--
-- Name: index_exercises_on_team_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_exercises_on_team_id ON public.exercises USING btree (team_id);


--
-- Name: index_flipper_features_on_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_flipper_features_on_key ON public.flipper_features USING btree (key);


--
-- Name: index_flipper_gates_on_feature_key_and_key_and_value; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_flipper_gates_on_feature_key_and_key_and_value ON public.flipper_gates USING btree (feature_key, key, value);


--
-- Name: index_interactions_on_exercise_event_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_interactions_on_exercise_event_id ON public.interactions USING btree (exercise_event_id);


--
-- Name: index_interactions_on_exercise_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_interactions_on_exercise_id ON public.interactions USING btree (exercise_id);


--
-- Name: index_interactions_on_team_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_interactions_on_team_id ON public.interactions USING btree (team_id);


--
-- Name: index_interactions_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_interactions_on_user_id ON public.interactions USING btree (user_id);


--
-- Name: index_memberships_on_team_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_memberships_on_team_id ON public.memberships USING btree (team_id);


--
-- Name: index_memberships_on_user_id_and_team_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_memberships_on_user_id_and_team_id ON public.memberships USING btree (user_id, team_id);


--
-- Name: index_predefined_event_transitions_on_from_event_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_predefined_event_transitions_on_from_event_id ON public.predefined_event_transitions USING btree (from_event_id);


--
-- Name: index_predefined_event_transitions_on_to_event_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_predefined_event_transitions_on_to_event_id ON public.predefined_event_transitions USING btree (to_event_id);


--
-- Name: index_predefined_events_on_predefined_scenario_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_predefined_events_on_predefined_scenario_id ON public.predefined_events USING btree (predefined_scenario_id);


--
-- Name: index_predefined_scenarios_on_exercise_type_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_predefined_scenarios_on_exercise_type_id ON public.predefined_scenarios USING btree (exercise_type_id);


--
-- Name: index_predefined_scenarios_on_starting_scenario_event_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_predefined_scenarios_on_starting_scenario_event_id ON public.predefined_scenarios USING btree (starting_scenario_event_id);


--
-- Name: index_teams_on_slug; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_teams_on_slug ON public.teams USING btree (slug);


--
-- Name: index_users_on_confirmation_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_confirmation_token ON public.users USING btree (confirmation_token);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: index_users_on_unlock_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_unlock_token ON public.users USING btree (unlock_token);


--
-- Name: index_versions_on_item_type_and_item_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_versions_on_item_type_and_item_id ON public.versions USING btree (item_type, item_id);


--
-- Name: interactions fk_rails_0a8f263f6c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.interactions
    ADD CONSTRAINT fk_rails_0a8f263f6c FOREIGN KEY (team_id) REFERENCES public.teams(id);


--
-- Name: active_storage_blobs fk_rails_10d6334af3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_blobs
    ADD CONSTRAINT fk_rails_10d6334af3 FOREIGN KEY (team_id) REFERENCES public.teams(id);


--
-- Name: custom_scenarios fk_rails_115dd11b4f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.custom_scenarios
    ADD CONSTRAINT fk_rails_115dd11b4f FOREIGN KEY (created_by_id) REFERENCES public.users(id);


--
-- Name: predefined_event_transitions fk_rails_149b26ba74; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.predefined_event_transitions
    ADD CONSTRAINT fk_rails_149b26ba74 FOREIGN KEY (from_event_id) REFERENCES public.predefined_events(id);


--
-- Name: exercise_participants fk_rails_280cf7e27d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exercise_participants
    ADD CONSTRAINT fk_rails_280cf7e27d FOREIGN KEY (team_id) REFERENCES public.teams(id);


--
-- Name: predefined_scenarios fk_rails_28b06ed143; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.predefined_scenarios
    ADD CONSTRAINT fk_rails_28b06ed143 FOREIGN KEY (starting_scenario_event_id) REFERENCES public.predefined_events(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: exercise_events fk_rails_2dd4fbc1b1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exercise_events
    ADD CONSTRAINT fk_rails_2dd4fbc1b1 FOREIGN KEY (team_id) REFERENCES public.teams(id);


--
-- Name: custom_events fk_rails_4259f728bf; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.custom_events
    ADD CONSTRAINT fk_rails_4259f728bf FOREIGN KEY (custom_scenario_id) REFERENCES public.custom_scenarios(id);


--
-- Name: exercise_participants fk_rails_4d01d06a99; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exercise_participants
    ADD CONSTRAINT fk_rails_4d01d06a99 FOREIGN KEY (exercise_id) REFERENCES public.exercises(id);


--
-- Name: exercises fk_rails_4e8aa710e4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exercises
    ADD CONSTRAINT fk_rails_4e8aa710e4 FOREIGN KEY (exercise_type_id) REFERENCES public.exercise_types(id);


--
-- Name: interactions fk_rails_585d5c59d8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.interactions
    ADD CONSTRAINT fk_rails_585d5c59d8 FOREIGN KEY (exercise_id) REFERENCES public.exercises(id);


--
-- Name: exercise_participants fk_rails_59cac967ed; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exercise_participants
    ADD CONSTRAINT fk_rails_59cac967ed FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: exercise_objective_assignments fk_rails_5a8001f88a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exercise_objective_assignments
    ADD CONSTRAINT fk_rails_5a8001f88a FOREIGN KEY (exercise_id) REFERENCES public.exercises(id);


--
-- Name: custom_scenarios fk_rails_63272d75ab; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.custom_scenarios
    ADD CONSTRAINT fk_rails_63272d75ab FOREIGN KEY (exercise_type_id) REFERENCES public.exercise_types(id);


--
-- Name: exercise_events fk_rails_68dd446e87; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exercise_events
    ADD CONSTRAINT fk_rails_68dd446e87 FOREIGN KEY (exercise_id) REFERENCES public.exercises(id);


--
-- Name: interactions fk_rails_69c9b45391; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.interactions
    ADD CONSTRAINT fk_rails_69c9b45391 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: active_storage_variant_records fk_rails_69f42507fa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT fk_rails_69f42507fa FOREIGN KEY (team_id) REFERENCES public.teams(id);


--
-- Name: active_storage_attachments fk_rails_75a7ab23e2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT fk_rails_75a7ab23e2 FOREIGN KEY (team_id) REFERENCES public.teams(id);


--
-- Name: exercise_objective_assignments fk_rails_75f8a3fefc; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exercise_objective_assignments
    ADD CONSTRAINT fk_rails_75f8a3fefc FOREIGN KEY (team_id) REFERENCES public.teams(id);


--
-- Name: exercise_objective_assignments fk_rails_7f495efaaf; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exercise_objective_assignments
    ADD CONSTRAINT fk_rails_7f495efaaf FOREIGN KEY (exercise_objective_id) REFERENCES public.exercise_objectives(id);


--
-- Name: predefined_event_transitions fk_rails_89f41c689d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.predefined_event_transitions
    ADD CONSTRAINT fk_rails_89f41c689d FOREIGN KEY (to_event_id) REFERENCES public.predefined_events(id);


--
-- Name: memberships fk_rails_99326fb65d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.memberships
    ADD CONSTRAINT fk_rails_99326fb65d FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: active_storage_variant_records fk_rails_993965df05; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT fk_rails_993965df05 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- Name: predefined_scenarios fk_rails_9c0651a577; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.predefined_scenarios
    ADD CONSTRAINT fk_rails_9c0651a577 FOREIGN KEY (exercise_type_id) REFERENCES public.exercise_types(id);


--
-- Name: predefined_events fk_rails_9ef24234df; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.predefined_events
    ADD CONSTRAINT fk_rails_9ef24234df FOREIGN KEY (predefined_scenario_id) REFERENCES public.predefined_scenarios(id);


--
-- Name: memberships fk_rails_ae2aedcfaf; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.memberships
    ADD CONSTRAINT fk_rails_ae2aedcfaf FOREIGN KEY (team_id) REFERENCES public.teams(id);


--
-- Name: exercise_artifacts fk_rails_b131d2d623; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exercise_artifacts
    ADD CONSTRAINT fk_rails_b131d2d623 FOREIGN KEY (exercise_id) REFERENCES public.exercises(id);


--
-- Name: exercises fk_rails_b175ef52e8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exercises
    ADD CONSTRAINT fk_rails_b175ef52e8 FOREIGN KEY (team_id) REFERENCES public.teams(id);


--
-- Name: custom_scenarios fk_rails_b6979c0489; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.custom_scenarios
    ADD CONSTRAINT fk_rails_b6979c0489 FOREIGN KEY (team_id) REFERENCES public.teams(id);


--
-- Name: exercise_artifacts fk_rails_bf1dd23e36; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exercise_artifacts
    ADD CONSTRAINT fk_rails_bf1dd23e36 FOREIGN KEY (team_id) REFERENCES public.teams(id);


--
-- Name: active_storage_attachments fk_rails_c3b3935057; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT fk_rails_c3b3935057 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- Name: custom_events fk_rails_c440881dc9; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.custom_events
    ADD CONSTRAINT fk_rails_c440881dc9 FOREIGN KEY (team_id) REFERENCES public.teams(id);


--
-- Name: interactions fk_rails_c522d85d32; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.interactions
    ADD CONSTRAINT fk_rails_c522d85d32 FOREIGN KEY (exercise_event_id) REFERENCES public.exercise_events(id);


--
-- Name: exercises fk_rails_ebb9a79285; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exercises
    ADD CONSTRAINT fk_rails_ebb9a79285 FOREIGN KEY (created_by_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20250117004158'),
('20250117003210'),
('20250117000327'),
('20250116224153'),
('20250116134210'),
('20250116123957'),
('20250116114759'),
('20250116113705'),
('20250116113650'),
('20250116113645'),
('20250116113510'),
('20250111131427'),
('20250111123410'),
('20250110223000'),
('20250110215925'),
('20250109111426'),
('20250109103253'),
('20250109102927'),
('20250105234619'),
('20250105123213'),
('20250105122653'),
('20250105121118'),
('20250105121000');


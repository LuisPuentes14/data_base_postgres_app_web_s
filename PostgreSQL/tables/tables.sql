DROP SCHEMA IF EXISTS public CASCADE;
CREATE SCHEMA public;
-- Table: permissions_profiles_web_modules

CREATE TABLE permissions_profiles_web_modules
(
    permission_profile_web_module_id       SERIAL PRIMARY KEY,
    profile_id                             INTEGER NOT NULL,
    web_module_id                          INTEGER NOT NULL,
    permission_profile_web_module_access   BOOLEAN DEFAULT FALSE,
    permission_profile_web_module_create   BOOLEAN DEFAULT FALSE,
    permission_profile_web_module_update   BOOLEAN DEFAULT FALSE,
    permission_profile_web_module_delete   BOOLEAN DEFAULT FALSE,
    permission_profile_web_module_download BOOLEAN DEFAULT FALSE
);

-- Table: profiles
CREATE TABLE profiles
(
    profile_id   SERIAL PRIMARY KEY,
    profile_name VARCHAR(100)
);

-- Table: user_states
CREATE TABLE users_states
(
    user_state_id   SERIAL PRIMARY KEY,
    user_state_name VARCHAR(100)
);

-- Table: users
CREATE TABLE users
(
    user_id                SERIAL PRIMARY KEY,
    user_name              VARCHAR(100) NOT NULL,
    user_email             VARCHAR(100) NOT NULL,
    user_login             VARCHAR(100) NOT NULL,
    user_password          VARCHAR(100) NOT NULL,
    user_state_id          INTEGER      NOT NULL,
    user_date_exp_password TIMESTAMP,
    user_date_create       TIMESTAMP,
    user_date_update       TIMESTAMP,
    user_Attempts          INTEGER DEFAULT 0,
    user_first_login       BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_state_id) REFERENCES users_states (user_state_id)
);


-- Table: user_profiles
CREATE TABLE users_profiles
(
    user_profile_id SERIAL PRIMARY KEY,
    profile_id      INTEGER,
    user_id         INTEGER,
    FOREIGN KEY (profile_id) REFERENCES profiles (profile_id),
    FOREIGN KEY (user_id) REFERENCES users (user_id)
);

-- Table: web_modules
CREATE TABLE web_modules
(
    web_module_id          SERIAL PRIMARY KEY,
    web_module_father      INTEGER,
    web_module_title       VARCHAR(100),
    web_module_description VARCHAR(100),
    web_module_index       INTEGER,
    web_module_create_date TIMESTAMP,
    web_module_update_date TIMESTAMP
);

-- Adding foreign keys
-- Note: PostgreSQL does not support adding multiple foreign keys in a single ALTER TABLE statement,
-- so we'll add them separately.

-- For permissions_profiles_web_modules
ALTER TABLE permissions_profiles_web_modules
    ADD CONSTRAINT fk_profile_id FOREIGN KEY (profile_id) REFERENCES profiles (profile_id);
ALTER TABLE permissions_profiles_web_modules
    ADD CONSTRAINT fk_web_module_id FOREIGN KEY (web_module_id) REFERENCES web_modules (web_module_id);

-- For users_profiles
ALTER TABLE users_profiles
    ADD CONSTRAINT fk_user_profiles_profile_id FOREIGN KEY (profile_id) REFERENCES profiles (profile_id);
ALTER TABLE users_profiles
    ADD CONSTRAINT fk_user_profiles_user_id FOREIGN KEY (user_id) REFERENCES users (user_id);

-- For users
ALTER TABLE users
    ADD CONSTRAINT fk_users_user_state_id FOREIGN KEY (user_state_id) REFERENCES users_states (user_state_id);

-- For web_modules
-- ALTER TABLE web_modules
--     ADD CONSTRAINT fk_web_modules_type_module_id FOREIGN KEY (type_module_id) REFERENCES types_modules (type_module_id);

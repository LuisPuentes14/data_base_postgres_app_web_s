CREATE OR REPLACE FUNCTION trg_after_insert_profiles()
RETURNS TRIGGER AS
$$
DECLARE
    local_profile_id BIGINT;
    local_web_module_id BIGINT;
BEGIN
    local_profile_id := NEW.profile_id;
    
    FOR local_web_module_id IN (SELECT web_module_id FROM web_modules)
    LOOP
        INSERT INTO permissions_profiles_web_modules (profile_id, web_module_id)
        VALUES (local_profile_id, local_web_module_id);
    END LOOP;
    
    RETURN NEW;
END;
$$
LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trg_after_insert_profiles
AFTER INSERT ON profiles
FOR EACH ROW
EXECUTE FUNCTION trg_after_insert_profiles();

CREATE OR REPLACE FUNCTION trg_after_insert_web_modules()
RETURNS TRIGGER AS
$$
DECLARE
    local_profile_id BIGINT;
BEGIN
    FOR local_profile_id IN (SELECT profile_id FROM profiles)
    LOOP
        INSERT INTO permissions_profiles_web_modules (profile_id, web_module_id)
        VALUES (local_profile_id, NEW.web_module_id);
    END LOOP;
    RETURN NEW;
END;
$$
LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trg_after_insert_web_modules
AFTER INSERT ON web_modules
FOR EACH ROW
EXECUTE FUNCTION trg_after_insert_web_modules();
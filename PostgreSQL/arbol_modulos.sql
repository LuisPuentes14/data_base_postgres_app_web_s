WITH RECURSIVE a (nid, padre, orden, level, sort_path) AS (
  SELECT 
    mw.web_module_id AS nid, 
    mw.web_module_father AS padre,  
    mw.web_module_index AS orden,
    1 AS level,
    CAST('/' || mw.web_module_title AS TEXT)
  FROM permissions_profiles_web_modules ppm
  INNER JOIN web_modules mw ON ppm.web_module_id = mw.web_module_id
  WHERE ppm.profile_id = 1 AND mw.web_module_father IS NULL AND mw.type_module_id = 1
  UNION ALL  
  SELECT 
    mw1.web_module_id, 
    mw1.web_module_father,   
    mw1.web_module_index,
    a.level + 1,
    a.sort_path || '/' || mw1.web_module_title
  FROM permissions_profiles_web_modules ppm1
  INNER JOIN web_modules mw1 ON ppm1.web_module_id = mw1.web_module_id
  INNER JOIN a ON a.nid = mw1.web_module_father
  WHERE ppm1.profile_id = 1 AND mw1.type_module_id = 1
)
SELECT nid, padre, orden, level, sort_path
FROM a
ORDER BY sort_path;
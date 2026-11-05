SET search_path TO catia_schema;

SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'catia_schema'
ORDER BY table_name;
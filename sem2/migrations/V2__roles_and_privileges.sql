CREATE ROLE app_admin LOGIN PASSWORD 'admin_pwd';
CREATE ROLE app_analyst LOGIN PASSWORD 'analyst_pwd';
CREATE ROLE app_readonly LOGIN PASSWORD 'readonly_pwd';

GRANT CONNECT ON DATABASE football_club_db3
TO app_admin, app_analyst, app_readonly;

GRANT USAGE ON SCHEMA football_club
TO app_admin, app_analyst, app_readonly;

GRANT ALL ON ALL TABLES IN SCHEMA football_club TO app_admin;
GRANT ALL ON ALL SEQUENCES IN SCHEMA football_club TO app_admin;

ALTER DEFAULT PRIVILEGES IN SCHEMA football_club
GRANT ALL ON TABLES TO app_admin;
ALTER DEFAULT PRIVILEGES IN SCHEMA football_club
GRANT ALL ON SEQUENCES TO app_admin;

GRANT SELECT, INSERT, UPDATE, DELETE ON
    football_club.players,
    football_club.contracts,
    football_club.football_clubs,
    football_club.products
TO app_analyst;

GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA football_club TO app_analyst;

GRANT SELECT ON ALL TABLES IN SCHEMA football_club TO app_readonly;
GRANT SELECT ON ALL SEQUENCES IN SCHEMA football_club TO app_readonly;

ALTER DEFAULT PRIVILEGES IN SCHEMA football_club
GRANT SELECT ON TABLES TO app_readonly;
ALTER DEFAULT PRIVILEGES IN SCHEMA football_club
GRANT SELECT ON SEQUENCES TO app_readonly;

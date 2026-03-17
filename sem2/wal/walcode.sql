INSERT INTO football_club.departments(name)
VALUES ('Test_Department_1');

BEGIN;

INSERT INTO football_club.departments(name)
VALUES ('Commit_Test_');
COMMIT;

CREATE TABLE IF NOT EXISTS football_club.wal_test (
    id serial PRIMARY KEY,
    note text
);
INSERT INTO football_club.wal_test(note)
SELECT 'row_' || g
FROM generate_series(1, 10000) AS g;

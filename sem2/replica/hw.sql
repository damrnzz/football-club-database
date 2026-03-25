INSERT INTO football_club.replication_test_load(payload)
SELECT 'load_' || g
FROM generate_series(1, 1000000) g;


CREATE PUBLICATION football_pub
FOR TABLE football_club.logical_demo;

CREATE SUBSCRIPTION football_sub
CONNECTION 'host=pg-master port=5432 dbname=football user=replicator password=replicator_pass'
PUBLICATION football_pub;

ALTER TABLE football_club.logical_demo ADD COLUMN test text;  
--На subscriber колонка НЕ появится.

CREATE TABLE test_no_pk (
    name text
);
ALTER TABLE test_no_pk REPLICA IDENTITY FULL;
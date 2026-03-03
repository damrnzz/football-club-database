EXPLAIN (ANALYZE, BUFFERS)
SELECT *
FROM football_club.players
WHERE rating > 8.5;

EXPLAIN (ANALYZE, BUFFERS)
SELECT *
FROM football_club.players
WHERE height_cm < 175;

EXPLAIN (ANALYZE, BUFFERS)
SELECT *
FROM football_club.players
WHERE player_id = 123456;

EXPLAIN (ANALYZE, BUFFERS)
SELECT *
FROM football_club.players
WHERE first_name LIKE 'Player_12%';

EXPLAIN (ANALYZE, BUFFERS)
SELECT *
FROM football_club.players
WHERE first_name LIKE '%99';

CREATE INDEX idx_players_rating_btree ON football_club.players USING btree (rating);
CREATE INDEX idx_players_height_btree ON football_club.players USING btree (height_cm);
CREATE INDEX idx_players_fname_btree  ON football_club.players USING btree (first_name);

-- 5 EXPLAIN выше

DROP INDEX IF EXISTS football_club.idx_players_fname_btree;

EXPLAIN (ANALYZE, BUFFERS)
SELECT * FROM football_club.players
WHERE first_name = 'Player_123456';

EXPLAIN (ANALYZE, BUFFERS)
SELECT * FROM football_club.players
WHERE first_name IN ('Player_1','Player_2','Player_3','Player_4','Player_5');

CREATE INDEX idx_players_fname_btree ON football_club.players USING btree(first_name);
ANALYZE football_club.players;
-- 2 EXPLAIN выше

DROP INDEX IF EXISTS football_club.idx_players_fname_btree;

CREATE INDEX idx_players_fname_hash ON football_club.players USING hash(first_name);
ANALYZE football_club.players;
-- ееще раз 2 EXPLAIN выше

INSERT INTO football_club.players(first_name, date_of_birth, club_id, rating)
VALUES ('Ivan Petrov', '2000-05-10', 1, 8.60)


INSERT INTO football_club.players(first_name, date_of_birth, club_id, rating)
VALUES ('Ivan Petrov', '2000-05-10', 1, 8.50)
ON CONFLICT (first_name, date_of_birth, club_id) DO UPDATE
SET rating = EXCLUDED.rating;

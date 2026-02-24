INSERT INTO football_club.cities(name, country)
SELECT
  'City_' || g,
  CASE
    WHEN g <= 40 THEN 'England'
    WHEN g <= 80 THEN 'Spain'
    ELSE 'Country_' || (g % 50)
  END
FROM generate_series(1, 200) AS g;

INSERT INTO football_club.owners(name, nationality, purchase_date)
SELECT
  'Owner_' || g,
  CASE WHEN random() < 0.7 THEN 'USA' ELSE 'Other_' || (g % 20) END,
  date '2000-01-01' + (random() * 7000)::int
FROM generate_series(1, 500) AS g;

INSERT INTO football_club.stadiums(name, capacity, address)
SELECT
  'Stadium_' || g,
  (random() * 60000 + 10000)::int,
  'Address ' || g
FROM generate_series(1, 500) AS g;
INSERT INTO football_club.football_clubs
(name, country, city, owner_id, stadium_id, city_id)
SELECT
  'Club_' || g,
  CASE
    WHEN random() < 0.7 THEN 'England'                   
    ELSE 'Country_' || (1 + (random()*20)::int)
  END,
  'City_' || (1 + (random()*200)::int),                  
  1 + (random()*499)::int,                                
  1 + (random()*499)::int,                                
  1 + (random()*199)::int                               
FROM generate_series(1, 200000) AS g;
INSERT INTO football_club.players
(first_name, date_of_birth, nationality, "position",
 market_value, club_id, bio, tags, extra, rating, height_cm)
SELECT
  'Player_' || g,                                  
  date '1980-01-01' + (random() * 15000)::int,
  CASE
    WHEN random() < 0.6 THEN 'Brazil'
    WHEN random() < 0.85 THEN 'Spain'
    ELSE 'Country_' || (1 + (random()*50)::int)
  END,
  (ARRAY['GK','DF','MF','FW'])[1 + (random()*3)::int],  
  (random() * 1000000)::money,
  1 + (random()*199999)::int,                          
  CASE
    WHEN random() < 0.1 THEN NULL                
    ELSE 'Talented player with strong passing and vision #' || g
  END,
  ARRAY[
    'tag_' || (1 + (random()*20)::int),
    'tag_' || (1 + (random()*20)::int)
  ],
  jsonb_build_object(
    'preferred_foot', (ARRAY['left','right','both'])[1 + (random()*2)::int],
    'speed', (random()*10)::numeric(4,2),
    'injury_prone', random() < 0.15
  ),
  CASE WHEN random() < 0.15 THEN NULL                  
       ELSE (random()*5 + 5)::numeric(4,2)
  END,
  160 + (random()*30)::int
FROM generate_series(1, 300000) AS g;
INSERT INTO football_club.contracts
(player_id, start_date, end_date, salary, bonus, active, signed_at, salary_min, salary_max)
SELECT
  p.player_id,
  start_d,
  start_d + (365 * (1 + (random()*5)::int))::int,
  ((random()*5000000 + 50000)::numeric(12,2))::money,
  CASE WHEN random() < 0.2 THEN NULL
       ELSE ((random()*500000)::numeric(12,2))::money
  END,
  random() < 0.7,
  now() - (random()*3650)::int * interval '1 day',
  ((random()*3000000 + 50000)::numeric(12,2))::money,
  ((random()*5000000 + 500000)::numeric(12,2))::money
FROM (
  SELECT player_id,
         date '2010-01-01' + (random()*3650)::int AS start_d
  FROM football_club.players
  ORDER BY random()
  LIMIT 300000
) AS p;
INSERT INTO football_club.fun_shop (name, address)
SELECT
  'Shop_' || g,
  'Some address ' || g
FROM generate_series(1, 10000) AS g;
INSERT INTO football_club.products
(name, type, price, count, shop_id, height, width, length)
SELECT
  'Product_' || g,
  (ARRAY['kit','scarf','ball','mug','flag'])[1 + (random()*4)::int],
  ((random()*200 + 5)::numeric(10,2))::money,
  CASE
    WHEN random() < 0.7 THEN (random()*10)::int
    ELSE (random()*500)::int
  END,
  1 + (random()*9999)::int,     
  5 + (random()*50)::int,
  5 + (random()*50)::int,
  5 + (random()*50)::int
FROM generate_series(1, 300000) AS g;

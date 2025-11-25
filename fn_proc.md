```sql
-- Процедуры
-- 1: обновить вместимость стадиона
CREATE OR REPLACE PROCEDURE update_stadium_capacity(p_stadium_id TEXT, p_delta INT)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE football_club.stadiums
    SET capacity = capacity + p_delta
    WHERE staduim_id = p_stadium_id;
END;
$$;

-- 2: добавить фан-шоп 
CREATE OR REPLACE PROCEDURE add_fun_shop(p_address TEXT, p_club_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO football_club.fun_shop (address, club_id)
    SELECT p_address, fc.club_id
    FROM football_club.football_clubs fc
    WHERE fc.club_id = p_club_id;
END;
$$;

-- 3: удалить спонсора по id
CREATE OR REPLACE PROCEDURE delete_sponsor(p_sponsor_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM football_club.sponsors WHERE sponsor_id = p_sponsor_id;
END;
$$;
```

![01](savepoint/111.jpg)

```sql
-- Функции
-- 1: объём спонсорских выплат клуба
CREATE OR REPLACE FUNCTION club_sponsors_total(p_club_id INT)
RETURNS INT
LANGUAGE sql
AS $$
    SELECT SUM(CAST(amount AS NUMERIC))
    FROM football_club.sponsors
    WHERE club_id = p_club_id;
$$;

-- 2: количество игроков клуба
CREATE OR REPLACE FUNCTION club_players_count(p_club_id INT)
RETURNS INT
LANGUAGE sql
AS $$
    SELECT COUNT(*) FROM football_club.players WHERE club_id = p_club_id;
$$;

-- 3: средняя зарплата по клубу
CREATE OR REPLACE FUNCTION club_avg_salary(p_club_id INT)
RETURNS INT
LANGUAGE sql
AS $$
    SELECT AVG(CAST(c.salary AS NUMERIC))
    FROM football_club.contracts c
    JOIN football_club.players p ON p.player_id = c.player_id
    WHERE p.club_id = p_club_id;
$$;


--4: сумма + количество по спонсорам клуба
CREATE OR REPLACE FUNCTION club_sponsor_report(p_club_id INT)
RETURNS TEXT
LANGUAGE plpgsql
AS $$
DECLARE
    total INT;
    count INT;
BEGIN
    SELECT SUM(CAST(amount AS NUMERIC)), COUNT(*)
    INTO total, count
    FROM football_club.sponsors sp
    JOIN football_club.football_clubs fc ON fc.club_id = sp.club_id
    WHERE fc.club_id = p_club_id;

    RETURN 'Спонсоров: ' || count ||', сумма: ' || total;
END;
$$;

-- 5: дата окончания последнего контракта игрока
CREATE OR REPLACE FUNCTION player_last_contract_end(p_player_name TEXT)
RETURNS DATE
LANGUAGE plpgsql
AS $$
DECLARE
    con_end DATE;
BEGIN
    SELECT MAX(end_date) INTO con_end
    FROM football_club.contracts c
    JOIN football_club.players p ON p.player_id = c.player_id
    WHERE p.first_name = p_player_name;
    RETURN con_end;
END;
$$;

-- 6:класс вместимости стадиона
CREATE OR REPLACE FUNCTION capacity_class(p_stadium_name TEXT)
RETURNS TEXT
LANGUAGE plpgsql
AS $$
DECLARE
    cap INT;
BEGIN
    SELECT capacity INTO cap
    FROM football_club.stadiums
    WHERE name = p_stadium_name;

    IF cap IS NULL THEN
        RETURN 'не найден';
    ELSIF cap >= 60000 THEN
        RETURN 'большой';
    ELSIF cap >= 40000 THEN
        RETURN 'средний';
    ELSE
        RETURN 'малый';
    END IF;
END;
$$;
```

![01](savepoint/222.jpg)

```sql
-- DO
-- 1: количество стадионов
DO $$
DECLARE
    cnt INT;
BEGIN
    SELECT COUNT(*) INTO cnt FROM football_club.stadiums;
    RAISE NOTICE 'Стадионов: %', cnt;
END;
$$;

-- 2: количество фан-шопов
DO $$
DECLARE
    cnt INT;
BEGIN
    SELECT COUNT(*) INTO cnt FROM football_club.fun_shop;
    RAISE NOTICE 'Фан-шопов: %', cnt;
END;
$$;

-- 3: 
DO $$
DECLARE
    total INT;
BEGIN
    SELECT SUM(CAST(amount AS NUMERIC)) INTO total
    FROM football_club.sponsors;
    RAISE NOTICE 'Общая сумма спонсорских: %', total;
END;
$$;

```
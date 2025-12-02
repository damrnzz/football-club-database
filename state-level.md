```sql
-- statement level :
-- 1 : добавляет спонсора для клуба, чей фан-шоп вставлен последним 
CREATE OR REPLACE FUNCTION trg_fun_shop_auto_sponsor() RETURNS trigger AS $$
DECLARE
    v_club_id INT;
BEGIN
    SELECT club_id INTO v_club_id
    FROM football_club.fun_shop
    ORDER BY shop_id DESC
    LIMIT 1;

    INSERT INTO football_club.sponsors (club_id, start_date, end_date, amount, type)
    VALUES (v_club_id, CURRENT_DATE, CURRENT_DATE + INTERVAL '1 year', 50000::money,
            'Авто-спонсор за новые фан-шопы');

    RETURN NULL; 
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER fun_shop_auto_sponsor
AFTER INSERT ON football_club.fun_shop
FOR EACH STATEMENT
EXECUTE FUNCTION trg_fun_shop_auto_sponsor();
```
![01](savepoint/1111.jpg)
![01](savepoint/2222.jpg)
```sql
CREATE OR REPLACE FUNCTION trg_players_auto_contract() RETURNS trigger AS $$
DECLARE
    v_player_id INT;
BEGIN
    SELECT MAX(player_id) INTO v_player_id FROM football_club.players;

    INSERT INTO football_club.contracts (player_id, start_date, end_date, salary)
    VALUES (v_player_id, CURRENT_DATE, CURRENT_DATE + INTERVAL '1 year', 20000::money);

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER players_auto_contract
AFTER INSERT ON football_club.players
FOR EACH STATEMENT
EXECUTE FUNCTION trg_players_auto_contract();

INSERT INTO football_club.players(first_name, date_of_birth, nationality, position, market_value, club_id)
SELECT 'Демо Игрок', '2000-01-01', 'Россия', 'FW', 1000000::money, fc.club_id
FROM football_club.football_clubs fc
WHERE fc.name = 'Тест Клуб';
```

![01](savepoint/3333.jpg)

```sql

--не воркает на win
SELECT cron.schedule(
    'restock_monday',
    '0 23 * * *',
    $$
    UPDATE football_club.products
    SET count = count + 20
    WHERE count < 100;
    $$
);


SELECT cron.schedule(
    'increase_price',
    '0 23 * * *',
    $$
    UPDATE football_club.products
    SET price = price::numeric * 1.05
    WHERE count < 50;
    $$
);

SELECT cron.schedule(
    'lower_price',
    '0 23 * * *',
    $$
    UPDATE football_club.products
    SET price = price::numeric * 1.05
    WHERE count > 80;
    $$
);

SELECT *
FROM cron.job;

SELECT *
FROM cron.job_run_details;
```
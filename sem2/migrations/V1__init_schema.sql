CREATE SCHEMA IF NOT EXISTS football_club;

CREATE TABLE IF NOT EXISTS football_club.cities
(
    city_id serial NOT NULL,
    name varchar(50) NOT NULL,
    country varchar(50) NOT NULL,
    CONSTRAINT cities_pkey PRIMARY KEY (city_id)
);

CREATE TABLE IF NOT EXISTS football_club.contracts
(
    contract_id serial NOT NULL,
    player_id integer,
    start_date date NOT NULL,
    end_date date NOT NULL,
    salary money NOT NULL,
    CONSTRAINT contracts_pkey PRIMARY KEY (contract_id)
);

CREATE TABLE IF NOT EXISTS football_club.departments
(
    department_id serial NOT NULL,
    name varchar(50) NOT NULL,
    CONSTRAINT departments_pkey PRIMARY KEY (department_id),
    CONSTRAINT departments_name_key UNIQUE (name)
);

CREATE TABLE IF NOT EXISTS football_club.football_clubs
(
    club_id serial NOT NULL,
    name varchar(100) NOT NULL,
    country varchar(50) NOT NULL,
    city varchar(50) NOT NULL,
    owner_id integer,
    staduim_id integer,
    city_id integer,
    CONSTRAINT football_clubs_pkey PRIMARY KEY (club_id)
);

CREATE TABLE IF NOT EXISTS football_club.fun_shop
(
    shop_id serial NOT NULL,
    address varchar(100) NOT NULL,
    club_id integer,
    CONSTRAINT fun_shop_pkey PRIMARY KEY (shop_id)
);

CREATE TABLE IF NOT EXISTS football_club.league
(
    liague_id serial NOT NULL,
    name varchar(100) NOT NULL,
    country varchar(50) NOT NULL,
    tier integer NOT NULL,
    CONSTRAINT league_pkey PRIMARY KEY (liague_id)
);

CREATE TABLE IF NOT EXISTS football_club.owners
(
    owner_id serial NOT NULL,
    name varchar(100) NOT NULL,
    nationality varchar(50) NOT NULL,
    purchase_date date NOT NULL,
    CONSTRAINT owners_pkey PRIMARY KEY (owner_id)
);

CREATE TABLE IF NOT EXISTS football_club.participation
(
    participation_id serial NOT NULL,
    club_id integer,
    tournament_id integer,
    liague_id integer,
    season varchar(10) NOT NULL,
    final_position integer NOT NULL,
    CONSTRAINT participation_pkey PRIMARY KEY (participation_id)
);

CREATE TABLE IF NOT EXISTS football_club.players
(
    player_id serial NOT NULL,
    first_name varchar(30) NOT NULL,
    date_of_birth date NOT NULL,
    nationality varchar(30),
    "position" varchar(20),
    market_value money,
    club_id integer,
    CONSTRAINT players_pkey PRIMARY KEY (player_id)
);

CREATE TABLE IF NOT EXISTS football_club.positions
(
    position_id serial NOT NULL,
    department_id integer,
    title varchar(100) NOT NULL,
    base_salary money NOT NULL,
    CONSTRAINT positions_pkey PRIMARY KEY (position_id)
);

CREATE TABLE IF NOT EXISTS football_club.products
(
    product_id serial NOT NULL,
    name varchar(100) NOT NULL,
    type varchar(50),
    price money NOT NULL,
    count integer NOT NULL,
    shop_id integer,
    height smallint,
    width smallint,
    length smallint,
    CONSTRAINT products_pkey PRIMARY KEY (product_id)
);

CREATE TABLE IF NOT EXISTS football_club.sponsors
(
    sponsor_id serial NOT NULL,
    club_id integer,
    start_date date NOT NULL,
    end_date date NOT NULL,
    amount money NOT NULL,
    type varchar(100) NOT NULL,
    CONSTRAINT sponsors_pkey PRIMARY KEY (sponsor_id)
);

CREATE TABLE IF NOT EXISTS football_club.stadiums
(
    staduim_id serial NOT NULL,
    name varchar(100) NOT NULL,
    capacity integer NOT NULL,
    address varchar(100) NOT NULL,
    CONSTRAINT stadiums_pkey PRIMARY KEY (staduim_id)
);

CREATE TABLE IF NOT EXISTS football_club.staff
(
    staff_id serial NOT NULL,
    first_name varchar(30) NOT NULL,
    date_of_birth date NOT NULL,
    salary money NOT NULL,
    position_id integer,
    club_id integer,
    CONSTRAINT staff_pkey PRIMARY KEY (staff_id)
);

CREATE TABLE IF NOT EXISTS football_club.tournament
(
    tournament_id serial NOT NULL,
    name varchar(100) NOT NULL,
    region varchar(50) NOT NULL,
    format varchar(20) NOT NULL,
    CONSTRAINT tournament_pkey PRIMARY KEY (tournament_id)
);

ALTER TABLE football_club.contracts
    ADD CONSTRAINT contracts_player_id_fkey
    FOREIGN KEY (player_id) REFERENCES football_club.players (player_id);

ALTER TABLE football_club.football_clubs
    ADD CONSTRAINT football_clubs_city_id_fkey
    FOREIGN KEY (city_id) REFERENCES football_club.cities (city_id);

ALTER TABLE football_club.football_clubs
    ADD CONSTRAINT football_clubs_owner_id_fkey
    FOREIGN KEY (owner_id) REFERENCES football_club.owners (owner_id);

ALTER TABLE football_club.football_clubs
    ADD CONSTRAINT football_clubs_staduim_id_fkey
    FOREIGN KEY (staduim_id) REFERENCES football_club.stadiums (staduim_id);

ALTER TABLE football_club.fun_shop
    ADD CONSTRAINT fun_shop_club_id_fkey
    FOREIGN KEY (club_id) REFERENCES football_club.football_clubs (club_id);

ALTER TABLE football_club.participation
    ADD CONSTRAINT participation_club_id_fkey
    FOREIGN KEY (club_id) REFERENCES football_club.football_clubs (club_id);

ALTER TABLE football_club.participation
    ADD CONSTRAINT participation_liague_id_fkey
    FOREIGN KEY (liague_id) REFERENCES football_club.league (liague_id);

ALTER TABLE football_club.participation
    ADD CONSTRAINT participation_tournament_id_fkey
    FOREIGN KEY (tournament_id) REFERENCES football_club.tournament (tournament_id);

ALTER TABLE football_club.players
    ADD CONSTRAINT players_club_id_fkey
    FOREIGN KEY (club_id) REFERENCES football_club.football_clubs (club_id);

ALTER TABLE football_club.positions
    ADD CONSTRAINT positions_department_id_fkey
    FOREIGN KEY (department_id) REFERENCES football_club.departments (department_id);

ALTER TABLE football_club.products
    ADD CONSTRAINT products_shop_id_fkey
    FOREIGN KEY (shop_id) REFERENCES football_club.fun_shop (shop_id);

ALTER TABLE football_club.sponsors
    ADD CONSTRAINT sponsors_club_id_fkey
    FOREIGN KEY (club_id) REFERENCES football_club.football_clubs (club_id);

ALTER TABLE football_club.staff
    ADD CONSTRAINT staff_club_id_fkey
    FOREIGN KEY (club_id) REFERENCES football_club.football_clubs (club_id);

ALTER TABLE football_club.staff
    ADD CONSTRAINT staff_position_id_fkey
    FOREIGN KEY (position_id) REFERENCES football_club.positions (position_id);

ALTER TABLE football_club.players
  ADD COLUMN bio text,   
  ADD COLUMN tags text[],  
  ADD COLUMN extra jsonb,
  ADD COLUMN rating numeric(4,2), 
  ADD COLUMN height_cm smallint;  

ALTER TABLE football_club.contracts
  ADD COLUMN bonus money,
  ADD COLUMN active boolean,
  ADD COLUMN signed_at timestamp;

CREATE TYPE salary_range AS RANGE (
  subtype = money
);

ALTER TABLE football_club.contracts
  ADD COLUMN salary_band salary_range;

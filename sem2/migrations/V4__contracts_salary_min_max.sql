ALTER TABLE football_club.contracts
  DROP COLUMN salary_band;

ALTER TABLE football_club.contracts
  ADD COLUMN salary_min money,
  ADD COLUMN salary_max money;

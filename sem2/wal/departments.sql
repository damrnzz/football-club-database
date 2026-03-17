INSERT INTO football_club.departments(name)
VALUES
  ('Medical'),
  ('Coaching'),
  ('Analytics'),
  ('Marketing'),
  ('Scouting')
ON CONFLICT (name) DO NOTHING;

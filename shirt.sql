-- alright motherfucker, your first sql exercise!
-- create a new database
CREATE DATABASE shirts_db;

--create a new table
CREATE TABLE shirts
  (
    shirt_id INT NOT NULL AUTO_INCREMENT,
    article VARCHAR(25),
    color VARCHAR(20),
    shirt_size VARCHAR(8),
    last_worn INT NOT NULL DEFAULT 0,
    PRIMARY KEY (shirt_id)
  );

--insert data for your new table
INSERT INTO shirts (article, color, shirt_size, last_worn)
VALUES (
  ('t-shirt', 'white', 's', 10),
  ('t-shirt', 'green', 's', 200),
  ('polo shirt', 'black', 's', 10),
  ('tank top', 'blue', 's', 50),
  ('t-shirt', 'pink', 's', 0),
  ('polo shirt', 'red', 'm', 5),
  ('tank top', 'white', 's', 200),
  ('tank top', 'blue', 'm', 15)
);

--add a new purple polo, size medium, worn 50 days ago SWAGGGG
INSERT INTO shirts (article, color, shirt_size, last_worn)
VALUES ('polo shirt', 'purple', 'm', 50);

--select all shirts but display only article and color
SELECT article, color FROM shirts;

--select all medium shirts, print all details except for shirt_id
SELECT article, color, shirt_size, last_worn FROM shirt_size = 'm';

--update all polo shirts to size LARGE
UPDATE shirts SET shirt_size = 'l' WHERE article = 'polo shirt';

--update shirt worn 15 days ago to 0
UPDATE shirts set last_worn = 0 WHERE last_worn = 15;

--update all white shirts to size XS and color to OFF-WHITE
UPDATE shirts set shirt_size = 'xs', color = 'white' WHERE color = 'white';

--delete all old shirts (200 days)
DELETE FROM shirts WHERE last_worn = 200;

--delete all tanktops
DELETE FROM shirts WHERE article = 'tank top';

--delete all shirts
DELETE FROM shirts;

--delete shirts database
DROP TABLE shirts;








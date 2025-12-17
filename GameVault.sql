
CREATE TABLE developers (
  id SERIAL PRIMARY KEY,
  company_name VARCHAR(255) NOT NULL UNIQUE,
  country VARCHAR(100),
  founded_year DATE
);

CREATE TABLE games (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL UNIQUE,
  price DECIMAL(10,2) NOT NULL,
  release_date DATE,
  rating DECIMAL(3,1),
  developer_id INT NOT NULL,
  CONSTRAINT fk_games_developer
    FOREIGN KEY (developer_id) REFERENCES developers(id)
);

CREATE TABLE genres (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE,
  description TEXT
);

CREATE TABLE game_genres (
  id SERIAL PRIMARY KEY,
  game_id INT NOT NULL,
  genre_id INT NOT NULL,
  CONSTRAINT fk_gg_game FOREIGN KEY (game_id) REFERENCES games(id) ON DELETE CASCADE;,
  CONSTRAINT fk_gg_genre FOREIGN KEY (genre_id) REFERENCES genres(id),
  CONSTRAINT uq_game_genre UNIQUE (game_id, genre_id)
);



INSERT INTO developers (company_name, country, founded_year) VALUES
('CD Projekt Red', 'Poland', '2002-01-01'),
('Rockstar Games', 'USA', '1998-01-01'),
('Bethesda Game Studios', 'USA', '2001-01-01'),
('Valve', 'USA', '1996-01-01'),
('Ubisoft', 'France', '1986-01-01');

INSERT INTO genres (name, description) VALUES
('RPG', 'Role-playing games with character progression and story.'),
('Open World', 'Large explorable world with free-roaming gameplay.'),
('Horror', 'Fear-based atmosphere and survival elements.'),
('FPS', 'First-person shooter focused on gunplay.'),
('Sports', 'Sports simulation or arcade sports gameplay.');

INSERT INTO games (title, price, release_date, rating, developer_id) VALUES
('The Witcher 3: Wild Hunt', 29.99, '2015-05-19', 9.3, 1),
('Cyberpunk 2077', 39.99, '2020-12-10', 7.8, 1),
('Grand Theft Auto V', 29.99, '2013-09-17', 9.6, 2),
('Red Dead Redemption 2', 49.99, '2018-10-26', 9.7, 2),
('Skyrim', 19.99, '2011-11-11', 9.0, 3),
('Fallout 4', 14.99, '2015-11-10', 8.7, 3),
('Half-Life 2', 9.99, '2004-11-16', 9.5, 4),
('Counter-Strike 2', 0.00, '2023-09-27', 8.6, 4),
('Assassin''s Creed Odyssey', 24.99, '2018-10-05', 8.6, 5),
('Rainbow Six Siege', 19.99, '2015-12-01', 8.2, 5);

INSERT INTO game_genres (game_id, genre_id) VALUES
(1, 1), (1, 2),          -- Witcher 3: RPG + Open World
(2, 1), (2, 2),          -- Cyberpunk: RPG + Open World
(3, 2),                  -- GTA V: Open World
(4, 2),                  -- RDR2: Open World
(5, 1), (5, 2),          -- Skyrim: RPG + Open World
(6, 1), (6, 2),          -- Fallout 4: RPG + Open World
(7, 4),                  -- Half-Life 2: FPS
(8, 4),                  -- CS2: FPS
(9, 1), (9, 2),          -- AC Odyssey: RPG + Open World
(10, 4);                 -- R6 Siege: FPS


-- Queries

-- Discount Time: Update query that reduces the price of all games by 10%

SELECT * FROM games;	

UPDATE games 
SET price = price*0.90 

-- Bug Fix: Update the rating of a specific game (e.g., change rating from 8.5 to 9.6)

SELECT id, title, rating FROM games WHERE id = 8;

UPDATE games
SET rating = 9.6
WHERE id = 8;

---- Delete a game and automatically remove related records from game_genres

SELECT * FROM games;

DELETE FROM games
WHERE id= 5;

SELECT * FROM game_genres WHERE game_id = 5;

--Reporting

-- List all games with their title, price, and developer company name

SELECT g.title,g.price,d.company_name
FROM games g
INNER JOIN developers d
  ON g.developer_id = d.id;
  
-- List the names and ratings of games that belong to the "RPG" genre

SELECT ga.title, ga.rating
FROM games ga
INNER JOIN game_genres gg ON ga.id = gg.game_id
INNER JOIN genres ge ON gg.genre_id = ge.id
WHERE ge.name = 'RPG';

-- Price Analysis: List games with a price above 15 TL, ordered from highest to lowest price

SELECT title, price FROM games
WHERE price > 15
ORDER BY price DESC;

-- Search: Find games whose title contains the word "si" 

SELECT * FROM games
WHERE title ILIKE '%si%';




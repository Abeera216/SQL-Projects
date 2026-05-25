-- ================================================
-- Golden Age of Video Games — SQL Analysis
-- Analyzes critic scores, user scores and sales
-- data for 25 top games released between 1977-2018
-- ================================================

-- creating game_sales table
CREATE TABLE game_sales (
    name VARCHAR PRIMARY KEY,
    platform VARCHAR,
    publisher VARCHAR,
    developer VARCHAR,
    games_sold FLOAT,
    year INT
);
-- creating reviews table
CREATE TABLE reviews (
    name VARCHAR PRIMARY KEY,
    critic_score FLOAT,
    user_score FLOAT
);

--inserting values in game_sales and reviews

INSERT INTO game_sales (name, platform, publisher, developer, games_sold, year) VALUES
('Wii Sports', 'Wii', 'Nintendo', 'Nintendo EAD', 82.9, 2006),
('Super Mario Bros.', 'NES', 'Nintendo', 'Nintendo', 40.2, 1985),
('Mario Kart 8 Deluxe', 'NS', 'Nintendo', 'Nintendo EPD', 38.7, 2017),
('PlayerUnknown Battlegrounds', 'PC', 'PUBG Corp', 'PUBG Corp', 36.6, 2017),
('Minecraft', 'PC', 'Microsoft', 'Mojang', 33.0, 2011),
('Wii Sports Resort', 'Wii', 'Nintendo', 'Nintendo EAD', 33.0, 2009),
('The Legend of Zelda: Breath of the Wild', 'NS', 'Nintendo', 'Nintendo EPD', 29.0, 2017),
('Grand Theft Auto V', 'PS3', 'Rockstar', 'Rockstar North', 21.4, 2013),
('Super Mario World', 'SNES', 'Nintendo', 'Nintendo', 20.6, 1990),
('Red Dead Redemption 2', 'PS4', 'Rockstar', 'Rockstar Studios', 17.0, 2018),
('The Elder Scrolls V: Skyrim', 'X360', 'Bethesda', 'Bethesda Game Studios', 20.0, 2011),
('Halo 3', 'X360', 'Microsoft', 'Bungie', 12.1, 2007),
('Final Fantasy VII', 'PS', 'Square', 'Square', 9.7, 1997),
('Ocarina of Time', 'N64', 'Nintendo', 'Nintendo EAD', 7.6, 1998),
('Tony Hawk Pro Skater 2', 'PS', 'Activision', 'Neversoft', 7.4, 2000),
('Gran Turismo 3', 'PS2', 'Sony', 'Polyphony Digital', 14.9, 2001),
('Super Mario Galaxy', 'Wii', 'Nintendo', 'Nintendo EAD', 12.8, 2007),
('Halo: Combat Evolved', 'XB', 'Microsoft', 'Bungie', 5.0, 2001),
('Portal 2', 'PC', 'Valve', 'Valve', 4.0, 2011),
('Bioshock', 'X360', '2K Games', 'Irrational Games', 3.0, 2007),
('Baldurs Gate II', 'PC', 'Interplay', 'BioWare', 2.5, 2000),
('StarCraft', 'PC', 'Blizzard', 'Blizzard', 9.5, 1998),
('Half-Life 2', 'PC', 'Valve', 'Valve', 12.0, 2004),
('Shadow of the Colossus', 'PS2', 'Sony', 'Team Ico', 1.9, 2005),
('Ico', 'PS2', 'Sony', 'Team Ico', 0.7, 2001);



INSERT INTO reviews (name, critic_score, user_score) VALUES
('Wii Sports', 7.7, 8.0),
('Super Mario Bros.', 8.4, 8.8),
('Mario Kart 8 Deluxe', 9.2, 9.0),
('Minecraft', 9.0, 8.7),
('Wii Sports Resort', 8.0, 8.1),
('The Legend of Zelda: Breath of the Wild', 9.7, 9.1),
('Grand Theft Auto V', 9.7, 9.0),
('Super Mario World', 9.2, 9.3),
('Red Dead Redemption 2', 9.7, 9.1),
('The Elder Scrolls V: Skyrim', 9.4, 9.5),
('Halo 3', 9.4, 9.3),
('Final Fantasy VII', 9.2, 9.0),
('Ocarina of Time', 9.9, 9.8),
('Tony Hawk Pro Skater 2', 9.4, 8.7),
('Gran Turismo 3', 9.1, 8.5),
('Super Mario Galaxy', 9.7, 9.4),
('Halo: Combat Evolved', 9.7, 9.3),
('Portal 2', 9.5, 9.5),
('Bioshock', 9.6, 9.4),
('Baldurs Gate II', 9.5, 9.6),
('StarCraft', 9.3, 9.4),
('Half-Life 2', 9.6, 9.5),
('Shadow of the Colossus', 9.6, 9.6),
('Ico', 9.1, 9.2),
('PlayerUnknown Battlegrounds', 8.6, 7.0);

-- checking that the data has loaded correctly
SELECT COUNT(*) FROM game_sales;    -- should return 25
SELECT COUNT(*) FROM reviews;       -- should return 25

-- shows the first 5 rows of game_sales and reviews
SELECT * FROM game_sales LIMIT 5;
SELECT * FROM reviews LIMIT 5;

-- To ensure fair average results
SELECT COUNT(*) FROM game_sales g
LEFT JOIN reviews r ON g.name = r.name
WHERE r.name IS NULL;
-- should print 0


-- HELPER TABLE 1: critics_avg_year_rating
CREATE TABLE critics_avg_year_rating (
    year INT,
    num_games INT,
    avg_critic_score FLOAT
);

INSERT INTO critics_avg_year_rating (year, num_games, avg_critic_score) VALUES
(1985, 1, 8.40),
(1990, 1, 9.20),
(1997, 1, 9.20),
(1998, 2, 9.60),  -- Ocarina of Time + StarCraft
(2000, 2, 9.45),  -- Tony Hawk Pro Skater 2 + Baldurs Gate II
(2001, 3, 9.30),  -- Halo CE + Gran Turismo 3 + Ico
(2004, 1, 9.60),  -- Half-Life 2
(2005, 1, 9.60),  -- Shadow of the Colossus
(2006, 1, 7.70),  -- Wii Sports
(2007, 3, 9.57),  -- Halo 3 + Super Mario Galaxy + Bioshock
(2009, 1, 8.00),  -- Wii Sports Resort
(2011, 3, 9.33),  -- Minecraft + Skyrim + Portal 2
(2013, 1, 9.70),  -- GTA V
(2017, 3, 9.17),  -- Zelda BOTW + Mario Kart 8 + PUBG
(2018, 1, 9.70);  -- Red Dead Redemption 2


-- HELPER TABLE 2: users_avg_year_rating

CREATE TABLE users_avg_year_rating (
    year INT,
    num_games INT,
    avg_user_score FLOAT
);

INSERT INTO users_avg_year_rating (year, num_games, avg_user_score) VALUES
(1985, 1, 8.80),
(1990, 1, 9.30),
(1997, 1, 9.00),
(1998, 2, 9.60),  -- Ocarina of Time + StarCraft
(2000, 2, 9.15),  -- Tony Hawk Pro Skater 2 + Baldurs Gate II
(2001, 3, 9.00),  -- Halo CE + Gran Turismo 3 + Ico
(2004, 1, 9.50),  -- Half-Life 2
(2005, 1, 9.60),  -- Shadow of the Colossus
(2006, 1, 8.00),  -- Wii Sports
(2007, 3, 9.40),  -- Halo 3 + Super Mario Galaxy + Bioshock
(2009, 1, 8.10),  -- Wii Sports Resort
(2011, 3, 9.23),  -- Minecraft + Skyrim + Portal 2
(2013, 1, 9.00),  -- GTA V
(2017, 3, 8.37),  -- Zelda BOTW + Mario Kart 8 + PUBG
(2018, 1, 9.10);  -- Red Dead Redemption 2

--checking that the data has loaded correctly

SELECT * FROM critics_avg_year_rating ORDER BY year;
SELECT * FROM users_avg_year_rating ORDER BY year;
--------------------------------------------------
-- Top 5 best selling games
CREATE TABLE best_selling_games AS
SELECT *
FROM game_sales
ORDER BY games_sold DESC
LIMIT 5;
-----------------------------------------------------------------------------
--Find the top 5 years with highest average critic scores (min 4 games per year)
CREATE TABLE critics_top_five_years AS
SELECT g.year,
       COUNT(g.name) AS num_games,
       ROUND(AVG(r.critic_score)::numeric, 2) AS avg_critic_score --numeric added as the data type for critic_score is float
FROM game_sales g
JOIN reviews r ON g.name = r.name --tables are joined not rows
GROUP BY g.year -- group by year as the criteria is "per year"
HAVING COUNT(g.name) >=4 --"at least 4"
ORDER BY avg_critic_score DESC 
LIMIT 5;

------------------------------------------------------------------------------
--Find the top 5 years with highest average user scores (min 1 game per year)
CREATE TABLE users_top_years AS
SELECT g.year,
       COUNT(g.name) AS num_games,
       ROUND(AVG(r.user_score)::numeric, 2) AS avg_user_score
FROM game_sales g
JOIN reviews r ON g.name = r.name
GROUP BY g.year
HAVING COUNT(g.name) >= 1
ORDER BY avg_user_score DESC
LIMIT 5;

----------------------------------------------------------------------------
--Identify golden years where critics OR users gave an average score above 9
CREATE TABLE golden_years AS
SELECT c.year,
       c.num_games,
       c.avg_critic_score,
       u.avg_user_score,
       c.avg_critic_score - u.avg_user_score AS diff
FROM critics_avg_year_rating c
JOIN users_avg_year_rating u ON c.year = u.year --"Connect the two tables where the year matches"
WHERE c.avg_critic_score > 9
   OR u.avg_user_score > 9
ORDER BY year;

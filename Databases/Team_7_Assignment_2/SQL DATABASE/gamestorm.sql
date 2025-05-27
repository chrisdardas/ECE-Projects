DROP DATABASE IF EXISTS `gamestorm`;
CREATE DATABASE `gamestorm`;
USE `gamestorm`;

CREATE TABLE player(
	`player_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `username` VARCHAR(20) NOT NULL UNIQUE,
    `email` VARCHAR(30) NOT NULL UNIQUE,
    `total_playtime` INT DEFAULT 0 CHECK(total_playtime >=0),
    `achievement_points` INT DEFAULT 0 CHECK(achievement_points>=0),
    `ban_status` BOOLEAN DEFAULT FALSE,
    `last_login` DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE developer(
	`developer_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(20) NOT NULL,
    `email` VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE platform_name(
	`name` VARCHAR(20) PRIMARY KEY NOT NULL,
    `type` ENUM("Console", "PC") NOT NULL CHECK(type IN("Console", "PC")),
    `operating_system` VARCHAR(15) NOT NULL CHECK(operating_system IN("Windows 10", "Windows 11", "Xbox OS", "Orbis OS", "Nintendo OS"))
    );

CREATE TABLE platform(
	`platform_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `platform_name` VARCHAR(20) NOT NULL,
    
    FOREIGN KEY(`platform_name`) REFERENCES platform_name(`name`)
);

CREATE TABLE genre(
	`name` VARCHAR(35) PRIMARY KEY NOT NULL,
    `target_audience` VARCHAR(10) CHECK(target_audience IN("All Ages", "Teenagers", "Adults")),
    `number_of_games` INT DEFAULT 0 CHECK(number_of_games>=0)
);

CREATE TABLE game(
	`game_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(50) NOT NULL UNIQUE,
	`release_date` DATE ,
    `price` DECIMAL(4, 2) DEFAULT 0.00 CHECK(price >= 0.00),
    `age_rating` VARCHAR(10) NOT NULL CHECK(age_rating IN("All Ages", "12+", "16+", "18+")),
    `dlcs_available` BOOLEAN DEFAULT FALSE,
    `multiplayer_support` BOOLEAN DEFAULT FALSE,
    `genre_name` VARCHAR(35),
    `developer_id` INT NOT NULL,
    `platform_id` INT NOT NULL,
    
    FOREIGN KEY (`genre_name`) REFERENCES genre(`name`) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (`developer_id`) REFERENCES developer(`developer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`platform_id`) REFERENCES platform(`platform_id`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE wishlist(
	`wishlist_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `date_of_addition` DATE ,
    `item_count` INT CHECK(item_count >= 0),
    `player_id` INT NOT NULL,
    
    FOREIGN KEY(`player_id`) REFERENCES player(`player_id`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE review(
	`review_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	`rating` DECIMAL(3, 2) DEFAULT 0.0 CHECK(rating >= 0.00 AND rating <= 5.00),
	`comment` TEXT DEFAULT NULL,
	`publication_date` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `player_id` INT NOT NULL,

	FOREIGN KEY (`player_id`) REFERENCES player(`player_id`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE dlc(
	`dlc_id` INT PRIMARY KEY AUTO_INCREMENT,
	`title` VARCHAR(50) NOT NULL UNIQUE,
	`description` TEXT,
	`release_date` DATE,
	`game_id` INT NOT NULL,
	`developer_id` INT NOT NULL,

	FOREIGN KEY (`game_id`) REFERENCES game(`game_id`) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (`developer_id`) REFERENCES developer(`developer_id`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE achievement(
	`achievement_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(50) NOT NULL,
    `achievement_description` TEXT NOT NULL,
    `date_of_completion` DATE ,
    `achievement_difficulty` ENUM("Easy", "Normal", "Hard") NOT NULL,
    `achievement_points` INT DEFAULT 0 CHECK(achievement_points>=0),
    `game_id` INT NOT NULL,
    
    FOREIGN KEY(`game_id`) REFERENCES game(`game_id`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE transaction(
	`transaction_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `date` DATE ,
    `transaction_amount` DECIMAL(6, 2) DEFAULT 0.0 CHECK(transaction_amount>=0.00),
    `payment_method` VARCHAR(15) CHECK(payment_method IN("Credit Card", "PayPal", "PaySafe")),
    `player_id` INT NOT NULL,
    
    FOREIGN KEY(`player_id`) REFERENCES player(`player_id`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE player_owns_game(
	`player_id` INT NOT NULL,
    `game_id` INT NOT NULL,
    `last_played` DATETIME DEFAULT CURRENT_TIMESTAMP,
     PRIMARY KEY(`player_id`, `game_id`),
     
     FOREIGN KEY (`player_id`) REFERENCES player(`player_id`) ON DELETE CASCADE ON UPDATE CASCADE,
     FOREIGN KEY (`game_id`) REFERENCES game(`game_id`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE player_unlocks_achievement(
	`player_id` INT NOT NULL,
    `achievement_id` INT NOT NULL,
    PRIMARY KEY(`player_id`, `achievement_id`),
    
    FOREIGN KEY (`player_id`) REFERENCES player(`player_id`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`achievement_id`) REFERENCES achievement(`achievement_id`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE game_createdby_developer(
	`game_id` INT NOT NULL,
    `developer_id` INT NOT NULL,
    PRIMARY KEY (`game_id`, `developer_id`),
    
    FOREIGN KEY (`game_id`) REFERENCES game(`game_id`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`developer_id`) REFERENCES developer(`developer_id`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE game_belongsto_wishlist(
	`game_id` INT NOT NULL,
    `wishlist_id` INT NOT NULL,
    PRIMARY KEY (`game_id`, `wishlist_id`),
    
    FOREIGN KEY (`game_id`) REFERENCES game(`game_id`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`wishlist_id`) REFERENCES wishlist(`wishlist_id`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE dlc_createdby_developer(
	`dlc_id` INT NOT NULL,
    `developer_id` INT NOT NULL,
    PRIMARY KEY(`dlc_id`, `developer_id`),
    
    FOREIGN KEY (`dlc_id`) REFERENCES dlc(`dlc_id`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`developer_id`) REFERENCES developer(`developer_id`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE VIEW `GamesByDeveloper` AS 
	SELECT A.game_id, A.title
	FROM game AS A
	JOIN game_createdby_developer AS B ON A.game_id = B.game_id
	JOIN developer AS C ON B.developer_id = C.developer_id;
    
CREATE VIEW `AchievementsByGames` AS
	SELECT achievement_id, B.game_id, achievement_points, A.title
    FROM achievement AS A
    JOIN GamesByDeveloper AS B ON A.game_id = B.game_id;
    
CREATE VIEW `UnlockedAchievements` AS 
	SELECT username, title
    FROM player AS A
    JOIN player_unlocks_achievement AS B ON A.player_id = B.player_id
    JOIN AchievementsByGames AS C ON B.achievement_id = C.achievement_id;
    
CREATE VIEW `TotalGamesPerPlayer` AS
	SELECT A.player_id, COUNT(DISTINCT C.game_id) AS TotalGames, GROUP_CONCAT(DISTINCT B.game_id) AS game_id
    FROM player AS A
    JOIN player_owns_game AS B ON A.player_id = B.player_id
    JOIN game AS C ON B.game_id = C.game_id
    GROUP BY A.player_id;
    
CREATE VIEW `TotalDLCsPerPlayer` AS
	SELECT G.game_id, COUNT(DISTINCT D.dlc_id) AS TotalDLCs
	FROM game AS G
	JOIN dlc AS D ON G.game_id = D.game_id
	GROUP BY G.game_id;

CREATE VIEW `MultiplayerGamesByDeveloper` AS
	SELECT A.game_id
	FROM game AS A
    JOIN developer AS B ON A.developer_id = B.developer_id
	WHERE B.developer_id = 34556 AND A.multiplayer_support = 1;
    
CREATE VIEW `ReviewsForDeveloperGames` AS 
	SELECT A.player_id, C.game_id, rating
	FROM player AS A 
    JOIN review AS B ON A.player_id = B.player_id
    JOIN player_owns_game AS C ON A.player_id = C.player_id
    JOIN MultiplayerGamesByDeveloper AS D ON C.game_id = D.game_id;
 
CREATE VIEW `GameAchievements` AS
	SELECT A.achievement_id , A.title
	FROM game AS G
	JOIN player_owns_game AS B ON G.game_id = B.game_id
	JOIN player_unlocks_achievement AS C ON B.player_id = C.player_id
	JOIN achievement AS A ON C.achievement_id = A.achievement_id
	WHERE B.player_id = 504;

INSERT INTO player 
VALUES  (56, 'stormrage', 'stormrage@example.com', 90, 500, TRUE, '2023-10-05 15:30:00'),
		(9, 'ninjaGirl', 'ninja@example.com', 400, 2500, FALSE, '2024-11-10 23:05:00'),
		(123, 'gourouAE', 'konst.wert@example.com', 48, 12, TRUE, '2022-07-04 10:32:09'),
		(555, 'masterdrag', 'jhnrot@example.com', 987, 4089, TRUE, '2024-11-15 22:38:55'),
		(1756, 'littleenem', 'katke.23@example.com', 350, 2002, FALSE, '2024-10-27 13:42:59'),
		(99, 'termin43', 'ionsal1995@example.com', 123, 1008, FALSE, '2023-12-29 18:36:03'),
		(288, 'dragonKing', 'doragon@example.com', 150, 1200, FALSE, '2024-08-01 12:47:00');


INSERT INTO developer 
VALUES  (34556, 'MasterDev', 'masterdev@example.com'),
		(22331, 'ChanAlik', 'chanalik@example.com'),
		(112233, 'LittlePrince', 'lprince18@example.com'),
		(89711, 'RoyalKing', 'kotiaser@example.com'),
		(45667, 'FlowerRoza', 'flowerroz23@example.com'),
		(32257, 'CharKolio', 'charilko45@example.com'),
		(43121, 'Selenimia', 'selenimia@example.com');


INSERT INTO platform_name 
VALUES  ('Xbox X', 'Console', 'Xbox OS'),
		('DELL', 'PC', 'Windows 11'),
		('Play Station 5', 'Console', 'Orbis OS'),
		('Nintendo Switch', 'Console', 'Nintendo OS'),
		('Xbox One', 'Console', 'Xbox OS'),
		('HP', 'PC', 'Windows 11'),
		('Alienware', 'PC', 'Windows 10');

INSERT INTO platform 
VALUES  (3242, 'Xbox X'),
		(509, 'DELL'),
		(21901, 'Play Station 5'),
		(7845, 'Nintendo Switch'),
		(10432, 'Xbox One'),
		(871, 'HP'),
		(340, 'Alienware');

INSERT INTO genre 
VALUES  ('Action', 'Adults', 90),
		('RPG', 'Teenagers', 201),
		('Adventure', 'Adults', 90),
		('Role-Play', 'Teenagers', 124),
		('Strategy', 'Adults', 78),
		('Racing', 'All Ages', 43),
		('Simulation', 'All Ages', 36);

INSERT INTO game 
VALUES	(1305, 'Elden Ring', '2022-02-25', 59.90, '16+', TRUE, TRUE, 'RPG', 34556, 509),
		(8734, 'Bloodborne', '2015-03-24', 19.99, '16+', TRUE, TRUE, 'RPG', 89711, 3242),
		(3125, 'Uncharted 4', '2017-05-10', 24.90, '16+', FALSE, TRUE, 'Adventure', 22331, 21901),
		(8392, 'God Of War', '2018-04-20', 19.99, '18+', FALSE, FALSE, 'Action', 43121, 340),
		(9021, 'Red Dead Redemption 2', '2018-10-26', 59.99, '18+', FALSE, TRUE, 'Action', 45667, 3242),
		(8743, 'Batman: Arkham Knight', '2015-06-23', 14.99, '18+', TRUE, FALSE, 'Action', 112233, 871),
		(7123, 'Overwatch 2', '2022-10-04', 0.00, '12+', FALSE, TRUE, 'Action', 34556, 3242);


INSERT INTO wishlist 
VALUES	(12345, '2024-10-23', 2, 56),
		(23500, '2023-09-09', 8, 9),
		(56789, '2023-09-09', 1, 123),
		(21312, '2024-03-24', 12, 555),
		(43560, '2023-12-15', 3, 1756),
		(55668, '2022-06-07', 9, 99),
		(12120, '2021-02-13', 25, 288);

INSERT INTO review
VALUES	(34, 2.50, 'Το gameplay είναι καλό, αλλά έχει αρκετά bugs.', '2021-03-25', 56),
		(250, 4.90, 'Φοβερό παιχνίδι, αξίζει τα χρήματά του!', '2023-02-15', 9),
		(85, 4.80, 'Το καλύτερο Battle Royale που έχω παίξει!', '2024-11-30', 123),
		(1024, 4.50, 'Co-op mode με φίλους είναι ό,τι καλύτερο.', '2022-03-18', 555),
		(325, 5.00, 'Η ιστορία με καθήλωσε!', '2020-07-24', 1756),
		(2001, 2.00, 'To matchmaking είναι άδικο και οι servers lagάρουν.', '2024-12-01', 99),
		(5933, 1.50, 'Pay-to-win μηχανισμοί παντού.', '2020-10-05', 288);

INSERT INTO dlc 
VALUES	(4378, 'Shadow Of The Erdtree', 'Explore the Realm of Shadow and fight challenging bosses.', '2024-06-21', 1305, 34556),
		(7685, 'The Old Hunters', 'Unique bosses, brutal difficulty, and terrifying locations.', '2015-11-24', 8734, 89711),
		(324, 'Artorias Of The Abyss', 'Fleshes out the story and adds some of the best bosses.', '2012-08-24', 8392, 112233),
		(8975, 'GCPD Lockdown', 'Nightwing tries to prevent The Penguin from escaping.', '2015-09-29', 8743, 22331),
		(8392, 'The Ringed City', 'New convoluted region, enemies, and mysteries.', '2017-01-23', 8392, 45667),
		(4372, 'Crown of the Old Iron King', 'New stages, maps, bosses, weapons, and armor.', '2014-08-26', 8743, 43121);


INSERT INTO achievement 
VALUES	(48, 'Master Explorer', 'Explore all the game maps.', '2024-01-05', 'Hard', 100, 1305),
		(496, 'First Blood', 'Kill your first opponent in the game.', '2023-12-15', 'Easy', 10, 8734),
		(103, "Legendary Collector", "Collect all the collectibles in the game", "2024-07-10", "Normal", 75, 1305),
		(1988, "Unstoppable", "Win 10 consecutive ranked matches", "2023-01-25", "Normal", 70, 7123),
		(4021, "Social Butterfly", "Play 100 multiplayer matches", "2021-07-02", "Easy", 30, 7123),
		(5, "Speed Runner", "Complete the game in under 5 hours", "2022-11-08", "Hard",  95, 8734),
		(629, "Master of Stealth", "Complete the game using only stealth kills",  "2020-04-18",  "Hard", 150, 8743);

INSERT INTO transaction
VALUES  (1290, "2023-05-17", 45.67, "Credit Card", 9),
		(1284, "2022-10-23", 76.42, "PayPal", 555),
		(984, "2020-09-30", 67.21, "Credit Card", 123),
		(8943, "2024-08-30", 34.54, "PaySafe", 9),
		(3241, "2024-03-12", 98.54, "PaySafe", 56),
		(2312, "2023-10-29", 91.87, "PayPal", 56),
		(3223, "2023-12-27", 12.85, "Credit Card", 555);

INSERT INTO player_owns_game 
VALUES	(56, 1305, '2023-11-01 15:30:00'),
    	(9, 8734, '2024-11-09 20:45:00'),
    	(123, 3125, '2022-07-05 12:00:00'),
    	(555, 8392, '2024-11-14 19:25:00'),
    	(1756, 9021, '2024-10-26 14:00:00'),
    	(99, 8743, '2023-12-28 18:40:00'),
    	(288, 7123, '2024-07-31 10:15:00');

INSERT INTO player_unlocks_achievement (player_id, achievement_id) 
VALUES	(56, 48),
    	(9, 496),
    	(123, 103),
    	(555, 1988),
    	(1756, 4021),
    	(99, 5),
    	(288, 629);

INSERT INTO game_createdby_developer
VALUES	(1305, 34556),
    	(8734, 89711),
    	(3125, 22331),
    	(8392, 43121),
    	(9021, 45667),
    	(8743, 112233),
    	(7123, 34556);

INSERT INTO game_belongsto_wishlist 
VALUES	(1305, 12345),
    	(8734, 23500),
    	(3125, 56789),
    	(8392, 21312),
    	(9021, 43560),
    	(8743, 55668),
    	(7123, 12120);


INSERT INTO dlc_createdby_developer 
VALUES	(4378, 34556),
    	(7685, 89711),
    	(324, 112233),
    	(8975, 22331),
    	(8392, 45667),
    	(4372, 43121);

DELIMITER $$

-- Trigger to set the default date for release_date, date_of_addition, release_date, date_of_completion, and date
CREATE TRIGGER set_default_date1
BEFORE INSERT ON game
FOR EACH ROW
BEGIN
    IF NEW.release_date IS NULL THEN
        SET NEW.release_date = CURDATE();
    END IF;
END; 
$$

CREATE TRIGGER set_default_date2
BEFORE INSERT ON wishlist
FOR EACH ROW
BEGIN
	IF NEW.date_of_addition IS NULL THEN
		SET NEW.date_of_addition = CURDATE();
	END IF;
END; 
$$

CREATE TRIGGER set_default_date3
BEFORE INSERT ON dlc
FOR EACH ROW 
BEGIN
	IF NEW.release_date IS NULL THEN
		SET NEW.release_date = CURDATE();
	END IF;
END; 
$$

CREATE TRIGGER set_default_date4
BEFORE INSERT ON achievement
FOR EACH ROW
BEGIN
	IF NEW.date_of_completion IS NULL THEN
		SET NEW.date_of_completion = CURDATE();
	END IF;
END; 
$$

CREATE TRIGGER set_default_date5
BEFORE INSERT ON transaction
FOR EACH ROW
BEGIN
	IF NEW.date IS NULL THEN
		SET NEW.date = CURDATE();
	END IF;
END; 
$$

-- Increment number_of_games after inserting a game
CREATE TRIGGER increment_genre_game_count
AFTER INSERT ON game
FOR EACH ROW
BEGIN
    UPDATE genre SET number_of_games = number_of_games + 1 WHERE name = NEW.genre_name;
END;
$$

-- Decrement number_of_games after deleting a game
CREATE TRIGGER decrement_genre_game_count
AFTER DELETE ON game
FOR EACH ROW
BEGIN
    UPDATE genre SET number_of_games = number_of_games - 1 WHERE name = OLD.genre_name;
END;
$$

-- Trigger to update the number_of_games of the genre after updating the genre_name of a game
CREATE TRIGGER update_genre_game_count
AFTER UPDATE ON game
FOR EACH ROW
BEGIN
    IF OLD.genre_name != NEW.genre_name THEN
        UPDATE genre SET number_of_games = number_of_games - 1 WHERE name = OLD.genre_name;
        UPDATE genre SET number_of_games = number_of_games + 1 WHERE name = NEW.genre_name;
    END IF;
END;

-- Trigger to update the total playtime of a player after the last_played field is updated
CREATE TRIGGER update_player_total_playtime
AFTER UPDATE ON player_owns_game
FOR EACH ROW
BEGIN
    DECLARE playtime_increment INT;
    SET playtime_increment = TIMESTAMPDIFF(HOUR, OLD.last_played, NEW.last_played);
    
    UPDATE player
    SET total_playtime = total_playtime + playtime_increment
    WHERE player_id = NEW.player_id;
END;
$$

-- Trigger to prevent deletion of a developer with associated games
CREATE TRIGGER prevent_developer_delete
BEFORE DELETE ON developer
FOR EACH ROW
BEGIN
	DECLARE game_count INT;
	SELECT COUNT(*) INTO game_count FROM game_createdby_developer WHERE developer_id = OLD.developer_id;
	
	IF game_count > 0 THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Cannot delete developer with associated games';
	END IF;
END;
$$

-- Trigger to remove a game from wishlist after deletion of the game
CREATE TRIGGER remove_game_from_wishlist_on_delete
AFTER DELETE ON game
FOR EACH ROW
BEGIN
	DELETE FROM game_belongsto_wishlist WHERE game_id = OLD.game_id;
END;
$$

-- Remove all achievements when a game is deleted
CREATE TRIGGER remove_achievements_on_game_delete
AFTER DELETE ON game
FOR EACH ROW 
BEGIN 
	DELETE FROM achievement WHERE game_id = OLD.game_id;
END;

-- Remove Wishlist when a player is deleted
CREATE TRIGGER remove_wishlist_on_player_delete
AFTER DELETE ON player
FOR EACH ROW
BEGIN 
	DELETE FROM wishlist WHERE player_id = OLD.player_id;
END
$$

-- Increment the total achievement points of a player 
CREATE TRIGGER increment_player_achievement_points
AFTER INSERT ON player_unlocks_achievement
FOR EACH ROW
BEGIN
    DECLARE points INT;
    SELECT achievement_points INTO points FROM achievement WHERE achievement_id = NEW.achievement_id;
    
    UPDATE player SET achievement_points = achievement_points + points WHERE player_id = NEW.player_id;
END;


DELIMITER ;

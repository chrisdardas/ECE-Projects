-- Admin User
DROP USER IF EXISTS 'admin'@'localhost';
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'adminpassword';
GRANT ALL PRIVILEGES ON gamestorm.* TO 'admin'@'localhost' WITH GRANT OPTION;

-- Player User
DROP USER IF EXISTS 'player'@'localhost';
CREATE USER 'player'@'localhost' IDENTIFIED BY 'playerpassword';

-- Developer User
DROP USER IF EXISTS 'developer'@'localhost';
CREATE USER 'developer'@'localhost' IDENTIFIED BY 'developerpassword';

-- Roles
DROP ROLE IF EXISTS 'players';
CREATE ROLE "players";
DROP ROLE IF EXISTS 'game_developer';
CREATE ROLE "game_developer";

-- Privileges for the player Role
GRANT SELECT, INSERT, UPDATE, DELETE ON gamestorm.player TO 'players';
GRANT SELECT, INSERT, UPDATE, DELETE ON gamestorm.review TO 'players';
GRANT SELECT, INSERT, UPDATE, DELETE ON gamestorm.wishlist TO 'players';
GRANT SELECT ON gamestorm.game TO 'players';
GRANT SELECT ON gamestorm.genre TO 'players';
GRANT SELECT ON gamestorm.platform_name TO 'players';
GRANT SELECT ON gamestorm.achievement TO 'players';
GRANT INSERT ON gamestorm.transaction TO 'players';
GRANT SELECT ON gamestorm.gamesbydeveloper TO 'players';
GRANT SELECT ON gamestorm.unlockedachievements TO 'players';
GRANT SELECT ON gamestorm.dlc TO 'players';


-- Privileges for the developer Role
GRANT SELECT, INSERT , UPDATE, DELETE ON gamestorm.developer TO 'game_developer';
GRANT SELECT, INSERT, UPDATE, DELETE ON gamestorm.game TO 'game_developer';
GRANT SELECT, INSERT, UPDATE, DELETE ON gamestorm.genre TO 'game_developer';
GRANT SELECT, INSERT, UPDATE ON gamestorm.platform_name to 'game_developer';
GRANT SELECT, INSERT ON gamestorm.review to 'game_developer';
GRANT SELECT, INSERT, UPDATE, DELETE ON gamestorm.dlc TO 'game_developer';
GRANT SELECT ON gamestorm.game_createdby_developer TO 'game_developer';
GRANT SELECT ON gamestorm.totalgamesperplayer TO 'game_developer';
GRANT SELECT ON gamestorm.totaldlcsperplayer TO 'game_developer';
GRANT SELECT ON gamestorm.reviewsfordevelopergames TO 'game_developer';


-- Grant roles to users
GRANT 'players' TO 'player'@'localhost';
GRANT 'game_developer' TO 'developer'@'localhost';

-- Set default role for users
SET DEFAULT ROLE 'players' TO 'player'@'localhost';
SET DEFAULT ROLE 'game_developer' TO 'developer'@'localhost';
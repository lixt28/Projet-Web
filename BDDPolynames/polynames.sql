-- Table Game
CREATE TABLE IF NOT EXISTS `Game` (
  `game_id` INT(11) NOT NULL AUTO_INCREMENT,
  `game_code` VARCHAR(50) COLLATE utf8_unicode_ci NOT NULL,
  `final_score` INT,
  PRIMARY KEY (`game_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Inserting data into the Game table
INSERT INTO Game (game_code, final_score) VALUES
('G001', 100),
('G002', 150);


-- Table Player
CREATE TABLE IF NOT EXISTS `Player` (
  `player_id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`player_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Inserting data into the Player table
INSERT INTO Player (name) VALUES
('Alice'),
('Bob'),
('Charlie'),
('Diana');


-- Table Participate (association between Game and Player)
CREATE TABLE IF NOT EXISTS `Participate` (
  `game_id` INT(11) NOT NULL,
  `player_id` INT(11) NOT NULL,
  `role` VARCHAR(50) COLLATE utf8_unicode_ci,
  PRIMARY KEY (`game_id`, `player_id`),
  KEY `FK_Participate_Game` (`game_id`),
  KEY `FK_Participate_Player` (`player_id`),
  CONSTRAINT `FK_Participate_Game` FOREIGN KEY (`game_id`) REFERENCES `Game` (`game_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_Participate_Player` FOREIGN KEY (`player_id`) REFERENCES `Player` (`player_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Inserting data into the Participate table
INSERT INTO Participate (game_id, player_id, role) VALUES
(1, 1, 'captain'),
(1, 2, 'member'),
(2, 3, 'captain'),
(2, 4, 'member');



-- Table Turn
CREATE TABLE IF NOT EXISTS `Turn` (
  `turn_id` INT(11) NOT NULL AUTO_INCREMENT,
  `hint` VARCHAR(30) NOT NULL,
  `word_count` INT,
  `score` INT,
  `game_id` INT(11),
  PRIMARY KEY (`turn_id`),
  KEY `FK_Turn_Game` (`game_id`),
  CONSTRAINT `FK_Turn_Game` FOREIGN KEY (`game_id`) REFERENCES `Game` (`game_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Inserting data into the Turn table
INSERT INTO Turn (hint, word_count, score, game_id) VALUES
("potato", 10, 50, 1),
("aunt", 15, 50, 1),
("rock", 20, 75, 2),
("coffee", 10, 75, 2);



-- Table Color
CREATE TABLE IF NOT EXISTS `Color` (
  `color_id` INT(11) NOT NULL AUTO_INCREMENT,
  `color_name` VARCHAR(50) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`color_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Inserting data into the Color table
INSERT INTO Color (color_name) VALUES
('Blue'),
('Gray'),
('Black');


-- Table Word
CREATE TABLE IF NOT EXISTS `Word` (
  `word_id` INT(11) NOT NULL AUTO_INCREMENT,
  `word` VARCHAR(100) COLLATE utf8_unicode_ci NOT NULL,
  `color_id` INT(11),
  PRIMARY KEY (`word_id`),
  KEY `FK_Word_Color` (`color_id`),
  CONSTRAINT `FK_Word_Color` FOREIGN KEY (`color_id`) REFERENCES `Color` (`color_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- Inserting data into the Word table (dictionary of 50 words)
INSERT INTO Word (word, color_id) VALUES
('Cat', 1),
('Cat', 2),
('Cat', 3),
('Dog', 1),
('Dog', 2),
('Dog', 3),
('House', 1),
('House', 2),
('House', 3),
('Car', 1),
('Car', 2),
('Car', 3),
('Tree', 1),
('Tree', 2),
('Tree', 3),
('Flower', 1),
('Flower', 2),
('Flower', 3),
('Boat', 1),
('Boat', 2),
('Boat', 3),
('Plane', 1),
('Plane', 2),
('Plane', 3),
('Computer', 1),
('Computer', 2),
('Computer', 3),
('Phone', 1),
('Phone', 2),
('Phone', 3),
('Book', 1),
('Book', 2),
('Book', 3),
('Pen', 1),
('Pen', 2),
('Pen', 3),
('Table', 1),
('Table', 2),
('Table', 3),
('Chair', 1),
('Chair', 2),
('Chair', 3),
('Window', 1),
('Window', 2),
('Window', 3),
('Door', 1),
('Door', 2),
('Door', 3),
('Sky', 1),
('Sky', 2),
('Sky', 3),
('Sun', 1),
('Sun', 2),
('Sun', 3),
('Moon', 1),
('Moon', 2),
('Moon', 3),
('Star', 1),
('Star', 2),
('Star', 3),
('Mountain', 1),
('Mountain', 2),
('Mountain', 3),
('River', 1),
('River', 2),
('River', 3),
('Ocean', 1),
('Ocean', 2),
('Ocean', 3),
('Beach', 1),
('Beach', 2),
('Beach', 3),
('Forest', 1),
('Forest', 2),
('Forest', 3),
('Desert', 1),
('Desert', 2),
('Desert', 3),
('Island', 1),
('Island', 2),
('Island', 3),
('Continent', 1),
('Continent', 2),
('Continent', 3),
('Country', 1),
('Country', 2),
('Country', 3),
('City', 1),
('City', 2),
('City', 3),
('Village', 1),
('Village', 2),
('Village', 3),
('Neighborhood', 1),
('Neighborhood', 2),
('Neighborhood', 3),
('Street', 1),
('Street', 2),
('Street', 3),
('Highway', 1),
('Highway', 2),
('Highway', 3),
('Path', 1),
('Path', 2),
('Path', 3),
('Trail', 1),
('Trail', 2),
('Trail', 3),
('Bridge', 1),
('Bridge', 2),
('Bridge', 3),
('Tunnel', 1),
('Tunnel', 2),
('Tunnel', 3),
('Building', 1),
('Building', 2),
('Building', 3),
('Skyscraper', 1),
('Skyscraper', 2),
('Skyscraper', 3),
('Park', 1),
('Park', 2),
('Park', 3),
('Garden', 1),
('Garden', 2),
('Garden', 3),
('School', 1),
('School', 2),
('School', 3),
('University', 1),
('University', 2),
('University', 3),
('Hospital', 1),
('Hospital', 2),
('Hospital', 3),
('Clinic', 1),
('Clinic', 2),
('Clinic', 3),
('Museum', 1),
('Museum', 2),
('Museum', 3),
('Cinema', 1),
('Cinema', 2),
('Cinema', 3),
('Theater', 1),
('Theater', 2),
('Theater', 3),
('Library', 1),
('Library', 2),
('Library', 3);


-- Table Contain (association between Game and Word)
CREATE TABLE IF NOT EXISTS `Contain` (
  `game_id` INT(11) NOT NULL,
  `word_id` INT(11) NOT NULL,
  PRIMARY KEY (`game_id`, `word_id`),
  KEY `FK_Contain_Game` (`game_id`),
  KEY `FK_Contain_Word` (`word_id`),
  CONSTRAINT `FK_Contain_Game` FOREIGN KEY (`game_id`) REFERENCES `Game` (`game_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_Contain_Word` FOREIGN KEY (`word_id`) REFERENCES `Word` (`word_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- Inserting data into the Contain table for two games of 25 words each
INSERT INTO Contain (game_id, word_id) VALUES
-- Game 1
(1, 1), (1, 2), (1, 3), (1, 4), (1, 5),
(1, 6), (1, 7), (1, 8), (1, 9), (1, 10),
(1, 11), (1, 12), (1, 13), (1, 14), (1, 15),
(1, 16), (1, 17), (1, 18), (1, 19), (1, 20),
(1, 21), (1, 22), (1, 23), (1, 24), (1, 25),
-- Game 2
(2, 26), (2, 27), (2, 28), (2, 29), (2, 30),
(2, 31), (2, 32), (2, 33), (2, 34), (2, 35),
(2, 36), (2, 37), (2, 38), (2, 39), (2, 40),
(2, 41), (2, 42), (2, 43), (2, 44), (2, 45),
(2, 46), (2, 47), (2, 48), (2, 49), (2, 50);

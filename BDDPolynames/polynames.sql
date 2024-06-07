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
('Dog', 1),
('House', 2),
('Car', 2),
('Tree', 3),
('Flower', 3),
('Boat', 1),
('Plane', 1),
('Computer', 2),
('Phone', 2),
('Book', 3),
('Pen', 3),
('Table', 1),
('Chair', 1),
('Window', 2),
('Door', 2),
('Sky', 3),
('Sun', 3),
('Moon', 1),
('Star', 1),
('Mountain', 2),
('River', 2),
('Ocean', 3),
('Beach', 3),
('Forest', 1),
('Desert', 1),
('Island', 2),
('Continent', 2),
('Country', 3),
('City', 3),
('Village', 1),
('Neighborhood', 1),
('Street', 2),
('Highway', 2),
('Path', 3),
('Trail', 3),
('Bridge', 1),
('Tunnel', 1),
('Building', 2),
('Skyscraper', 2),
('Park', 3),
('Garden', 3),
('School', 1),
('University', 1),
('Hospital', 2),
('Clinic', 2),
('Museum', 3),
('Cinema', 3),
('Theater', 1),
('Library', 1);


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

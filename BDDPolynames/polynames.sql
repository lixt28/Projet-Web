-- Table Partie
CREATE TABLE IF NOT EXISTS `Partie` (
  `id_Partie` INT(11) NOT NULL AUTO_INCREMENT,
  `code_Partie` VARCHAR(50) COLLATE utf8_unicode_ci NOT NULL,
  `score_final` INT,
  PRIMARY KEY (`id_Partie`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Insertion des données dans la table Partie
INSERT INTO Partie (code_Partie, score_final) VALUES
('P001', 100),
('P002', 150);


-- Table Joueur
CREATE TABLE IF NOT EXISTS `Joueur` (
  `id_Joueur` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id_Joueur`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Insertion des données dans la table Joueur
INSERT INTO Joueur (nom) VALUES
('Alice'),
('Bob'),
('Charlie'),
('Diana');


-- Table Participer (association entre Partie et Joueur)
CREATE TABLE IF NOT EXISTS `Participer` (
  `id_Partie` INT(11) NOT NULL,
  `id_Joueur` INT(11) NOT NULL,
  `role` VARCHAR(50) COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id_Partie`, `id_Joueur`),
  KEY `FK_Participer_Partie` (`id_Partie`),
  KEY `FK_Participer_Joueur` (`id_Joueur`),
  CONSTRAINT `FK_Participer_Partie` FOREIGN KEY (`id_Partie`) REFERENCES `Partie` (`id_Partie`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_Participer_Joueur` FOREIGN KEY (`id_Joueur`) REFERENCES `Joueur` (`id_Joueur`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Insertion des données dans la table Participer
INSERT INTO Participer (id_Partie, id_Joueur, role) VALUES
(1, 1, 'capitaine'),
(1, 2, 'membre'),
(2, 3, 'capitaine'),
(2, 4, 'membre');



-- Table Tour
CREATE TABLE IF NOT EXISTS `Tour` (
  `id_Tour` INT(11) NOT NULL AUTO_INCREMENT,
  `indice` VARCHAR(30) NOT NULL,
  `nombre_mot` INT,
  `score` INT,
  `id_Partie` INT(11),
  PRIMARY KEY (`id_Tour`),
  KEY `FK_Tour_Partie` (`id_Partie`),
  CONSTRAINT `FK_Tour_Partie` FOREIGN KEY (`id_Partie`) REFERENCES `Partie` (`id_Partie`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Insertion des données dans la table Tour
INSERT INTO Tour (indice, nombre_mot, score, id_Partie) VALUES
("patate", 10, 50, 1),
("tata", 15, 50, 1),
("rocher", 20, 75, 2),
("café", 10, 75, 2);



-- Table Couleur
CREATE TABLE IF NOT EXISTS `Couleur` (
  `id_Couleur` INT(11) NOT NULL AUTO_INCREMENT,
  `nom_couleur` VARCHAR(50) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id_Couleur`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Insertion des données dans la table Couleur
INSERT INTO Couleur (nom_couleur) VALUES
('Bleu'),
('Gris'),
('Noir');


-- Table Mot
CREATE TABLE IF NOT EXISTS `Mot` (
  `id_Mot` INT(11) NOT NULL AUTO_INCREMENT,
  `mot` VARCHAR(100) COLLATE utf8_unicode_ci NOT NULL,
  `id_Couleur` INT(11),
  PRIMARY KEY (`id_Mot`),
  KEY `FK_Mot_Couleur` (`id_Couleur`),
  CONSTRAINT `FK_Mot_Couleur` FOREIGN KEY (`id_Couleur`) REFERENCES `Couleur` (`id_Couleur`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- Insertion des données dans la table Mot (dictionnaire de 50 mots)
INSERT INTO Mot (mot, id_Couleur) VALUES
('Chat', 1),
('Chien', 1),
('Maison', 2),
('Voiture', 2),
('Arbre', 3),
('Fleur', 3),
('Bateau', 1),
('Avion', 1),
('Ordinateur', 2),
('Téléphone', 2),
('Livre', 3),
('Stylo', 3),
('Table', 1),
('Chaise', 1),
('Fenêtre', 2),
('Porte', 2),
('Ciel', 3),
('Soleil', 3),
('Lune', 1),
('Étoile', 1),
('Montagne', 2),
('Rivière', 2),
('Océan', 3),
('Plage', 3),
('Forêt', 1),
('Désert', 1),
('Île', 2),
('Continent', 2),
('Pays', 3),
('Ville', 3),
('Village', 1),
('Quartier', 1),
('Rue', 2),
('Autoroute', 2),
('Chemin', 3),
('Sentier', 3),
('Pont', 1),
('Tunnel', 1),
('Bâtiment', 2),
('Gratte-ciel', 2),
('Parc', 3),
('Jardin', 3),
('École', 1),
('Université', 1),
('Hôpital', 2),
('Clinique', 2),
('Musée', 3),
('Cinéma', 3),
('Théâtre', 1),
('Bibliothèque', 1);


-- Table Contenir (association entre Partie et Mot)
CREATE TABLE IF NOT EXISTS `Contenir` (
  `id_Partie` INT(11) NOT NULL,
  `id_Mot` INT(11) NOT NULL,
  PRIMARY KEY (`id_Partie`, `id_Mot`),
  KEY `FK_Contenir_Partie` (`id_Partie`),
  KEY `FK_Contenir_Mot` (`id_Mot`),
  CONSTRAINT `FK_Contenir_Partie` FOREIGN KEY (`id_Partie`) REFERENCES `Partie` (`id_Partie`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_Contenir_Mot` FOREIGN KEY (`id_Mot`) REFERENCES `Mot` (`id_Mot`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- Insertion des données dans la table Contenir pour deux parties de 25 mots chacune
INSERT INTO Contenir (id_Partie, id_Mot) VALUES
-- Partie 1
(1, 1), (1, 2), (1, 3), (1, 4), (1, 5),
(1, 6), (1, 7), (1, 8), (1, 9), (1, 10),
(1, 11), (1, 12), (1, 13), (1, 14), (1, 15),
(1, 16), (1, 17), (1, 18), (1, 19), (1, 20),
(1, 21), (1, 22), (1, 23), (1, 24), (1, 25),
-- Partie 2
(2, 26), (2, 27), (2, 28), (2, 29), (2, 30),
(2, 31), (2, 32), (2, 33), (2, 34), (2, 35),
(2, 36), (2, 37), (2, 38), (2, 39), (2, 40),
(2, 41), (2, 42), (2, 43), (2, 44), (2, 45),
(2, 46), (2, 47), (2, 48), (2, 49), (2, 50);

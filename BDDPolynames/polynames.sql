

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
  `indice` INT NOT NULL,
  `nombre_mot` INT,
  `score` INT,
  `id_Partie` INT(11),
  PRIMARY KEY (`id_Tour`),
  KEY `FK_Tour_Partie` (`id_Partie`),
  CONSTRAINT `FK_Tour_Partie` FOREIGN KEY (`id_Partie`) REFERENCES `Partie` (`id_Partie`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Insertion des données dans la table Tour
INSERT INTO Tour (indice, nombre_mot, score, id_Partie) VALUES
(1, 10, 50, 1),
(2, 15, 50, 1),
(1, 20, 75, 2),
(2, 10, 75, 2);



-- Table Couleur
CREATE TABLE IF NOT EXISTS `Couleur` (
  `id_Couleur` INT(11) NOT NULL AUTO_INCREMENT,
  `nom_couleur` VARCHAR(50) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id_Couleur`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Insertion des données dans la table Couleur
INSERT INTO Couleur (nom_couleur) VALUES
('Rouge'),
('Bleu'),
('Vert'),
('Jaune');


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
('Bateau', 4),
('Avion', 4),
('Ordinateur', 1),
('Téléphone', 1),
('Livre', 2),
('Stylo', 2),
('Table', 3),
('Chaise', 3),
('Fenêtre', 4),
('Porte', 4),
('Ciel', 1),
('Soleil', 1),
('Lune', 2),
('Étoile', 2),
('Montagne', 3),
('Rivière', 3),
('Océan', 4),
('Plage', 4),
('Forêt', 1),
('Désert', 1),
('Île', 2),
('Continent', 2),
('Pays', 3),
('Ville', 3),
('Village', 4),
('Quartier', 4),
('Rue', 1),
('Autoroute', 1),
('Chemin', 2),
('Sentier', 2),
('Pont', 3),
('Tunnel', 3),
('Bâtiment', 4),
('Gratte-ciel', 4),
('Parc', 1),
('Jardin', 1),
('École', 2),
('Université', 2),
('Hôpital', 3),
('Clinique', 3),
('Musée', 4),
('Cinéma', 4),
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


-- Insertion des données dans la table Contenir
INSERT INTO Contenir (id_Partie, id_Mot) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(1, 8),
(1, 9),
(1, 10),
(2, 11),
(2, 12),
(2, 13),
(2, 14),
(2, 15),
(2, 16),
(2, 17),
(2, 18),
(2, 19),
(2, 20),
(2, 21),
(2, 22),
(2, 23),
(2, 24),
(2, 25);
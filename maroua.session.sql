SELECT * FROM Utilisateurs;
CREATE TABLE Utilisateurs (
    id_utilisateur INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    motdepasse VARCHAR(255) NOT NULL,
    role ENUM('enseignant', 'etudiant') NOT NULL
);

--@block
INSERT INTO Utilisateurs (nom, email, motdepasse, role) VALUES
('Mohammed Alami', 'alami@gmail.com', SHA2('password123', 256), 'enseignant'),
('Fatima Zahra', 'fatima@gmail.com', SHA2('password123', 256), 'enseignant'),
('Ahmed Bennani', 'ahmed@gmail.com', SHA2('password123', 256), 'etudiant'),
('Salma Idrissi', 'salma@gmail.com', SHA2('password123', 256), 'etudiant'),
('Youssef Tazi', 'youssef@gmail.com', SHA2('password123', 256), 'etudiant');





--@block 
CREATE TABLE Categories(
    id_categorie INT AUTO_INCREMENT PRIMARY KEY,
    nom_categorie VARCHAR(100)NOT NULL
);
--@block
INSERT INTO Categories (nom_categorie)VALUES
('Mathématiques'),
('Histoire'),
('Informatique');



--@block

CREATE TABLE Quiz (
    id_quiz INT AUTO_INCREMENT PRIMARY KEY,
    titre_quiz VARCHAR(150) NOT NULL,
    description TEXT,
    duree_minutes INT CHECK(duree_minutes > 0),
    id_categorie INT,
    id_enseignant INT,
    FOREIGN KEY (id_categorie) REFERENCES Categories(id_categorie),
    FOREIGN KEY (id_enseignant) REFERENCES Utilisateurs(id_utilisateur)
);
--@block
INSERT INTO Quiz (titre_quiz, description, duree_minutes, id_categorie, id_enseignant)
VALUES
('Algèbre niveau 1','Quiz sur les bases de l\algèbre',30,1,1),
('Histoire du Maroc','Quiz sur les événements clés',40,2,2),
('Intro à SQL','Questions sur SELECT, JOIN, GROUP BY',45,3,1);

--@block
CREATE TABLE Questions (
    id_question INT AUTO_INCREMENT PRIMARY KEY,
    texte_question TEXT NOT NULL,
    reponse_correcte TEXT NOT NULL,
    points INT CHECK(points > 0),
    id_quiz INT,
    FOREIGN KEY (id_quiz) REFERENCES Quiz(id_quiz)
);

--@block
INSERT INTO Questions (texte_question, reponse_correcte, points, id_quiz)
VALUES
('Quel est le discriminant?','b',5,1),
('Année de l''indépendance du Maroc?','1956',10,2),
('Quelle commande pour joindre deux tables?','JOIN',8,3);

--@block

CREATE TABLE Resultats (
    id_resultat INT AUTO_INCREMENT PRIMARY KEY,
    score INT CHECK(score >= 0),
    date_passage DATETIME DEFAULT CURRENT_TIMESTAMP,
    id_etudiant INT,
    id_quiz INT,
    FOREIGN KEY (id_etudiant) REFERENCES Utilisateurs(id_utilisateur),
    FOREIGN KEY (id_quiz) REFERENCES Quiz(id_quiz)
);

--@block
INSERT INTO Resultats (score, date_passage, id_etudiant, id_quiz)
VALUES
(85, '2025-11-20', 3, 1),
(72, '2025-11-22', 4, 1),
(40, '2025-11-25', 5, 3),
(95, '2025-11-26', 3, 3);







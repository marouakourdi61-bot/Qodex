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
('Math Facile', 'Quiz simple sur les maths', 20, 1, 1),
('Histoire Générale', 'Questions simples sur l’histoire', 25, 2, 2),
('Bases de l''informatique', 'Quiz sur les notions de base', 30, 3, 1);

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
('Combien font 2 + 2 ?', '4', 5, 1),
('Quelle est la forme d’un ballon de football ?', 'Ronde', 3, 1),
('Qui était le premier roi du Maroc ?', 'Idriss 1', 5, 2),
('Quelle est la capitale du Maroc ?', 'Rabat', 4, 2),
('Que signifie PC ?', 'Personal Computer', 5, 3),
('Composant principal d’un ordinateur ?', 'Processeur', 6, 3);

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
(90, '2025-12-01', 3, 1),
(75, '2025-12-01', 4, 1),
(30, '2025-12-02', 5, 2),
(95, '2025-12-03', 3, 3);



--@block --Ajouter un nouveau quiz créé par un enseignant

INSERT INTO quiz (titre_quiz,description,duree_minutes,id_categorie,id_enseignant)
VALUES('Nouveau quiz exemple', 'Description', 35, 3 ,1);

--@block

SELECT * FROM quiz


--@block --Modifier la durée d'un quiz existant
UPDATE quiz set duree_minutes = 70 WHERE id_quiz = 1;

--@block

SELECT * FROM quiz

--@block --Afficher tous les utilisateurs

SELECT * FROM utilisateurs

--@block Afficher uniquement les noms et emails des utilisateurs

SELECT nom, email FROM utilisateurs

--@block Afficher tous les quiz

SELECT * FROM quiz

--@block Afficher uniquement les titres des quiz

SELECT titre_quiz FROM quiz

--@block Afficher toutes les catégories

SELECT * FROM categories

--@block Afficher les utilisateurs qui sont enseignants
SELECT * FROM utilisateurs WHERE role = 'enseignant';

--@block --Afficher les utilisateurs qui sont étudiants
SELECT * FROM utilisateurs WHERE role = 'etudiant';

--@block  Afficher les quiz de durée supérieure à 30 minutes

SELECT * FROM quiz WHERE duree_minutes > 30;

--@block Afficher les quiz de durée inférieure ou égale à 45 minutes

 SELECT * FROM quiz WHERE duree_minutes <= 45;

--@block Afficher les questions valant plus de 5 points

SELECT * FROM questions WHERE points > 5;

--@block Afficher les quiz de durée entre 20 et 40 minutes

SELECT *FROM quiz WHERE duree_minutes BETWEEN 20 AND 40;

--@block Afficher les résultats avec un score supérieur ou égal à 60

SELECT * FROM Resultats WHERE score > 60;

--@block  Afficher les résultats avec un score inférieur à 50

SELECT * FROM Resultats WHERE score < 50;

--@block  Afficher les questions valant entre 5 et 15 points

SELECT * FROM questions WHERE points BETWEEN 5 AND 15;

--@block  Afficher les quiz créés par l'enseignant avec id_enseignant = 1

SELECT * FROM quiz WHERE id_enseignant = 1;

--@block  Afficher tous les quiz triés par durée (du plus court au plus long)

SELECT * FROM quiz ORDER BY duree_minutes ASC;

--@block  Afficher tous les résultats triés par score (du plus élevé au plus faible)

SELECT * FROM resultats ORDER BY score DESC;

--@block Afficher les 5 meilleurs scores

SELECT * FROM resultats ORDER BY score DESC LIMIT 5;

--@block Afficher les questions triées par points (du plus faible au plus élevé)

SELECT * FROM questions ORDER BY points ASC ;

--@block Afficher les 3 derniers résultats (triés par date_passage décroissante)

SELECT * FROM resultats ORDER BY date_passage DESC LIMIT 3;

--@block   Afficher le nom de chaque quiz avec sa catégorie

SELECT  quiz.titre_quiz, Categories.nom_categorie 
 FROM quiz LEFT JOIN Categories ON quiz.id_categorie = Categories.id_categorie;

 --@block  Ajouter une requête qui compte combien d'étudiants ont passé chaque quiz

SELECT quiz.titre_quiz, COUNT(Resultats.id_etudiant) AS nombre_etudiants FROM quiz
JOIN Resultats ON quiz.id_quiz = Resultats.id_quiz
GROUP BY quiz.id_quiz, quiz.titre_quiz;

--@block  Créer une requête qui affiche le meilleur score pour chaque quiz

SELECT quiz.titre_quiz, Max(resultats.score) As Max_score FROM quiz JOIN resultats ON quiz.id_quiz = resultats.id_quiz
GROUP BY quiz.id_quiz, quiz.titre_quiz




















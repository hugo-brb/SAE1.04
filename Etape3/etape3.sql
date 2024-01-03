/* Relation PORT dérivée de l'entité PORT du SEA -App. R0 */
CREATE TABLE PORT (
  PortId char(1) primary key CHECK (PortId IN ('C','Q','S')),
  PortName varchar NOT NULL,
  Country varchar NOT NULL
);
/*
Relation PASSENGER dérivée de l'entité PASSENGER du SEA - App. R0
complétée par :
  - l'identifiant de l'entité CLASS (non conservée) - App. R1
  - l'identifiant de l'entité PORT (conservée) - App. R1
*/
CREATE TABLE PASSENGER (
  PassengerId int primary key,
  Name varchar NOT NULL,
  Sex varchar NOT NULL CHECK (Sex IN ('male','female')),
  Age int CHECK(Age >= 0),
  Survived int NOT NULL CHECK (Survived IN (0,1)),
  PClass int NOT NULL CHECK (PClass BETWEEN 1 and 3),
  PortId char(1) references PORT(PortId)
);
/* Relation OCCUPATION dérivée de l'assoication Occupation - App. R3 */
CREATE TABLE OCCUPATION (
  PassengerId int References PASSENGER(PassengerId),
  CabinCode varchar,
  Primary key (PassengerId, CabinCode)
);
/* Relation SERVICE dérivée de l'association service - App. R2 */
CREATE TABLE SERVICE (
  PassengerId_Dom int primary key references PASSENGER(PassengerId),
  PassengerId_Emp int NOT NULL,
  foreign key (PassengerId_Emp) references PASSENGER(PassengerId),
  Role varchar NOT NULL,
  CHECK (PassengerId_Dom != PassengerID_Emp)
);
/* REALTION CATEGORY dérivée de l'entité CATEGORY du SEA - App. R0 */
CREATE TABLE CATEGORY (
  LifeBoatCat varchar primary key CHECK (LifeBoatCat IN ('standard','secours','radeau')),
  Structure varchar NOT NULL CHECK (Structure IN ('bois', 'bois et toile')),
  Places int NOT NULL CHECK (Places > 0)
);
/*
Relation LIFEBOAT dérivée de l'entite LIFEBOAT du SEA - APP. R0
complétée par :
  - l'identifiant de l'entité CATEGORY (conservée) - App. R1
  - L'identifiant de l'entité TIME (non consevée) - App. R1
*/
CREATE TABLE LIFEBOAT (
  LifeBoatId varchar primary key,
  LifeBoatCat varchar NOT NULL references CATEGORY(LifeBoatCat),
  Side varchar NOT NULL CHECK (Side IN ('babord','tribord')),
  Position varchar NOT NULL CHECK (Position IN ('avant','arriere')),
  Location varchar NOT NULL DEFAULT 'Pont', -- pour dire
  Launching_Time Time NOT NULL
);
/*
Relation RECOVERY dérivée de l'assocation recovery (non conservée) - App. R2
*/
CREATE TABLE RECOVERY (
  LifeBoatId varchar references LIFEBOAT(LifeBoatId) primary key,
  Recovery_time time NOT NULL
);
/* Relation RESCUE dériveé de lassociation rescue - App. R2 */
CREATE TABLE RESCUE (
  PassengerID int references PASSENGER(PassengerId) primary key,
  LifeBoatId varchar NOT NULL references LIFEBOAT(LifeboatId)
);

-- A1 --

-- Nombre de survivants, respectivement de victimes parmi les passagers, selon leur classe (une requête par classe)
-- 1er classe
SELECT
    (SELECT COUNT(*) 
    FROM PASSENGER 
    GROUP BY PClass, Survived
    HAVING PClass = 1 and Survived = 0) as Nombre_de_1ere_classes_mort,
    (SELECT COUNT(*) 
    FROM PASSENGER 
    GROUP BY PClass, Survived
    HAVING PClass = 1 and Survived = 1) as Nombre_de_1ere_classes_survivants;
    --Autre Possibilité
/*SELECT 
    CASE Survived
        WHEN 0 THEN 'mort'
        WHEN 1 THEN 'survivant'
    END AS Status,
    COUNT(*) AS nb_de_personnes
FROM PASSENGER
GROUP BY PClass, Survived
HAVING PClass = 1
ORDER BY Survived;*/

-- 2ième classe
SELECT
    (SELECT COUNT(*) 
    FROM PASSENGER 
    GROUP BY PClass, Survived
    HAVING PClass = 2 and Survived = 0) as Nombre_de_2ieme_classes_mort,
    (SELECT COUNT(*) 
    FROM PASSENGER 
    GROUP BY PClass, Survived
    HAVING PClass = 2 and Survived = 1) as Nombre_de_2ieme_classes_survivants;
    
-- 3ième classe
SELECT
    (SELECT COUNT(*) 
    FROM PASSENGER 
    GROUP BY PClass, Survived
    HAVING PClass = 3 and Survived = 0) as Nombre_de_3ieme_classes_mort,
    (SELECT COUNT(*) 
    FROM PASSENGER 
    GROUP BY PClass, Survived
    HAVING PClass = 3 and Survived = 1) as Nombre_de_3ieme_classes_survivants;

-- Nombre de survivants, respectivement de victimes parmi les passagers, selon leur catégorie (enfant, femme ou homme – une requête par catégorie) 
SELECT
    (SELECT COUNT(*) 
    FROM PASSENGER 
    WHERE Age < 12 and Survived = 0) as Nombre_enfant_mort,
    (SELECT COUNT(*) 
    FROM PASSENGER 
    WHERE Age < 12 and Survived = 1) as Nombre_enfant_survivants;

SELECT
    (SELECT COUNT(*) 
    FROM PASSENGER 
    WHERE Sex = 'female' and Survived = 0) as Nombre_femme_mort,
    (SELECT COUNT(*) 
    FROM PASSENGER 
    WHERE Sex = 'female' and Survived = 1) as Nombre_femme_survivants;
    
SELECT
    (SELECT COUNT(*) 
    FROM PASSENGER 
    WHERE Sex = 'male' and Survived = 0) as Nombre_homme_mort,
    (SELECT COUNT(*) 
    FROM PASSENGER 
    WHERE Sex = 'male' and Survived = 1) as Nombre_homme_survivants;
    -- Autre possibilité
/*SELECT 
    CASE 
        WHEN Age < 18 THEN 'Enfant'
        WHEN Sex = 'female' THEN 'Femme'
        ELSE 'Homme'
    END AS Categorie,
    COUNT(*) AS Nombre_de_survivants
FROM PASSENGER
WHERE Survived = 1
GROUP BY Categorie;*/

-- PARTIE A3 --------------------------------------------------------------------------------------

-- taux de survivants par classe, toutes catégories confondues (enfants, femmes ou hommes)
SELECT round(avg(survived*100),2) as taux_survivants
FROM PASSENGER
WHERE age < 12 and PClass = 2;



SELECT PClass, round(avg(survived*100),2) as taux_survivants
FROM PASSENGER
GROUP BY PClass
ORDER BY PClass;

-- Taux de survivants par classe dans la catégorie enfants

SELECT PClass, round(avg(survived*100),2) as taux_survivants
FROM PASSENGER
WHERE age<12
GROUP BY PClass
ORDER BY PClass;


-- psql -h postgres-info barbiehu -U barbiehu

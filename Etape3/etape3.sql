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
    WHERE Sex = 'female' and age>=12 and Survived = 0) as Nombre_femme_mort,
    (SELECT COUNT(*) 
    FROM PASSENGER 
    WHERE Sex = 'female' and age>=12 and  Survived = 1) as Nombre_femme_survivants;
    
SELECT
    (SELECT COUNT(*) 
    FROM PASSENGER 
    WHERE Sex = 'male' and age>=12 and Survived = 0) as Nombre_homme_mort,
    (SELECT COUNT(*) 
    FROM PASSENGER 
    WHERE Sex = 'male' and age>=12 and Survived = 1) as Nombre_homme_survivants;
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

SELECT PClass as classe, round(avg(survived*100),2) as taux_survivants
FROM PASSENGER
GROUP BY PClass
ORDER BY PClass;


-- Taux de survivants par classe dans la catégorie enfants

SELECT PClass as classe, round(avg(survived*100),2) as taux_survivants
FROM PASSENGER
WHERE age<12
GROUP BY PClass
ORDER BY PClass;

-- Taux de survivants par classe dans la catégorie femme

SELECT PClass as classe, round(avg(survived*100),2) as taux_survivants
FROM PASSENGER
WHERE Sex = 'female' and age>=12
GROUP BY PClass
ORDER BY PClass;

-- Taux de survivants par classe dans la catégorie hommes

SELECT PClass as classe, round(avg(survived*100),2) as taux_survivants
FROM PASSENGER
WHERE Sex = 'male' and age>=12
GROUP BY PClass
ORDER BY PClass;


-- A4 --
-- (a) Nombre total d'enfants et nombre d'enfants rescapés


SELECT
    (SELECT COUNT(*)
    FROM PASSENGER
    WHERE Age < 12) as nb_enfants,
    (SELECT COUNT(*)
    FROM RESCUE r, PASSENGER p
    WHERE p.PassengerID = r.PassengerID
    and p.Age < 12) as nb_enfants_rescapes;

-- (b) Nombre d'enfants qui ont survécu parmi les enfants qui ont été rescapés


SELECT COUNT(*) as nb_enfants_surv_dans_rescapes
FROM RESCUE r, PASSENGER p
WHERE r.PassengerID = p.PassengerID
and Survived = 1
and p.Age < 12;

-- (c) Pour chaque classe de passagers : nombre d'enfants qui ont survécu parmi les enfants rescapés

SELECT
    (SELECT COUNT(*)
    FROM RESCUE r, PASSENGER p
    WHERE r.PassengerID = p.PassengerID
    and Survived = 1
    and PClass = 1
    and p.Age < 12) as nb_enfts_class1_surv_dans_rescapes,
    (SELECT COUNT(*)
    FROM RESCUE r, PASSENGER p
    WHERE r.PassengerID = p.PassengerID
    and Survived = 1
    and PClass = 3
    and p.Age < 12) as nb_enfts_class2_surv_dans_rescapes,
    (SELECT COUNT(*)
    FROM RESCUE r, PASSENGER p
    WHERE r.PassengerID = p.PassengerID
    and Survived = 1
    and PClass = 2
    and p.Age < 12) as nb_enfts_class3_surv_dans_rescapes;


-- (d) Taux de rescapés parmi les passagers

SELECT round(100 *
    (SELECT count(*) FROM RESCUE) / 
    (SELECT COUNT(*) FROM PASSENGER),2) as taux_rescapes;

-- (e) Nombre de rescapés par catégorie de passager (enfant, femme ou homme)

SELECT (SELECT COUNT(*)
    FROM RESCUE r, PASSENGER p
    WHERE p.PassengerID = r.PassengerID
    and p.Age < 12) as nb_enfants_rescapes,
    (SELECT COUNT(*)
    FROM RESCUE r, PASSENGER p
    WHERE p.PassengerID = r.PassengerID
    and Sex='female' and age>=12) as nb_femmes_rescapes,
    (SELECT COUNT(*)
    FROM RESCUE r, PASSENGER p
    WHERE p.PassengerID = r.PassengerID
    and Sex='male' and age>=12) as nb_hommes_rescapes;



-- (f) Nombre de survivants par catégorie de rescapés (enfant, femme ou homme)

SELECT (SELECT COUNT(*)
    FROM RESCUE r, PASSENGER p
    WHERE r.PassengerID = p.PassengerID
    and Survived = 1
    and p.Age < 12) as nb_enfants_surv_dans_rescapes,
    (SELECT COUNT(*)
    FROM RESCUE r, PASSENGER p
    WHERE r.PassengerID = p.PassengerID
    and Survived = 1
    and Sex='female' and age>=12) as nb_femmes_surv_dans_rescapes,
    (SELECT COUNT(*)
    FROM RESCUE r, PASSENGER p
    WHERE r.PassengerID = p.PassengerID
    and Survived = 1
    and Sex='male' and age>=12) as nb_hommes_surv_dans_rescapes;

-- (g) Nombre total de rescapés et taux de survivants par embarcation - résultat ordonné sur le code de l'embarcation

SELECT LifeBoatId, count(LifeBoatId) as nb_rescapes, 100*(SELECT COUNT(PassengerID) 
      FROM PASSENGER 
      WHERE PassengerID IN (SELECT PassengerID 
            FROM RESCUE r2 
            WHERE r2.LifeBoatId = r1.LifeBoatId)
      and survived=1 ) / count(LifeBoatId) as taux_survivants
FROM RESCUE r1
GROUP BY LifeBoatId
ORDER BY LifeboatId;

-- (h) Pour chaque classe de passager, nombre d'enfants, nombre de femmes et nombre d'hommes qui ont survécu parmi les rescapés


SELECT PClass as classe, (SELECT COUNT(*)
    FROM RESCUE r, PASSENGER p
    WHERE r.PassengerID = p.PassengerID
    and Survived = 1
    and p.Age < 12
    and p.PClass = p2.PClass) as nb_enfants_surv_dans_rescapes,
    (SELECT COUNT(*)
    FROM RESCUE r, PASSENGER p
    WHERE r.PassengerID = p.PassengerID
    and Survived = 1
    and Sex='female' and age>=12
    and p.PClass = p2.PClass) as nb_femmes_surv_dans_rescapes,
    (SELECT COUNT(*)
    FROM RESCUE r, PASSENGER p
    WHERE r.PassengerID = p.PassengerID
    and Survived = 1
    and Sex='male' and age>=12
    and p.PClass = p2.PClass) as nb_hommes_surv_dans_rescapes
FROM PASSENGER p2
GROUP BY PClass
ORDER BY PClass;



-- B --
-- (a) On verifie si les domestiques ont été rescapés
SELECT COUNT(*) AS Total_Domestics,
     COUNT(CASE WHEN Survived = 1 THEN 1 END) AS Rescued_Domestics
FROM PASSENGER
WHERE Occupation = 'Domestic';




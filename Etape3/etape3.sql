/* PARTIE A*/
    -- A1 --

-- a) Nombre de survivants, respectivement de victimes parmi les passagers, selon leur classe (une requête par classe)
        -- 1ière classe
SELECT
    (SELECT COUNT(*) 
    FROM PASSENGER 
    GROUP BY PClass, Survived
    HAVING PClass = 1 and Survived = 0) as Nombre_de_1ere_classes_décédés,
    (SELECT COUNT(*) 
    FROM PASSENGER 
    GROUP BY PClass, Survived
    HAVING PClass = 1 and Survived = 1) as Nombre_de_1ere_classes_survivants;
/*Autre Possibilité
SELECT 
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


-- b) Nombre de survivants, respectivement de victimes parmi les passagers, selon leur catégorie (enfant, femme ou homme – une requête par catégorie) 
        -- Enfants
SELECT
    (SELECT COUNT(*) 
    FROM PASSENGER 
    WHERE Age < 12 and Survived = 0) as Nombre_enfant_mort,
    (SELECT COUNT(*) 
    FROM PASSENGER 
    WHERE Age < 12 and Survived = 1) as Nombre_enfant_survivants;

        -- Femmes
SELECT
    (SELECT COUNT(*) 
    FROM PASSENGER 
    WHERE Sex = 'female' and age>=12 and Survived = 0) as Nombre_femme_mort,
    (SELECT COUNT(*) 
    FROM PASSENGER 
    WHERE Sex = 'female' and age>=12 and Survived = 1) as Nombre_femme_survivants;

        -- Hommes  
SELECT
    (SELECT COUNT(*) 
    FROM PASSENGER 
    WHERE Sex = 'male' and age>=12 and Survived = 0) as Nombre_homme_mort,
    (SELECT COUNT(*) 
    FROM PASSENGER 
    WHERE Sex = 'male' and age>=12 and Survived = 1) as Nombre_homme_survivants;

/*Autre possibilité
SELECT 
    CASE 
        WHEN Age < 12 THEN 'Enfant'
        WHEN Sex = 'female' THEN 'Femme'
        ELSE 'Homme'
    END AS Categorie,
    COUNT(*) AS Nombre_de_survivants
FROM PASSENGER
WHERE Survived = 1
GROUP BY Categorie;*/

        -- Comparaison survivants
SELECT COUNT(*) as total_survivants, 
(SELECT COUNT(*) 
FROM PASSENGER
WHERE Age < 12 and Survived = 1) as total_survivants_enfants,
(SELECT COUNT(*) 
FROM PASSENGER
WHERE Sex = 'female' and Age >= 12 and Survived = 1) as total_survivants_femmes,
(SELECT COUNT(*) 
FROM PASSENGER
WHERE Sex = 'male' and Age >= 12 and Survived = 1) as total_survivants_hommes
FROM PASSENGER
WHERE Survived = 1;

        -- Comparaison décès
SELECT COUNT(*) as total_décès, 
(SELECT COUNT(*) 
FROM PASSENGER
WHERE Age < 12 and Survived = 0) as total_décès_enfants,
(SELECT COUNT(*) 
FROM PASSENGER
WHERE Sex = 'female' and Age >= 12 and Survived = 0) as total_décès_femmes,
(SELECT COUNT(*) 
FROM PASSENGER
WHERE Sex = 'male' and Age >= 12 and Survived = 0) as total_décès_hommes
FROM PASSENGER
WHERE Survived = 0;


    -- A3 --

-- a) Taux de survivants par classe, toutes catégories confondues (enfants, femmes ou hommes)
SELECT PClass as classe, round(avg(survived*100),2) as taux_survivants
FROM PASSENGER
GROUP BY PClass
ORDER BY PClass;


-- b) Taux de survivants par classe dans la catégorie enfants
SELECT PClass as classe, round(avg(survived*100),2) as taux_survivants
FROM PASSENGER
WHERE age<12
GROUP BY PClass
ORDER BY PClass;

-- c) Taux de survivants par classe dans la catégorie femme
SELECT PClass as classe, round(avg(survived*100),2) as taux_survivants
FROM PASSENGER
WHERE Sex = 'female' and age>=12
GROUP BY PClass
ORDER BY PClass;

-- d) Taux de survivants par classe dans la catégorie hommes
SELECT PClass as classe, round(avg(survived*100),2) as taux_survivants
FROM PASSENGER
WHERE Sex = 'male' and age>=12
GROUP BY PClass
ORDER BY PClass;


    -- A4 --

-- a) Nombre total d'enfants et nombre d'enfants rescapés
SELECT
    (SELECT COUNT(*)
    FROM PASSENGER
    WHERE Age < 12) as nb_enfants,
    (SELECT COUNT(*)
    FROM RESCUE r, PASSENGER p
    WHERE p.PassengerID = r.PassengerID
    and p.Age < 12) as nb_enfants_rescapes;

-- b) Nombre d'enfants qui ont survécu parmi les enfants qui ont été rescapés
SELECT COUNT(*) as nb_enfants_surv_dans_rescapes
FROM RESCUE r, PASSENGER p
WHERE r.PassengerID = p.PassengerID
and Survived = 1
and p.Age < 12;

-- c) Pour chaque classe de passagers : nombre d'enfants qui ont survécu parmi les enfants rescapés
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

-- d) Taux de rescapés parmi les passagers
SELECT round(100 *
    (SELECT count(*) FROM RESCUE) / 
    (SELECT COUNT(*) FROM PASSENGER),2) as taux_rescapes;

-- e) Nombre de rescapés par catégorie de passager (enfant, femme ou homme)
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

-- f) Nombre de survivants par catégorie de rescapés (enfant, femme ou homme)

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

-- g) Nombre total de rescapés et taux de survivants par embarcation - résultat ordonné sur le code de l'embarcation
SELECT LifeBoatId, count(LifeBoatId) as nb_rescapes, 100*(SELECT COUNT(PassengerID) 
      FROM PASSENGER 
      WHERE PassengerID IN (SELECT PassengerID 
            FROM RESCUE r2 
            WHERE r2.LifeBoatId = r1.LifeBoatId)
      and survived=1 ) / count(LifeBoatId) as taux_survivants
FROM RESCUE r1
GROUP BY LifeBoatId
ORDER BY LifeboatId;

-- h) Pour chaque classe de passager, nombre d'enfants, nombre de femmes et nombre d'hommes qui ont survécu parmi les rescapés
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



/*Partie B*/

-- 1) Combien de domestiques ont survécu
SELECT 
    (SELECT COUNT(*) 
    FROM PASSENGER
    WHERE passengerid IN (SELECT PassengerId_Dom FROM service)
    AND survived = 1) as nb_domestiques_survivant,
    (SELECT COUNT(*) 
    FROM PASSENGER
    WHERE passengerid IN (SELECT PassengerId_Dom FROM service)
    AND survived = 0) as nb_domestiques_mort;

    -- Quid des employeurs des survivants ?
SELECT COUNT(*) as nb_employeurs_rescapes
FROM PASSENGER p, service s
WHERE p.passengerid = s.PassengerID_Emp
AND p.survived = 1
AND s.PassengerID_Dom IN (SELECT PassengerID FROM RESCUE);

-- 2) Influence de l'emplacement des embarcations de sauvetage (side et/ou position) sur le taux de survie des passagers qui y ont pris place ?
SELECT l.LifeBoatId, l.side, l.position, count(r1.LifeBoatId) as nb_rescapes, 100*(SELECT COUNT(PassengerID) 
      FROM PASSENGER 
      WHERE PassengerID IN (SELECT PassengerID 
            FROM RESCUE r2 
            WHERE r2.LifeBoatId = l.LifeBoatId)
      and survived=1 )/count(r1.LifeBoatId) as taux_survivants
FROM RESCUE r1, LIFEBOAT l
WHERE r1.LifeBoatId = l.LifeBoatId
GROUP BY l.LifeBoatId
ORDER BY l.LifeboatId;

-- 3) Influence de l'heure de mise à l'eau des embarcations de sauvetage sur le taux de survie des passagers qui y ont pris place (ou encore, influence de l'heure de récupération de ces embarcations par le Carpathia)?
SELECT l.LifeBoatId, launching_time, (SELECT recovery_time 
FROM RECOVERY WHERE LifeBoatId = l.LifeBoatId), 100*(SELECT count(*) FROM PASSENGER
WHERE passengerid in (SELECT passengerid FROM RESCUE WHERE LifeBoatId = l.LifeBoatId))/count(r.LifeBoatId) as taux_survivants
FROM LIFEBOAT l, RESCUE r
WHERE l.LifeBoatId = r.LifeBoatId
GROUP BY l.LifeBoatId
ORDER BY l.LifeboatId;

-- 4) Taux de survie par tranche d'âge parmi les passagers ayant au moins 12 ans lors du naufrage :
  -- Tranches : 12-16 ans, 17-29 ans, 30-39 ans, 40-49 ans, 50-59 ans, 60-69 ans, et +70 ans
SELECT (SELECT round(avg(survived*100),2)
    FROM PASSENGER
    WHERE age>=12
    and age<16) as taux_12_16ans,
    (SELECT round(avg(survived*100),2)
    FROM PASSENGER
    WHERE age>=17
    and age<30) as taux_17_29ans,
    (SELECT round(avg(survived*100),2)
    FROM PASSENGER
    WHERE age>=30
    and age<40) as taux_30_39ans,
    (SELECT round(avg(survived*100),2)
    FROM PASSENGER
    WHERE age>=40
    and age<50) as taux_40_49ans,
    (SELECT round(avg(survived*100),2)
    FROM PASSENGER
    WHERE age>=50
    and age<60) as taux_50_59ans,
    (SELECT round(avg(survived*100),2)
    FROM PASSENGER
    WHERE age>=60
    and age<70) as taux_60_69ans,
    (SELECT round(avg(survived*100),2)
    FROM PASSENGER
    WHERE age>=70) as taux_plus_70ans;

-- 5) Combien de passagers supplémentaires auraient pu être rescapés (et peut-être survivre) si le taux
  -- maximum de remplissage des embarcations de sauvetage avait été respecté ?

-- selon les données du site https://titanic-1912.fr/ menu : "Les canots de sauvetage" => "Bilan du sauvetage",
-- le nombre moyen de membre d'équipage est ±6 par canot. Je vais donc ajouter artificielement 6 personnes
-- par canot pour avoir un nombre approximatif de places libres.

-- Première requête qui donne le nombre de rescapés, de places, et de places libres pour chaque canot :
SELECT r.LifeBoatId, count(r.LifeBoatId)+6 as nb_rescapes, places as places, places-6-count(r.LifeBoatId) as nb_places_libres
FROM RESCUE r, CATEGORY c, LIFEBOAT l
WHERE r.LifeBoatId = l.LifeBoatId
and l.LifeBoatCat = c.LifeBoatCat
GROUP BY r.LifeBoatId, places
ORDER BY r.LifeboatId;

-- Requête qui donne le nombre de rescapés, de places, et de places libres pour tous les canots :
SELECT SUM(nb_rescapes) as total_rescapes, SUM(places) as nb_places_max, SUM(nb_places_libres) as total_places_libres
FROM (
    SELECT count(r.LifeBoatId)+6 as nb_rescapes, places as places, places-6-count(r.LifeBoatId) as nb_places_libres
    FROM RESCUE r, CATEGORY c, LIFEBOAT l
    WHERE r.LifeBoatId = l.LifeBoatId
    and l.LifeBoatCat = c.LifeBoatCat
    GROUP BY r.LifeBoatId, places
    ORDER BY r.LifeboatId) as somme;
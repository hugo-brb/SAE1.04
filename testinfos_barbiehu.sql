/*les informations relatives au passager n°916 : son nom, son âge, sa classe, sa ou ses cabines, le nom du port où il a
embarqué, numéro et catégorie de l'embarcation de sauvetage qui l'a éventuellement secouru*/
SELECT Name, Age, PClass, o.CabineCode, PortName, l.LifeBoatId, LifeBoatCat
FROM Passenger p, Occupation o, LifeBoat l, Port po, rescue r
WHERE p.PassengerId = o.PassengerId
AND p.PortId = po.PortId
AND p.PassengerId = r.PassengerId
AND r.LifeBoatId = l.LifeBoatId
AND p.PassengerId = 916;



-- le nom et le rôle des domestiques du passager n°1264 est exact
SELECT Name, Role
FROM Passenger p, Service s
WHERE p.PassengerId = s.PassengerId_Dom
AND PassengerId_Emp = 1264;



-- la liste des passagers ayant été secourus par le canot n°7 est exacte
SELECT Name
FROM Passenger p, Rescue r, LifeBoat l
WHERE p.PassengerId = r.PassengerId
AND r.LifeBoatId = l.LifeBoatId
AND l.LifeBoatId = '7';
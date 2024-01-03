-- TEST CONTRAINTES PORT

INSERT INTO PORT VALUES ('C', 'CHERBOURG', 'FRANCE');
INSERT INTO PORT VALUES ('C', 'CHERBOURG', 'FRANCE');
/*ERROR:  duplicate key value violates unique constraint "port_pkey"
DETAIL:  Key (portid)=(C) already exists.
FR : Une clé primaire ne peut pas exister en double.*/
INSERT INTO PORT VALUES ('T', 'TITANIC', 'UK');
/*ERROR:  new row for relation "port" violates check constraint "port_portid_check"
DETAIL:  Failing row contains (T, TITANIC, UK).
FR : T n'est pas une valeur acceptable*/
INSERT INTO PORT VALUES ('C');
/*ERROR:  null value in column "portname" of relation "port" violates not-null constraint
DETAIL:  Failing row contains (C, null, null).
FR : Une valeur null ne peut pas être mise dans la column portname.*/
INSERT INTO PORT VALUES ('C', 'CHERBOURG');
/*ERROR:  null value in column "country" of relation "port" violates not-null constraint
DETAIL:  Failing row contains (C, CHERBOURG, null).
FR : Une valeur null ne peut pas être mise dans la column country.*/



-- TEST CONTRAINTES PASSENGER
 
INSERT INTO PASSENGER VALUES(17,'Darmanin','h',43,0,3,'C');
INSERT INTO PASSENGER VALUES(17,'Darmanin','h',43,0,3,'C');
/* ERROR:  duplicate key value violates unique constraint "passenger_pkey"
FR : Erreur car l'attribut PassengerId est clé primaire et doit etre unique */
INSERT INTO PASSENGER(PassengerId,sex,age,survived,pclass,portid) VALUES(18,'h',43,0,3,'C');
/* ERROR:  null value in column "name" of relation "passenger" violates not-null constraint
FR : il faut une valeur pour l'attribut 'name' */
INSERT INTO PASSENGER(PassengerId,name,age,survived,pclass,portid) VALUES(18,'Darmanin',43,0,3,'C');
/* ERROR:  null value in column "sex" of relation "passenger" violates not-null constraint
FR : il faut une valeur pour l'attribut 'sex' */
INSERT INTO PASSENGER VALUES(18,'Darmanin','h',43,2,3,'C');
/* ERROR:  new row for relation "passenger" violates check constraint "passenger_survived_check"
FR : il faut une valeur egale a 1 et 2 pour l'attribut 'survived' */
INSERT INTO PASSENGER(PassengerId,name,sex,age,survived,portid) VALUES(18,'Darmanin',43,0,'C');
/* ERROR:  null value in column "pclass" of relation "passenger" violates not-null constraint
FR : il faut une valeur pour l'attribut 'pclass' */
INSERT INTO PASSENGER VALUES(18,'Darmanin','h',43,2,4,'C');
/* ERROR:  new row for relation "passenger" violates check constraint "passenger_pclass_check"
FR : il faut une valeur egale a 1, 2 ou 3 pour l'attribut 'pclass' */
INSERT INTO PASSENGER VALUES(18,'Darmanin','h',43,2,4,'Z');
/* ERROR:  new row for relation "passenger" violates foreign key constraint "passenger_portid_fkey"
DETAIL:  Key (portid)=(Z) is not present in table "port".
FR : il faut une valeur existante dans la table 'port' pour l'attribut 'portid' */



-- TEST CONTRAINTES OCCUPATION

INSERT INTO OCCUPATION VALUES(17,'OK');
/*ERROR:  insert or update on table "occupation" violates foreign key constraint "occupation_passengerid_fkey"
DETAIL:  Key (passengerid)=(17) is not present in table "passenger".
FR : le passager d'identifiant 17 n'existe pas dans la table passenger il est donc impossible de l'ajouter à celle-ci*/
INSERT INTO Passenger VALUES(18,'Hollande', 'f', 43, 0, 1,'C');
INSERT INTO OCCUPATION VALUES(18,'OK');
INSERT INTO OCCUPATION VALUES(18,'OK');
/*ERROR:  duplicate key value violates unique constraint "pk_occupation"
DETAIL:  Key (passengerid, cabinecode)=(18, OK) already exists.
FR : Une clé primaire ne peut pas exister en double.*/



-- TEST CONTRAINTES SERVICE

INSERT INTO SERVICE VALUES(17,18,'Capitaine');
/*ERROR:  insert or update on table "service" violates foreign key constraint "service_passengerid_emp_fkey"
DETAIL:  Key (passengerid_emp)=(18) is not present in table "passenger".
FR : le passager d'identifiant 18 n'existe pas dans la table passenger il est donc impossible de l'ajouter à celle-ci*/
INSERT INTO Passenger VALUES(18,'Hollande', 'f', 43, 0, 1,'C');
INSERT INTO SERVICE VALUES(17,18,'Capitaine');
INSERT INTO SERVICE VALUES(17,18,'Capitaine');
/*ERROR:  duplicate key value violates unique constraint "service_pkey"
DETAIL:  Key (passengerid_dom)=(17) already exists.
FR : Une clé primaire ne peut pas exister en double.*/
INSERT INTO SERVICE(passengerid_dom, Role) VALUES(17,'Capitaine');
/*ERROR:  null value in column "passengerid_emp" of relation "service" violates not-null constraint
DETAIL:  Failing row contains (17, null, Capitaine).
FR : l'attribut passengerid_emp ne peut pas être null, il doit être renseigné.*/
INSERT INTO SERVICE(passengerid_dom, passengerid_emp) VALUES(17,18);
/*ERROR:  null value in column "role" of relation "service" violates not-null constraint
DETAIL:  Failing row contains (17, 18, null).
FR : l'attribut passengerid_emp ne peut pas être null, il doit être renseigné.*/



-- TEST CONTRAINTES CATEGORY

INSERT INTO CATEGORY VALUES('standard', 'bois', 64);
INSERT INTO CATEGORY VALUES('standard', 'bois', 64);
/*ERROR:  duplicate key value violates unique constraint "category_pkey"
DETAIL:  Key (lifeboatcat)=(standard) already exists.
FR : Une clé primaire ne peut pas exister en double.*/
INSERT INTO CATEGORY VALUES('Titanic', 'bois', 64);
/*ERROR:  new row for relation "category" violates check constraint "category_lifeboatcat_check"
DETAIL:  Failing row contains (Titanic, bois, 64).
FR : la valeur de l'attribut lifeboatcat doit être soit 'standard', soit 'secours', soit 'radeau'*/
INSERT INTO CATEGORY VALUES('standard', 'acier', 64);
/*ERROR:  new row for relation "category" violates check constraint "category_structure_check"
DETAIL:  Failing row contains (standard, acier, 64).
FR : la valeur de l'attribut structure doit être soit 'bois', soit 'bois et toile'*/
INSERT INTO CATEGORY(LifeBoatCat, Places) VALUES('standard', 64);
/*ERROR:  null value in column "structure" of relation "category" violates not-null constraint
DETAIL:  Failing row contains (standard, null, 64).
FR : l'attribut structure ne peut pas être null, il doit être renseigné.*/
INSERT INTO CATEGORY(LifeBoatCat, Structure) VALUES('standard', 'bois');
/*ERROR:  null value in column "places" of relation "category" violates not-null constraint
DETAIL:  Failing row contains (standard, bois, null).
FR : l'attribut places ne peut pas être null, il doit être renseigné.*/



-- TEST CONTRAINTES LIFEBOAT

INSERT INTO CATEGORY VALUES('standard', 'bois', 64); -- être sur que cette insertion à bien été faite
INSERT INTO LIFEBOAT VALUES('A', 'standard', 'tribord', 'avant', 'pont', '00:00:00');
INSERT INTO LIFEBOAT VALUES('A', 'standard', 'tribord', 'avant', 'pont', '00:00:00');
/*ERROR:  duplicate key value violates unique constraint "lifeboat_pkey"
DETAIL:  Key (lifeboatid)=(A) already exists.
FR : Une clé primaire ne peut pas exister en double.*/
INSERT INTO LIFEBOAT VALUES('A', 'Titanic', 'tribord', 'avant', 'pont', '00:00:00');
/*ERROR:  new row for relation "lifeboat" violates check constraint "lifeboat_lifeboatcat_check"
DETAIL:  Failing row contains (A, Titanic, tribord, avant, pont, 00:00:00).
FR : la valeur de l'attribut lifeboatcat doit être soit 'standard', soit 'secours', soit 'radeau'*/
INSERT INTO LIFEBOAT(LifeBoatId, LifeBoatCat, Side, Position, Launching_Time) VALUES('A', 'standard', 'tribord', 'avant', '00:00:00');
/*ERROR:  null value in column "position" of relation "lifeboat" violates not-null constraint
DETAIL:  Failing row contains (A, standard, tribord, null, 00:00:00).
FR : l'attribut position ne peut pas être null, il doit être renseigné.*/
INSERT INTO LIFEBOAT(LifeBoatId, LifeBoatCat, Side, Position, Launching_Time) VALUES('A', 'standard', 'tribord', 'avant', '00:00:00');
/*ERROR:  null value in column "launching_time" of relation "lifeboat" violates not-null constraint
DETAIL:  Failing row contains (A, standard, tribord, avant, null).
FR : l'attribut launching_time ne peut pas être null, il doit être renseigné.*/
INSERT INTO LIFEBOAT(LifeBoatId, LifeBoatCat, Side, Position, Launching_Time) VALUES('A', 'standard', 'tribord', 'avant', '00:00:00');
/*ERROR:  null value in column "lifeboatcat" of relation "lifeboat" violates not-null constraint
DETAIL:  Failing row contains (A, null, tribord, avant, 00:00:00).
FR : l'attribut lifeboatcat ne peut pas être null, il doit être renseigné.*/
INSERT INTO LIFEBOAT(LifeBoatId, LifeBoatCat, Side, Position, Launching_Time) VALUES('A', 'standard', 'tribord', 'avant', '00:00:00');
/*ERROR:  null value in column "side" of relation "lifeboat" violates not-null constraint
DETAIL:  Failing row contains (A, standard, null, avant, 00:00:00).
FR : l'attribut side ne peut pas être null, il doit être renseigné.*/
INSERT INTO LIFEBOAT(LifeBoatId, LifeBoatCat, Side, Position, Launching_Time) VALUES('A', 'standard', 'tribord', 'avant', '00:00:00');
/*ERROR:  null value in column "location" of relation "lifeboat" violates not-null constraint
DETAIL:  Failing row contains (A, standard, tribord, avant, 00:00:00, null).
FR : l'attribut location ne peut pas être null, il doit être renseigné.*/
INSERT INTO LIFEBOAT VALUES('A', 'standard', 'acier', 'avant', 'pont', '00:00:00');
/*ERROR:  new row for relation "lifeboat" violates check constraint "lifeboat_structure_check"
DETAIL:  Failing row contains (A, standard, acier, avant, pont, 00:00:00).
FR : la valeur de l'attribut structure doit être soit 'bois', soit 'bois et toile'*/
INSERT INTO LIFEBOAT VALUES('A', 'standard', 'tribord', 'dessus', 'pont', '00:00:00');
/*ERROR:  new row for relation "lifeboat" violates check constraint "lifeboat_position_check"
DETAIL:  Failing row contains (A, standard, tribord, dessus, pont, 00:00:00).
FR : la valeur de l'attribut position doit être soit 'avant', soit 'arriere'*/



-- TEST CONTRAINTES RECOVERY

INSERT INTO RECOVERY VALUES('A', '00:00:00');
INSERT INTO RECOVERY VALUES('A', '00:00:00');
/*ERROR:  duplicate key value violates unique constraint "recovery_pkey"
DETAIL:  Key (lifeboatid)=(A) already exists.
FR : Une clé primaire ne peut pas exister en double.*/
INSERT INTO RECOVERY VALUES('B', '00:00:00');
/*ERROR:  insert or update on table "recovery" violates foreign key constraint "recovery_lifeboatid_fkey"
DETAIL:  Key (lifeboatid)=(B) is not present in table "lifeboat".
FR : le bateau d'identifiant B n'existe pas dans la table lifeboat il est donc impossible de l'ajouter à celle-ci*/
INSERT INTO RECOVERY(LifeBoatId) VALUES('A');
/*ERROR:  null value in column "recovery_time" of relation "recovery" violates not-null constraint
DETAIL:  Failing row contains (A, null).
FR : l'attribut recovery_time ne peut pas être null, il doit être renseigné.*/



-- TEST CONTRAINTES RESCUE

INSERT INTO PORT VALUES ('C', 'CHERBOURG', 'FRANCE'); -- être sur que cette insertion à bien été faite
INSERT INTO PASSENGER VALUES(17,'Darmanin','h',43,0,3,'C'); -- être sur que cette insertion à bien été faite
INSERT INTO RESCUE VALUES(17,'A');
INSERT INTO RESCUE VALUES(17,'A');
/*ERROR:  duplicate key value violates unique constraint "rescue_pkey"
DETAIL:  Key (passengerid)=(17) already exists.
FR : Une clé primaire ne peut pas exister en double.*/
INSERT INTO RESCUE VALUES(28,'A');
/*ERROR:  insert or update on table "rescue" violates foreign key constraint "rescue_passengerid_fkey"
DETAIL:  Key (passengerid)=(28) is not present in table "passenger".
FR : le passager d'identifiant 28 n'existe pas dans la table passenger il est donc impossible de l'ajouter à celle-ci*/
INSERT INTO RESCUE(PassengerId) VALUES(17);
/*ERROR:  null value in column "lifeboatid" of relation "rescue" violates not-null constraint
DETAIL:  Failing row contains (17, null).
FR : l'attribut lifeboatid ne peut pas être null, il doit être renseigné.*/
-------- insertion données de la base titanic ------------------------------------------------------------------
\copy PORT FROM '/workspaces/SAE1.04/donnees/PORTS.csv' WITH (DELIMITER ';', format CSV, HEADER, ENCODING 'UTF8');
\copy PASSENGER FROM '/workspaces/SAE1.04/donnees/PASSENGERS.csv' WITH (DELIMITER ';', format CSV, HEADER, ENCODING 'UTF8');
\copy OCCUPATION FROM '/workspaces/SAE1.04/donnees/OCCUPATION.csv' WITH (DELIMITER ';', format CSV, HEADER, ENCODING 'UTF8');
\copy SERVICE FROM '/workspaces/SAE1.04/donnees/SERVICE.csv' WITH (DELIMITER ';', format CSV, HEADER, ENCODING 'UTF8');
\copy CATEGORY FROM '/workspaces/SAE1.04/donnees/CATEGORY.csv' WITH (DELIMITER ';', format CSV, HEADER, ENCODING 'UTF8');
\copy LIFEBOAT FROM '/workspaces/SAE1.04/donnees/LIFEBOAT.csv' WITH (DELIMITER ';', format CSV, HEADER, ENCODING 'UTF8');
\copy RECOVERY FROM '/workspaces/SAE1.04/donnees/RECOVERY.csv' WITH (DELIMITER ';', format CSV, HEADER, ENCODING 'UTF8');
\copy RESCUE FROM '/workspaces/SAE1.04/donnees/RESCUE.csv' WITH (DELIMITER ';', format CSV, HEADER, ENCODING 'UTF8');
----------------------------------------------------------------------------------------------------------------

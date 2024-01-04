\copy PORT FROM '/workspaces/SAE1.04/donnes/PORTS.csv' WITH (DELIMITER ';', format CSV, HEADER, ENCODING 'UTF8');
\copy PASSENGER FROM '/workspaces/SAE1.04/donnes/Patch_Passengers.csv' WITH (DELIMITER ';', format CSV, HEADER, ENCODING 'UTF8');
\copy OCCUPATION FROM '/workspaces/SAE1.04/donnes/OCCUPATION.csv' WITH (DELIMITER ';', format CSV, HEADER, ENCODING 'UTF8');
\copy SERVICE FROM '/workspaces/SAE1.04/donnes/SERVICE.csv' WITH (DELIMITER ';', format CSV, HEADER, ENCODING 'UTF8');
\copy CATEGORY FROM '/workspaces/SAE1.04/donnes/CATEGORY.csv' WITH (DELIMITER ';', format CSV, HEADER, ENCODING 'UTF8');
\copy LIFEBOAT FROM '/workspaces/SAE1.04/donnes/LIFEBOAT.csv' WITH (DELIMITER ';', format CSV, HEADER, ENCODING 'UTF8');
\copy RECOVERY FROM '/workspaces/SAE1.04/donnes/RECOVERY.csv' WITH (DELIMITER ';', format CSV, HEADER, ENCODING 'UTF8');
\copy RESCUE FROM '/workspaces/SAE1.04/donnes/RESCUE.csv' WITH (DELIMITER ';', format CSV, HEADER, ENCODING 'UTF8');
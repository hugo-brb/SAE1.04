\copy PORT FROM '../donnes/PORTS.csv' WITH (DELIMITER ';', format CSV, HEADER, ENCODING 'UTF8');
\copy PASSENGER FROM '../donnes/Patch_Passengers.csv' WITH (DELIMITER ';', format CSV, HEADER, ENCODING 'UTF8');
\copy OCCUPATION FROM '../donnes/OCCUPATION.csv' WITH (DELIMITER ';', format CSV, HEADER, ENCODING 'UTF8');
\copy SERVICE FROM '../donnes/SERVICE.csv' WITH (DELIMITER ';', format CSV, HEADER, ENCODING 'UTF8');
\copy CATEGORY FROM '../donnes/CATEGORY.csv' WITH (DELIMITER ';', format CSV, HEADER, ENCODING 'UTF8');
\copy LIFEBOAT FROM '../donnes/LIFEBOAT.csv' WITH (DELIMITER ';', format CSV, HEADER, ENCODING 'UTF8');
\copy RECOVERY FROM '../donnes/RECOVERY.csv' WITH (DELIMITER ';', format CSV, HEADER, ENCODING 'UTF8');
\copy RESCUE FROM '../donnes/RESCUE.csv' WITH (DELIMITER ';', format CSV, HEADER, ENCODING 'UTF8');
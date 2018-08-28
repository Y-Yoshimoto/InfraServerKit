LOAD DATA LOCAL INFILE '/InfraServerKit/Server_Setup/Unit/mariadb_custom/testdata/x-ken-all.csv' INTO TABLE t_postcode FIELDS TERMINATED BY ',';

SELECT id,postcode,prefectural,municipality,town FROM t_postcode;

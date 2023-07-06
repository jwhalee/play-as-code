#!/bin/bash

# download and unzip MySQL's official sample datasets
curl https://downloads.mysql.com/docs/world_x-db.tar.gz --output world_x-db.tar.gz
curl https://downloads.mysql.com/docs/sakila-db.tar.gz --output sakila-db.tar.gz
tar -xvf world_x-db.tar.gz
tar -xvf sakila-db.tar.gz

# batch run commands to set up DB with sakila, world_x, and a readonly user
mysql -u root -p89024jhk7D3809423hjhj -Bse "SOURCE sakila-db/sakila-schema.sql;SOURCE sakila-db/sakila-data.sql;SOURCE world_x-db/world_x.sql;CREATE USER 'grafanaReadOnly'@'%' IDENTIFIED BY 'contrail-DOCTOR-pique-knit-earn-mean';GRANT SELECT, SHOW VIEW ON *.* TO 'grafanaReadOnly'@'%';FLUSH PRIVILEGES;"

# if you want to run them one ata time from the command line:
# mysql -u root "-p89024jhk7D3809423hjhj" -e 'SOURCE sakila-db/sakila-schema.sql;' # sakila schema first
# mysql -u root "-p89024jhk7D3809423hjhj" -e 'SOURCE sakila-db/sakila-data.sql;' # sakila tables second
# mysql -u root "-p89024jhk7D3809423hjhj" -e 'SOURCE world_x-db/world_x.sql;' # add world_x tables
# mysql -u root "-p89024jhk7D3809423hjhj" -e 'CREATE USER 'grafanaReadOnly'@'%' IDENTIFIED BY 'contrail-DOCTOR-pique-knit-earn-mean';' # create readonly user for Grafana Play 1 of 3
# mysql -u root "-p89024jhk7D3809423hjhj" -e 'GRANT SELECT, SHOW VIEW ON *.* TO 'grafanaReadOnly'@'%';' # create readonly user for Grafana Play 2 of 3
# mysql -u root "-p89024jhk7D3809423hjhj" -e 'FLUSH PRIVILEGES;' # create readonly user for Grafana Play 3 of 3
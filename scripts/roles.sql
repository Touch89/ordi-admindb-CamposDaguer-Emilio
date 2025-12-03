CREATE USER 'admin'@'%' IDENTIFIED BY 'Admin';
GRANT ALL PRIVILEGES ON campos_daguer_emilio.* TO 'admin'@'%';

CREATE USER 'almacenista'@'%' IDENTIFIED BY 'almacenista';
GRANT SELECT, INSERT, UPDATE, DELETE ON campos_daguer_emilio.* TO 'almacenista'@'%';

CREATE USER 'auxAlmacen'@'%' IDENTIFIED BY 'AuxAlmacen';
GRANT SELECT ON campos_daguer_emilio.* TO 'auxAlmacen'@'%';

FLUSH PRIVILEGES;
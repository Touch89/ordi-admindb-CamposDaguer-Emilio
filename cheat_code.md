# SQL Cheat Code

## 1. CREACIÓN DE BASE DE DATOS Y TABLAS

### Crear base de datos

```sql
CREATE DATABASE LogiStore;
USE LogiStore;
```

### Crear tabla simple

```sql
CREATE TABLE Usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Crear tabla con clave foránea

```sql
CREATE TABLE Tareas (
    id_tarea INT AUTO_INCREMENT PRIMARY KEY,
    id_proyecto INT NOT NULL,
    titulo VARCHAR(200) NOT NULL,
    descripcion TEXT,
    fecha_creacion DATE NOT NULL,
    estado VARCHAR(50) NOT NULL DEFAULT 'Pendiente',
    FOREIGN KEY (id_proyecto) REFERENCES Proyectos(id_proyecto) ON DELETE CASCADE
);
```

---

## 2. DOCKER COMPOSE CON MYSQL

### Estructura de archivos

```
PracticaBDD/
├── docker-compose.yml
├── init.sql
├── secrets/
│   └── mysql_root_password.txt
```

### Levantar contenedor MySQL

```bash
docker-compose up -d
```

### Verificar estado del contenedor

```bash
docker-compose ps
```

### Conectarse a MySQL como root

```bash
docker exec -it logistore-mysql mysql -u root -p
```

### Conectarse con usuarios creados

```bash
docker exec -it logistore-mysql mysql -u admin_logistore -p
docker exec -it logistore-mysql mysql -u dev_logistore -p
docker exec -it logistore-mysql mysql -u readonly_logistore -p
```

### Ejecutar script SQL desde host

```bash
docker exec -i logistore-mysql mysql -u root -p < script_create_tables.sql
```

### Detener contenedor

```bash
docker-compose down
```

### Detener y eliminar volúmenes

```bash
docker-compose down -v
```

---

## 3. USUARIOS, ROLES Y PERMISOS

### Crear usuario con permisos completos

```sql
CREATE USER 'admin_logistore'@'%' IDENTIFIED BY 'Admin2024!';
GRANT ALL PRIVILEGES ON LogiStore.* TO 'admin_logistore'@'%';
```

### Crear usuario con permisos de desarrollo

```sql
CREATE USER 'dev_logistore'@'%' IDENTIFIED BY 'Dev2024!';
GRANT SELECT, INSERT, UPDATE, DELETE ON LogiStore.* TO 'dev_logistore'@'%';
```

### Crear usuario solo lectura

```sql
CREATE USER 'readonly_logistore'@'%' IDENTIFIED BY 'Read2024!';
GRANT SELECT ON LogiStore.* TO 'readonly_logistore'@'%';
```

### Aplicar cambios de permisos

```sql
FLUSH PRIVILEGES;
```

### Ver usuarios existentes

```sql
SELECT User, Host FROM mysql.user;
```

### Ver permisos de un usuario

```sql
SHOW GRANTS FOR 'admin_logistore'@'%';
```

### Revocar permisos

```sql
REVOKE INSERT, UPDATE ON LogiStore.* FROM 'dev_logistore'@'%';
```

### Eliminar usuario

```sql
DROP USER 'readonly_logistore'@'%';
```

---

## 4. ÍNDICES

### Crear índice simple

```sql
CREATE INDEX idx_tareas_proyecto ON Tareas(id_proyecto);
```

### Crear índice en columna de estado

```sql
CREATE INDEX idx_tareas_estado ON Tareas(estado);
```

### Crear índice único

```sql
CREATE UNIQUE INDEX idx_usuarios_email ON Usuarios(email);
```

### Crear índice compuesto

```sql
CREATE INDEX idx_asignaciones_completo ON Asignaciones(id_tarea, id_usuario);
```

### Ver índices de una tabla

```sql
SHOW INDEX FROM Tareas;
```

### Analizar uso de índices con EXPLAIN

```sql
EXPLAIN SELECT * FROM Tareas WHERE id_proyecto = 1;
EXPLAIN SELECT * FROM Tareas WHERE estado = 'Pendiente';
```

### Eliminar índice

```sql
DROP INDEX idx_tareas_estado ON Tareas;
```

---

## 5. TRANSACCIONES

### Transacción exitosa con COMMIT

```sql
START TRANSACTION;

INSERT INTO Usuarios (nombre, email, telefono)
VALUES ('Juan Pérez', 'juan.perez@logistore.com', '555-0001');

INSERT INTO Proyectos (nombre, descripcion, fecha_inicio, estado)
VALUES ('Mantenimiento Rack A', 'Mantenimiento general', '2024-12-01', 'En Progreso');

COMMIT;
```

### Transacción con error y ROLLBACK

```sql
START TRANSACTION;

INSERT INTO Proyectos (nombre, descripcion, fecha_inicio, estado)
VALUES ('Proyecto Test', 'Descripción', '2024-12-01', 'En Progreso');

INSERT INTO Tareas (id_proyecto, titulo, fecha_creacion)
VALUES (999, 'Tarea inválida', '2024-12-01');

ROLLBACK;
```

### Verificar nivel de aislamiento

```sql
SELECT @@transaction_isolation;
```

### Cambiar nivel de aislamiento

```sql
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
```

### Transacción con punto de guardado (SAVEPOINT)

```sql
START TRANSACTION;

INSERT INTO Usuarios (nombre, email) VALUES ('User1', 'user1@test.com');
SAVEPOINT punto1;

INSERT INTO Usuarios (nombre, email) VALUES ('User2', 'user2@test.com');
ROLLBACK TO punto1;

COMMIT;
```

---

## 6. MONITOREO

Espacio total usado por Docker
docker system df

Tamaño del contenedor MySQL
docker ps -s

Espacio usado internamente por MySQL

Entramos

docker exec -it db-mysql-mysql-1 bash
du -h /var/lib/mysql

Esto muestra cuánto pesan:
Datos
Índices
Binary logs
Tablespaces

Ver memoria y CPU que usa MySQL
docker stats db-mysql-mysql-1

CPU % → Saturación
MEM USAGE → Memoria real
LIMIT → Límite del contenedor
BLOCK I/O → Lectura/escritura en disco

### Ver logs de MySQL

```bash
docker logs logistore-mysql
docker logs -f logistore-mysql
```

### Guardar logs en archivo

```bash
docker logs logistore-mysql > mysql_logs.txt 2>&1
```

### Estado general del servidor MySQL

```sql

SHOW GLOBAL STATUS;

Principales métricas relevantes

SHOW GLOBAL STATUS LIKE 'Threads%';
ATUS LIKE 'Connections';
SHOW GLOBAL STATUS LIKE 'Uptime';
SHOW GLOBAL STATUS LIKE 'Slow_queries';

Ver consultas lentas (slow query log)

SET GLOBAL slow_query_log = 1;
SET GLOBAL slow_query_log_file = '/var/lib/mysql/mysql-slow.log';
SET GLOBAL long_query_time = 1;

docker exec -it db-mysql-mysql-1 bash
cat /var/lib/mysql/mysql-slow.log

Ver tamaño de tablas y bases de datos

SELECT
table_name,
(data_length + index_length) / 1024 / 1024 AS size_mb
FROM information_schema.tables
WHERE table_schema = 'pruebas'
ORDER BY size_mb DESC;

Ver uso de memoria (buffers, cache, InnoDB)

SHOW ENGINE INNODB STATUS;

SHOW VARIABLES LIKE '%buffer%';
SHOW VARIABLES LIKE 'innodb_buffer_pool_size';
```

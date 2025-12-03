
CREATE DATABASE IF NOT EXISTS campos_daguer_emilio;
USE campos_daguer_emilio;

CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(50) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0,
    id_categoria INT,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

CREATE TABLE empleados (
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    puesto VARCHAR(50)
);

CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(20)
);

CREATE TABLE proveedores (
    id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    telefono VARCHAR(20)
);

CREATE TABLE ventas (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_cliente INT,
    id_empleado INT,
    total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado)
);

CREATE TABLE detalle_ventas (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_venta INT,
    id_producto INT,
    cantidad INT NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_venta) REFERENCES ventas(id_venta),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);


INSERT INTO categorias (nombre) VALUES
('Cables'),
('Audio'),
('Cargadores'),
('Memorias'),
('Periféricos');

INSERT INTO productos (codigo, nombre, precio, stock, id_categoria) VALUES
('CAB-001', 'Cable USB-C', 89.99, 50, 1),
('AUD-001', 'Audífonos Bluetooth', 599.99, 30, 2),
('CAR-001', 'Cargador Rápido', 249.99, 40, 3),
('MEM-001', 'Memoria USB 32GB', 199.99, 60, 4),
('MOU-001', 'Mouse Inalámbrico', 349.99, 25, 5);

INSERT INTO empleados (nombre, puesto) VALUES
('Juan Pérez', 'Gerente'),
('María López', 'Vendedor'),
('Carlos Ruiz', 'Almacenista'),
('Ana García', 'Vendedor'),
('Luis Torres', 'Cajero');

INSERT INTO clientes (nombre, telefono) VALUES
('Roberto Méndez', '9991234567'),
('TechStore', '9992345678'),
('Claudia Vega', '9993456789'),
('ElectroShop', '9994567890'),
('Jorge Castillo', '9995678901');

INSERT INTO proveedores (nombre, telefono) VALUES
('Distribuidora Tech', '5551234567'),
('Importadora Global', '5552345678'),
('Accesorios del Sur', '9991122334'),
('Mayorista Express', '3331234567'),
('ElectroDistribuidor', '8181234567');

INSERT INTO ventas (id_cliente, id_empleado, total) VALUES
(1, 2, 689.98),
(2, 4, 1799.95),
(3, 2, 599.99),
(4, 4, 849.98),
(5, 2, 349.99);

INSERT INTO detalle_ventas (id_venta, id_producto, cantidad, precio) VALUES
(1, 1, 2, 89.99),
(1, 3, 2, 249.99),
(2, 2, 3, 599.99),
(3, 2, 1, 599.99),
(4, 4, 2, 199.99),
(4, 1, 3, 89.99),
(5, 5, 1, 349.99);

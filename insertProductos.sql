
/* 10 productos*/

START TRANSACTION;

INSERT INTO productos (codigo, nombre, precio, stock, id_categoria) VALUES
('CAB-002', 'Cable USB-D', 39.99, 20, 1),
('CAB-003', 'Cable HDMI', 49.99, 30, 1),
('AUD-002', 'Audífonos Chingones', 999.99, 10, 2),
('AUD-003', 'Audífonos con Cable', 299.99, 40, 2),
('CAR-002', 'Cargador Lento', 49.99, 20, 3),
('CAR-003', 'Cargador Inalámbrico', 39.99, 15, 3),
('MEM-002', 'Memoria USB 500GB', 199.99, 6, 4),
('MEM-003', 'SSD 1TB', 399.99, 10, 4),
('MOU-002', 'Mouse Logitik', 349.99, 25, 5);
('MOU-002', 'Mouse DE CABLE', 109.99, 25, 5);

COMMIT;


INSERT INTO productos (codigo, nombre, precio, stock, id_categoria) VALUES
('CAB-002', 'Cable USB-D', 'AAAAAAAAAAAAAAAAAAAAAAAAAAA', 20, 1),
('CAB-003', 'Cable HDMI', 49.99, 'AAAAAAAAAAAAAAAAAAAAAAAAAAA', 1),
('AUD-002', 'Audífonos Chingones', 999.99, 10, 'AAAAAAAAAAAAAAAAAAAAAAAAAAA'),
('AUD-003', 'Audífonos con Cable', 299.99, 40, 2),
('CAR-002', 'Cargador Lento', 49.99, 20, 3),
('CAR-003', 'Cargador Inalámbrico', 39.99, 15, 3),
('MEM-002', 'Memoria USB 500GB', 199.99, 6, 4),
('MEM-003', 'SSD 1TB', 399.99, 10, 4),
('MOU-002', 'Mouse Logitik', 349.99, 25, 5);
('MOU-002', 'Mouse DE CABLE', 109.99, 25, 5);
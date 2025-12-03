
USE campos_daguer_emilio;

SELECT 
    p.nombre AS 'Nombre del producto',
    SUM(dv.cantidad) AS 'Total de piezas vendidas',
    SUM(dv.cantidad * dv.precio) AS 'Total de venta (precio x piezas)'
FROM detalle_ventas dv
INNER JOIN productos p ON dv.id_producto = p.id_producto
INNER JOIN ventas v ON dv.id_venta = v.id_venta
WHERE MONTH(v.fecha) = 11 AND YEAR(v.fecha) = 2025
GROUP BY p.id_producto, p.nombre
ORDER BY SUM(dv.cantidad) DESC
LIMIT 3;

SELECT 
    p.nombre AS 'Nombre del producto',
    c.nombre AS 'Nombre del cliente',
    v.fecha AS 'Fecha de venta',
    dv.cantidad AS 'Piezas vendidas',
    (dv.cantidad * dv.precio) AS 'Total vendido (precio x piezas)',
    'Almacenes Yucatán' AS 'Nombre del almacén'
FROM ventas v
INNER JOIN clientes c ON v.id_cliente = c.id_cliente
INNER JOIN detalle_ventas dv ON v.id_venta = dv.id_venta
INNER JOIN productos p ON dv.id_producto = p.id_producto
WHERE v.fecha >= '2025-11-05' AND v.fecha < '2025-12-01'
ORDER BY v.fecha;

SELECT 
    v.id_venta,
    v.fecha AS 'Fecha y hora de venta',
    c.nombre AS 'Cliente',
    e.nombre AS 'Empleado que atendió',
    v.total AS 'Total de venta',
    CASE 
        WHEN HOUR(v.fecha) BETWEEN 0 AND 5 THEN 'Madrugada (00:00-05:59)'
        WHEN HOUR(v.fecha) BETWEEN 6 AND 11 THEN 'Mañana (06:00-11:59)'
        WHEN HOUR(v.fecha) BETWEEN 12 AND 17 THEN 'Tarde (12:00-17:59)'
        ELSE 'Noche (18:00-23:59)'
    END AS 'Turno'
FROM ventas v
INNER JOIN clientes c ON v.id_cliente = c.id_cliente
INNER JOIN empleados e ON v.id_empleado = e.id_empleado
ORDER BY v.fecha;

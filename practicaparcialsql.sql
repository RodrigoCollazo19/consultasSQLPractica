-- 1) Seleccionar los Números de factura con su respectivo nombre de sucursal
SELECT F.Num, S.nombre
FROM Factura F INNER JOIN Sucursal S ON F.SucCod=S.codS;

-- 2) Seleccionar los clientes que no han sido registrados en ninguna factura
SELECT C.Nombre
FROM Cliente C 
WHERE C.cc NOT IN (SELECT C.cc
				   FROM Cliente C INNER JOIN Factura F ON C.cc=F.					CliCod);

-- 3) Seleccionar todos los clientes junto con sus facturas (si las tiene)
SELECT C.Nombre
FROM Cliente C INNER JOIN Factura F ON F.CliCod=C.cc;

-- 4) Encontrar el o los clientes que han comprado en todas las sucursales
SELECT C.cc
FROM Factura F INNER JOIN Sucursal S ON F.SucCod=S.cods
			   INNER JOIN Cliente C ON F.CliCod=C.cc
GROUP BY C.cc
HAVING COUNT(DISTINCT S.cods) = (SELECT COUNT(*) FROM Sucursal);

-- 5) Encontrar los clientes que solo han comprado en la sucursal X
SELECT *
FROM Factura F INNER JOIN Sucursal S ON F.SucCod=S.cods
			   INNER JOIN Cliente C ON F.CliCod=C.cc
WHERE S.nombre='Sucursal Centro' AND C.cc NOT IN (SELECT CliCod FROM Factura WHERE Succod <> 'X')

-- DDL
-- 6) Seleccionar el total de facturas del mes Julio 2023.
SELECT COUNT(*)
FROM Factura
WHERE Fecha BETWEEN '2023-07-01' AND '2023-07-31';

-- 7) Seleccionar el producto más vendido por sucursal

-- 8) Escribir la sentencia para crear las tablas Ciudad y Cliente
CREATE TABLE City (codC int PRIMARY KEY AUTO_INCREMENT, nombreCiudad VARCHAR(100) NOT NULL);

-- 9) Modificar la tabla Producto, incrementando los precios en un 50%
UPDATE Producto
SET precio=precio*1.50;

-- 10) Eliminar de la tabla producto, aquellos productos cuya categoría sea "Varios".
DELETE FROM Producto
WHERE categoria='Varios';
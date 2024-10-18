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
<<<<<<< HEAD
WHERE S.nombre='Sucursal Centro' AND C.cc NOT IN (SELECT CliCod FROM Factura WHERE Succod <> 'X');
=======
WHERE S.nombre='Sucursal Centro' AND C.cc NOT IN (SELECT CliCod FROM Factura WHERE Succod <> 'X')
>>>>>>> f42c755adbf99964ce1fc85ce1984a10f56f01c5

-- DDL
-- 6) Seleccionar el total de facturas del mes Julio 2023.
SELECT COUNT(*)
FROM Factura
WHERE Fecha BETWEEN '2023-07-01' AND '2023-07-31';

-- 7) Seleccionar el producto más vendido por sucursal
SELECT S.nombre AS Sucursal, P.nombre AS Producto, SUM(D.Cant_Unit) AS Total_Vendido
FROM Detalle D
JOIN Factura F ON D.FacNum = F.Num AND D.FacSucCod = F.SucCod
JOIN Producto P ON D.ProCod = P.codp
JOIN Sucursal S ON F.SucCod = S.cods
GROUP BY S.cods, S.nombre, P.codp, P.nombre
HAVING SUM(D.Cant_Unit) = (
    SELECT MAX(Total_Ventas)
    FROM (
        SELECT SUM(D2.Cant_Unit) AS Total_Ventas
        FROM Detalle D2
        JOIN Factura F2 ON D2.FacNum = F2.Num AND D2.FacSucCod = F2.SucCod
        WHERE F2.SucCod = F.SucCod
        GROUP BY D2.ProCod
    ) AS SubQuery
)
ORDER BY S.nombre;

-- 8) Escribir la sentencia para crear las tablas Ciudad y Cliente
CREATE TABLE City (codC int PRIMARY KEY AUTO_INCREMENT, nombreCiudad VARCHAR(100) NOT NULL);

-- 9) Modificar la tabla Producto, incrementando los precios en un 50%
UPDATE Producto
SET precio=precio*1.50;

-- 10) Eliminar de la tabla producto, aquellos productos cuya categoría sea "Varios".
DELETE FROM Producto
WHERE categoria='Varios';

-- 11) Seleccionar los datos de los clientes, junto con el nombre de la ciudad a la cual pertenece.
SELECT DISTINCT C.cc, C.Nombre, CD.nombre
FROM Cliente C INNER JOIN Ciudad CD ON C.CiuCod=CD.codc;

-- 12) Seleccionar los productos que no han sido registrados en ninguna factura
SELECT *
FROM Producto
WHERE codp NOT IN (SELECT ProCod
				   FROM Detalle);
                   
-- 13) Seleccionar todas las ciudades junto con sus sucursales (si las tiene)
SELECT C.codc Codigo_Ciudad, C.nombre Ciudad, S.cods Codigo_Sucursal, S.nombre Sucursal
FROM Ciudad C LEFT JOIN Sucursal S ON S.CiuCod=C.codc;
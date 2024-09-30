-- 1) Obtener todos los detalles de todos los proyectos.
SELECT *
FROM proyecto;

-- 2) Obtener todos los detalles de todos los proyectos en Londres.
SELECT *
FROM proyecto
WHERE CIUDADY = 'Londres';

-- 3) Obtener los números de los proveedores que suministran al proyecto Y1.
SELECT NroV
FROM proyecto p INNER JOIN vpy ON p.NroY = vpy.NroY
WHERE PROYECTO='Y1';

-- 4) Obtener todos los envíos donde la cantidad está en el rango de 300 a 750 inclusive.
SELECT NroP
FROM vpy
WHERE CANT BETWEEN 300 AND 750;

-- 5) Obtener todas las combinaciones parte-color/parte-ciudad. Nota: A partir de este punto, el término "todos(as)" se entenderá como "todos los representados actualmente en la base de datos", no "todos los posibles".
SELECT COLOR, CIUDADP
FROM parte;

-- 6) Obtener todos los triples número de proveedor/número de parte/número de proyecto, tales que el proveedor, parte y proyecto indicados estén coubicados (es decir, todos en la misma ciudad).
SELECT vpy.NroY, vpy.NroP, vpy.NroV
FROM vpy 
INNER JOIN proveedor V ON vpy.NroV=V.NroV
INNER JOIN proyecto Y ON vpy.NroY=Y.NroY
INNER JOIN parte P ON vpy.NroP=P.NroP
WHERE V.CIUDADV = P.CIUDADP AND P.CIUDADP=Y.CIUDADY;

-- 7) Obtener todos los triples número de proveedor/número de parte/número de proyecto, tales que los proveedores, partes y proyectos indicados no estén todos coubicados.
SELECT vpy.NroY, vpy.NroP, vpy.NroV
FROM vpy 
INNER JOIN proveedor V ON vpy.NroV=V.NroV
INNER JOIN proyecto Y ON vpy.NroY=Y.NroY
INNER JOIN parte P ON vpy.NroP=P.NroP
WHERE V.CIUDADV <> P.CIUDADP OR P.CIUDADP<>Y.CIUDADY;

-- 8) Obtener todos los triples número de proveedor/número de parte/número de proyecto, tales que ningún par de los proveedores, partes y proyectos indicados esté coubicado.
SELECT vpy.NroY, vpy.NroP, vpy.NroV
FROM vpy 
INNER JOIN proveedor V ON vpy.NroV=V.NroV
INNER JOIN proyecto Y ON vpy.NroY=Y.NroY
INNER JOIN parte P ON vpy.NroP=P.NroP
WHERE V.CIUDADV <> P.CIUDADP AND P.CIUDADP<>Y.CIUDADY AND V.CIUDADV <> Y.CIUDADY;

-- 9) Obtener todos los detalles de las partes suministradas por un proveedor de Londres.
SELECT vpy.NroP, PARTE, COLOR, PESO, CIUDADP
FROM vpy INNER JOIN proveedor V ON vpy.NroV=V.NroV
		 INNER JOIN parte P ON vpy.NroP=P.NroP
WHERE CIUDADV='Londres'

-- 10) Obtener los números de las partes suministradas por un proveedor de Londres para un proyecto en Londres.

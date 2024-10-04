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
WHERE CIUDADV='Londres';

-- 10) Obtener los números de las partes suministradas por un proveedor de Londres para un proyecto en Londres.
SELECT NroP
FROM vpy INNER JOIN proveedor V ON vpy.NroV=V.NroV
		 INNER JOIN proyecto Y ON vpy.NroY=Y.NroY
WHERE CIUDADV='Londres' AND CIUDADY='Londres';

-- 11) Obtener todos los pares de nombres de ciudad tales que un proveedor en la primera ciudad suministre a un proyecto en la segunda ciudad.
SELECT CIUDADV, CIUDADY
FROM vpy INNER JOIN proveedor V ON vpy.NroV=V.NroV
		 INNER JOIN proyecto Y ON vpy.NroY=Y.NroY;

-- 12) Obtener los números de las partes suministradas para cualquier proyecto por un proveedor en la misma ciudad del proyecto.
SELECT NroP
FROM vpy INNER JOIN proveedor V ON vpy.NroV=V.NroV
		 INNER JOIN proyecto Y ON vpy.NroY=Y.NroY
WHERE CIUDADY=CIUDADV;

-- 13) Obtener los números de los proyectos que suministra por lo menos un proveedor que no está en la misma ciudad.
SELECT vpy.NroY
FROM vpy INNER JOIN proveedor V ON vpy.NroV=V.NroV
		 INNER JOIN proyecto Y ON vpy.NroY=Y.NroY
WHERE CIUDADY<>CIUDADV;

-- 14) Obtener todos los pares de números de parte tales que algún proveedor suministre ambas partes indicadas.

-- 15) Obtener los nombres de los proyectos que suministra el proveedor V1.
SELECT Y.PROYECTO
FROM vpy INNER JOIN proveedor V ON vpy.NroV=V.NroV
		 INNER JOIN proyecto Y ON vpy.NroY=Y.NroY
WHERE V.PROVEEDOR='V1';

-- 16) Obtener los colores de las partes suministradas por el proveedor V1.
SELECT P.COLOR
FROM vpy INNER JOIN proveedor V ON vpy.NroV=V.NroV
		 INNER JOIN parte P ON vpy.NroP=P.NroP
WHERE V.PROVEEDOR='V1';

-- 17) Obtener los números de las partes suministradas a cualquier proyecto en Londres.
SELECT vpy.NroP
FROM vpy INNER JOIN proyecto Y ON vpy.NroY=Y.NroY
WHERE Y.CIUDADY='Londres';

-- 18) Obtener los números de proyectos que usan al menos una parte disponible del proveedor V1.
SELECT vpy.NroY
FROM vpy INNER JOIN proveedor V ON vpy.NroV=V.NroV
WHERE V.PROVEEDOR='V1';

-- 19) Obtener los números de proveedores que suministran al menos una de las partes sumistradas al menos por un proveedor que a su vez suministra por lo menos una parte roja.
SELECT distinct NroV
FROM vpy
WHERE vpy.NroP IN (SELECT vpy.NroP
				  FROM vpy 
				  WHERE vpy.NroV IN	(SELECT vpy.NroV
									 FROM vpy INNER JOIN parte P ON vpy.NroP=P.NroP
									 WHERE P.COLOR='ROJO'));
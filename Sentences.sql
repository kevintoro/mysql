/*
    Hay que pensar en qué tipo de entidades hay que realizar: 
    preferiblemente, en plural porque van a ser varios los datos que se han de guardar
*/
USE libreria_cf;

/*
    Es bueno utilizar condicionales para evitar errores al momento de crear nuestras tablas en la base de datos.
    Para prevenir que se inserten valores enteros negativos usamos "UNSIGNED"
*/
DROP TABLE IF EXISTS autores;
DROP TABLE IF EXISTS libros;

/*
    Las CONSTRAINT como "NOT NULL" son restricciones para el almacenamiento de datos dentro de nuestras tablas
    Enum, es una lista de la que una columna puede tomar un valor (por ejemplo género)
*/
CREATE TABLE IF NOT EXISTS autores(
    autor_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(40) NOT NULL,
    apellido VARCHAR(25) NOT NULL,
    seudonimo VARCHAR(50) UNIQUE,
    genero ENUM ('M', 'F'),
    fecha_nacimiento DATE,
    pais_origen VARCHAR(40),
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP
);

/*
    Así se hacen las inserciones en lenguaje SQL, que son los STATEMENTS que se usarán en los distintos 
    lenguajes con las librerías
    respectivas para cada uno
*/
INSERT INTO autores(nombre, apellido, genero, fecha_nacimiento, pais_origen) VALUES
('Kevin', 'Toro', 'M', '1999-07-07', 'Colombia');

INSERT INTO autores(nombre, apellido, genero, fecha_nacimiento, pais_origen) VALUES
('Janner', 'Toro', 'M', '2004-08-08', 'Colombia');

INSERT INTO autores(nombre, apellido, genero, fecha_nacimiento, pais_origen) VALUES
('Luz', 'Galvan', 'F', '1976-07-13', 'Colombia');

INSERT INTO autores(nombre, apellido, genero, fecha_nacimiento, pais_origen) VALUES
('Jose', 'Toro', 'M', '1976-06-26', 'Colombia');

INSERT INTO autores(nombre, apellido, genero, fecha_nacimiento, pais_origen) VALUES
('Daiber', 'Toro', 'M', '2007-08-27', 'Colombia');

INSERT INTO autores(nombre, apellido, genero, pais_origen) VALUES
('Allison', 'Toro', 'F', 'Colombia');

INSERT INTO autores(nombre, apellido, genero, fecha_nacimiento, pais_origen) VALUES
('Luz', 'Galvan', 'F', '1976-07-13', 'Colombia');

INSERT INTO autores(nombre, apellido, genero, fecha_nacimiento, pais_origen) VALUES
('Jose', 'Toro', 'M', '1976-06-26', 'Colombia');

INSERT INTO autores(nombre, apellido, genero, fecha_nacimiento, pais_origen) VALUES
('Daiber', 'Toro', 'M', '2007-08-27', 'Colombia');

/*
    También se pueden insertar varios registros de la siguiente manera, cuando se necesite
*/
INSERT INTO autores(nombre, apellido, genero, fecha_nacimiento, pais_origen) VALUES
('Kyrie', 'Irving', 'M', '1992-03-23', 'Colombia'),
('Marggie', 'Garcia', 'F', '1998-08-05', 'Colombia');

SELECT * FROM autores;

CREATE TABLE libros(
    libro_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    autor_id INT UNSIGNED NOT NULL,
    titulo VARCHAR(50) NOT NULL,
    descripcion VARCHAR(250),
    paginas INTEGER UNSIGNED,
    fecha_publicacion DATE NOT NULL,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (autor_id) REFERENCES autores(autor_id)
)

/**
    PARA MODIFICAR UNA TABLA SE USA "ALTER TABLE" Y LO QUE QUEREMOS HACER, POR EJEMPLO "ADD" o "DROP COLUMN 
    (nombre de columna)"
    Toda consulta se puede condicionar con {<, >, <=, >=, != (<>)}
    
    Operadores lógicos: AND, OR, NOT
    AND: todas las sentencias deben ser verdaderas
    OR: se ejecuta con una sola condición que se cumpla
    Null no representa un tipo de dato, así que no representa nunca ello, para especificar que queremos saber los registros que tengan
    NULL, colocaremos "IS NULL"
    ello se puede negar con el operador lógico "NOT", que niega toda afirmación
    también podemos hacer lo mismo con "<=> NULL", pero es preferible usar el IS

    Trabajamos en SQL también con rangos con "BETWEEN" donde también es necesario usar el AND, para especificarle hasta dónde va el rango
    También podemos estar buscando entre una lista con "IN ('todos los valores para buscar')"
    Para no ver datos repetidos, usamos DISTINCT, que va después de un SELECT, antes de un FROM

    Alias: nombres para tablas, columnas o funciones, es muy útil cuando se trabaja con nombres complejos

    por ejemplo: "SELECT autor_id AS autor", titulo AS nombre FROM libros"
*/

/*
    Actualizar registros:
    UPDATE tabla SET columna a actualizar = nuevo valor WHERE condicion bajo llave primaria;

    Eliminar registro o registros:
    DELETE FROM tabla WHERE condicion;

    Eliminación en cascada, "ON DELETE CASCADE", nos permitirá eliminar las filas relacionadas en otras tablas

    Eliminación de todos los registros de una tabla:
    TRUNCATE TABLE nombre de tabla; (esto incluso elimina todos los metadatos de la tabla)
*/

/*
    Funciones Strings:

    CONCAT, une los valores guardados en dos columnas, pero no deja espacio entre ellas, así que podemos colocar entre cada columna un
    " ", para hacer la concatenación con ese espacio
    y para que la columna restante tenga un título descriptivo, usaremos un ALIAS
    
    SELECT CONCAT(nombre, " ", apellido) AS nombre_completo FROM autores;

    LENGTH: devuelve la cantidad de caracteres que tiene una cadena de texto, después de colocarla, se puede colocar condiciones
    UPPER y LOWER, transforma a MAYÚSCULA O MINÚSCULA el texto
    TRIM: Elimina alguna cosa del inicio y final del texto, por default serán los espacios.
    LEFT and RIGHT: nos permite sacar sub Strings de un String original, tiene dos parametros:
        LEFT(cadena de texto, cantidad de caracteres a elegir) -> va de izquierda a derecha
        RIGHT(cadena de texto, cantidad de caracteres a elegir) -> va de derecha a izquierda.
        Puede ser usada con condicionales
*/

/*
    Fuciones sobre Numeros:
    RAND: nos permite tener un número aleatorio entre 0 y 1, para que nos de un valor positivo hasta 100, podemos usar la función:
    ROUND: redondea números flotantes
    TRUNCATE: trunca los números después de punto decimal-> (TRUNCATE(1.123456789, 5)-> devolverá 5 números después del punto decimal)
    POW: permite elevar un número x a y potencia: POW(x, y)
*/

/*
    Funciones Fechas:
    Puedo configurar lo siguiente: {SET @now = NOW()}, y luego usarlo en código (ya se han tomado screenshots de su uso).
    originalmente el NOW() es un TIMESTAMP, se puede usar la función DATE(@now) para pasar a ese tipo de dato (mirar screenshots)
*/

/*
    Condiciones:
    IF(condicion, valor de retorno, valor que retorna si no se cumple).
    IFNULL(valor a evualuar si es null, retorno)
*/

/*
    CREACIÓN DE FUNCIONES: veamos un ejemplo con una función para agregar días a una fecha
    -toda función debe retornar un valor
    - entre BEGIN y END debe ir toda la lógica del método
    NOTA: HAY QUE COLOCAR UN DELIMITER DIFERENTE A ";" EN LA CONSOLA PORQUE, COMO VEMOS, TENEMOS 2 ";" PARA LA FUNCIÓN,
    Y NECESITAMOS QUE MYSQL NO TOME COMO SENTENCIAS DISTINTAS YA QUE NOS VA A GENERAR UN ERROR, ELLO LO HACEMOS CON "DELIMITER"
*/
CREATE FUNCTION agregar_dias(fecha DATE, dias INT)
RETURNS DATE
BEGIN
    RETURN fecha + INTERVAL dias DAY;
END;

/*
    COMENTARIO DE CODIGOFACILITO: (con respecto a nuevas versiones de MySQL)
    Tal como comenta yurimm40, para la versión 8 la instrucción para listar las funciones es: 
    SHOW FUNCTION STATUS WHERE db = database() AND type = "FUNCTION"\G
    Ahora bien, por lógica se debe suponer que es un objeto que se anexa directamente en la base de datos que la invoca.
    Pueden recrear o visualizar su contenido con esta instrucción: SHOW CREATE FUNCTION agregar_dias\G
    Ah, como pueden observar, cuando se aplica \G (para aquellas instrucciones donde desee paginar), este no debe finalizar
    con ";", porque en la ultima linea aparece un error. 
*/
/*
    Podemos crear funciones con SENTENCIAS dentro del BEGIN
    NOTA: PARA ALMACENAR EN UNA VARIABLE LO DE UNA SENTENCIA, SE DEBE COLOCAR LA SENTENCIA ENTRE PARÉNTESIS.    
*/
DELIMITER --
CREATE FUNCTION obtener_paginas()
RETURNS INT
BEGIN
    SET @paginas = (SELECT(ROUND(RAND()*100)*4));
    RETURN @paginas;
END--
DELIMITER ;

UPDATE libros SET paginas = obtener_paginas();

CREATE FUNCTION obtener_ventas()
    RETURNS INT
    BEGIN
        SET @ventas = (SELECT(ROUND(RAND()*100)*10));
        RETURN @ventas;
    END--

UPDATE libros SET ventas = obtener_ventas();

INSERT INTO autores  (Nombre, Apellido, seudonimo, Genero, Fecha_nacimiento, Pais_origen)
VALUES ('Stephen Edwin', 'King', 'Richard Bachman', 'M', '1947-09-27', 'United States'),
('Joanne','Rowling', ' J.K Rowling', 'F', '1947-09-27','United Kingdom');

INSERT INTO libros(autor_id, titulo, fecha_publicacion, ventas)
VALUES (12, 'Carrie','1974-01-01', 0),
(12, 'El misterio de salmes lot','1975-01-01', 0),
(12, 'El resplando','1977-01-01', 0),
(13, 'Harry Potter y la piedra filosofal', '1997-06-30', 0),
(13, 'Harry Potter y la camara secreta', '1998-07-2', 0),
(13, 'Harry Potter y el prisionero de azkaban', '1999-07-8', 0),
(13, 'Harry Potter y el Caliz de fuego', '2000-03-20', 0),
(13, 'Harry Potter y a orden de fenix','2003-06-21', 0),
(13, 'Harry Potter y el misterio del principe','2005-06-16', 0),
(13, 'Harry Potter y la reliquias de la muerte', '2007-07-21', 0);

SELECT libros.libro_id, libros.titulo, libros.paginas, libros.fecha_publicacion,autores.autor_id, autores.nombre, autores.apellido,
autores.pais_origen FROM libros INNER JOIN autores ON libros.autor_id = autores.autor_id;

/*
    Tabla resultante del inner join:
    +----------+------------------------------------------+---------+-------------------+----------+---------------+----------+----------------+
    | libro_id | titulo                                   | paginas | fecha_publicacion | autor_id | nombre        | apellido | pais_origen    |
    +----------+------------------------------------------+---------+-------------------+----------+---------------+----------+----------------+
    |        1 | Carrie                                   |     372 | 1974-01-01        |       12 | Stephen Edwin | King     | United States  |
    |        2 | El misterio de salmes lot                |     256 | 1975-01-01        |       12 | Stephen Edwin | King     | United States  |
    |        3 | El resplando                             |     172 | 1977-01-01        |       12 | Stephen Edwin | King     | United States  |
    |        4 | Harry Potter y la piedra filosofal       |      88 | 1997-06-30        |       13 | Joanne        | Rowling  | United Kingdom |
    |        5 | Harry Potter y la camara secreta         |     328 | 1998-07-02        |       13 | Joanne        | Rowling  | United Kingdom |
    |        6 | Harry Potter y el prisionero de azkaban  |     184 | 1999-07-08        |       13 | Joanne        | Rowling  | United Kingdom |
    |        7 | Harry Potter y el Caliz de fuego         |     324 | 2000-03-20        |       13 | Joanne        | Rowling  | United Kingdom |
    |        8 | Harry Potter y a orden de fenix          |     264 | 2003-06-21        |       13 | Joanne        | Rowling  | United Kingdom |
    |        9 | Harry Potter y el misterio del principe  |     352 | 2005-06-16        |       13 | Joanne        | Rowling  | United Kingdom |
    |       10 | Harry Potter y la reliquias de la muerte |     168 | 2007-07-21        |       13 | Joanne        | Rowling  | United Kingdom |
    +----------+------------------------------------------+---------+-------------------+----------+---------------+----------+----------------+
    10 rows in set (0.03 sec)
*/

/*
    Podemos también trabajar con cadenas con la palabra LIKE, por ejemplo, podemos buscar Dentro de la tabla libros, los que comiencen
    con "Harry Potter":
    SELECT * FROM libros WHERE titulo LIKE 'Harry Potter%';
    Este es nuestro resultado:
    +----------+----------+------------------------------------------+-------------+---------+-------------------+---------------------+--------+
    | libro_id | autor_id | titulo                                   | descripcion | paginas | fecha_publicacion | fecha_creacion      | ventas |
    +----------+----------+------------------------------------------+-------------+---------+-------------------+---------------------+--------+
    |        4 |       13 | Harry Potter y la piedra filosofal       | NULL        |      88 | 1997-06-30        | 2020-05-26 16:01:58 |      0 |
    |        5 |       13 | Harry Potter y la camara secreta         | NULL        |     328 | 1998-07-02        | 2020-05-26 16:01:58 |      0 |
    |        6 |       13 | Harry Potter y el prisionero de azkaban  | NULL        |     184 | 1999-07-08        | 2020-05-26 16:01:58 |      0 |
    |        7 |       13 | Harry Potter y el Caliz de fuego         | NULL        |     324 | 2000-03-20        | 2020-05-26 16:01:58 |      0 |
    |        8 |       13 | Harry Potter y a orden de fenix          | NULL        |     264 | 2003-06-21        | 2020-05-26 16:01:58 |      0 |
    |        9 |       13 | Harry Potter y el misterio del principe  | NULL        |     352 | 2005-06-16        | 2020-05-26 16:01:58 |      0 |
    |       10 |       13 | Harry Potter y la reliquias de la muerte | NULL        |     168 | 2007-07-21        | 2020-05-26 16:01:58 |      0 |
    +----------+----------+------------------------------------------+-------------+---------+-------------------+---------------------+--------+

    Ahora los libros que terminen con "e":
    SELECT * FROM libros WHERE titulo LIKE '%e';
    Este es nuestro resultado:
    +----------+----------+------------------------------------------+-------------+---------+-------------------+---------------------+--------+
    | libro_id | autor_id | titulo                                   | descripcion | paginas | fecha_publicacion | fecha_creacion      | ventas |
    +----------+----------+------------------------------------------+-------------+---------+-------------------+---------------------+--------+
    |        1 |       12 | Carrie                                   | NULL        |     372 | 1974-01-01        | 2020-05-26 16:01:58 |      0 |
    |        9 |       13 | Harry Potter y el misterio del principe  | NULL        |     352 | 2005-06-16        | 2020-05-26 16:01:58 |      0 |
    |       10 |       13 | Harry Potter y la reliquias de la muerte | NULL        |     168 | 2007-07-21        | 2020-05-26 16:01:58 |      0 |
    +----------+----------+------------------------------------------+-------------+---------+-------------------+---------------------+--------+
    Hay que observar que para el inicio, el porcentaje estaba en el final del substring, caso contrario para el del "finaliza con"

    Ahora buscando substrings que están en el medio del texto:
    SELECT * FROM libros WHERE titulo LIKE "%la%";
    +----------+----------+------------------------------------------+-------------+---------+-------------------+---------------------+--------+
    | libro_id | autor_id | titulo                                   | descripcion | paginas | fecha_publicacion | fecha_creacion      | ventas |
    +----------+----------+------------------------------------------+-------------+---------+-------------------+---------------------+--------+
    |        3 |       12 | El resplando                             | NULL        |     172 | 1977-01-01        | 2020-05-26 16:01:58 |      0 |
    |        4 |       13 | Harry Potter y la piedra filosofal       | NULL        |      88 | 1997-06-30        | 2020-05-26 16:01:58 |      0 |
    |        5 |       13 | Harry Potter y la camara secreta         | NULL        |     328 | 1998-07-02        | 2020-05-26 16:01:58 |      0 |
    |       10 |       13 | Harry Potter y la reliquias de la muerte | NULL        |     168 | 2007-07-21        | 2020-05-26 16:01:58 |      0 |
    +----------+----------+------------------------------------------+-------------+---------+-------------------+---------------------+--------+

    Esto es una sentencia más compleja: 

    SELECT * FROM libros WHERE titulo LIKE '_a____';
    +----------+----------+--------+-------------+---------+-------------------+---------------------+--------+
    | libro_id | autor_id | titulo | descripcion | paginas | fecha_publicacion | fecha_creacion      | ventas |
    +----------+----------+--------+-------------+---------+-------------------+---------------------+--------+
    |        1 |       12 | Carrie | NULL        |     372 | 1974-01-01        | 2020-05-26 16:01:58 |      0 |
    +----------+----------+--------+-------------+---------+-------------------+---------------------+--------+
*/

/*
    Expresiones regulares:
    Cuando tenemos que buscar varias cosas con el like, y ello podría hacer que nuestras sentencias sean dificiles de mantener
    debemos usar el REGEXP '^[expresiones con las que inicia]', veamos un ejemplo:
    SELECT titulo FROM libros WHERE titulo REGEXP '^[EH]';
    +------------------------------------------+
    | titulo                                   |
    +------------------------------------------+
    | El misterio de salmes lot                |
    | El resplando                             |
    | Harry Potter y la piedra filosofal       |
    | Harry Potter y la camara secreta         |
    | Harry Potter y el prisionero de azkaban  |
    | Harry Potter y el Caliz de fuego         |
    | Harry Potter y a orden de fenix          |
    | Harry Potter y el misterio del principe  |
    | Harry Potter y la reliquias de la muerte |
    +------------------------------------------+
*/

/*
    Ordenar resultados:
    SELECT * FROM libros ORDER BY paginas;
    +----------+----------+------------------------------------------+-------------+---------+-------------------+---------------------+--------+
    | libro_id | autor_id | titulo                                   | descripcion | paginas | fecha_publicacion | fecha_creacion      | ventas |
    +----------+----------+------------------------------------------+-------------+---------+-------------------+---------------------+--------+
    |        4 |       13 | Harry Potter y la piedra filosofal       | NULL        |      88 | 1997-06-30        | 2020-05-26 16:01:58 |      0 |
    |       10 |       13 | Harry Potter y la reliquias de la muerte | NULL        |     168 | 2007-07-21        | 2020-05-26 16:01:58 |      0 |
    |        3 |       12 | El resplando                             | NULL        |     172 | 1977-01-01        | 2020-05-26 16:01:58 |      0 |
    |        6 |       13 | Harry Potter y el prisionero de azkaban  | NULL        |     184 | 1999-07-08        | 2020-05-26 16:01:58 |      0 |
    |        2 |       12 | El misterio de salmes lot                | NULL        |     256 | 1975-01-01        | 2020-05-26 16:01:58 |      0 |
    |        8 |       13 | Harry Potter y a orden de fenix          | NULL        |     264 | 2003-06-21        | 2020-05-26 16:01:58 |      0 |
    |        7 |       13 | Harry Potter y el Caliz de fuego         | NULL        |     324 | 2000-03-20        | 2020-05-26 16:01:58 |      0 |
    |        5 |       13 | Harry Potter y la camara secreta         | NULL        |     328 | 1998-07-02        | 2020-05-26 16:01:58 |      0 |
    |        9 |       13 | Harry Potter y el misterio del principe  | NULL        |     352 | 2005-06-16        | 2020-05-26 16:01:58 |      0 |
    |        1 |       12 | Carrie                                   | NULL        |     372 | 1974-01-01        | 2020-05-26 16:01:58 |      0 |
    +----------+----------+------------------------------------------+-------------+---------+-------------------+---------------------+--------+
    Vemos que los libros están ordenados por el número de páginas que tiene cada uno de ellos.
    Por defecto es ascendente, si queremos que sea descendente, se usa el DESC
*/

/*
    Limitar la cantidad de resultados de una consulta:
    "LIMIT x"
    SELECT titulo FROM libros LIMIT 7;
    +-----------------------------------------+
    | titulo                                  |
    +-----------------------------------------+
    | Carrie                                  |
    | El misterio de salmes lot               |
    | El resplando                            |
    | Harry Potter y la piedra filosofal      |
    | Harry Potter y la camara secreta        |
    | Harry Potter y el prisionero de azkaban |
    | Harry Potter y el Caliz de fuego        |
    +-----------------------------------------+
*/

/*
    FUNCIONES DE AGREGACIÓN:
    COUNT: nos permite contar registros, por ejemplo:
    SELECT COUNT(*) FROM autores;
    +----------+
    | COUNT(*) |
    +----------+
    |       13 |
    +----------+

    También podemos colocar columnas en vez de *:

    SELECT COUNT(seudonimo) AS total_autores FROM autores;
    +---------------+
    | total_autores |
    +---------------+
    |             2 |
    +---------------+
    Como vemos, NULL no es tomado en cuenta

    Podemos colocar condicionales:
    SELECT COUNT(apellido) AS apellido_autor FROM autores WHERE seudonimo IS NOT NULL;
    +----------------+
    | apellido_autor |
    +----------------+
    |              2 |
    +----------------+

    SUM: suma todos los campos de los registros:
    SELECT SUM(paginas) FROM libros;
    +--------------+
    | SUM(paginas) |
    +--------------+
    |         2508 |
    +--------------+

    MAX: valor máximo dentro de una columna
    SELECT MAX(paginas) FROM libros;
    +--------------+
    | MAX(paginas) |
    +--------------+
    |          372 |
    +--------------+

    MIN: valor mínimo dentro de una columna
    SELECT MIN(paginas) FROM libros;
    +--------------+
    | MIN(paginas) |
    +--------------+
    |           88 |
    +--------------+

    AVG: Saber promedio de una columna
    SELECT AVG(paginas) FROM libros;
    +--------------+
    | AVG(paginas) |
    +--------------+
    |     250.8000 |
    +--------------+
    SÓLO SE TOMAN REGISTROS QUE POSEAN VALORES
*/

/*
    AGRUPAMIENTO: siempre que se deba hacer una agrupación SIEMPRE se debe usar GROUP BY, por ejemplo:
    SELECT autor_id, SUM(paginas) FROM libros GROUP BY autor_id;
    +----------+--------------+
    | autor_id | SUM(paginas) |
    +----------+--------------+
    |       12 |          800 |
    |       13 |         1708 |
    +----------+--------------+
    MUESTRA LA CANTIDAD DE PÁGINAS QUE TIENEN TODOS LOS LIBROS QUE HAY DE UN AUTOR

    SELECT autor_id, SUM(paginas) AS suma_paginas FROM libros GROUP BY autor_id ORDER BY suma_paginas DESC;
    +----------+--------------+
    | autor_id | suma_paginas |
    +----------+--------------+
    |       13 |         1708 |
    |       12 |          800 |
    +----------+--------------+
*/

/*
    HAVING: AGRUPACIONES POR CONDICION
    Las funciones de agregación no se pueden usar o condicionar con el WHERE, así que usamos el HAVING como un filtro de datos:
    SELECT autor_id, SUM(paginas) AS total FROM libros GROUP BY autor_id HAVING SUM(paginas) > 801;
    +----------+-------+
    | autor_id | total |
    +----------+-------+
    |       13 |  1708 |
    +----------+-------+
    Autores cuyas páginas sumadas de los libros es mayor a 801
*/

/*
    UNION: une dos resulsets
    SELECT CONCAT(nombre, " ", apellido) AS nombre_completo FROM autores
    UNION
    SELECT CONCAT(nombre, " ", apellido) AS nombre_completo FROM usuarios;
    +--------------------+
    | nombre_completo    |
    +--------------------+
    | Kevin Toro         |
    | Janner Toro        |
    | Luz Galvan         |
    | Jose Toro          |
    | Daiber Toro        |
    | Allison Toro       |
    | Kyrie Irving       |
    | Marggie Garcia     |
    | Stephen Edwin King |
    | Joanne Rowling     |
    +--------------------+

    UN EJEMPLO MÁS COMPLEJO:
    SELECT CONCAT(nombre, " ", apellido) AS nombre_completo, seudonimo, "" FROM autores
    UNION
    SELECT CONCAT(nombre, " ", apellido) AS nombre_completo, "", username FROM usuarios;
    +--------------------+-----------------+------------+
    | nombre_completo    | seudonimo       |            |
    +--------------------+-----------------+------------+
    | Kevin Toro         | NULL            |            |
    | Janner Toro        | NULL            |            |
    | Luz Galvan         | NULL            |            |
    | Jose Toro          | NULL            |            |
    | Daiber Toro        | NULL            |            |
    | Allison Toro       | NULL            |            |
    | Kyrie Irving       | NULL            |            |
    | Marggie Garcia     | NULL            |            |
    | Stephen Edwin King | Richard Bachman |            |
    | Joanne Rowling     |  J.K Rowling    |            |
    | Kevin Toro         |                 | kevintoro7 |
    | Janner Toro        |                 | ajbull     |
    +--------------------+-----------------+------------+
*/

/*
    SUBCONSULTAS:
    Para ejemplo, vamos a obtener los autores que hayan tenido ventas por encima del promedio
*/
SET @promedio_ventas = (SELECT AVG(ventas) FROM libros);
SELECT
    autor_id
FROM libros
GROUP BY autor_id
HAVING SUM(ventas) > @promedio_ventas;
-- Esa sería la manera convencional, sin embargo, se puede usar una subconsulta en vez de crear una variable, de la siguiente manera:
SELECT
    autor_id
FROM libros
GROUP BY autor_id
HAVING SUM(ventas) > (SELECT AVG(ventas) FROM libros);
--Toda subconsulta debe ir entre paréntesis, pero sólo nos está mostrando los ID de los autores, así que haremos lo siguiente:
SELECT CONCAT(nombre, " ", apellido) AS nombre_autor FROM autores WHERE autor_id IN (
    SELECT
        autor_id
    FROM libros
    GROUP BY autor_id
    HAVING SUM(ventas) > (SELECT AVG(ventas) FROM libros)
);

/*
    Validar registros:
    EXISTS
    Obtener el mensaje "DISPONIBLE" si un libro está en el listado dado su nombre, si no "AGOTADO"
*/
SELECT IF(EXISTS(SELECT libro_id FROM libros WHERE titulo = "Carrie"), "DISPONIBLE", "AGOTADO") AS Mensaje;

-- JOINS O UNIÓN ENTRE TABLAS
/*
    INNER JOIN: obtiene los datos en intersección de dos tablas
    Cuando las columnas tienen el mismo nombre, se debe colocar el nombre de la tabla origen de la columna
*/
SELECT libros.titulo, CONCAT(autores.nombre, " ", autores.apellido) AS nombre_autor, libros.fecha_creacion FROM libros 
INNER JOIN autores ON libros.autor_id = autores.autor_id;
-- Si las dos tablas tienen el mismo nombre en el campo después del ON, podemos usar la Sub Clausula USING
SELECT libros.titulo, CONCAT(autores.nombre, " ", autores.apellido) AS nombre_autor, libros.fecha_creacion FROM libros 
INNER JOIN autores USING(autor_id);
--Sin embargo el ON nos permite condicionar una unión de tablas, por ejemplo:
SELECT libros.titulo, CONCAT(autores.nombre, " ", autores.apellido) AS nombre_autor, libros.fecha_creacion FROM libros 
INNER JOIN autores ON libros.autor_id = autores.autor_id AND libros.ventas > 500;
/*
    RESULTADO:
    +-----------------------------------------+--------------------+---------------------+
    | titulo                                  | nombre_autor       | fecha_creacion      |
    +-----------------------------------------+--------------------+---------------------+
    | El resplando                            | Stephen Edwin King | 2020-05-26 16:01:58 |
    | Harry Potter y el prisionero de azkaban | Joanne Rowling     | 2020-05-26 16:01:58 |
    | Harry Potter y a orden de fenix         | Joanne Rowling     | 2020-05-26 16:01:58 |
    | Harry Potter y el misterio del principe | Joanne Rowling     | 2020-05-26 16:01:58 |
    +-----------------------------------------+--------------------+---------------------+
*/

/*
    LEFT JOIN: Obtiene los datos de la intersección de dos tablas y la izquierda (o tabla a)
*/
CREATE TABLE libros_usuarios(
    libro_id INT UNSIGNED NOT NULL,
    usuario_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (libro_id) REFERENCES libros(libro_id),
    FOREIGN KEY (usuario_id) REFERENCES usuarios(usuario_id),
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP) NOT NULL;

INSERT INTO libros_usuarios(libro_id, usuario_id) VALUES (1, 1), (4, 1), (3, 2), (10, 2);

/*
    usuarios = tabla a
    libros_usuarios = tabla b
*/
SELECT CONCAT(nombre, " ", apellido) AS nombre_usuario, libros_usuarios.libro_id FROM usuarios
    LEFT JOIN libros_usuarios ON usuarios.usuario_id = libros_usuarios.usuario_id;
/*
    +----------------+----------+
    | nombre_usuario | libro_id |
    +----------------+----------+
    | Kevin Toro     |        1 |
    | Kevin Toro     |        4 |
    | Janner Toro    |        3 |
    | Janner Toro    |       10 |
    | Luz Galvan     |     NULL |
    +----------------+----------+
*/
--para seleccionar sólo los que han prestado un libro
SELECT CONCAT(nombre, " ", apellido) AS nombre_usuario, libros_usuarios.libro_id FROM usuarios
    LEFT JOIN libros_usuarios ON usuarios.usuario_id = libros_usuarios.usuario_id
    WHERE libros_usuarios.libro_id IS NOT NULL;

/*
    RIGHT JOIN: Obtiene los datos de la intersección de dos tablas y la derecha (o tabla b)

    usuarios = b
    libros_usuarios = a

    NOTA: LA TABLA DESPUÉS DEL "FROM" ES LA TABLA "a"
*/

SELECT CONCAT(nombre, " ", apellido) AS nombre_usuario, libros_usuarios.libro_id FROM libros_usuarios
    RIGHT JOIN usuarios ON libros_usuarios.usuario_id = usuarios.usuario_id;

/*
    SENTENCIAS CON VARIOS JOINS:
    Ejemplo: obtener los usuarios que han pedido prestado un libro el día de hoy, y ese libro debe haber sido escrito por un autor con
    seudónimo.

    usuarios, libros_usuarios, libros, autores
*/
SELECT DISTINCT CONCAT(usuarios.nombre, " ", usuarios.apellido) AS nombre_usuario FROM usuarios
    INNER JOIN libros_usuarios ON usuarios.usuario_id = libros_usuarios.usuario_id
                                AND DATE(libros_usuarios.fecha_creacion) = CURDATE()
    INNER JOIN libros ON libros_usuarios.libro_id = libros.libro_id
    INNER JOIN autores ON libros.autor_id = autores.autor_id AND autores.seudonimo IS NOT NULL;

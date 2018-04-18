/* START - Sample data for worldwar2 db */
CREATE DATABASE worldwar2;
SHOW DATABASES;
USE worldwar2;

CREATE TABLE classes (
class VARCHAR(255)  NOT NULL PRIMARY KEY,
type VARCHAR(255),
country VARCHAR(255),
numGuns INT,
bore INT,
displacement INT
);

CREATE TABLE ships (
name VARCHAR(255) NOT NULL PRIMARY KEY,
class VARCHAR(255),
launched INT,
FOREIGN KEY (class) REFERENCES classes(class)
);

CREATE TABLE battles (
name VARCHAR(255) NOT NULL PRIMARY KEY,
date DATE
);

CREATE TABLE outcomes(
ship VARCHAR(255),
battle VARCHAR(255),
result VARCHAR(255),
FOREIGN KEY (ship) REFERENCES ships(name),
FOREIGN KEY (battle) REFERENCES battles(name)
);

INSERT INTO classes VALUES('Bismarck', 'bb', 'Germany', '8', '15', '42000');
INSERT INTO classes VALUES('Iowa', 'bb', 'USA', '9', '16', '46000');
INSERT INTO classes VALUES('Kongo', 'bc', 'Japan', '8', '14', '32000');
INSERT INTO classes VALUES('North Carolina', 'bb', 'USA', '9', '16', '37000');
INSERT INTO classes VALUES('Renown', 'bc', 'Gt. Britain', '6', '15', '32000');
INSERT INTO classes VALUES('Revenge', 'bb', 'Gt. Britain', '8', '15', '29000');
INSERT INTO classes VALUES('Tennessee', 'bb', 'USA', '12', '14', '32000');
INSERT INTO classes VALUES('Yamato', 'bb', 'Japan', '9', '18', '65000');



INSERT INTO ships VALUES('California', 'Tennessee', '1921');
INSERT INTO ships VALUES('Haruna', 'Kongo', '1915');
INSERT INTO ships VALUES('Hiei', 'Kongo', '1914');
INSERT INTO ships VALUES('Iowa', 'Iowa', '1943');
INSERT INTO ships VALUES('Kirishima', 'Kongo', '1915');
INSERT INTO ships VALUES('Kongo', 'Kongo', '1913');
INSERT INTO ships VALUES('Missouri', 'Iowa', '1944');
INSERT INTO ships VALUES('Musashi', 'Yamato', '1942');
INSERT INTO ships VALUES('New Jersey', 'Iowa', '1943');
INSERT INTO ships VALUES('North Carolina', 'North Carolina', '1941');
INSERT INTO ships VALUES('Ramillies', 'Revenge', '1917');
INSERT INTO ships VALUES('Renown', 'Renown', '1916');
INSERT INTO ships VALUES('Repulse', 'Renown', '1916');
INSERT INTO ships VALUES('Resolution', 'Revenge', '1916');
INSERT INTO ships VALUES('Revenge', 'Revenge', '1916');
INSERT INTO ships VALUES('Royal Oak', 'Revenge', '1916');
INSERT INTO ships VALUES('Royal Sovereign', 'Revenge', '1916');
INSERT INTO ships VALUES('Tennessee', 'Tennessee', '1920');
INSERT INTO ships VALUES('Washington', 'North Carolina', '1941');
INSERT INTO ships VALUES('Wisconsin', 'Iowa', '1944');
INSERT INTO ships VALUES('Yamato', 'Yamato', '1941');
INSERT INTO ships VALUES('Arizona', 'Renown', '1942');
INSERT INTO ships VALUES('Bismarck', 'Renown', '1943');
INSERT INTO ships VALUES('Yamashiro', 'Renown', '1944');



INSERT INTO battles VALUES('Denmark Strait', '1941-05-24');
INSERT INTO battles VALUES('Guadalcanal', '1942-11-15');
INSERT INTO battles VALUES('North Cape', '1943-12-26');
INSERT INTO battles VALUES('Surigao Strait', '1944-10-25');
INSERT INTO battles VALUES('Pearl Harbor', '1945-12-25');

  
INSERT INTO outcomes VALUES('Arizona', 'Pearl Harbor', 'sunk');
INSERT INTO outcomes VALUES('Bismarck', 'Denmark Strait', 'sunk');
INSERT INTO outcomes VALUES('California', 'Surigao Strait', 'ok');
INSERT INTO outcomes VALUES('Royal Sovereign', 'North Cape', 'ok'); 
INSERT INTO outcomes VALUES('Ramillies', 'Surigao Strait', 'sunk'); 
INSERT INTO outcomes VALUES('Kirishima', 'Guadalcanal', 'sunk');
INSERT INTO outcomes VALUES('Resolution', 'Denmark Strait', 'sunk');
INSERT INTO outcomes VALUES('Royal Oak', 'Denmark Strait', 'sunk');
INSERT INTO outcomes VALUES('Yamashiro', 'Surigao Strait', 'sunk');
INSERT INTO outcomes VALUES('Hiei', 'Surigao Strait', 'sunk');
/* END - Sample data for worldwar2 db */




/* START - Task1 */

/* 1. Find the Number of battleship classes */
SELECT COUNT(class) 
FROM classes 
WHERE type = "bb";


/* 2. Find the average number of guns of battleship classes */
SELECT AVG(numGuns)
FROM classes 
WHERE type = "bb";


/* 3. Find the average number of guns of battleship */
SELECT AVG(numGuns) 
FROM classes, ships
WHERE ships.class = classes.class AND type = "bb";


/* 4. For each class, find the year in which the first ship of that class was launched */
SELECT class, MIN(launched) AS 'FirstShipLaunched'
FROM ships
GROUP BY class;


/* 5. For each class, find the number of ships of that class that sunk in battle */
SELECT ships.class, COUNT(outcomes.ship) 
FROM ships, outcomes
WHERE ships.name = outcomes.ship AND outcomes.result = "sunk"
GROUP BY ships.class;


/* 6. For each class, find the class with at least three ships the number of ships of that class sunk in a battle. */
SELECT ships.class, COUNT(outcomes.ship) 
FROM ships, outcomes
WHERE ships.name = outcomes.ship AND outcomes.result = "sunk"
GROUP BY ships.class
HAVING COUNT(outcomes.ship) >= 3;


/* 7. The weight (in pounds) of the shell fired FROM a naval gun is approximately one half the cube of the bore (in inches). Find the average weight of the shell for each country’s ship. */
SELECT classes.country, AVG((bore * bore * bore) / 2) AS 'AverageWeight'  
FROM classes, ships
WHERE classes.class = ships.class
GROUP BY classes.country;

/* END - Task1 */



/* START - Task3 */
SELECT name, classes.class, launched, type, country, numGuns, bore, displacement 
FROM ships, classes 
WHERE classes.class = ships.class;
/* END - Task3 */



/* START - Task4 */
SELECT  classes.class, name, launched, type, country, numGuns, bore, displacement 
FROM classes LEFT JOIN ships 
ON classes.class = ships.class;
/* END - Task4 */
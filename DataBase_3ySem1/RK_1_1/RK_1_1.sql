

CREATE TABLE bouquet(
	id INTEGER PRIMARY KEY NOT NULL,
	author VARCHAR(50) NOT NULL,	
	title VARCHAR(50)

);


CREATE TABLE florist(
	id INTEGER PRIMARY KEY NOT NULL,
	name VARCHAR(50) NOT NULL,
	ppno INTEGER,
	telephone INTEGER 

);

CREATE TABLE customer(
	id INTEGER PRIMARY KEY NOT NULL,
	name VARCHAR(50) NOT NULL,
	bd VARCHAR(50) NOT NULL,
	city VARCHAR(50),
	telephone INTEGER
);

COPY florist FROM 'E:\bauman 3rd year-1st sem\Data Base\RK_1_1\florist.csv' WITH (FORMAT CSV,HEADER);
COPY customer FROM 'E:\bauman 3rd year-1st sem\Data Base\RK_1_1\customer.csv' WITH (FORMAT CSV,HEADER);
COPY bouquet FROM 'E:\bauman 3rd year-1st sem\Data Base\RK_1_1\bouquet.csv' WITH (FORMAT CSV,HEADER);

//1

SELECT customer.id,customer.name,florist.name,bouquet.title
FROM bouquet
INNER JOIN florist ON bouquet.id = florist.id
INNER JOIN customer ON customer.id = bouquet.id
WHERE customer.name = 'Bell Caines' AND florist.name = 'Salvador Autin';

//2
SELECT florist.name, COUNT (*) No_bouquets 
FROM bouquet
INNER JOIN florist USING (id)
INNER JOIN customer USING (id)
WHERE customer.bd = '2008'
GROUP BY florist.name;


-- UPDATE customer
-- SET bd = '2008'
-- WHERE id = 1 AND id =2;

SELECT * FROM customer;

//3
SELECT bouquet.title,florist.name,customer.name
FROM bouquet
INNER JOIN florist USING(id)
INNER JOIN customer USING(id)
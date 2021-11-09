--rk2
--variant 3
--helambage gavindu

CREATE TABLE department 
(
	department_id INTEGER PRIMARY KEY NOT NULL,
	title VARCHAR(30),
	specification VARCHAR(30)

);

CREATE TABLE teachers
(
	id SERIAL PRIMARY KEY NOT NULL,
	name VARCHAR(30),
	degree VARCHAR(30),
	position VARCHAR(30),
	dept_id  INTEGER REFERENCES department (department_id)
	
);


CREATE TABLE subject
(
	subject_id INTEGER PRIMARY KEY,
	title VARCHAR(30),
	hours INTEGER ,
	semester VARCHAR(30),
	rating VARCHAR(30)

);

INSERT INTO teachers(name,degree,position,dept_id)
VALUES('marina','computer science','lecturer',1),
	('yulia','computer science','professor',1),
	('dimitry','mechanical','assistant professor',2),
	('taccov','physics','lecturer',3),
	('govorilov','electronic','lecturer',4),
	('olga','computer science','lecturer',1),
	('popov','computer network','professor',1)
	
INSERT INTO department(department_id,title,specification)
VALUES (1,'informatics','software engineering'),
	    (2,'mechanical','robotics'),
		(3,'electronic','physics'),
		(4,'radio technology','radiation'),
		(5,'informatics','computer network'),
		(6,'mechanical','mecanics'),
		(7,'informatics','cyber security')
		
INSERT INTO subject(subject_id,title,hours,semester,rating)
VALUES(1,'data base',45,'5th sem','1'),
		(2,'operating system',50,'4th sem','2'),
		(3,'physics',50,'3rd sem','3'),
		(4,'raido technology',45,'6th sem','4'),
		(5,'robo technology',50,'6th sem','1'),
		(6,'EBM',45,'4th sem','2'),
		(7,'dinamics',50,'3th sem','3')
		
		
--1.SELECT statement using a quantifier comparison predicate

SELECT subject_id,title,hours
 FROM subject
 WHERE hours > ALL
	(
		SELECT subject_id
		FROM subject
		WHERE hours = 45
	
	)	

--2.SELECT statement using aggregate functions in column expressions	


SELECT AVG(Total_Hours) AS AverageHours ,
	   SUM (Total_Hours)/COUNT(subject_id) AS Calc
	   
FROM (
		SELECT subject_id,SUM(hours)AS Total_Hours
		FROM subject
		GROUP BY subject_id
	
	) AS TotHours
	
--3.Create a new temporary local table from the resulting SELECT statement dataset

SELECT subject_id, 
	SUM(hours) AS TH,
	CAST(SUM(hours*3) AS hr) AS AH
INTO TEACHINGHOURS
FROM subject
WHERE subject_id IS NOT NULL 
GROUP BY subject_id

--3 part

CREATE OR REPLACE PROCEDURE deleter(varchar)
LANGUAGE plpgsql    
AS $$
BEGIN
    
	DELETE 
    FROM 
		varchar a 
			USING varchar b
			
    WHERE a.id = b.id;
	
	
    COMMIT;
END;
$$;

	

CALL deleter('department');
CALL deleter('subject');
CALL deleter('teachers');
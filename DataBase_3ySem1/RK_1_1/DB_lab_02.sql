--LAB_2
--1. SELECT statement using a comparison predicate.
SELECT DISTINCT C1.color_name,C2.color_code
FROM color c1 JOIN color AS C2 ON C2.color_name = C1.color_name
WHERE C2.id <> C1.id AND C1.color_code = '50'
ORDER BY C1.color_name

--2. 1. SELECT statement using the BETWEEN predicate.

SELECT DISTINCT id,color_code
FROM color
WHERE id BETWEEN 10 AND 100


 


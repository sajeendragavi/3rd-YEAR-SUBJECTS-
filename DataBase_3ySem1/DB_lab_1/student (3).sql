DROP TABLE IF EXISTS m_groups;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS marks;
DROP TABLE IF EXISTS subject_teacher;
DROP TABLE IF EXISTS subjects;
DROP TABLE IF EXISTS teachers;


CREATE TABLE students(
	id INTEGER PRIMARY KEY NOT NULL,
	first_name VARCHAR(40) NOT NULL, 
	last_name VARCHAR(40) NOT NULL,
	s_group INTEGER NOT NULL
);

CREATE TABLE teachers(
	id INTEGER PRIMARY KEY NOT NULL,
	first_name VARCHAR(40) NOT NULL, 
	last_name VARCHAR(40) NOT NULL
);

CREATE TABLE groups(
	id INTEGER PRIMARY KEY NOT NULL,
	name VARCHAR(5) NOT NULL,
	index INTEGER NOT NULL
);

CREATE TABLE subjects(
	id INTEGER PRIMARY KEY NOT NULL,
	title VARCHAR(30) NOT NULL
);

CREATE TABLE marks(
	id INTEGER PRIMARY KEY NOT NULL,
	date DATE,
	mark INTEGER,
	student_id INTEGER,
	subject_id INTEGER 
);

CREATE TABLE sub_teach(
	subject_id INTEGER,
	teacher_id INTEGER,
	group_id INTEGER,
	auditory INTEGER
);


ALTER TABLE students 
ADD CONSTRAINT fkey_student_g FOREIGN KEY (s_group) REFERENCES groups(id);

ALTER TABLE marks 
ADD CONSTRAINT fkey_mark_s FOREIGN KEY (student_id) REFERENCES students(id),
ADD CONSTRAINT fkey_mark_su FOREIGN KEY (subjectsct_id) REFERENCES subjects(id);

ALTER TABLE sub_teach
ADD CONSTRAINT pkey_subteach   	PRIMARY KEY	(subject_id, teacher_id, group_id),	
ADD CONSTRAINT fkey_subteach_su FOREIGN KEY (subject_id) REFERENCES subjects(id),
ADD CONSTRAINT fkey_subteach_s  FOREIGN KEY (teacher_id) REFERENCES teachers(id),
ADD CONSTRAINT fkey_subteach_g  FOREIGN KEY (group_id)   REFERENCES groups(id);

ALTER TABLE marks ADD CONSTRAINT mark_check CHECK (mark BETWEEN 2 AND 5);


COPY sub_teach FROM "E:\5_sem\DataBase\Lab_1\sub_teach.csv" DELIMITER ',' CSV;
COPY subjects  FROM "E:\5_sem\DataBase\Lab_1\subject.csv"   DELIMITER ',' CSV;
COPY teachers  FROM "E:\5_sem\DataBase\Lab_1\teacher.csv"   DELIMITER ',' CSV;
COPY students  FROM "E:\5_sem\DataBase\Lab_1\student.csv"   DELIMITER ',' CSV;
COPY groups    FROM "E:\5_sem\DataBase\Lab_1\group.csv"     DELIMITER ',' CSV;
COPY marks 	   FROM "E:\5_sem\DataBase\Lab_1\mark.csv"      DELIMITER ',' CSV;
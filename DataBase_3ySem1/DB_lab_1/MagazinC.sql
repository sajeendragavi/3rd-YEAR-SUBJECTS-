

CREATE TABLE product(
	id INTEGER PRIMARY KEY NOT NULL,
	name VARCHAR(40) NOT NULL,

);

CREATE TABLE color(
	id INTEGER PRIMARY KEY NOT NULL,
	name VARCHAR(40) NOT NULL,
	color_code NVARCHAR(10) NOT NULL
);

CREATE TABLE categories(
	id INTEGER PRIMARY KEY NOT NULL,
	name VARCHAR(40) NOT NULL


);

CREATE TABLE outfit_size(
	id INTEGER PRIMARY KEY NOT NULL,
	size_code NVARCHAR(10) NOT NULL,
	sort_order VARCHAR(10) NOT NULL

); 	


ALTER TABLE product
	ADD COLUMN p_color_id integer,
	ADD COLUMN p_catog_id integer ;

ALTER TABLE product
ADD CONSTRAINT fkey_color FOREIGN KEY(p_color_id) REFERENCES color(id),
ADD CONSTRAINT fkey_category FOREIGN KEY(p_catog_id) REFERENCES categories(id);
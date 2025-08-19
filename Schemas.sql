-- SCHEMAS of Netflix

CREATE DATABASE netflix_db;
USE netflix_db;
CREATE TABLE netflix
(
	show_id	VARCHAR(5) PRIMARY KEY,
	type    VARCHAR(10),
	title	VARCHAR(250),
	director VARCHAR(550),
	casts	VARCHAR(1050),
	country	VARCHAR(550),
	date_added DATE,
	release_year	YEAR,
	rating	VARCHAR(15),
	duration	VARCHAR(15),
	listed_in	VARCHAR(250),
	description VARCHAR(550)
);

SELECT * FROM netflix;

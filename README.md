# Netflix Movies and TV Shows Data Analysis using MySQL

![Netflix_logo](https://github.com/swetha-105/netflix_mysql_project/blob/main/netflix_logo.jpg)

## Overview

 This project involves a comprehensive analysis of Netflix's movies and TV shows data using SQL. The goal is to extract valuable insights and answer various business questions based on the dataset. The following README provides a detailed account of the project's objectives, business problems, solutions, findings, and conclusions.

## Objective

Analyze the distribution of content types (movies vs TV shows).
Identify the most common ratings for movies and TV shows.
List and analyze content based on release years, countries, and durations.
Explore and categorize content based on specific criteria and keywords.

## Dataset

The data for this project is sourced from the Kaggle dataset:
### . Dataset Link:(Movies Dataset)

## Schema
```sql
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
```


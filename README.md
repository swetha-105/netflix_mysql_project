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
###  Dataset Link:
![Netflix Titles](https://github.com/swetha-105/netflix_mysql_project/blob/main/Netflix_titles)

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

## Business problems and Solutions
### 1.Count the number of Movies vs TV Shows
```sql
SELECT type, COUNT(*) AS total
FROM netflix
GROUP BY type;
```

### 2.Find the total number of content items for each rating within each content type and sort them by highest count.
```sql
SELECT type, rating, COUNT(*) AS total
FROM netflix
GROUP BY type, rating
ORDER BY type, total DESC;
```
### 3. Retrieve all content released in the year 2020 from the Netflix dataset.
```sql
SELECT * 
FROM netflix
WHERE release_year = 2020;
```

### 4.Retrieve the top 5 countries with the highest number of content items in the dataset.
```sql
SELECT country, COUNT(*) AS total
FROM netflix
WHERE country IS NOT NULL
GROUP BY country
ORDER BY total DESC
LIMIT 5;
```
### 5. Find the movie with the maximum duration from the dataset.
```sql
SELECT title, duration
FROM netflix
WHERE type = 'Movie'
ORDER BY CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) DESC
LIMIT 1;
```

### 6. Retrieve all content that was added to Netflix in the last 5 years.
```sql
SELECT *
FROM netflix
WHERE date_added >= CURDATE() - INTERVAL 5 YEAR;
```

### 7. Retrieve all content directed by 'Rajiv Chilaka' from the dataset.
```sql
SELECT *
FROM netflix
WHERE director LIKE '%Rajiv Chilaka%';
```
### 8. Retrieve all TV shows that have more than 5 seasons.
```sql
SELECT *
FROM netflix
WHERE type = 'TV Show'
AND CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) > 5;
```
### 9. Count the number of content items in each genre category as listed in the dataset.
```sql
SELECT listed_in, COUNT(*) AS total_content
FROM netflix
GROUP BY listed_in;
```
### 10. Find the number of content items released each year in India and return the top 5 years with the highest count.
```sql
SELECT release_year, COUNT(*) AS total
FROM netflix
WHERE country = 'India'
GROUP BY release_year
ORDER BY total DESC
LIMIT 5;
```

### 11. Retrieve all content that belongs to the ‘Documentaries’ category.
```sql
SELECT *
FROM netflix
WHERE listed_in LIKE '%Documentaries%';
```

### 12. Retrieve all content that does not have a director specified.
```sql
SELECT * 
FROM netflix
WHERE director IS NULL;
```
### 13. Find the total number of movies featuring actor ‘Salman Khan’ released in the last 10 years.
```sql
SELECT COUNT(*) AS total_movies
FROM netflix
WHERE casts LIKE '%Salman Khan%'
AND type = 'Movie'
AND release_year >= YEAR(CURDATE()) - 10;
```
### 14. Find the top 10 cast entries with the highest number of content items produced in India.
```sql
SELECT casts, COUNT(*) AS total
FROM netflix
WHERE country = 'India'
AND casts IS NOT NULL
GROUP BY casts
ORDER BY total DESC
LIMIT 10;
```
### 15. Classify content as ‘Bad’ or ‘Good’ based on keywords in the description and count the number of items in each category.
```sql
SELECT 
CASE 
    WHEN description LIKE '%kill%' OR description LIKE '%violence%' THEN 'Bad'
    ELSE 'Good'
END AS category,
COUNT(*) AS total
FROM netflix
GROUP BY category;
```

### 16.Retrieve the top 10 oldest movies based on release year from the dataset.
```sql
SELECT title, release_year
FROM netflix
WHERE type = 'Movie'
ORDER BY release_year ASC
LIMIT 10;
```
### 17.Retrieve all content titles that contain the keyword ‘Love’.
```sql
SELECT title, type, release_year
FROM netflix
WHERE title LIKE '%Love%';
```
### 18.Retrieve the number of content items for each country and content type, and display the top results based on count.
```sql
SELECT country, type, COUNT(*) AS total
FROM netflix
WHERE country IS NOT NULL
GROUP BY country, type
ORDER BY total DESC
LIMIT 10;
```

## Findings and Conclusion
### Content Distribution:
The dataset contains a diverse range of movies and TV shows with varying ratings and genres.
### Common Ratings: 
Insights into the most common ratings provide an understanding of the content's target audience.
### Geographical Insights: 
The top countries and the average content releases by India highlight regional content distribution.
### Content Categorization: 
Categorizing content based on specific keywords helps in understanding the nature of content available on Netflix.

This analysis provides a comprehensive view of Netflix's content and can help inform content strategy and decision-making


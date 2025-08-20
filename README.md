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

## Business problems and Solutions
### 1.Count the number of Movies vs TV Shows
```sql
SELECT 
	type,
	COUNT(*) AS total
FROM netflix
GROUP BY type;
```

### 2. Find the most common rating for movies and TV shows
```sql
    SELECT 
        type,rating
      FROM(
      SELECT
      type,rating,
        COUNT(*) AS rating_count,
      RANK() OVER (PARTITION BY type ORDER BY COUNT(*) DESC) AS rnk
    FROM netflix
    GROUP BY type, rating
) AS ranked WHERE rnk=1;
```
### 3. List all movies released in a specific year (e.g., 2020)
```sql
SELECT * 
FROM netflix
WHERE release_year = 2020;
```

### 4. Find the top 5 countries with the most content on Netflix
```sql
	SELECT 
		 country,
		COUNT(*) AS total_content
	FROM netflix
WHERE country IS NOT NULL
GROUP BY country
ORDER BY total_content DESC
LIMIT 5;
```
### 5. Identify the longest movie
```sql
SELECT *
FROM netflix
WHERE type = 'Movie'
ORDER BY CAST(SUBSTRING_INDEX(duration, ' ', 1)AS UNSIGNED) DESC
LIMIT 1;
```

### 6. Find content added in the last 5 years
```sql
SELECT
*
FROM netflix
WHERE STR_TO_DATE(date_added, '%M %d, %Y') >= DATE_SUB(CURDATE(), - INTERVAL 5 YEAR);
```

### 7. Find all the movies/TV shows by director 'Rajiv Chilaka'!
```sql
SELECT *
FROM netflix
WHERE	FIND_IN_SET('Rajiv Chilaka',REPLACE(director, ',', ','))>0;
```
### 8. List all TV shows with more than 5 seasons
```sql
SELECT *
FROM netflix
WHERE type = 'TV Show'
  AND CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) > 5;
```
### 9. Count the number of content items in each genre
```sql
SELECT listed_in, COUNT(*) AS total_content
FROM netflix
GROUP BY listed_in;
```
### 10. Find each year and the average numbers of content release by India on netflix.Return top 5 year with highest avg content release !
```sql
SELECT 
    country,
    release_year,
    COUNT(show_id) AS total_release,
    ROUND(
        (COUNT(show_id) / (SELECT COUNT(show_id) FROM netflix WHERE country = 'India')) * 100, 2
    ) AS avg_release
FROM netflix
WHERE country = 'India'
GROUP BY country, release_year
ORDER BY avg_release DESC
LIMIT 5;
```

### 11. List all movies that are documentaries
```sql
SELECT *
FROM netflix
WHERE listed_in LIKE '%Documentaries%';
```

### 12. Find all content without a director
```sql
SELECT * FROM netflix
WHERE director IS NULL;
```
### 13. Find how many movies actor 'Salman Khan' appeared in last 10 years
```sql
SELECT *
FROM netflix
WHERE cast LIKE '%Salman Khan%'
  AND release_year > YEAR(CURDATE()) - 10;
```
### 14. Find the top 10 actors who have appeared in the highest number of movies produced in India.
```sql
SELECT cast, COUNT(*) AS appearances
FROM netflix
WHERE country = 'India'
  AND cast IS NOT NULL
GROUP BY cast
ORDER BY appearances DESC
LIMIT 10;
```
### 15. Categorize the content based on the presence of the keywords 'kill' and 'violence' in the description field. Label content containing these keywords as'Bad' and all other content as 'Good'. Count how many items fall into each category.
```sql
SELECT 
    category,
    type,
    COUNT(*) AS content_count
FROM (
 SELECT *,
    CASE 
        WHEN LOWER(description) LIKE '%kill%' OR LOWER(description) LIKE '%violence%' THEN 'Bad'
        ELSE 'Good'
    END AS category
FROM netflix
) AS categorized_content
GROUP BY category, type
ORDER BY type;
```

### 16.List oldest movies on netflix.
```sql
SELECT title, release_year
FROM netflix
WHERE type = 'Movie'
ORDER BY release_year ASC
LIMIT 10;
```
### 17.Titles containing specific keyword "Love".
```sql
SELECT title, type, release_year
FROM netflix
WHERE title LIKE '%Love%'
ORDER BY release_year DESC;
```
### 18.List top 5 countries producing TV shows vs Movies.
```sql
SELECT country, type, COUNT(*) AS total
FROM netflix
WHERE country IS NOT NULL
GROUP BY country, type
ORDER BY total DESC
LIMIT 15;
```

## Findings and Conclusion
### Content Distribution:The dataset contains a diverse range of movies and TV shows with varying ratings and genres.
### Common Ratings: 
Insights into the most common ratings provide an understanding of the content's target audience.
### Geographical Insights: 
The top countries and the average content releases by India highlight regional content distribution.
### Content Categorization: 
Categorizing content based on specific keywords helps in understanding the nature of content available on Netflix.

This analysis provides a comprehensive view of Netflix's content and can help inform content strategy and decision-making


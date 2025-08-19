-- Netflix Data Analysis using SQL
-- Solutions of 18 business problems
-- 1. Count the number of Movies vs TV Shows

SELECT 
	type,
	COUNT(*) AS total
FROM netflix
GROUP BY type;

-- 2. Find the most common rating for movies and TV shows

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

-- 3. List all movies released in a specific year (e.g., 2020)

SELECT * 
FROM netflix
WHERE release_year = 2020;


-- 4. Find the top 5 countries with the most content on Netflix

	SELECT 
		 country,
		COUNT(*) AS total_content
	FROM netflix
WHERE country IS NOT NULL
GROUP BY country
ORDER BY total_content DESC
LIMIT 5;

-- 5. Identify the longest movie

SELECT *
FROM netflix
WHERE type = 'Movie'
ORDER BY CAST(SUBSTRING_INDEX(duration, ' ', 1)AS UNSIGNED) DESC
LIMIT 1;


-- 6. Find content added in the last 5 years
SELECT
*
FROM netflix
WHERE STR_TO_DATE(date_added, '%M %d, %Y') >= DATE_SUB(CURDATE(), - INTERVAL 5 YEAR);


-- 7. Find all the movies/TV shows by director 'Rajiv Chilaka'!

SELECT *
FROM netflix
WHERE	FIND_IN_SET('Rajiv Chilaka',REPLACE(director, ',', ','))>0;

-- 8. List all TV shows with more than 5 seasons

SELECT *
FROM netflix
WHERE type = 'TV Show'
  AND CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) > 5;

-- 9. Count the number of content items in each genre

SELECT listed_in, COUNT(*) AS total_content
FROM netflix
GROUP BY listed_in;

-- 10. Find each year and the average numbers of content release by India on netflix. 
-- return top 5 year with highest avg content release !

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

-- 11. List all movies that are documentaries
SELECT *
FROM netflix
WHERE listed_in LIKE '%Documentaries%';

-- 12. Find all content without a director

SELECT * FROM netflix
WHERE director IS NULL OR director=";
	
-- 13. Find how many movies actor 'Salman Khan' appeared in last 10 years

SELECT *
FROM netflix
WHERE cast LIKE '%Salman Khan%'
  AND release_year > YEAR(CURDATE()) - 10;

-- 14. Find the top 10 actors who have appeared in the highest number of movies produced in India.

SELECT cast, COUNT(*) AS appearances
FROM netflix
WHERE country = 'India'
  AND cast IS NOT NULL
GROUP BY cast
ORDER BY appearances DESC
LIMIT 10;

/*
Question 15:
Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
the description field. Label content containing these keywords as 'Bad' and all other 
content as 'Good'. Count how many items fall into each category.
*/

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

-- 16.

	




-- End of reports

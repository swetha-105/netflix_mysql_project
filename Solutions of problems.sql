-- Netflix Data Analysis using SQL
-- Solutions of 18 business problems
-- 1. Count the number of Movies vs TV Shows

SELECT type, COUNT(*) AS total
FROM netflix
GROUP BY type;

-- 2. Find the total number of content items for each rating within each content type and sort them by highest count.

SELECT type, rating, COUNT(*) AS total
FROM netflix
GROUP BY type, rating
ORDER BY type, total DESC;

-- 3. Retrieve all content released in the year 2020 from the Netflix dataset.

SELECT * 
FROM netflix
WHERE release_year = 2020;


-- 4. Retrieve the top 5 countries with the highest number of content items in the dataset.

SELECT country, COUNT(*) AS total
FROM netflix
WHERE country IS NOT NULL
GROUP BY country
ORDER BY total DESC
LIMIT 5;

-- 5. Find the movie with the maximum duration from the dataset.

SELECT title, duration
FROM netflix
WHERE type = 'Movie'
ORDER BY CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) DESC
LIMIT 1;


-- 6.Retrieve all content that was added to Netflix in the last 5 years.
SELECT *
FROM netflix
WHERE date_added >= CURDATE() - INTERVAL 5 YEAR;


-- 7. Retrieve all content directed by 'Rajiv Chilaka' from the dataset.

SELECT *
FROM netflix
WHERE director LIKE '%Rajiv Chilaka%';

-- 8. Retrieve all TV shows that have more than 5 seasons.

SELECT *
FROM netflix
WHERE type = 'TV Show'
AND CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) > 5;

-- 9. Count the number of content items in each genre category as listed in the dataset.

SELECT listed_in, COUNT(*) AS total_content
FROM netflix
GROUP BY listed_in;

-- 10. Find the number of content items released each year in India and return the top 5 years with the highest count.

SELECT release_year, COUNT(*) AS total
FROM netflix
WHERE country = 'India'
GROUP BY release_year
ORDER BY total DESC
LIMIT 5;

-- 11. Retrieve all content that belongs to the ‘Documentaries’ category.
SELECT *
FROM netflix
WHERE listed_in LIKE '%Documentaries%';

-- 12. Retrieve all content that does not have a director specified.

SELECT * 
FROM netflix
WHERE director IS NULL;

--13. Find the total number of movies featuring actor ‘Salman Khan’ released in the last 10 years.
SELECT COUNT(*) AS total_movies
FROM netflix
WHERE casts LIKE '%Salman Khan%'
AND type = 'Movie'
AND release_year >= YEAR(CURDATE()) - 10;

-- 14. Find the top 10 cast entries with the highest number of content items produced in India.

SELECT casts, COUNT(*) AS total
FROM netflix
WHERE country = 'India'
AND casts IS NOT NULL
GROUP BY casts
ORDER BY total DESC
LIMIT 10;

--15. Classify content as ‘Bad’ or ‘Good’ based on keywords in the description and count the number of items in each category.

SELECT 
CASE 
    WHEN description LIKE '%kill%' OR description LIKE '%violence%' THEN 'Bad'
    ELSE 'Good'
END AS category,
COUNT(*) AS total
FROM netflix
GROUP BY category;

-- 16.Retrieve the top 10 oldest movies based on release year from the dataset.

SELECT title, release_year
FROM netflix
WHERE type = 'Movie'
ORDER BY release_year ASC
LIMIT 10;

--17.Retrieve all content titles that contain the keyword ‘Love’.

SELECT title, type, release_year
FROM netflix
WHERE title LIKE '%Love%';

--18. Retrieve the number of content items for each country and content type, and display the top results based on count.

SELECT country, type, COUNT(*) AS total
FROM netflix
WHERE country IS NOT NULL
GROUP BY country, type
ORDER BY total DESC
LIMIT 10;



	




-- End of reports

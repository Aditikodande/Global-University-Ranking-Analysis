create database global_ranking;
use global_ranking;



CREATE TABLE university_rankings (
    university_ranking FLOAT,
    University VARCHAR(255),
    Country VARCHAR(100),
    Region VARCHAR(100),
    City VARCHAR(100),
    Overall_Score FLOAT,
    Rank_Category VARCHAR(50),
    Score_Category VARCHAR(50),
    Continent VARCHAR(50)
);
drop table university_rankings;

-- 1. Top 10 Universities


SELECT University, Overall_Score
FROM university_rankings
ORDER BY Overall_Score DESC
LIMIT 10;

-- 2. Top Countries by Number of Universities


SELECT Country, COUNT(*) AS total_universities
FROM university_rankings
GROUP BY Country
ORDER BY total_universities DESC;



-- 3. Average Score by Continent


SELECT Continent, AVG(Overall_Score) AS avg_score
FROM university_rankings
GROUP BY Continent
ORDER BY avg_score DESC;



-- 4. Top 3 Universities per Country


SELECT Country, University, Overall_Score
FROM (
    SELECT Country, University, Overall_Score,
           RANK() OVER (PARTITION BY Country ORDER BY Overall_Score DESC) AS rnk
    FROM university_rankings
) t
WHERE rnk <= 3;

 -- 5. Rank Within Each Continent

SELECT Continent, University, Overall_Score,
       DENSE_RANK() OVER (PARTITION BY Continent ORDER BY Overall_Score DESC) AS rank_in_continent
FROM university_rankings;


-- 6. Best Cities (Highest Average Score)


SELECT City, AVG(Overall_Score) AS avg_score
FROM university_rankings
GROUP BY City
ORDER BY avg_score DESC
LIMIT 10;


-- 7. Universities Above Global Average


SELECT University, Country, Overall_Score
FROM university_rankings
WHERE Overall_Score > (
    SELECT AVG(Overall_Score) FROM university_rankings
);

-- 8. Top 100 Universities Analysis (by Continent)

SELECT Continent, COUNT(*) AS total_universities
FROM university_rankings
WHERE university_ranking <= 100
GROUP BY Continent
ORDER BY total_universities DESC;

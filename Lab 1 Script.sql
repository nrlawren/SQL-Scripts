-- Lab 1 Script
-- Nash Lawrence 1/20/22

USE world;

-- Select all columns from the city table
SELECT * FROM world.city;

-- What are the countries in the world with the longest life expectancies?
SELECT name, region, continent, lifeexpectancy
FROM country
ORDER BY lifeexpectancy DESC;

-- What cities in the world have the largest populations?
SELECT city.name AS 'city name', country.name AS 'country name', region, continent, country.Population
FROM country, city
WHERE country.Code = city.countrycode
ORDER BY Population DESC;

-- What are the largest countires in land mass (Surface Area)?
SELECT name, region, continent, surfaceArea
FROM country
ORDER BY surfaceArea DESC;

-- Which English speaking countries in the world have the higest GNP?
SELECT name AS 'country name', region, continent, language, GNP
FROM country, countrylanguage
WHERE country.Code = countrylanguage.Countrycode
AND Language = 'English'
ORDER BY GNP DESC;

-- What countries in North America have the largest life expectancy?
SELECT name AS 'country name', continent, lifeexpectancy
FROM country
WHERE continent = 'North America'
ORDER BY lifeexpectancy DESC;

-- What countries on the continent Africa have the largest land mass?
SELECT name AS 'country name', continent, region, surfaceArea
FROM country
WHERE continent = 'Africa'
ORDER BY surfaceArea DESC;

-- Which English speaking countries in the world have the lowest GNP?
SELECT name AS 'country name', region, continent, language, GNP
FROM country, countrylanguage
WHERE country.Code = countrylanguage.CountryCode
AND Language = 'English'
ORDER BY GNP;

-- What countries have the smallest surface area?
SELECT name AS 'country name', region, continent, surfaceArea
FROM country
ORDER BY surfaceArea;

-- What Republic countries have the lowest GNP?
SELECT name AS 'country name', GovernmentForm, GNP
FROM country
WHERE GovernmentForm = 'Republic'
ORDER BY GNP;

-- Which country in Southern Europe has the highest population?
SELECT name AS 'country name', region, continent, population
FROM country
WHERE region = 'Southern Europe'
ORDER BY population DESC;

SELECT country.name AS 'Country Name', city.Name AS 'City Name', GNP,  SUM(city.Population) AS totalpopulation
FROM city INNER JOIN country
ON city.countrycode = country.code
GROUP By country.Name
HAVING totalpopulation > 100000000
ORDER BY country.name, city.name;

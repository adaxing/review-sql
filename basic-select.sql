-- Million is 10^6 => 1,000,000 
-- Billion is 10^9 => 1,000,000,000 
-- Trillion is 10^12 => 1,000,000,000,000

SELECT attribute-list
   FROM table-name
   WHERE condition

--attribute-list
    -- a comma separated list of attributes
    -- string values concatenated using || 
    -- select all using *
--condition
    -- a boolean expression
    -- operators include AND, OR, XOR(not both), NOT, >, >=, =, <, <=
        -- AND to ensure that two or more conditions hold true.
        -- IN allows us to check if an item is in a list.
        -- LIKE permits pattern matching - %, _ is the wildcard; _ => single char, % => sequence of char
            -- NOT LIKE '%char' to exclude char
        -- BETWEEN allows range checking - note that it is inclusive.
        -- ROUND(f,p) returns f rounded to p decimal places
            -- nearest 10 = p is -1
            -- nearest 100 = p is -2 
            -- nearest 1 = p is 0
            -- nearest .1 = p is 1
            -- nearest .01 = p is 2
        -- LENGTH(s) returns the number of characters in string s
        -- LEFT(s,n) extract n characters from the start of the string 
        -- <> as NOT EQUALS operator

------------------------------------------------------------------------------
--WHERE filters
--The population of 'France'. Strings should be in 'single quotes'
SELECT population 
    FROM bbc
        WHERE name = 'France';
--The names and population densities for the very large countries.
SELECT name, population/area 
    FROM bbc
        WHERE area > 5000000;
--Where to find some very small, very rich countries.
SELECT name , region
  FROM bbc
    WHERE area < 2000 AND 
        gdp > 5000000000;
--Which of Ceylon, Iran, Persia and Sri Lanka is the name of a country?
SELECT name 
    FROM bbc
        WHERE name IN ('Sri Lanka', 'Ceylon', 'Persia', 'Iran');
--What are the countries beginning with D? 
SELECT name 
    FROM bbc
        WHERE name LIKE 'D%';
--Which countries are not too small and not too big? 
SELECT name, area 
    FROM bbc
        WHERE area BETWEEN 207600 AND 244820;
------------------------------------------------------------------------------
world(name, continent, area, population, gdp)
--1. Show the name and the population for 'Sweden', 'Norway' and 'Denmark'.
SELECT name, population 
    FROM world
        WHERE name IN ('Sweden', 'Norway', 'Denmark');

--2. Show the name for the countries that have a population of at least 200 million.
SELECT name 
    FROM world
        WHERE population >= 200000000;
--3. Give the name and the per capita GDP for those countries with a population of at least 200 million.
SELECT name, gdp/population 
    FROM world 
        WHERE population >= 200000000;
--4. Show the name and population in millions for the countries of the continent 'South America'. Divide the population by 1000000 to get population in millions.
SELECT name, population/1000000 
    FROM world 
        WHERE continent = 'South America';
--5. Show the countries which have a name that includes the word 'United'
SELECT name 
    FROM world 
        WHERE name LIKE ('%United%');
--6. [Two ways to be big] Show the countries that are big by area or big by population. Show name, population and area.
SELECT name, population, area 
    FROM world 
        WHERE area > 3000000 OR 
            population > 250000000;
--7. [One or the other (but not both)] Show the countries that are big by area or big by population but not both. Show name, population and area.
SELECT name, population, area 
    FROM world 
        WHERE area > 3000000 XOR 
            population > 250000000;
--8. [ROUNDING]For South America show population in millions and GDP in billions both to 2 decimal places.
SELECT name, ROUND(population/1000000, 2), ROUND(gdp/1000000000, 2) 
    FROM world 
        WHERE continent = 'South America'; 
--9. Show per-capita GDP for the trillion dollar countries to the nearest $1000.
SELECT name,ROUND(gdp/population, -3) 
    FROM world 
        WHERE gdp >= 1000000000000;
--10. Show the name and capital where the name and the capital have the same number of characters.
SELECT name,  capital
    FROM world
        WHERE LENGTH(name) = LENGTH(capital);
--11. Show the name and the capital where the first letters of each match. Don't include countries where the name and the capital are the same word.
SELECT name, capital
    FROM world 
        WHERE LEFT(name, 1) = LEFT(capital, 1)  AND 
            name <> capital;
--12. Find the country that has all the vowels and no spaces in its name.
SELECT name
   FROM world
        WHERE name LIKE '%a%' AND 
            name LIKE '%e%' AND 
                name LIKE '%i%' AND 
                    name LIKE '%o%' AND 
                        name LIKE '%u%' AND 
                            name NOT LIKE '% %';


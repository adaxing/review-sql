-- Aggregate function: take many values and just deliver one value
    -- COUNT(), SUM(), AVG(), MAX(), MIN()
-- all columns must be "aggregated" by one of SUM, COUNT, AVG..
-- DISTINCT is to remove duplicates
-- ORDER BY is to turn result in any particular order; ASC(ascending order) or DESC
-- GROUP BY itself return result is you get only one row for each different value
-- HAVING allow use to filter the groups, filter after aggregation
-- WHERE filter rows before aggregation


--------------------- EXAMPLE ------------------------------
-- a. The total population and GDP of Europe.
SELECT SUM(population), SUM(gdp)
    FROM bbc
        WHERE region = 'Europe';
-- b. What are the regions?
SELECT DISTINCT region FROM bbc;
-- c. Show the name and population for each country with a population of more than 100000000. Show countries in descending order of population.
SELECT name, population
    FROM bbc
        WHERE population > 100000000
        ORDER BY population DESC;
-- d. For each continent show the number of countries:
SELECT continent, COUNT(name)
    FROM world
    GROUP BY continent;   
-- e. For each continent show the total population:
SELECT continent, SUM(population)
    FROM world
    GROUP BY continent;
-- f. [WHERE before GROUP BY]For each relevant continent show the number of countries that has a population of at least 200000000.
SELECT continent, COUNT(name)
    FROM world
    WHERE population>200000000
    GROUP BY continent;
-- g. [HAVING after GROUP BY]Show the total population of those continents with a total population of at least half a billion.
SELECT continent, SUM(population)
    FROM world
    GROUP BY continent
    HAVING SUM(population)>500000000;
-----------------------------------------------------------------
--1. Show the total population of the world.
SELECT SUM(population)
    FROM world;
--2. List all the continents - just once each.
SELECT DISTINCT(continent) 
    FROM world;
--3. Give the total GDP of Africa
SELECT SUM(gdp)
    FROM world
        WHERE continent = 'Africa';
--4. How many countries have an area of at least 1000000
SELECT COUNT(name)
    FROM world
        WHERE area >= 1000000;
--5. What is the total population of ('Estonia', 'Latvia', 'Lithuania')
SELECT SUM(population)
    FROM world 
        WHERE name in ('Estonia', 'Latvia', 'Lithuania');
--6. For each continent show the continent and number of countries.
SELECT continent, COUNT(name)
    FROM world
        GROUP BY continent;
--7. For each continent show the continent and number of countries with populations of at least 10 million.
SELECT continent, COUNT(name)
    FROM world
        GROUP BY continent
        HAVING SUM(population) >= 10000000;
--8. List the continents that have a total population of at least 100 million.
SELECT continent 
    FROM world
        GROUP BY continent
        HAVING SUM(population) >= 100000000;
--9. Show the total number of prizes awarded for Physics.
SELECT COUNT(winner)
    FROM nobel
        WHERE subject='Physics';
--10. For each subject show the subject and the number of prizes.
SELECT subject, COUNT(winner) as prizes
    FROM nobel
        GROUP BY subject;
--11. For each subject show the first year that the prize was awarded.
SELECT subject, MIN(yr)
    FROM nobel
        GROUP BY subject;  
--12. For each subject show the number of prizes awarded in the year 2000.
SELECT subject, COUNT(winner)
    FROM nobel
        WHERE yr= 2000
            GROUP BY subject;
--13. Show the number of different winners for each subject.
SELECT subject, COUNT(DISTINCT(winner))
    FROM nobel
        GROUP BY subject;
--14. For each subject show how many years have had prizes awarded.
SELECT subject, COUNT(DISTINCT(yr))
    FROM nobel
        GROUP BY subject;
--15. Show the years in which three prizes were given for Physics.
SELECT yr
    FROM nobel x
        WHERE subject = 'Physics'
            GROUP BY yr
            HAVING COUNT(winner) =3;
--16. Show winners who have won more than once.
SELECT DISTINCT(winner)
    FROM nobel x
        WHERE 1< (
            SELECT COUNT(*) 
                FROM nobel y 
                    WHERE x.winner = y.winner);
--17. Show winners who have won more than one subject.
SELECT DISTINCT(winner)
    FROM nobel x
        WHERE 1< (
            SELECT COUNT(DISTINCT(subject)) 
            FROM nobel y WHERE x.winner = y.winner)
--18. Show the year and subject where 3 prizes were given. Show only years 2000 onwards.
SELECT yr, subject 
    FROM nobel x
        WHERE  yr>=2000 
            GROUP BY yr, subject
            HAVING COUNT(winner) = 3;








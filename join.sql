-- Join allows you to use data from two or more tables
-- example 
    SELECT element
        FROM tableA JOIN tableB ON (tableA.id = tableB.id)
-- FROM JOIN clause is to merge data from tableA with that from tableB
-- ON is to figure out how rows in tableA go with rows in tableB 
-- CASE allows to return different values under different conditions
    -- if no conditions match, then NULL is returned
    CASE WHEN condition1 THEN value1 
       WHEN condition2 THEN value2  
       ELSE def_value 
    END 
--------------------- Table --------------------------
-- game.id = goal.matchid  game.team1/team2 = goal.teamid = eteam.id
game(id, mdate, stadium, team1, team2)
goal(matchid, teamid, player, gtime)
eteam(id, teamname, coach)

--1. Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'
SELECT team1, team2, player  
    FROM game JOIN goal ON (game.id = goal.matchid)
        WHERE goal.player LIKE 'Mario%';
--2. Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10
SELECT player, teamid, coach, gtime
    FROM goal JOIN eteam ON (goal.teamid = eteam.id)
        WHERE gtime<=10;
--3. List the the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.
SELECT mdate, teamname
    FROM game JOIN eteam ON (team1=eteam.id)
        WHERE eteam.coach = 'Fernando Santos'；
--4. List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'
SELECT player
    FROM game JOIN goal ON (game.id = goal.matchid)
        WHERE game.stadium = 'National Stadium, Warsaw'；
--5. show the name of all players who scored a goal against Germany.
SELECT DISTINCT(player)
    FROM game JOIN goal ON (matchid = id)
        WHERE (teamid = team1 AND teamid != 'GER' AND team2='GER') OR
            (teamid = team2 AND teamid != 'GER' AND team1='GER');
OR 
SELECT DISTINCT(player)
    FROM game JOIN goal ON (matchid = id)
        WHERE (teamid = team1  AND team2='GER') OR
            (teamid = team2 AND team1='GER') AND
                teamid != 'GER';
--6. Show teamname and the total number of goals scored.
SELECT teamname, COUNT(*)
    FROM eteam JOIN goal ON id=teamid
        GROUP BY teamname;
--7. Show the stadium and the number of goals scored in each stadium.
SELECT stadium, COUNT(*)
    FROM game JOIN goal ON (id=matchid)
        GROUP BY stadium;
--8. For every match involving 'POL', show the matchid, date and the number of goals scored.
SELECT matchid,mdate, COUNT(teamid)
    FROM game JOIN goal ON matchid = id 
        WHERE (team1 = 'POL' OR team2 = 'POL')
            GROUP BY matchid, mdate;
--9. For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'
SELECT matchid, mdate, COUNT(teamid)
    FROM game JOIN goal ON (matchid = id)
        WHERE teamid = 'GER'
            GROUP BY matchid, mdate;
--10. List every match with the goals scored by each team as shown. 
SELECT mdate, team1, 
    SUM(
        CASE WHEN teamid=team1 THEN 1 
            ELSE 0 
        END) AS score1, 
    team2, 
    SUM(
        CASE WHEN teamid=team2 THEN 1 
            ELSE 0 
        END) AS score2
    FROM game LEFT JOIN goal ON id = matchid
        GROUP BY mdate, team1, team2
            ORDER BY mdate,matchid, team1, team2;

--------------------- Table --------------------------
-- ttms.country = country.id
-- ttms.games shows year; ttms.color shows gold, silver.. ; country.name shows country full name
ttms(games, color, who, country)
contry(id, name)

--1. Show the athelete (who) and the country name for medal winners in 2000.
SELECT who, country.name
    FROM ttms JOIN country ON (ttms.country=country.id)
        WHERE games = 2000;
--2. Show the who and the color of the medal for the medal winners from 'Sweden'.
SELECT who, color
    FROM ttms JOIN country ON (ttms.country = country.id)
        WHERE country.name = 'Sweden';
--3. Show the years in which 'China' won a 'gold' medal.
SELECT games
    FROM ttms JOIN country ON (ttms.country = country.id)
        WHERE country.name = 'China' AND ttms.color = 'gold'
--------------------- Table --------------------------
-- ttws.games = games.yr ttws.country = games.country
ttws(games, color, who, country)
games(yr, city, country)

--1. Show who won medals in the 'Barcelona' games.
SELECT who
    FROM ttws JOIN games ON (ttws.games=games.yr)
        WHERE city = 'Barcelona';
--2. Show which city 'Jing Chen' won medals. Show the city and the medal color
SELECT city, color
    FROM ttws JOIN games ON (ttws.games = games.yr)
        WHERE who='Jing Chen';
--3. Show who won the gold medal and the city.
SELECT who, city
    FROM ttws JOIN games ON (ttws.games = games.yr)
        WHERE color = 'gold';
--------------------- Table --------------------------
-- ttmd.team = team.id
ttmd(games, color, team, country)
team(id, name)

--1. Show the games and color of the medal won by the team that includes 'Yan Sen'.
select games, color 
    FROM ttmd JOIN team ON (ttmd.team = team.id)
        WHERE team.name = 'Yan Sen';
--2. Show the 'gold' medal winners in 2004.
SELECT name
    FROM ttmd JOIN team ON (team = id)
        WHERE color = 'gold' AND games= 2004;
--3. Show the name of each medal winner country 'FRA'.
SELECT name
    FROM ttmd JOIN team ON (team=id)
        WHERE country = 'FRA';


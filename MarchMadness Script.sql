/* Nash Lawrence
2022 NCAA Mens Basketball Tournament Data
Database: ncaatournament
Tables: teams, players
'teams' table has all 68 teams specified with a unique team id, and their rankings, averages in various metrics/statistics
'players' table has statistics and physical attributes of all healthy players averaging over 5 minutes played per game for all 68 teams, specified by a unique player id
The tables are connected through the player team id, which is the foreign key in the players dataset
The primary key in 'teams' is 'team_id', the primary key in 'players' is 'player_id' */

-- Tell SQL to use the ncaatournament schema/database
USE ncaatournament;

-- Declare Primary/Foreign keys
ALTER TABLE teams ADD PRIMARY KEY(team_id);
ALTER TABLE players ADD PRIMARY KEY(player_id);
ALTER TABLE players ADD CONSTRAINT FK_teams FOREIGN KEY(team_id) REFERENCES teams(team_id);

-- Every national champion since 1997 has been top 40 in offensive and top 25 in defensive efficiency, list the teams that meet this criteria with their efficiency rankings
SELECT team_name AS 'Team', off_efficiencyRank, def_efficiencyRank
FROM teams
WHERE off_efficiencyRank < 41
AND def_efficiencyRank < 26
ORDER BY off_efficiencyRank;

-- To get an idea of who the best players are from smaller schools, list the scoring leaders of teams not in a major 6 conference
SELECT player_team AS 'Team', player_name AS 'Player', ppg_avg
FROM teams, players
WHERE teams.team_id = players.team_id
AND teams.p6_conference = "N"
ORDER BY ppg_avg DESC;

-- Two teams playing each other in the first round are Yale and Purdue, list all the data involving these two teams statistics/metrics
SELECT * FROM teams
WHERE team_name = "Purdue"
OR team_name = "Yale";

-- display the amount of teams each conference has in the tournament, in order of highest to lowest amount
SELECT team_conference, COUNT(team_conference) AS "TotalTeams"
FROM teams
GROUP BY team_conference
ORDER BY TotalTeams DESC;

-- experience is key in March, list the number of seniors on each teams starting lineup from highest to lowest
SELECT player_team, COUNT(player_year) AS 'Classification'
FROM players
WHERE player_year = "Sr"
AND starting_player = "Y"
GROUP BY player_team
ORDER BY Classification DESC;

-- find all teams that start with the letter 'A'
SELECT team_name AS 'Team' 
FROM teams
WHERE team_name LIKE 'A%';


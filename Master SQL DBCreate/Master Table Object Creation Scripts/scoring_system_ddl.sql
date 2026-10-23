-- 8/12/24: adding scoring system descriptions to help explain what the scoring systems are for the various tourneys.dcf 

create table scoring_system 
(scoring_system_id integer not null,
scoring_system_desc varchar(255));

-- first, build in all known Racquetball scoring systems
insert into scoring_system values (101,'First 2 Games to 15, tie-breaker to 11, win by one all games.  USAR standard Rules 1982-present');
insert into scoring_system values (102,'First 2 Games to 15, tie-breaker to 11, all games win by two.  Racquetball Canada mod to USAR standard Rules');
insert into scoring_system values (103,'Best 3 out of 5 games to 11, all games win by two.  IRT Standard rules 1991-2017');
insert into scoring_system values (104,'Best 3 out of 5 games to 11, first four games win by one, final game win by two.  IRT standard Rules 1989-1991');
insert into scoring_system values (105,'Best 3 out of 5 games to 11, all games win by one.  Mens Pro standard Rules 1981-1989');
insert into scoring_system values (106,'First 2 games to 21, tiebreaker 11, all games win by one.  NRC/IRA standard scoring 1976-1981');
insert into scoring_system values (107,'Best 2 of 3 games to 21, all games win by one.  NRC/IRA standard scoring from origins of sport to 1976');

-- Pickleball
insert into scoring_system values (201,'PPA Mar 2024-present: Best of 3 to 11, win by two. Single elimination until semis, then semi losers compete for Bronze medal.  Gold medal 3 of 5 to 11.');
insert into scoring_system values (202,'APP Jan 2024-present: Doubles Best of 3 to 11, win by two, Singles rally scoring best of 3 to 15.  Early round losers drop to 9th place draw.  Winner bracket semi losers compete for Bronze medal.');
insert into scoring_system values (203,'USAP standard scoring: Full Double elimination. 2 out of 3 to 11 in winner bracket, one game to 15 in losers bracket.  Winner of LB plays back into final.');
insert into scoring_system values (204,'PPA ? - Mar 2024: Main Draw single elim 2 out of 3 to 11, win by 2.  First round main draw losers drop to Bonus Draw, Qualifying losers drop to Points draw, both one-game to 15.  Semis losers compete for bronze.  Gold medal 3 out of 5 to 11.');
-- insert into scoring_system values (205,'Main Draw singles rally scoring 2 out of 3 to 15 win by two.  APP standard singles main draw rules 2024-present');
-- insert into scoring_system values (206,'Singles Pro Qualifying, 9th Place, and Points draw: rally scoring one game to 21 win by two.  APP standard singles non main draw rules 2024-present');
insert into scoring_system values (207,'MLP 2024 season: Doubles games to 25, rally scoring, win by two.  DreamBreaker to 21 win by two.  No Freeze.');
insert into scoring_system values (208,'MLP 2023 Season: Doubles games to 21, rally scoring, win by two, freeze at 20, must win on serve.  DreamBreaker to 21 win by two.');
insert into scoring_system values (209,'MLP 2022 Season: placeholder');
insert into scoring_system values (210,'PPA Tour Finals Format: Two Round robin groups of four, top 2 to single elimination knockout, no bronze/3rd place');
insert into scoring_system values (211,'USAP modified standard scoring: Full double elimination to Loser bracket final, which determines bronze medal.  ');
insert into scoring_system values (212,'Round Robin single pass, with no advancing to knockouts.  Each team players the other once.  Standings and medals determined by full round robin results');
insert into scoring_system values (213,'Round Robin double pass, with no advancing to knockouts.  Each team plays the other twice. Standings and medals determined by full round robin results');


select scoring_system_id from tourneys_doubles;
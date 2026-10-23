-- 11/21/18: createing team_results and staging table to store IRF team results.

use cp30725_irf;

drop table team_results;

create table team_results (
Country	varchar(100),
position int,
points	int,
Division varchar(25),
City varchar(100),
Event	varchar(255),
Date	varchar(10),
Source	varchar(255),
Season varchar(10),
tmp_date date
);

drop table team_results_staging;

create table team_results_staging as select * from team_results where 1=2;

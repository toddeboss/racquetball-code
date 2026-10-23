# 5/10/14: created temporary holding table to assist with tour depth/missed tournament analysis

create table missed_tourney_rpt
(season varchar(10),
player varchar(100),
missed integer)

select * from missed_tourney_rpt order by player;

truncate table missed_tourney_rpt;
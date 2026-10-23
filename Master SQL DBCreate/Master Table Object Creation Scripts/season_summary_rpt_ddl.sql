# 5/27/08: creation of this table to assist with a report generation.

# 5/9/14: modifying table to also contain a round of 256

--use wwwbossconsultingcom;

use cp30725_men;

drop table season_summary_rpt;

create table season_summary_rpt
(player varchar(50),
wins integer,
finals integer,
semis integer,
quarters integer,
sixteens integer,
thirtytwos integer,
sixtyfours integer,
onetwentyeights integer,
twofiftysixes integer);

select * from season_summary_rpt;
delete from season_summary_rpt;

insert into season_summary_rpt values ('Alder,D',0,0,2,3,0,4,0,0,0);

select * from season_summary_rpt order by wins,finals,semis,quarters,sixteens,thirtytwos,sixtyfours,onetwentyeights;

select player,wins,finals,semis,quarters,sixteens,thirtytwos,sixtyfours,onetwentyeights from season_summary_rpt 
order by wins,finals,semis,quarters,sixteens,thirtytwos,sixtyfours,onetwentyeights;

-- clean out after testing, ready for prod usage
delete from season_summary_rpt;
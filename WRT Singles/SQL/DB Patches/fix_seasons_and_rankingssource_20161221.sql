-- Various season and rankings patches

select * from results where season='2013';

create table results_20161213 as select * from results;

update results set season='2013' where season like '2013%';

update results set season='2014' where season like '2014%';

update results set season='2015' where season like '2015%';

select '~' || season || '~', count(*) from results group by season;


select * from rankings;

insert into rankings_source (season,source) values ('2016','worldracquetballtour.com as of 12/21/16');
insert into rankings_source (season,source) values ('2015','missing');
insert into rankings_source (season,source) values ('2014','missing');
insert into rankings_source (season,source) values ('2013','missing');
insert into rankings_source (season,source) values ('2012','n/a');


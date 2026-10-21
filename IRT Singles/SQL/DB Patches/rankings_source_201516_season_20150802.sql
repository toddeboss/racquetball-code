show tables;

select * from rankings_source order by season desc;

update rankings_source set source='IRT Website 6/16/16' where season='2015-16';

insert into rankings_source values ('2016-17','Season not complete; no rankings yet');
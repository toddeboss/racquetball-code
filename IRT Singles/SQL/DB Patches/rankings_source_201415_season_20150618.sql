show tables;

select * from rankings_source order by season desc;

update rankings_source set source='IRT Website 5/31/15' where season='2014-15';


insert into rankings_source values ('2015-16','Season not complete; no rankings yet');
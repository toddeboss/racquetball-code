show tables;

select * from rankings_source order by season desc;

update rankings_source set source='IRT Website 6/11/14' where season='2013-14';

insert into rankings_source values ('2014-15','Season not complete; no rankings yet');
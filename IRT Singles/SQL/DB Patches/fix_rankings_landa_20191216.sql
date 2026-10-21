-- fixing bad Landa entry in rankings

SET SQL_SAFE_UPDATES = 0;


create table rankings_20191216 as select * from rankings;

update rankings set player='Landa, Armando' where player='Landa, Alejandro' and season='2003-4' and points=2;
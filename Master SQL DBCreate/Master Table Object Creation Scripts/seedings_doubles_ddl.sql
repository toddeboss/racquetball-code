

drop table seedings_doubles;

create table seedings_doubles
(event varchar(255),
seeding integer,
player1 varchar(50),
player2 varchar(50)
);

create table seedings_doubles_staging as select * from seedings_doubles;


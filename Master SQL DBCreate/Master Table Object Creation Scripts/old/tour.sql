-- Quickie simple table to hold the name of the tour so the code will key off of it without having to 
-- pass in another variable.

-- create in all three DBs, change as appropriate

create table tour (tourname varchar(10));

insert into tour values ('IRT');
commit;

insert into tour values ('LPRT');
commit;

insert into tour values ('WRT');
commit;
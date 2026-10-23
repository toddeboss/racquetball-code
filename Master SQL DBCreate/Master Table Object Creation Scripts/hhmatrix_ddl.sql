-- hhmatrix table working.

create table hhmatrix (player varchar(50),tour varchar(10),record varchar(10));



truncate table hhmatrix;

insert into hhmatrix values ('Carter, Thomas','IRT','1-0');
insert into hhmatrix values ('Carter, Thomas','IRF','3-1');
insert into hhmatrix values ('Horn, David','IRT','1-0');
insert into hhmatrix values ('Troncoso, Francisco','Amateur','1-0');

select * from  hhmatrix;

select player, 'IRT', 'WRT','IRF','Amateur', 'LPRT' from;


select player, record, null, null, null, null from hhmatrix where tour='IRT';
union all
select player, null, record, null, null, null from hhmatrix where tour='WRT'
union all
select player, null, null, record, null,null from hhmatrix where tour='IRF'
union all
select player, null, null, null, record, null from hhmatrix where tour='Amateur'
union all
select player, null, null, null, null, record from hhmatrix where tour='LPRT';


drop table hhmatrix;

create table hhmatrix (player varchar(50),irt varchar(10),wrt varchar(10),irf varchar(10),amateur varchar(10),lprt varchar(10));


------------------

SET SQL_SAFE_UPDATES = 0;

drop table hhmatrix;

create table hhmatrix (player varchar(50),irt varchar(10),wrt varchar(10),irf varchar(10),amateur varchar(10),lprt varchar(10),total integer);

select * from hhmatrix;

truncate table hhmatrix;

select SUBSTRING(lprt, 1, 1) from hhmatrix where player='Acosta, Susana';

select substring_index(irt,'-',1) from hhmatrix;

select * from hhmatrix where player='Beltran, Alvaro';


select substring_index(irt,'-',1) + substring_index(irt,'-',-1) +
       substring_index(irt,'-',1) + substring_index(irt,'-',-1) +
       substring_index(irt,'-',1) + substring_index(irt,'-',-1) +
       substring_index(irt,'-',1) + substring_index(irt,'-',-1) +
       substring_index(irt,'-',1) + substring_index(irt,'-',-1)
       from hhmatrix where player='Beltran, Alvaro';

update hhmatrix set total=(ifnull(substring_index(irt,'-',1),0) + ifnull(substring_index(irt,'-',-1),0) + ifnull(substring_index(wrt,'-',1),0) + ifnull(substring_index(wrt,'-',-1),0) + ifnull(substring_index(irf,'-',1),0) + ifnull(substring_index(irf,'-',-1),0) + ifnull(substring_index(amateur,'-',1),0) + ifnull(substring_index(amateur,'-',-1),0) + ifnull(substring_index(lprt,'-',1),0) + ifnull(substring_index(lprt,'-',-1),0));      

            
                          
update hhmatrix set total=(ifnull(substring_index(irt,'-',1),0) + ifnull(substring_index(irt,'-',-1),0));                             

select * from hhmatrix;


select player,irt,wrt,irf,amateur,lprt,total from hhmatrix order by total desc;
/* 4/27/09: quick fix to make all the 2008-9 season the same in teh db */

update results set season='2008-9' where season like '2008%';
update results set season='2007-8' where season like '2007%';
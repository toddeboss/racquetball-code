/* 11/20/07: noticed inconsistencies in teh city names */

update results set city = 'Albuequerque, NM' where city='Albuquerque, NM';
update results set city = 'Riverside, CA' where city='Riverside';

update results set city = 'Toronto, Can' where city='Toronto, CA';
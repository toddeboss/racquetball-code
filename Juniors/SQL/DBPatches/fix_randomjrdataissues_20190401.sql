-- random junior data patches.

call sp_fixname ('Meneses, Micaela','Meneses, Micaela');
call sp_fixname ('Meneses, Micaela','Menses, Micaela');
call sp_fixname ('Meneses, Micaela','Meneses Cuellar, Micaela');

call sp_fixname ('Centellas, Valeria','Centellas, Valerie');
call sp_fixname ('Centellas, Valeria','Centellas Claros, Valeria');

-- fixing junior results

create table results_20190401 as select * from results;

select * from results where event='2008 Junior World Championships - Girls 8U';

update results set event='2006 Junior World Championships - Girls 8U' where event='2008 Junior World Championships - Girls 8U' and date='10/31/2006';

update results set event='2007 Junior World Championships - Girls 8U' where event='2008 Junior World Championships - Girls 8U' and date='10/31/2007';

select * from results where event='2014 Junior World Championships - Girls 16U' and source='Tim Baghurst/IRF Summary data research Nov 2017';

delete from results where event='2014 Junior World Championships - Girls 16U' and source='Tim Baghurst/IRF Summary data research Nov 2017';

select * from results where event='2014 Junior World Championships - Girls 18U';

delete from results where event='2014 Junior World Championships - Girls 18U' and source='Tim Baghurst/IRF Summary data research Nov 2017';

select * from results where event='2010 Junior World Championships - Boys 8U';

delete from results where event='2014 Junior World Championships - Boys 18U' and source='Tim Baghurst/IRF Summary data research Nov 2017';

delete from results where event='2013 Junior World Championships - Boys 18U' and source='Tim Baghurst/IRF Summary data research Nov 2017';

create table results_onerow as select distinct * from 
results where event='2010 Junior World Championships - Boys 8U';

select * from results_onerow;

delete from results where event='2010 Junior World Championships - Boys 8U';

insert into results select * from results_onerow;

drop table results_onerow;

call sp_fixname ('Rico, Daniela','Rico Segura, Daniela');
call sp_fixname ('Rico, Daniela','Rico Segura, Daniela Edith');



select * from results where event='2013 Junior World Championships - Boys 16U';

delete from results where event='2013 Junior World Championships - Boys 16U' and source ='Tim Baghurst/IRF Summary data research Nov 2017';



select * from results where event='2019 USA Junior Nationals - Girls 14U';

update results set loser='Cyril, Arya' where event='2019 USA Junior Nationals - Girls 14U' and round=3;




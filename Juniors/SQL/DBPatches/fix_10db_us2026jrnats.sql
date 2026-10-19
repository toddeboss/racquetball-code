-- fixing 10udb issues in 2026 USA Junior nationals data

create table results_20260629dbfix as select * from results;

select * from results where event='2026 USA Junior Nationals - Girls 10U';
select * from results where event='2026 USA Junior Nationals - Girls 10db';
select * from results where event='2026 USA Junior Nationals - Girls 10Udb';

update results set event='2026 USA Junior Nationals - Girls 10U' where event='2026 USA Junior Nationals - Girls 10db';
update results set event='2026 USA Junior Nationals - Girls 10Udb' where event='2026 USA Junior Nationals - Girls 10U' and tour='Girls 10Udb';

select * from results where event='2026 USA Junior Nationals - Boys 10U';
select * from results where event='2026 USA Junior Nationals - Boys 10db';
select * from results where event='2026 USA Junior Nationals - Boys 10Udb';

update results set event='2026 USA Junior Nationals - Boys 10Udb', tour='Boys 10Udb' where event='2026 USA Junior Nationals - Boys 10db';


call sp_fixname('Haacke, Scott','Haake, Scott');

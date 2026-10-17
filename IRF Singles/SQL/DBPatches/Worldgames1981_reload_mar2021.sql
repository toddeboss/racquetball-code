
-- updating 1981 World Games full results

SET SQL_SAFE_UPDATES = 0;


select * from results where event='1981 World Games/World Championships I - Mens Open';

select * from results where event='1981 World Games/World Championships I - Womens Open';



delete from results where event='1981 World Games/World Championships I - Mens Open';

delete from seedings where event='1981 World Games/World Championships I - Mens Open';

delete from results where event='1981 World Games/World Championships I - Womens Open';

delete from seedings where event='1981 World Games/World Championships I - Womens Open';

commit;

-- now load normally


create table results_doubles_20210311 as select * from results_doubles;

create table tourneys_doubles_20210311 as select * from tourneys_doubles;

create table seedings_doubles_20210311 as select * from seedings_doubles;


select * from results_doubles where event='1981 World Games/World Championships I - Mens Open';

select * from results_doubles where event='1981 World Games/World Championships I - Womens Open';

delete from results_doubles where event='1981 World Games/World Championships I - Mens Open';

delete from results_doubles where event='1981 World Games/World Championships I - Womens Open';


-- now load doubles data
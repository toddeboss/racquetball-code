SET SQL_SAFE_UPDATES = 0;

select * from tourneys order by tmp_date desc;

create table tourneys_20180315 as select * from tourneys;

alter table tourneys add preview_url varchar(200);
alter table tourneys add wrapup_url varchar(200);

-- IRT links for 2017-18 season
update tourneys set preview_url='https://www.facebook.com/prorballstats/posts/252021728672048' where event='2018 IRT March Madness';
update tourneys set wrapup_url='https://www.facebook.com/prorballstats/posts/253463201861234' where event='2018 IRT March Madness';

update tourneys set preview_url='https://www.facebook.com/prorballstats/posts/237800216760866' where event='2018 40th Annual Lewis Drug Pro-Am IRT Tier 1';
update tourneys set wrapup_url='https://www.facebook.com/prorballstats/posts/239509759923245' where event='2018 40th Annual Lewis Drug Pro-Am IRT Tier 1';

update tourneys set preview_url='https://www.facebook.com/prorballstats/posts/233392533868301' where event='2018 LA Open presented by Coast to Coast';
update tourneys set wrapup_url='https://www.facebook.com/prorballstats/posts/234688683738686' where event='2018 LA Open presented by Coast to Coast';

update tourneys set preview_url='https://www.facebook.com/prorballstats/posts/221414661732755' where event='2017 John Pelham Memorial/ Pro Kennex Tournament of Champions';
update tourneys set wrapup_url='https://www.facebook.com/prorballstats/posts/222649938275894' where event='2017 John Pelham Memorial/ Pro Kennex Tournament of Champions';

update tourneys set preview_url='https://www.facebook.com/prorballstats/posts/216783415529213' where event='2017 St. Louis IRT Pro Racquetball Winter Rollout presented by Pro Kennex';
update tourneys set wrapup_url='https://www.facebook.com/prorballstats/posts/218353715372183' where event='2017 St. Louis IRT Pro Racquetball Winter Rollout presented by Pro Kennex';

update tourneys set preview_url='https://www.reddit.com/r/racquetball/comments/7abdle/2017_atlanta_irt_event_preview_and_predictions/' where event='2017 Atlanta Creatix Open IRT Pro-Am';
update tourneys set wrapup_url='http://theracquetballblog.blogspot.com/2017/11/waselenchuk-wins-2017-irt-atlanta-open.html' where event='2017 Atlanta Creatix Open IRT Pro-Am';

update tourneys set preview_url='http://theracquetballblog.blogspot.com/2017/09/2017-unitedhealthcare-us-open-irt.html' where event='2017 22nd UnitedHealthcare US OPEN Racquetball Championships';
update tourneys set wrapup_url='http://theracquetballblog.blogspot.com/2017/10/waselenchuk-wins-13th-title-at-2017.html' where event='2017 22nd UnitedHealthcare US OPEN Racquetball Championships';

update tourneys set preview_url='http://theracquetballblog.blogspot.com/2017/09/the-2017-18-irt-season-begins-in-canoga.html' where event='2017 IRT Phase IV Scientific Health and Performance Pro-Am';
update tourneys set wrapup_url='http://theracquetballblog.blogspot.com/2017/09/waselenchuk-wins-singles-doubles-at.html' where event='2017 IRT Phase IV Scientific Health and Performance Pro-Am';


commit;
-- rpt_tracking clean up post creation


SET SQL_SAFE_UPDATES = 0;

use cp30725_prs;

-- this is the code in the perl script
/*
   # 1/29/18: putting in rpt_tracking code
   my $subroutine = (caller(0))[3];
   &rpt_tracking($form{'tour'},$form{'query'},$form{'sum_event'},$form{'division'},$form{'category'},$form{'player'},$form{'event'},$form{'season'},$subroutine);

   # 1/29/18: putting in rpt_tracking code
   my $subroutine = (caller(0))[3];
   &rpt_tracking($form{'tour'},$form{'query'},$form{'sum_event'},$form{'division'},$form{'category'},$form{'player'},$event,$year,$subroutine);
*/



insert into rpt_tracking (rpt_date,tour,query,sum_event,division,category,player,event,season,subroutine) values (now(),IRT,all_matches_per_event,,,,0,2018 40th Annual Lewis Drug Pro-Am IRT Tier 1~1/21/2018,0,main::all_matches_per_event);

insert into rpt_tracking (rpt_date,tour,query,sum_event,division,category,player,event,season,subroutine) values (now(),'IRT','all_matches_per_event','','','','0','2018 40th Annual Lewis Drug Pro-Am IRT Tier 1~1/21/2018','0','main::all_matches_per_event');

insert into rpt_tracking (rpt_date,tour,query,sum_event,division,category,player,event,season,subroutine) values (now(),'IRT','all_matches_per_event','','','','0','$event','0','main::all_matches_per_event');

insert into cp30725_prs.rpt_tracking (rpt_date,tour,query,sum_event,division,category,player,event,season,subroutine) values (now(),'IRT','all_matches_per_event','','','','0','2018 40th Annual Lewis Drug Pro-Am IRT Tier 1','0','main::all_matches_per_event');




update cp30725_prs.rpt_tracking set player='0' where query='all_matches_per_event';

update cp30725_prs.rpt_tracking set season='0' where query='head_to_head_3yr';

update cp30725_prs.rpt_tracking set season='0' where query='head_to_head_3yr';

update cp30725_prs.rpt_tracking set player='0' where query like 'longest%';

update cp30725_prs.rpt_tracking set player='0' where query in ('most_dominant_tourneys','most_losses','most_matchups','most_tourney_wins','oldest_player_to','player_profiles_regular');

update cp30725_prs.rpt_tracking set player='0' where query in ('season_summary_all','season_tourney_wins','wl_pct_all','finals_by_season');

update cp30725_prs.rpt_tracking set event='0' where query in ('player_summary','player_wl');

update cp30725_prs.rpt_tracking set season='0' where query in ('player_summary','player_wl');





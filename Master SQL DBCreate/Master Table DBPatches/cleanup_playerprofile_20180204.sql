-- 2/4/18: cleaning up player_profile.

o created anew in cp30725_prs

-- droppedin all 7 dbs:
drop table cp30725_amateur.player_profile;

-- confirm each other user can read the new master version
select * from cp30725_prs.player_profile;

-- now re-make sp_fixname after modifying it to clean the player_profile data...
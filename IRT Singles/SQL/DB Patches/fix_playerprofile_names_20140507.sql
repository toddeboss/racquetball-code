-- fixing three names in player_profile table...

select * from player_profile;

update player_profile set player='Bowman, Jeff' where player='Bowman,J';

update player_profile set player='Ikier, Paul' where player='Ikier,P';

update player_profile set player='Thurman, Bill' where player='Thurman,B';
use cp30725_men;

select * from player_profile where player='Sweeney, Tim';

update player_profile set dob='6/3/1967', tmp_dob='1967-06-03', notes='Updated May2014 from Chad Levis input based on Sweeney facebook'
where player='Sweeney, Tim';

commit;
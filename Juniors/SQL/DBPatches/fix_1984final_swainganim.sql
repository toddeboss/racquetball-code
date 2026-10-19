-- updating older final for Ganim podcast

select * from results where event='1984 USA Junior Nationals - Boys 18U';

update results set loser='Swain, Cliff' where event='1984 USA Junior Nationals - Boys 18U' and round=2;


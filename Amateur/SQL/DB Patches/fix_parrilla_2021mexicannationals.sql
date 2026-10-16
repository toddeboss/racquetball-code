-- 11/1/21: accidentally entered Andree for Jessica in the 2021 Mexican nationals

SET SQL_SAFE_UPDATES = 0;

create table results_20211101 as select * from results;

update results set winner='Parrilla, Jessica' where event ='2021 Campeonato Nacional Selectivo de Raquetbol - Womens Open'
and winner='Parrilla, Andree';

update results set loser='Parrilla, Jessica' where event ='2021 Campeonato Nacional Selectivo de Raquetbol - Womens Open'
and loser='Parrilla, Andree';

update seedings set player='Parrilla, Jessica' where event ='2021 Campeonato Nacional Selectivo de Raquetbol - Womens Open'
and player='Parrilla, Andree';
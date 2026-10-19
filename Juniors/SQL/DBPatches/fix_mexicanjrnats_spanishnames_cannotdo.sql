-- fix tourney names to be in spanish.

-- actually, can't do this b/c all the code depends on formatted names.  d uh.

create table results_20190729 as select * from results;

create table seedings_20190729 as select * from seedings;

create table tourneys_20190729 as select * from tourneys;


select * from tourneys where city like '%MEX' order by tmp_date desc;

--  update this with help of xls work in tourney status xls

update results set event='2019 Campeonato Nacional de Raquetbol Infantil y Juvenil  - Girls 14U' where event='2019 Mexico Junior Nationals - Girls 14U';
update results set event='2019 Campeonato Nacional de Raquetbol Infantil y Juvenil  - Boys 10U' where event='2019 Mexico Junior Nationals - Boys 10U';
update results set event='2019 Campeonato Nacional de Raquetbol Infantil y Juvenil  - Girls 10U' where event='2019 Mexico Junior Nationals - Girls 10U';
update results set event='2019 Campeonato Nacional de Raquetbol Infantil y Juvenil  - Boys 8U' where event='2019 Mexico Junior Nationals - Boys 8U';
update results set event='2019 Campeonato Nacional de Raquetbol Infantil y Juvenil  - Girls 8U' where event='2019 Mexico Junior Nationals - Girls 8U';
update results set event='2019 Campeonato Nacional de Raquetbol Infantil y Juvenil  - Boys 12U' where event='2019 Mexico Junior Nationals - Boys 12U';
update results set event='2019 Campeonato Nacional de Raquetbol Infantil y Juvenil  - Boys 14U' where event='2019 Mexico Junior Nationals - Boys 14U';
update results set event='2019 Campeonato Nacional de Raquetbol Infantil y Juvenil  - Girls 16U' where event='2019 Mexico Junior Nationals - Girls 16U';
update results set event='2019 Campeonato Nacional de Raquetbol Infantil y Juvenil  - Boys 16U' where event='2019 Mexico Junior Nationals - Boys 16U';
update results set event='2019 Campeonato Nacional de Raquetbol Infantil y Juvenil  - Girls 18U' where event='2019 Mexico Junior Nationals - Girls 18U';
update results set event='2019 Campeonato Nacional de Raquetbol Infantil y Juvenil  - Boys 18U' where event='2019 Mexico Junior Nationals - Boys 18U';
update results set event='2019 Campeonato Nacional de Raquetbol Infantil y Juvenil  - Girls 12U' where event='2019 Mexico Junior Nationals - Girls 12U';
update results set event='2018 Campeonato Nacional de Raquetbol Cotuco - Girls 10U' where event='2018 Mexico Junior Nationals - Girls 10U';
update results set event='2018 Campeonato Nacional de Raquetbol Cotuco - Boys 16U' where event='2018 Mexico Junior Nationals - Boys 16U';
update results set event='2018 Campeonato Nacional de Raquetbol Cotuco - Girls 18U' where event='2018 Mexico Junior Nationals - Girls 18U';
update results set event='2018 Campeonato Nacional de Raquetbol Cotuco - Girls 16U' where event='2018 Mexico Junior Nationals - Girls 16U';
update results set event='2018 Campeonato Nacional de Raquetbol Cotuco - Girls 14U' where event='2018 Mexico Junior Nationals - Girls 14U';
update results set event='2018 Campeonato Nacional de Raquetbol Cotuco - Boys 14U' where event='2018 Mexico Junior Nationals - Boys 14U';
update results set event='2018 Campeonato Nacional de Raquetbol Cotuco - Boys 12U' where event='2018 Mexico Junior Nationals - Boys 12U';
update results set event='2018 Campeonato Nacional de Raquetbol Cotuco - Boys 10U' where event='2018 Mexico Junior Nationals - Boys 10U';
update results set event='2018 Campeonato Nacional de Raquetbol Cotuco - Girls 12U' where event='2018 Mexico Junior Nationals - Girls 12U';
update results set event='2018 Campeonato Nacional de Raquetbol Cotuco - Boys 18U' where event='2018 Mexico Junior Nationals - Boys 18U';
update results set event='2018 Campeonato Nacional de Raquetbol Cotuco - Girls 8U' where event='2018 Mexico Junior Nationals - Girls 8U';
update results set event='2018 Campeonato Nacional de Raquetbol Cotuco - Boys 8U' where event='2018 Mexico Junior Nationals - Boys 8U';
update results set event='2017 Campeonato Nacional Selectivo Infantil - Juvenil - Boys 12U' where event='2017 Mexico Junior Nationals - Boys 12U';
update results set event='2017 Campeonato Nacional Selectivo Infantil - Juvenil - Boys 8U' where event='2017 Mexico Junior Nationals - Boys 8U';
update results set event='2017 Campeonato Nacional Selectivo Infantil - Juvenil - Girls 10U' where event='2017 Mexico Junior Nationals - Girls 10U';
update results set event='2017 Campeonato Nacional Selectivo Infantil - Juvenil - Boys 10U' where event='2017 Mexico Junior Nationals - Boys 10U';
update results set event='2017 Campeonato Nacional Selectivo Infantil - Juvenil - Girls 12U' where event='2017 Mexico Junior Nationals - Girls 12U';
update results set event='2017 Campeonato Nacional Selectivo Infantil - Juvenil - Girls 14U' where event='2017 Mexico Junior Nationals - Girls 14U';
update results set event='2017 Campeonato Nacional Selectivo Infantil - Juvenil - Girls 8U' where event='2017 Mexico Junior Nationals - Girls 8U';
update results set event='2017 Campeonato Nacional Selectivo Infantil - Juvenil - Boys 14U' where event='2017 Mexico Junior Nationals - Boys 14U';
update results set event='2017 Campeonato Nacional Selectivo Infantil - Juvenil - Boys 16U' where event='2017 Mexico Junior Nationals - Boys 16U';
update results set event='2017 Campeonato Nacional Selectivo Infantil - Juvenil - Girls 18U' where event='2017 Mexico Junior Nationals - Girls 18U';
update results set event='2017 Campeonato Nacional Selectivo Infantil - Juvenil - Girls 16U' where event='2017 Mexico Junior Nationals - Girls 16U';
update results set event='2017 Campeonato Nacional Selectivo Infantil - Juvenil - Boys 18U' where event='2017 Mexico Junior Nationals - Boys 18U';
update results set event='2016 Campeonato Nacional Selectivo Infantil-Juvenil - Girls 16U' where event='2016 Mexico Junior Nationals - Girls 16U';
update results set event='2016 Campeonato Nacional Selectivo Infantil-Juvenil - Boys 16U' where event='2016 Mexico Junior Nationals - Boys 16U';
update results set event='2016 Campeonato Nacional Selectivo Infantil-Juvenil - Girls 18U' where event='2016 Mexico Junior Nationals - Girls 18U';
update results set event='2016 Campeonato Nacional Selectivo Infantil-Juvenil - Boys 18U' where event='2016 Mexico Junior Nationals - Boys 18U';
update results set event='2016 Campeonato Nacional Selectivo Infantil-Juvenil - Boys 18U' where event='2016 Mexico Junior Nationals - Boys 18U';
update results set event='2016 Campeonato Nacional Selectivo Infantil-Juvenil - Girls 18U' where event='2016 Mexico Junior Nationals - Girls 18U';
update results set event='2015 Campeonato Nacional Selectivo Infantil-Juvenil - Boys 18U' where event='2015 Mexico Junior Nationals - Boys 18U';
update results set event='2015 Campeonato Nacional Selectivo Infantil-Juvenil - Boys 16U' where event='2015 Mexico Junior Nationals - Boys 16U';
update results set event='2015 Campeonato Nacional Selectivo Infantil-Juvenil - Girls 16U' where event='2015 Mexico Junior Nationals - Girls 16U';
update results set event='2015 Campeonato Nacional Selectivo Infantil-Juvenil - Girls 18U' where event='2015 Mexico Junior Nationals - Girls 18U';
update results set event='2013 Campeonato Nacional Selectivo Infantil-Juvenil - Boys 18U' where event='2013 Mexico Junior Nationals - Boys 18U';
update results set event='2013 Campeonato Nacional Selectivo Infantil-Juvenil - Girls 18U' where event='2013 Mexico Junior Nationals - Girls 18U';
update results set event='2013 Campeonato Nacional Selectivo Infantil-Juvenil - Boys 16U' where event='2013 Mexico Junior Nationals - Boys 16U';
update results set event='2013 Campeonato Nacional Selectivo Infantil-Juvenil - Girls 16U' where event='2013 Mexico Junior Nationals - Girls 16U';



update tourneys set event='2019 Campeonato Nacional de Raquetbol Infantil y Juvenil  - Girls 14U' where event='2019 Mexico Junior Nationals - Girls 14U';
update tourneys set event='2019 Campeonato Nacional de Raquetbol Infantil y Juvenil  - Boys 10U' where event='2019 Mexico Junior Nationals - Boys 10U';
update tourneys set event='2019 Campeonato Nacional de Raquetbol Infantil y Juvenil  - Girls 10U' where event='2019 Mexico Junior Nationals - Girls 10U';
update tourneys set event='2019 Campeonato Nacional de Raquetbol Infantil y Juvenil  - Boys 8U' where event='2019 Mexico Junior Nationals - Boys 8U';
update tourneys set event='2019 Campeonato Nacional de Raquetbol Infantil y Juvenil  - Girls 8U' where event='2019 Mexico Junior Nationals - Girls 8U';
update tourneys set event='2019 Campeonato Nacional de Raquetbol Infantil y Juvenil  - Boys 12U' where event='2019 Mexico Junior Nationals - Boys 12U';
update tourneys set event='2019 Campeonato Nacional de Raquetbol Infantil y Juvenil  - Boys 14U' where event='2019 Mexico Junior Nationals - Boys 14U';
update tourneys set event='2019 Campeonato Nacional de Raquetbol Infantil y Juvenil  - Girls 16U' where event='2019 Mexico Junior Nationals - Girls 16U';
update tourneys set event='2019 Campeonato Nacional de Raquetbol Infantil y Juvenil  - Boys 16U' where event='2019 Mexico Junior Nationals - Boys 16U';
update tourneys set event='2019 Campeonato Nacional de Raquetbol Infantil y Juvenil  - Girls 18U' where event='2019 Mexico Junior Nationals - Girls 18U';
update tourneys set event='2019 Campeonato Nacional de Raquetbol Infantil y Juvenil  - Boys 18U' where event='2019 Mexico Junior Nationals - Boys 18U';
update tourneys set event='2019 Campeonato Nacional de Raquetbol Infantil y Juvenil  - Girls 12U' where event='2019 Mexico Junior Nationals - Girls 12U';
update tourneys set event='2018 Campeonato Nacional de Raquetbol Cotuco - Girls 10U' where event='2018 Mexico Junior Nationals - Girls 10U';
update tourneys set event='2018 Campeonato Nacional de Raquetbol Cotuco - Boys 16U' where event='2018 Mexico Junior Nationals - Boys 16U';
update tourneys set event='2018 Campeonato Nacional de Raquetbol Cotuco - Girls 18U' where event='2018 Mexico Junior Nationals - Girls 18U';
update tourneys set event='2018 Campeonato Nacional de Raquetbol Cotuco - Girls 16U' where event='2018 Mexico Junior Nationals - Girls 16U';
update tourneys set event='2018 Campeonato Nacional de Raquetbol Cotuco - Girls 14U' where event='2018 Mexico Junior Nationals - Girls 14U';
update tourneys set event='2018 Campeonato Nacional de Raquetbol Cotuco - Boys 14U' where event='2018 Mexico Junior Nationals - Boys 14U';
update tourneys set event='2018 Campeonato Nacional de Raquetbol Cotuco - Boys 12U' where event='2018 Mexico Junior Nationals - Boys 12U';
update tourneys set event='2018 Campeonato Nacional de Raquetbol Cotuco - Boys 10U' where event='2018 Mexico Junior Nationals - Boys 10U';
update tourneys set event='2018 Campeonato Nacional de Raquetbol Cotuco - Girls 12U' where event='2018 Mexico Junior Nationals - Girls 12U';
update tourneys set event='2018 Campeonato Nacional de Raquetbol Cotuco - Boys 18U' where event='2018 Mexico Junior Nationals - Boys 18U';
update tourneys set event='2018 Campeonato Nacional de Raquetbol Cotuco - Girls 8U' where event='2018 Mexico Junior Nationals - Girls 8U';
update tourneys set event='2018 Campeonato Nacional de Raquetbol Cotuco - Boys 8U' where event='2018 Mexico Junior Nationals - Boys 8U';
update tourneys set event='2017 Campeonato Nacional Selectivo Infantil - Juvenil - Boys 12U' where event='2017 Mexico Junior Nationals - Boys 12U';
update tourneys set event='2017 Campeonato Nacional Selectivo Infantil - Juvenil - Boys 8U' where event='2017 Mexico Junior Nationals - Boys 8U';
update tourneys set event='2017 Campeonato Nacional Selectivo Infantil - Juvenil - Girls 10U' where event='2017 Mexico Junior Nationals - Girls 10U';
update tourneys set event='2017 Campeonato Nacional Selectivo Infantil - Juvenil - Boys 10U' where event='2017 Mexico Junior Nationals - Boys 10U';
update tourneys set event='2017 Campeonato Nacional Selectivo Infantil - Juvenil - Girls 12U' where event='2017 Mexico Junior Nationals - Girls 12U';
update tourneys set event='2017 Campeonato Nacional Selectivo Infantil - Juvenil - Girls 14U' where event='2017 Mexico Junior Nationals - Girls 14U';
update tourneys set event='2017 Campeonato Nacional Selectivo Infantil - Juvenil - Girls 8U' where event='2017 Mexico Junior Nationals - Girls 8U';
update tourneys set event='2017 Campeonato Nacional Selectivo Infantil - Juvenil - Boys 14U' where event='2017 Mexico Junior Nationals - Boys 14U';
update tourneys set event='2017 Campeonato Nacional Selectivo Infantil - Juvenil - Boys 16U' where event='2017 Mexico Junior Nationals - Boys 16U';
update tourneys set event='2017 Campeonato Nacional Selectivo Infantil - Juvenil - Girls 18U' where event='2017 Mexico Junior Nationals - Girls 18U';
update tourneys set event='2017 Campeonato Nacional Selectivo Infantil - Juvenil - Girls 16U' where event='2017 Mexico Junior Nationals - Girls 16U';
update tourneys set event='2017 Campeonato Nacional Selectivo Infantil - Juvenil - Boys 18U' where event='2017 Mexico Junior Nationals - Boys 18U';
update tourneys set event='2016 Campeonato Nacional Selectivo Infantil-Juvenil - Girls 16U' where event='2016 Mexico Junior Nationals - Girls 16U';
update tourneys set event='2016 Campeonato Nacional Selectivo Infantil-Juvenil - Boys 16U' where event='2016 Mexico Junior Nationals - Boys 16U';
update tourneys set event='2016 Campeonato Nacional Selectivo Infantil-Juvenil - Girls 18U' where event='2016 Mexico Junior Nationals - Girls 18U';
update tourneys set event='2016 Campeonato Nacional Selectivo Infantil-Juvenil - Boys 18U' where event='2016 Mexico Junior Nationals - Boys 18U';
update tourneys set event='2016 Campeonato Nacional Selectivo Infantil-Juvenil - Boys 18U' where event='2016 Mexico Junior Nationals - Boys 18U';
update tourneys set event='2016 Campeonato Nacional Selectivo Infantil-Juvenil - Girls 18U' where event='2016 Mexico Junior Nationals - Girls 18U';
update tourneys set event='2015 Campeonato Nacional Selectivo Infantil-Juvenil - Boys 18U' where event='2015 Mexico Junior Nationals - Boys 18U';
update tourneys set event='2015 Campeonato Nacional Selectivo Infantil-Juvenil - Boys 16U' where event='2015 Mexico Junior Nationals - Boys 16U';
update tourneys set event='2015 Campeonato Nacional Selectivo Infantil-Juvenil - Girls 16U' where event='2015 Mexico Junior Nationals - Girls 16U';
update tourneys set event='2015 Campeonato Nacional Selectivo Infantil-Juvenil - Girls 18U' where event='2015 Mexico Junior Nationals - Girls 18U';
update tourneys set event='2013 Campeonato Nacional Selectivo Infantil-Juvenil - Boys 18U' where event='2013 Mexico Junior Nationals - Boys 18U';
update tourneys set event='2013 Campeonato Nacional Selectivo Infantil-Juvenil - Girls 18U' where event='2013 Mexico Junior Nationals - Girls 18U';
update tourneys set event='2013 Campeonato Nacional Selectivo Infantil-Juvenil - Boys 16U' where event='2013 Mexico Junior Nationals - Boys 16U';
update tourneys set event='2013 Campeonato Nacional Selectivo Infantil-Juvenil - Girls 16U' where event='2013 Mexico Junior Nationals - Girls 16U';

update seedings set event='2019 Campeonato Nacional de Raquetbol Infantil y Juvenil  - Girls 14U' where event='2019 Mexico Junior Nationals - Girls 14U';
update seedings set event='2019 Campeonato Nacional de Raquetbol Infantil y Juvenil  - Boys 10U' where event='2019 Mexico Junior Nationals - Boys 10U';
update seedings set event='2019 Campeonato Nacional de Raquetbol Infantil y Juvenil  - Girls 10U' where event='2019 Mexico Junior Nationals - Girls 10U';
update seedings set event='2019 Campeonato Nacional de Raquetbol Infantil y Juvenil  - Boys 8U' where event='2019 Mexico Junior Nationals - Boys 8U';
update seedings set event='2019 Campeonato Nacional de Raquetbol Infantil y Juvenil  - Girls 8U' where event='2019 Mexico Junior Nationals - Girls 8U';
update seedings set event='2019 Campeonato Nacional de Raquetbol Infantil y Juvenil  - Boys 12U' where event='2019 Mexico Junior Nationals - Boys 12U';
update seedings set event='2019 Campeonato Nacional de Raquetbol Infantil y Juvenil  - Boys 14U' where event='2019 Mexico Junior Nationals - Boys 14U';
update seedings set event='2019 Campeonato Nacional de Raquetbol Infantil y Juvenil  - Girls 16U' where event='2019 Mexico Junior Nationals - Girls 16U';
update seedings set event='2019 Campeonato Nacional de Raquetbol Infantil y Juvenil  - Boys 16U' where event='2019 Mexico Junior Nationals - Boys 16U';
update seedings set event='2019 Campeonato Nacional de Raquetbol Infantil y Juvenil  - Girls 18U' where event='2019 Mexico Junior Nationals - Girls 18U';
update seedings set event='2019 Campeonato Nacional de Raquetbol Infantil y Juvenil  - Boys 18U' where event='2019 Mexico Junior Nationals - Boys 18U';
update seedings set event='2019 Campeonato Nacional de Raquetbol Infantil y Juvenil  - Girls 12U' where event='2019 Mexico Junior Nationals - Girls 12U';
update seedings set event='2018 Campeonato Nacional de Raquetbol Cotuco - Girls 10U' where event='2018 Mexico Junior Nationals - Girls 10U';
update seedings set event='2018 Campeonato Nacional de Raquetbol Cotuco - Boys 16U' where event='2018 Mexico Junior Nationals - Boys 16U';
update seedings set event='2018 Campeonato Nacional de Raquetbol Cotuco - Girls 18U' where event='2018 Mexico Junior Nationals - Girls 18U';
update seedings set event='2018 Campeonato Nacional de Raquetbol Cotuco - Girls 16U' where event='2018 Mexico Junior Nationals - Girls 16U';
update seedings set event='2018 Campeonato Nacional de Raquetbol Cotuco - Girls 14U' where event='2018 Mexico Junior Nationals - Girls 14U';
update seedings set event='2018 Campeonato Nacional de Raquetbol Cotuco - Boys 14U' where event='2018 Mexico Junior Nationals - Boys 14U';
update seedings set event='2018 Campeonato Nacional de Raquetbol Cotuco - Boys 12U' where event='2018 Mexico Junior Nationals - Boys 12U';
update seedings set event='2018 Campeonato Nacional de Raquetbol Cotuco - Boys 10U' where event='2018 Mexico Junior Nationals - Boys 10U';
update seedings set event='2018 Campeonato Nacional de Raquetbol Cotuco - Girls 12U' where event='2018 Mexico Junior Nationals - Girls 12U';
update seedings set event='2018 Campeonato Nacional de Raquetbol Cotuco - Boys 18U' where event='2018 Mexico Junior Nationals - Boys 18U';
update seedings set event='2018 Campeonato Nacional de Raquetbol Cotuco - Girls 8U' where event='2018 Mexico Junior Nationals - Girls 8U';
update seedings set event='2018 Campeonato Nacional de Raquetbol Cotuco - Boys 8U' where event='2018 Mexico Junior Nationals - Boys 8U';
update seedings set event='2017 Campeonato Nacional Selectivo Infantil - Juvenil - Boys 12U' where event='2017 Mexico Junior Nationals - Boys 12U';
update seedings set event='2017 Campeonato Nacional Selectivo Infantil - Juvenil - Boys 8U' where event='2017 Mexico Junior Nationals - Boys 8U';
update seedings set event='2017 Campeonato Nacional Selectivo Infantil - Juvenil - Girls 10U' where event='2017 Mexico Junior Nationals - Girls 10U';
update seedings set event='2017 Campeonato Nacional Selectivo Infantil - Juvenil - Boys 10U' where event='2017 Mexico Junior Nationals - Boys 10U';
update seedings set event='2017 Campeonato Nacional Selectivo Infantil - Juvenil - Girls 12U' where event='2017 Mexico Junior Nationals - Girls 12U';
update seedings set event='2017 Campeonato Nacional Selectivo Infantil - Juvenil - Girls 14U' where event='2017 Mexico Junior Nationals - Girls 14U';
update seedings set event='2017 Campeonato Nacional Selectivo Infantil - Juvenil - Girls 8U' where event='2017 Mexico Junior Nationals - Girls 8U';
update seedings set event='2017 Campeonato Nacional Selectivo Infantil - Juvenil - Boys 14U' where event='2017 Mexico Junior Nationals - Boys 14U';
update seedings set event='2017 Campeonato Nacional Selectivo Infantil - Juvenil - Boys 16U' where event='2017 Mexico Junior Nationals - Boys 16U';
update seedings set event='2017 Campeonato Nacional Selectivo Infantil - Juvenil - Girls 18U' where event='2017 Mexico Junior Nationals - Girls 18U';
update seedings set event='2017 Campeonato Nacional Selectivo Infantil - Juvenil - Girls 16U' where event='2017 Mexico Junior Nationals - Girls 16U';
update seedings set event='2017 Campeonato Nacional Selectivo Infantil - Juvenil - Boys 18U' where event='2017 Mexico Junior Nationals - Boys 18U';
update seedings set event='2016 Campeonato Nacional Selectivo Infantil-Juvenil - Girls 16U' where event='2016 Mexico Junior Nationals - Girls 16U';
update seedings set event='2016 Campeonato Nacional Selectivo Infantil-Juvenil - Boys 16U' where event='2016 Mexico Junior Nationals - Boys 16U';
update seedings set event='2016 Campeonato Nacional Selectivo Infantil-Juvenil - Girls 18U' where event='2016 Mexico Junior Nationals - Girls 18U';
update seedings set event='2016 Campeonato Nacional Selectivo Infantil-Juvenil - Boys 18U' where event='2016 Mexico Junior Nationals - Boys 18U';
update seedings set event='2016 Campeonato Nacional Selectivo Infantil-Juvenil - Boys 18U' where event='2016 Mexico Junior Nationals - Boys 18U';
update seedings set event='2016 Campeonato Nacional Selectivo Infantil-Juvenil - Girls 18U' where event='2016 Mexico Junior Nationals - Girls 18U';
update seedings set event='2015 Campeonato Nacional Selectivo Infantil-Juvenil - Boys 18U' where event='2015 Mexico Junior Nationals - Boys 18U';
update seedings set event='2015 Campeonato Nacional Selectivo Infantil-Juvenil - Boys 16U' where event='2015 Mexico Junior Nationals - Boys 16U';
update seedings set event='2015 Campeonato Nacional Selectivo Infantil-Juvenil - Girls 16U' where event='2015 Mexico Junior Nationals - Girls 16U';
update seedings set event='2015 Campeonato Nacional Selectivo Infantil-Juvenil - Girls 18U' where event='2015 Mexico Junior Nationals - Girls 18U';
update seedings set event='2013 Campeonato Nacional Selectivo Infantil-Juvenil - Boys 18U' where event='2013 Mexico Junior Nationals - Boys 18U';
update seedings set event='2013 Campeonato Nacional Selectivo Infantil-Juvenil - Girls 18U' where event='2013 Mexico Junior Nationals - Girls 18U';
update seedings set event='2013 Campeonato Nacional Selectivo Infantil-Juvenil - Boys 16U' where event='2013 Mexico Junior Nationals - Boys 16U';
update seedings set event='2013 Campeonato Nacional Selectivo Infantil-Juvenil - Girls 16U' where event='2013 Mexico Junior Nationals - Girls 16U';



-----

-- decided to update to have "Mexicano" in the name


CREATE TABLE `results` (
  `winner` varchar(50) NOT NULL DEFAULT '',
  `loser` varchar(50) NOT NULL DEFAULT '',
  `round` int(11) DEFAULT NULL,
  `score` varchar(25) NOT NULL DEFAULT '',
  `tour` varchar(10) NOT NULL DEFAULT '',
  `city` varchar(30) NOT NULL DEFAULT '',
  `event` varchar(255) DEFAULT NULL,
  `date` varchar(20) DEFAULT NULL,
  `source` varchar(50) NOT NULL DEFAULT '',
  `season` varchar(10) NOT NULL DEFAULT '',
  `notes` varchar(100) NOT NULL DEFAULT '',
  `tmp_date` date DEFAULT NULL,
  KEY `winner_ndx` (`winner`),
  KEY `loser_ndx` (`loser`),
  KEY `round_ndx` (`round`),
  KEY `event_ndx` (`event`),
  KEY `date_ndx` (`date`),
  KEY `season_ndx` (`season`),
  KEY `tmp_date_ndx` (`tmp_date`),
  KEY `event_date_ndx` (`event`,`date`),
  KEY `winner_round_ndx` (`winner`,`round`),
  KEY `loser_round_ndx` (`loser`,`round`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- because we're going to overload the results table tour field, expand it.


ALTER TABLE results MODIFY tour VARCHAR(100);

-- 9/21/20: for PPS we have to add loser brackets, which means the round cannot be an integer

alter table results modify round varchar(5);

# the source is wayy too small to fit big URLs.  damn.
alter table results modify source varchar(500);



-- create the staging table once done.
create table results_staging as select * from results;


-- 9/17/25: added in a couple of indexes to help with performance

create index results_winner_ndx on results (winner);

create index results_loser_ndx on results (loser);
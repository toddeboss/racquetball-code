CREATE TABLE `results_doubles` (
  `winner_p1` varchar(50) NOT NULL DEFAULT '',
  `winner_p2` varchar(50) NOT NULL DEFAULT '',
  `loser_p1` varchar(50) NOT NULL DEFAULT '',
  `loser_p2` varchar(50) NOT NULL DEFAULT '',
  `round` int(11) DEFAULT NULL,
  `score` varchar(25) NOT NULL DEFAULT '',
  `tour` varchar(100) NOT NULL DEFAULT '',
  `city` varchar(30) NOT NULL DEFAULT '',
  `event` varchar(255) DEFAULT NULL,
  `date` varchar(20) DEFAULT NULL,
  `source` varchar(50) NOT NULL DEFAULT '',
  `season` varchar(10) NOT NULL DEFAULT '',
  `notes` varchar(100) NOT NULL DEFAULT '',
  `tmp_date` date DEFAULT NULL,
  KEY `winnerp1_ndx` (`winner_p1`),
  KEY `winnerp2_ndx` (`winner_p2`),
  KEY `loserp1_ndx` (`loser_p1`),
  KEY `loserp2_ndx` (`loser_p2`),
  KEY `round_ndx` (`round`),
  KEY `event_ndx` (`event`),
  KEY `date_ndx` (`date`),
  KEY `season_ndx` (`season`),
  KEY `tmp_date_ndx` (`tmp_date`),
  KEY `event_date_ndx` (`event`,`date`),
  KEY `winner_round_ndx` (`winner_p1`,`round`),
  KEY `loser_round_ndx` (`loser_p1`,`round`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- because we're going to overload the results table tour field, expand it.
-- done above
-- ALTER TABLE results MODIFY tour VARCHAR(100);

select * from results_doubles;

create table results_doubles_staging as select * from results_doubles;
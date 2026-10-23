/*

CREATE TABLE `results_staging` (
  `winner` varchar(50) NOT NULL DEFAULT '',
  `loser` varchar(50) NOT NULL DEFAULT '',
  `round` char(3) DEFAULT NULL,
  `score` varchar(25) NOT NULL DEFAULT '',
  `tour` varchar(10) NOT NULL DEFAULT '',
  `city` varchar(30) NOT NULL DEFAULT '',
  `event` varchar(255) DEFAULT NULL,
  `date` varchar(20) DEFAULT NULL,
  `source` varchar(50) NOT NULL DEFAULT '',
  `season` varchar(10) NOT NULL DEFAULT '',
  `notes` varchar(100) NOT NULL DEFAULT '',
  `tmp_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE results_staging MODIFY tour VARCHAR(100);


*/

-- obsolete this; just CTAS from results.
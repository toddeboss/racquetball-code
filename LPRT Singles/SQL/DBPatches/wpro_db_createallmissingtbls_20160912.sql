-- Catching up LPRT database tables so code works.

CREATE TABLE `banner` (
  `banner_text` varchar(250) DEFAULT NULL,
  `last_update_date` varchar(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `missed_tourney_rpt` (
  `season` varchar(10) DEFAULT NULL,
  `player` varchar(100) DEFAULT NULL,
  `missed` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `player_profile` (
  `player` varchar(50) DEFAULT NULL,
  `total_wins` int(11) DEFAULT NULL,
  `tourney_wins` int(11) DEFAULT NULL,
  `hometown` varchar(100) DEFAULT NULL,
  `current_residence` varchar(100) DEFAULT NULL,
  `height` varchar(10) DEFAULT NULL,
  `weight` varchar(4) DEFAULT NULL,
  `college` varchar(50) DEFAULT NULL,
  `sponsor` varchar(50) DEFAULT NULL,
  `dob` varchar(10) DEFAULT NULL,
  `l_r_flag` varchar(1) DEFAULT NULL,
  `current_age` int(11) DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `tmp_dob` date DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `rankings` (
  `season` varchar(10) DEFAULT NULL,
  `rank` varchar(5) DEFAULT NULL,
  `player` varchar(50) DEFAULT NULL,
  `points` int(11) DEFAULT NULL,
  `record` varchar(10) DEFAULT NULL,
  `prizemoney` varchar(10) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `rankings_source` (
  `season` varchar(10) DEFAULT NULL,
  `source` varchar(1000) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `season_summary_rpt` (
  `player` varchar(50) DEFAULT NULL,
  `wins` int(11) DEFAULT NULL,
  `finals` int(11) DEFAULT NULL,
  `semis` int(11) DEFAULT NULL,
  `quarters` int(11) DEFAULT NULL,
  `sixteens` int(11) DEFAULT NULL,
  `thirtytwos` int(11) DEFAULT NULL,
  `sixtyfours` int(11) DEFAULT NULL,
  `onetwentyeights` int(11) DEFAULT NULL,
  `twofiftysixes` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


CREATE TABLE `seedings` (
  `event` varchar(255) DEFAULT NULL,
  `seeding` int(11) DEFAULT NULL,
  `player` varchar(50) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `seedings_staging` (
  `event` varchar(255) DEFAULT NULL,
  `seeding` int(11) DEFAULT NULL,
  `player` varchar(50) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `tour_champions` (
  `season` varchar(10) DEFAULT NULL,
  `player` varchar(50) DEFAULT NULL,
  `player_dbname` varchar(50) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


CREATE TABLE `tourneys` (
  `tourney_pk` int(11) DEFAULT NULL,
  `city` varchar(30) DEFAULT NULL,
  `event` varchar(255) DEFAULT NULL,
  `date` varchar(20) DEFAULT NULL,
  `tmp_date` date DEFAULT NULL,
  `season` varchar(10) DEFAULT NULL,
  `major_flag` varchar(1) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `wins` (
  `winner` varchar(50) NOT NULL DEFAULT '',
  `wins` bigint(21) NOT NULL DEFAULT '0',
  KEY `wins_ndx` (`wins`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

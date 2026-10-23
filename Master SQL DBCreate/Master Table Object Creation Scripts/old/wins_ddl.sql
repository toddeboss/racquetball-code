CREATE TABLE `wins` (
  `winner` varchar(50) NOT NULL DEFAULT '',
  `wins` bigint(21) NOT NULL DEFAULT '0',
  KEY `wins_ndx` (`wins`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
DROP TABLE IF EXISTS `contribution_list`;
CREATE TABLE IF NOT EXISTS `contribution_list` (
  `NAME` varchar(24) NOT NULL,
  `DISCORD_ID` varchar(50) NOT NULL,
  UNIQUE KEY `DISCORD_ID` (`DISCORD_ID`),
  UNIQUE KEY `NAME` (`NAME`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `contribution_list`
--

INSERT INTO `contribution_list` (`NAME`, `DISCORD_ID`) VALUES
('LuciferM', 'LuciferM#3887'),
('traxyy', 'traxyy#6154');
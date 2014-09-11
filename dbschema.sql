USE `inform`;

DROP TABLE IF EXISTS `inform`.`all_gb_data`;
CREATE TABLE IF NOT EXISTS `inform`.`all_gb_data` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Nummer` int(11) NOT NULL DEFAULT '0',
  `Tag` int(11) DEFAULT NULL,
  `Monat` int(11) DEFAULT NULL,
  `Jahr` int(11) DEFAULT NULL,
  `Von` time DEFAULT NULL,
  `Bis` time DEFAULT NULL,
  `Stunden` double(4,2) DEFAULT NULL,
  `Projekt` int(5) DEFAULT NULL,
  `Position` varchar(4) DEFAULT NULL,
  `Beschreibung` varchar(1024) DEFAULT NULL,
  `LastChanges` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Key_UNIQUE` (`ID`),
  KEY `gbDataIndex` (`Nummer`,`Jahr`,`Monat`,`Tag`),
  KEY `MRProjects` (`Jahr`,`Monat`,`Projekt`)
  ) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;


DROP TABLE IF EXISTS `inform`.`all_gb_dekdata`;
CREATE TABLE IF NOT EXISTS `inform`.`all_gb_dekdata` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Nummer` int(11) NOT NULL DEFAULT '0',
  `Monat` int(11) DEFAULT NULL,
  `Jahr` int(11) DEFAULT NULL,
  `Projekt` int(5) DEFAULT NULL,
  `Stunden` double(10,2) DEFAULT NULL,
  `RK` double(10,2) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Key_UNIQUE` (`ID`),
  KEY `gbDekDataIndex` (`Nummer`,`Jahr`,`Monat`)
  ) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;


DROP TABLE IF EXISTS `inform`.`personaltable`;
CREATE TABLE IF NOT EXISTS `inform`.`personaltable` (
  `Nummer` int(11) NOT NULL DEFAULT '0',
  `Name` varchar(256) DEFAULT NULL,
  `UebStdReg` double DEFAULT NULL, # -1=Inklusive, 0=UeberstundenKonto, >0=Percent
  `StdPerWeek` double DEFAULT NULL,
  `JahresUrlaub` double DEFAULT NULL,
  `StdPerVacation` double DEFAULT NULL,
  `ActualVacation` double DEFAULT '0',
  `MDRechte` varchar(45) DEFAULT NULL,
  `PSRechte` varchar(45) DEFAULT NULL,
  `Hinweis` varchar(512) DEFAULT NULL,
  `GB` varchar(45) DEFAULT NULL,
  `U_GB` varchar(45) DEFAULT NULL,
  `U_FTE` double DEFAULT NULL,
  `U_Kopf` int(11) DEFAULT NULL,
  `U_AC` int(11) DEFAULT NULL,
  `isDeleted` tinyint(4) NOT NULL DEFAULT '0',
  `Password` text,
  `CanUseMPP` tinyint(4) NOT NULL DEFAULT '0', 
  `CanUseME` tinyint(4) NOT NULL DEFAULT '0', # MonlistPersonalEditor
  `CanUseMPJ` tinyint(4) NOT NULL DEFAULT '0', # MonlistProjectEditor
  `CanUseMR` tinyint(4) NOT NULL DEFAULT '0', # MonlistReader
  `CanUseMC` tinyint(4) NOT NULL DEFAULT '0', # MonChecker
  `CanUseMM` tinyint(4) NOT NULL DEFAULT '0', # MonMake
  `CanExportKIData` tinyint(4) NOT NULL DEFAULT '0', # MonMake, exporting KI Data
  `CanExportGBData` tinyint(4) NOT NULL DEFAULT '0', # MonMake, exporting GB Data
  `CanExportMRDeckblattData` tinyint(4) NOT NULL DEFAULT '0', # MonlistReader, exporting MR Data (Deckblatt)
  `CanExportMRHiWiData` tinyint(4) NOT NULL DEFAULT '0', # MonlistReader, exporting MR Data (only HiWis)
  `HolidayAddOnStartDate` date DEFAULT NULL,
  `LastChanges` varchar(1024) DEFAULT NULL,
  `Bundesland` tinyint(4) NOT NULL DEFAULT '9', # welches Bundesland: 6 = Hessen, 9 = NRW
  PRIMARY KEY (`Nummer`)
  ) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;


DROP TABLE IF EXISTS `inform`.`projekte`;
CREATE TABLE IF NOT EXISTS `inform`.`projekte` (
  `Nummer` int(11) NOT NULL DEFAULT '0',
  `Kennb1` varchar(5) DEFAULT NULL,
  `Kennb2` varchar(5) DEFAULT NULL,
  `Kennb3` varchar(5) DEFAULT NULL,
  `IsOld` tinyint(4) NOT NULL DEFAULT '0',
  `Beschreibung` varchar(512) DEFAULT NULL,
  `LastChanges` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`Nummer`)
  ) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;


DROP TABLE IF EXISTS `inform`.`holiday_data`;
CREATE TABLE IF NOT EXISTS `inform`.`holiday_data` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Nummer` int(11) NOT NULL DEFAULT '0',
  `Monat` int(11) DEFAULT NULL,
  `Jahr` int(11) DEFAULT NULL,
  `OldHoliday` double DEFAULT NULL,
  `Holiday` double DEFAULT NULL,
  `NewHoliday` double DEFAULT NULL,
  `HoursPerHoliday` double DEFAULT NULL, # welche stunden pro urlaubstag galten bei diesem urlaub
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Key_UNIQUE` (`ID`),
  KEY `holidayDataIndex` (`Nummer`,`Jahr`,`Monat`)
  ) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;


DROP TABLE IF EXISTS `inform`.`deckblatt_data`;
CREATE TABLE IF NOT EXISTS `inform`.`deckblatt_data` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Nummer` int(11) NOT NULL DEFAULT '0',
  `Monat` int(11) DEFAULT NULL,
  `Jahr` int(11) DEFAULT NULL,
  `OvertimeOld` double DEFAULT NULL,
  `OvertimeNew` double DEFAULT NULL,
  `PaidOvertime` double DEFAULT NULL,
  `StdPerWeek` double DEFAULT NULL, # welche stunden pro woche wurden diesen monat genommen
  `UebStdReg` double DEFAULT NULL, # welche überstundenregelung galt diesen monat
  `IsOpen` tinyint(4) NOT NULL DEFAULT '0', # deckblatt offen?
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Key_UNIQUE` (`ID`),
  KEY `dataIndex` (`Nummer`,`Jahr`,`Monat`)
  ) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;


DROP TABLE IF EXISTS `inform`.`holiday_history`;
CREATE TABLE IF NOT EXISTS `inform`.`holiday_history` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Nummer` int(11) NOT NULL DEFAULT '0',
  # log date
  `Date` DATETIME(3) DEFAULT NULL,
  # welcher typ des eintrags => THolidayEntry = (0=heUnkown, 1=heInitial, 2=heDeckBlatt, 3=heNewYear, 4=heChange, 5=heDelete, 6=heSonderUrlaub, 7=heAustritt);
  `EntryType` smallint NOT NULL DEFAULT '0',
  # Monat und Jahr vom Deckblatt
  `Monat` int(11) DEFAULT NULL,
  `Jahr` int(11) DEFAULT NULL,
  # Urlaubstunden pro Tag
  `HoursPerHoliday` double DEFAULT NULL,
  # geänderte Urlaubstunden
  `ChangedHoliday` double DEFAULT NULL,
  # Urlaub nach der Änderung
  `NewHoliday` double DEFAULT NULL,
  # ein Kommentar
  `Comment` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Key_UNIQUE` (`ID`),
  KEY `holidayhistoryIndex` (`Nummer`,`Jahr`,`Monat`)
  ) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;


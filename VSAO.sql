-- phpMyAdmin SQL Dump
-- version 3.4.11.1deb2+deb7u4
-- http://www.phpmyadmin.net
--
-- Client: localhost
-- Généré le: Mer 31 Août 2016 à 17:00
-- Version du serveur: 5.5.49
-- Version de PHP: 5.4.45-0+deb7u4

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données: `VSAO`
--

-- --------------------------------------------------------

--
-- Structure de la table `Accounts`
--

CREATE TABLE IF NOT EXISTS `Accounts` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Ip` varchar(16) NOT NULL,
  `Staff` tinyint(1) NOT NULL DEFAULT '0',
  `Logged` smallint(5) unsigned NOT NULL DEFAULT '65535',
  `Username` varchar(24) NOT NULL,
  `Password` varchar(128) NOT NULL,
  `Mute` int(10) unsigned NOT NULL DEFAULT '0',
  `Level` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `Xp` int(11) unsigned NOT NULL DEFAULT '0',
  `XpMax` int(11) unsigned NOT NULL DEFAULT '1500',
  `Class` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Kills` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Deaths` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Likes` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `GamesPlayed` smallint(5) unsigned NOT NULL DEFAULT '0',
  `GamesWon` smallint(5) unsigned NOT NULL DEFAULT '0',
  `GamesLost` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

-- --------------------------------------------------------

--
-- Structure de la table `IPBans`
--

CREATE TABLE IF NOT EXISTS `IPBans` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `IP` varchar(15) NOT NULL,
  `RaisonBan` varchar(144) NOT NULL,
  `BanPar` varchar(24) NOT NULL,
  `TempsBan` int(11) NOT NULL,
  `HeureBan` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `UsernameBans`
--

CREATE TABLE IF NOT EXISTS `UsernameBans` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Username` varchar(24) NOT NULL,
  `RaisonBan` varchar(144) NOT NULL,
  `BanPar` varchar(24) NOT NULL,
  `TempsBan` int(11) NOT NULL,
  `HeureBan` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `Whitelist`
--

CREATE TABLE IF NOT EXISTS `Whitelist` (
  `Username` varchar(24) NOT NULL,
  PRIMARY KEY (`Username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

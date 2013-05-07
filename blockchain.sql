-- phpMyAdmin SQL Dump
-- version 3.5.6
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: May 07, 2013 at 10:37 PM
-- Server version: 5.1.66-MariaDB
-- PHP Version: 5.3.22

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `blockchain`
--

-- --------------------------------------------------------

--
-- Table structure for table `addr_tx`
--

CREATE TABLE IF NOT EXISTS `addr_tx` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address` varchar(34) COLLATE utf8_unicode_ci NOT NULL,
  `tx_ref` char(64) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=10120 ;

-- --------------------------------------------------------

--
-- Table structure for table `blocks`
--

CREATE TABLE IF NOT EXISTS `blocks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hash` char(64) COLLATE utf8_unicode_ci NOT NULL,
  `confirmations` int(11) NOT NULL,
  `size` int(11) NOT NULL,
  `height` int(11) NOT NULL,
  `version` int(11) NOT NULL,
  `merkleroot` char(64) COLLATE utf8_unicode_ci NOT NULL,
  `time` int(11) NOT NULL,
  `nonce` int(11) NOT NULL,
  `bits` varchar(16) COLLATE utf8_unicode_ci NOT NULL,
  `difficulty` double NOT NULL,
  `previousblockhash` char(64) COLLATE utf8_unicode_ci NOT NULL,
  `nextblockhash` char(64) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hash` (`hash`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=10001 ;

-- --------------------------------------------------------

--
-- Table structure for table `tx`
--

CREATE TABLE IF NOT EXISTS `tx` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `height` int(11) NOT NULL,
  `tx` char(64) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=10093 ;

-- --------------------------------------------------------

--
-- Table structure for table `tx_detail`
--

CREATE TABLE IF NOT EXISTS `tx_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hex` text COLLATE utf8_unicode_ci NOT NULL,
  `tx` char(64) COLLATE utf8_unicode_ci NOT NULL,
  `version` int(11) NOT NULL,
  `locktime` int(11) NOT NULL,
  `block` char(64) COLLATE utf8_unicode_ci NOT NULL,
  `confirmations` int(11) NOT NULL,
  `time` int(11) NOT NULL,
  `blocktime` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tx` (`tx`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=10093 ;

-- --------------------------------------------------------

--
-- Table structure for table `tx_vin`
--

CREATE TABLE IF NOT EXISTS `tx_vin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_tx` char(64) COLLATE utf8_unicode_ci NOT NULL,
  `tx` char(64) COLLATE utf8_unicode_ci NOT NULL,
  `vout` int(11) NOT NULL,
  `sequence` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tx_vout`
--

CREATE TABLE IF NOT EXISTS `tx_vout` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_tx` char(64) COLLATE utf8_unicode_ci NOT NULL,
  `value` double NOT NULL,
  `n` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=10120 ;

-- --------------------------------------------------------

--
-- Table structure for table `tx_vout_addr`
--

CREATE TABLE IF NOT EXISTS `tx_vout_addr` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_tx` char(64) COLLATE utf8_unicode_ci NOT NULL,
  `address` char(34) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=10120 ;

-- --------------------------------------------------------

--
-- Table structure for table `tx_vout_spk`
--

CREATE TABLE IF NOT EXISTS `tx_vout_spk` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_tx` char(64) COLLATE utf8_unicode_ci NOT NULL,
  `asm` text COLLATE utf8_unicode_ci NOT NULL,
  `hex` text COLLATE utf8_unicode_ci NOT NULL,
  `req_sigs` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=10120 ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

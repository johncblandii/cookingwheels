# Sequel Pro dump
# Version 2492
# http://code.google.com/p/sequel-pro
#
# Host: cookingwheels.com (MySQL 5.0.77)
# Database: cookingwheels_dev
# Generation Time: 2010-08-13 05:01:24 -0500
# ************************************************************

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table comments
# ------------------------------------------------------------

DROP TABLE IF EXISTS `comments`;

CREATE TABLE `comments` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `userid` int(11) unsigned NOT NULL,
  `recipeid` int(11) unsigned NOT NULL,
  `createdat` datetime default NULL,
  `updatedat` datetime default NULL,
  `deletedat` datetime default NULL,
  `details` text NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `userid` (`userid`),
  KEY `recipeid` (`recipeid`),
  CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`recipeid`) REFERENCES `recipes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table reciperatings
# ------------------------------------------------------------

DROP TABLE IF EXISTS `reciperatings`;

CREATE TABLE `reciperatings` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `userid` int(11) unsigned NOT NULL,
  `recipeid` int(11) unsigned NOT NULL,
  `createdat` datetime default NULL,
  `updatedat` datetime default NULL,
  `deletedat` datetime default NULL,
  `rating` float default NULL,
  PRIMARY KEY  (`id`),
  KEY `userid` (`userid`),
  KEY `recipeid` (`recipeid`),
  CONSTRAINT `reciperatings_ibfk_2` FOREIGN KEY (`recipeid`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `reciperatings_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table recipes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `recipes`;

CREATE TABLE `recipes` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `userid` int(11) unsigned NOT NULL,
  `lasteditedbyuserid` int(11) unsigned NOT NULL,
  `createdat` datetime default NULL,
  `updatedat` datetime default NULL,
  `deletedat` datetime default NULL,
  `title` varchar(140) NOT NULL,
  `problem` varchar(500) default NULL,
  `solution` varchar(500) default NULL,
  `details` text,
  PRIMARY KEY  (`id`),
  KEY `userid` (`userid`),
  KEY `lasteditedbyuserid` (`lasteditedbyuserid`),
  CONSTRAINT `recipes_ibfk_2` FOREIGN KEY (`lasteditedbyuserid`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `recipes_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table recipetags
# ------------------------------------------------------------

DROP TABLE IF EXISTS `recipetags`;

CREATE TABLE `recipetags` (
  `recipeid` int(11) unsigned default NULL,
  `tagid` int(11) unsigned default NULL,
  KEY `recipeid` (`recipeid`),
  KEY `tagid` (`tagid`),
  CONSTRAINT `recipetags_ibfk_2` FOREIGN KEY (`tagid`) REFERENCES `tags` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `recipetags_ibfk_1` FOREIGN KEY (`recipeid`) REFERENCES `recipes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table tags
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tags`;

CREATE TABLE `tags` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `name` varchar(140) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `usertypeid` int(11) NOT NULL,
  `createdat` datetime default NULL,
  `updatedat` datetime default NULL,
  `deletedat` datetime default NULL,
  `isactive` char(1) default '1',
  `ispasswordreset` char(1) default '0',
  `username` varchar(25) NOT NULL,
  `password` varchar(250) NOT NULL,
  `passwordsalt` varchar(250) default NULL,
  `firstname` varchar(50) default NULL,
  `middleinitial` varchar(2) default NULL,
  `lastname` varchar(50) default NULL,
  `suffix` varchar(50) default NULL,
  `emailaddress` varchar(140) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `usertypeid` (`usertypeid`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`usertypeid`) REFERENCES `usertypes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table usertypes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `usertypes`;

CREATE TABLE `usertypes` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(50) NOT NULL,
  `description` varchar(50) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

LOCK TABLES `usertypes` WRITE;
/*!40000 ALTER TABLE `usertypes` DISABLE KEYS */;
INSERT INTO `usertypes` (`id`,`title`,`description`)
VALUES
	(1,'Administrator','Main Dude'),
	(2,'User','Random Somebody');

/*!40000 ALTER TABLE `usertypes` ENABLE KEYS */;
UNLOCK TABLES;





/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

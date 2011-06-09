# Host: cookingwheels.com (MySQL 5.1.54)
# Database: cookingwheels_prod
# Generation Time: 2011-06-09 16:05:07 -0500
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
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(11) unsigned NOT NULL,
  `recipeid` int(11) unsigned NOT NULL,
  `createdat` datetime DEFAULT NULL,
  `updatedat` datetime DEFAULT NULL,
  `deletedat` datetime DEFAULT NULL,
  `details` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
  KEY `recipeid` (`recipeid`),
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`recipeid`) REFERENCES `recipes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

# Dump of table reciperatings
# ------------------------------------------------------------

DROP TABLE IF EXISTS `reciperatings`;

CREATE TABLE `reciperatings` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(11) unsigned NOT NULL,
  `recipeid` int(11) unsigned NOT NULL,
  `createdat` datetime DEFAULT NULL,
  `updatedat` datetime DEFAULT NULL,
  `deletedat` datetime DEFAULT NULL,
  `rating` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
  KEY `recipeid` (`recipeid`),
  CONSTRAINT `reciperatings_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `reciperatings_ibfk_2` FOREIGN KEY (`recipeid`) REFERENCES `recipes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# Dump of table recipes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `recipes`;

CREATE TABLE `recipes` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(11) unsigned NOT NULL,
  `lasteditedbyuserid` int(11) unsigned NOT NULL,
  `createdat` datetime DEFAULT NULL,
  `updatedat` datetime DEFAULT NULL,
  `deletedat` datetime DEFAULT NULL,
  `approvedat` datetime DEFAULT NULL,
  `title` varchar(140) NOT NULL,
  `problem` varchar(500) DEFAULT NULL,
  `solution` varchar(500) DEFAULT NULL,
  `details` text,
  `documentationlink` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
  KEY `lasteditedbyuserid` (`lasteditedbyuserid`),
  CONSTRAINT `recipes_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `recipes_ibfk_2` FOREIGN KEY (`lasteditedbyuserid`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

# Dump of table recipetags
# ------------------------------------------------------------

DROP TABLE IF EXISTS `recipetags`;

CREATE TABLE `recipetags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `recipeid` int(11) unsigned DEFAULT NULL,
  `tagid` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `recipeid` (`recipeid`),
  KEY `tagid` (`tagid`),
  CONSTRAINT `recipetags_ibfk_1` FOREIGN KEY (`recipeid`) REFERENCES `recipes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `recipetags_ibfk_2` FOREIGN KEY (`tagid`) REFERENCES `tags` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;

# Dump of table settings
# ------------------------------------------------------------

DROP TABLE IF EXISTS `settings`;

CREATE TABLE `settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `keyname` varchar(50) NOT NULL,
  `value` varchar(250) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` (`id`,`keyname`,`value`)
VALUES
	(1,'twitter.consumerkey','test'),
	(2,'twitter.consumersecret','test'),
	(3,'email.from.default','noreply@cookingwheels.com'),
	(4,'email.registration.subject','[Cooking Wheels] Thank you for registering!'),
	(5,'email.recipe.new.subject','[Cooking Wheels] New Recipe'),
	(6,'email.passwordreset.subject','[Cooking Wheels] Password Reset'),
	(7,'email.passwordchanged.subject','[Cooking Wheels] Password Changed'),
	(8,'email.to.admins','dev-team@cookingwheels.com');

/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table tags
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tags`;

CREATE TABLE `tags` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(140) NOT NULL,
  `slug` varchar(140) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

# Dump of table users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `usertypeid` int(11) DEFAULT '2',
  `createdat` datetime DEFAULT NULL,
  `updatedat` datetime DEFAULT NULL,
  `deletedat` datetime DEFAULT NULL,
  `isactive` char(1) DEFAULT '1',
  `ispasswordreset` char(1) DEFAULT '0',
  `username` varchar(25) NOT NULL,
  `password` varchar(250) DEFAULT NULL,
  `passwordsalt` varchar(250) DEFAULT NULL,
  `emailaddress` varchar(140) NOT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `middleinitial` varchar(2) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `suffix` varchar(50) DEFAULT NULL,
  `twitterusername` varchar(140) DEFAULT NULL,
  `facebookurl` varchar(250) DEFAULT NULL,
  `siteurl` varchar(250) DEFAULT NULL,
  `oauthtoken` varchar(250) DEFAULT NULL,
  `oauthsecret` varchar(250) DEFAULT NULL,
  `about` text,
  `profileimageurl` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `usertypeid` (`usertypeid`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`usertypeid`) REFERENCES `usertypes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

# Dump of table usertypes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `usertypes`;

CREATE TABLE `usertypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `description` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
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

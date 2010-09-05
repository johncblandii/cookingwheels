# Sequel Pro dump
# Version 2492
# http://code.google.com/p/sequel-pro
#
# Host: dev.cookingwheels.com (MySQL 5.0.77)
# Database: cookingwheels_dev
# Generation Time: 2010-09-04 22:58:47 -0500
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;



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
  CONSTRAINT `reciperatings_ibfk_2` FOREIGN KEY (`recipeid`) REFERENCES `recipes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
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
  `approvedat` datetime default NULL,
  `title` varchar(140) NOT NULL,
  `problem` varchar(500) default NULL,
  `solution` varchar(500) default NULL,
  `details` text,
  `documentationlink` varchar(500) default NULL,
  PRIMARY KEY  (`id`),
  KEY `userid` (`userid`),
  KEY `lasteditedbyuserid` (`lasteditedbyuserid`),
  CONSTRAINT `recipes_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `recipes_ibfk_2` FOREIGN KEY (`lasteditedbyuserid`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

LOCK TABLES `recipes` WRITE;
/*!40000 ALTER TABLE `recipes` DISABLE KEYS */;
INSERT INTO `recipes` (`id`,`userid`,`lasteditedbyuserid`,`createdat`,`updatedat`,`deletedat`,`approvedat`,`title`,`problem`,`solution`,`details`,`documentationlink`)
VALUES
	(1,5,5,'2010-08-16 00:52:42',NULL,NULL,'2010-08-16 00:52:42','Sending emails from Google','You have a Google Apps account and wish to send emails using their SMTP servers. ','Use the sendEmail() function and specify the useSSL, server, and port attributes to match gmail\'s requirements. ','The sendEmail() function wraps around the CFMAIL tag and because GMail\'s servers require a secure connection you need to specify the following code in your /config/settings.cfm file (or in the appropriate Wheels environment)\r\n\n[code]\n<cfset set(functionName=\"sendEmail\", \r\n      server=\"smtp.gmail.com\", \r\n      username=\"yourEmail@yourwebsite.com\", \r\n      password=\"yourPassword\", \r\n      port=\"587\", useTLS=\"yes\")/>\r\n[/code]\n\nThe previous piece of code will set a default setting for all the sendEmail() functions used in your application, so all that is left is send the desired email from your controller like so:\r\n\r\n[code]\n<cfset sendEmail(from=\"yourEmail@yourwebsite.com\", \r\n    to=\"recipient@hiswebsite.com\", \r\n    subject=\"Email subject\", \r\n    template=\"yourEmailTemplateViewFile\", \r\n    type=\"html\") />\r\n[/code]\n\r\nRemember that the content of the email will be stored in the file you pass into the template argument. A quick \"gotcha\" moment: by default the type argument is set to \"text\" in the CFMAIL tag, so be sure to pass in type=\"html\" if your emails will be formatted.',NULL),
	(2,5,5,'2010-08-16 00:54:54',NULL,NULL,'2010-08-16 00:52:42','Preventing users from using free email services in your applications','You need to custom validate the email addresses your users use to register to your application. ','Use the validate() function and specify the method that will use to custom validate your user\'s email. ','The validate() function accepts a method name argument, which will perform the validation you wish to perform. Head into /models/User.cfc (your user model file) and add following line of code inside your init() function.\r\n\n[code]\r\n<cfset validate(methods=\"advancedEmailValidation\")>\r\n[/code]\r\nThe previous piece of code will perform the \"advancedEmailValidation\" on every create and update events in your user model. Now, let\'s add the \"advancedEmailValidation\" function somewhere in your model file.\r\n\n[code]\r\n<cffunction name=\"advancedEmailValidation\" access=\"private\">\r\n    <cfset var loc = {}>\r\n    \r\n    <!--- Invalid email providers --->\r\n    <cfset loc.invalidEmailProviders = \"live.com, hotmail.com, msn.com, gmail.com, yahoo.com, yahoo.es\">\r\n    \r\n    <!--- Extract email URL --->\r\n    <cfset loc.emailURL = Trim(ListLast(this.email, \"@\"))>\r\n    \r\n    <!--- Reject all emails from \"free services\" --->\r\n    <cfif ListFind(loc.invalidEmailProviders, loc.emailURL)>\r\n        <cfset this.addError(property=\"email\", message=\"Sorry no free email accounts will be accepted\")>\r\n    </cfif>\r\n</cffunction> \r\n[/code]\r\nThat application will prevent users from using \"free email services\" to register to your application, this could be useful in enterprise applications where you want your users to only register themselves with the email address from their own company.',NULL),
	(3,1,1,'2010-08-30 11:03:15',NULL,NULL,'2010-08-16 00:52:42','Validating Email Addresses','How do you validate email addresses?','Use the validatesFormatOf function in your model.','[code]\r\n<cfset validatesFormatOf(property=\"email\" format=\"email\" />\r\n[/code]\r\nThis assumes you have a column your model\'s table named \'email\'. You can also set the default message to show up as well by passing the argument property to the above function.',NULL),
	(4,1,1,'2010-09-04 22:09:09',NULL,NULL,NULL,'code test <cfset b = 1 />','<cfset b = 1 />','<cfset b = 1 />','<cfset b = 1 />',NULL);

/*!40000 ALTER TABLE `recipes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table recipetags
# ------------------------------------------------------------

DROP TABLE IF EXISTS `recipetags`;

CREATE TABLE `recipetags` (
  `id` int(11) NOT NULL auto_increment,
  `recipeid` int(11) unsigned default NULL,
  `tagid` int(11) unsigned default NULL,
  PRIMARY KEY  (`id`),
  KEY `recipeid` (`recipeid`),
  KEY `tagid` (`tagid`),
  CONSTRAINT `recipetags_ibfk_1` FOREIGN KEY (`recipeid`) REFERENCES `recipes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `recipetags_ibfk_2` FOREIGN KEY (`tagid`) REFERENCES `tags` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

LOCK TABLES `recipetags` WRITE;
/*!40000 ALTER TABLE `recipetags` DISABLE KEYS */;
INSERT INTO `recipetags` (`id`,`recipeid`,`tagid`)
VALUES
	(1,1,1),
	(2,2,2),
	(3,1,2),
	(4,1,3),
	(5,1,4),
	(6,1,5),
	(11,3,8),
	(12,3,3),
	(17,3,9),
	(18,4,7);

/*!40000 ALTER TABLE `recipetags` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table settings
# ------------------------------------------------------------

DROP TABLE IF EXISTS `settings`;

CREATE TABLE `settings` (
  `id` int(11) NOT NULL auto_increment,
  `keyname` varchar(50) NOT NULL,
  `value` varchar(250) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

LOCK TABLES `settings` WRITE;

/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table tags
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tags`;

CREATE TABLE `tags` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `name` varchar(140) NOT NULL,
  `slug` varchar(140) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
INSERT INTO `tags` (`id`,`name`,`slug`)
VALUES
	(1,'controller','controller'),
	(2,'model','model'),
	(3,'email','email'),
	(4,'google','google'),
	(5,'gmail','gmail'),
	(7,'test','test'),
	(8,'validation','validation'),
	(9,'validatesFormatOf','validatesFormatOf');

/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `usertypeid` int(11) default '2',
  `createdat` datetime default NULL,
  `updatedat` datetime default NULL,
  `deletedat` datetime default NULL,
  `isactive` char(1) default '1',
  `ispasswordreset` char(1) default '0',
  `username` varchar(25) NOT NULL,
  `password` varchar(250) default NULL,
  `passwordsalt` varchar(250) default NULL,
  `emailaddress` varchar(140) NOT NULL,
  `firstname` varchar(50) default NULL,
  `middleinitial` varchar(2) default NULL,
  `lastname` varchar(50) default NULL,
  `suffix` varchar(50) default NULL,
  `twitterusername` varchar(140) default NULL,
  `facebookurl` varchar(250) default NULL,
  `siteurl` varchar(250) default NULL,
  `oauthtoken` varchar(250) default NULL,
  `oauthsecret` varchar(250) default NULL,
  `about` text,
  `profileimageurl` varchar(250) default NULL,
  PRIMARY KEY  (`id`),
  KEY `usertypeid` (`usertypeid`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`usertypeid`) REFERENCES `usertypes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`,`usertypeid`,`createdat`,`updatedat`,`deletedat`,`isactive`,`ispasswordreset`,`username`,`password`,`passwordsalt`,`emailaddress`,`firstname`,`middleinitial`,`lastname`,`suffix`,`twitterusername`,`facebookurl`,`siteurl`,`oauthtoken`,`oauthsecret`,`about`,`profileimageurl`)
VALUES
	(1,2,'2010-08-13 17:04:14','2010-09-04 15:55:25',NULL,'1','0','johncblandii','CF25BE5EC0FE2D18EED2E249DEF548C2A9EEAF95E99943A37763C0BD012B5EE8A64977C3E7C8F46CCDB68EF1770B635E7097758DC4C04EB58D9C2B8503FD3138','7146A7B','iam@johncblandii.com','John','C','Bland','II','johncblandii','','http://johncblandii.com',NULL,NULL,'my about',NULL),
	(4,2,'2010-08-15 19:55:04',NULL,NULL,'1','0','warrenbrown','CB4BA6A94EC5ABB9AE9326AFBC432815E7269558384894DE619A61C0291A6F622503DEF0EF7844C1399DBBCA969DA02135255D3BE2FF7B922848427C5BD993EE','E63CD11','warren@katapultmedia.com','Warren','M','Brown',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(5,2,'2010-08-16 00:51:46',NULL,NULL,'1','0','raulriera','0AD47189CB8915F353F6841FC2264894E1BD00F48CC8C38563AC48FDC801F311F7B042DA377D1C6F37C7E478C6418EE5353D42ECA45FD2241C756F7B12D728C4','0ADA3AF','rieraraul@gmail.com','Raul','A','Riera','Di Cristofaro',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(10,2,'2010-08-30 18:14:06','2010-08-31 01:05:36',NULL,'1','0','cookingwheels',NULL,NULL,'john@katapultmedia.com','Cooking',NULL,'Wheels',NULL,'cookingwheels',NULL,'http://cookingwheels.com','180693857-JxUHqzEJX3PtCfgpcaSghDIADwHoI8iDhcnfnu4m','GzGWDyECfSQfxSAGB06jIQd8u2vRZswlZ2b30Erclk','The Official CFWheels Cookbook &lt;br &#x2f;&gt;','http://a3.twimg.com/profile_images/1114292651/wheelstwitter_normal.png');

/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;


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

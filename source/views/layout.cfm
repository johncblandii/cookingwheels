<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>CFWheels Cookbook | Cooking Wheels</title>
		<link rel="shortcut icon" type="image/x-icon" href="/images/wheels-icon-16x16.png" />
		<link href="/stylesheets/base.css" media="all" rel="stylesheet" type="text/css" />
		<link href="/stylesheets/home.css" media="all" rel="stylesheet" type="text/css" />
		<link href="/stylesheets/print.css" media="print" rel="stylesheet" type="text/css" />
		<!--[if IE]><link href="stylesheets/base_ie.css" media="all" rel="stylesheet" type="text/css" />
					 <![endif]-->
		<!--[if IE 6]><link href="stylesheets/base_ie6.css" media="all" rel="stylesheet" type="text/css" />
					 <![endif]-->
		<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.1/jquery.min.js"></script>
		<script type="text/javascript" src="http://cdn.jquerytools.org/1.1.1/jquery.tools.min.js"></script>
		<script src="http://www.google.com/jsapi" type="text/javascript"></script>
		<script src="/javascripts/tiny_mce/jquery.tinymce.js" type="text/javascript"></script>
		<script type="text/javascript" src="/javascripts/init.js?200901250704"></script>
		<script type="text/javascript" src="http://www.google.com/cse/brand?form=cse-search-box&amp;lang=en"></script>
		<meta name="verify-v1" content="lr62spbjTwfzF6tzGhCR+WvuJHNUEe4F9T6H0m4T7XM=" />
		<link rel="alternate" type="application/rss+xml" title="ColdFusion on Wheels Cookbook" href="/rss" />
	</head>
	<body>
	<cfoutput>
		<div id="wrapper">
			<div id="header">
				<div id="logo"> <a class="image" href="/" title="Home"><img alt="ColdFusion on Wheels" height="121" src="/images/cfwheels-logo.png" width="93" /></a> </div>
				<div id="tagline"> An open source <abbr title="ColdFusion on Wheels">CFWheels</abbr> site<br />for the community. </div>
				<div id="utility">
					<ul class="inline">
						<li class="first"> <strong>Welcome, <cfif isLoggedIn()>#linkTo(route="userprofile", userid=session.user.id, text=session.user.getDisplayName())#<cfelse>guest</cfif>!</strong> </li>
						<cfif isLoggedIn()>
							<li>#linkTo(controller="user", action="signout", text="Sign Out")#</li>
						<cfelse>
							<li>#linkTo(controller="user", action="signup", text="Sign Up")#</li>
							<li>#linkTo(controller="user", action="signin", text="Sign In")#</li>
						</cfif>
						<!---
						<li class="first">
							<div id="site-search">
								#startFormTag(id="cse-search-box", method="get", controller="search")#
									<div>
										<input type="hidden" name="cx" value="005724978648843866544:jpej79qhz14" />
										<input type="hidden" name="cof" value="FORID:10" />
										<input type="hidden" name="ie" value="UTF-8" />
										<input id="search-query" type="text" name="q" />
										<input type="submit" name="sa" value="Search" />
									</div>
								#endFormTag()#
							</div>
						</li>
						--->
					</ul>
				</div>
				<div id="global-navigation">#includePartial("/cooking/nav")#</div>
				<div id="breadcrumbs">
					<div id="feeds">#linkTo(route="rss", text=imageTag("rss_icon.png"))#</div>
					<a href="/">Home</a> / <strong>Cookbook</strong></div>
			</div>
			<div id="contentWrapper" class="content">
				<div id="content">
					<div id="local-navigation">
						#includePartial("/cooking/sidebar")#
					</div>
					<div class="has-local-navigation">
						#contentForLayout()#
					</div>
				</div>
			</div>
			<div id="footer">
				<div class="content">
					<p id="hosting">Follow us: <a href="http://twitter.com/cookingwheels">#imageTag("twitter_icon.png")#</a></p>
					<p class="copyright"> &copy; #dateformat(now(), "yyyy")# ColdFusion on Wheels<br />
						Wheels is licensed under the <a href="http://www.apache.org/licenses/LICENSE-2.0">Apache License, Version 2.0</a>. </p>
				</div>
			</div>
		</div>
	</cfoutput>
	</body>
</html>
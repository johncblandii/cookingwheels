<cfparam name="pagetitle" type="string" default="ColdFusion On Wheels Cookbook">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title><cfoutput>#pagetitle#</cfoutput> | Cooking Wheels</title>
		<link rel="alternate" type="application/rss+xml" title="ColdFusion on Wheels Cookbook" href="/rss" />
		<link href="/stylesheets/reset.css" rel="stylesheet" type="text/css" />
		<link href="/stylesheets/cooking.css" rel="stylesheet" type="text/css" />
		<!--[if !IE 7]>
			<style type="text/css">
				.wrapper{display:table;height:100%}
			</style>
		<![endif]-->
		<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.1/jquery.min.js"></script>
		<script type="text/javascript" src="http://cdn.jquerytools.org/1.1.1/jquery.tools.min.js"></script>
		<script type="text/javascript" src="http://platform.twitter.com/anywhere.js?id=QPpFbBgDWaGzm6sAfm2ow&v=1"></script>
		<script type="text/javascript" src="http://platform.twitter.com/widgets.js"></script>
		<script type="text/javascript" src="http://widgets.twimg.com/j/2/widget.js"></script>
		<script type="text/javascript" src="/javascripts/tiny_mce/jquery.tinymce.js"></script>
		<script type="text/javascript" src="/javascripts/cooking.js"></script>
	</head>
	<body>
	<cfoutput>
		<div class="wrapper">
			<div class="header">
				<a class="logo" href="/" title="Home">Cooking Wheels</a>
				<ul class="utilities">
					<li class="withborder">Welcome, <cfif isLoggedIn()>#linkTo(route="userprofile", userid=session.user.id, text=session.user.getDisplayName())#<cfelse>guest</cfif>!</li>
					<cfif isLoggedIn()>
						<li>#linkTo(controller="user", action="signout", text="Sign Out")#</li>
					<cfelse>
						<li class="withborder">#linkTo(controller="user", action="signup", text="Sign Up")#</li>
						<li>#linkTo(controller="user", action="signin", text="Sign In")#</li>
					</cfif>
				</ul>
				#includePartial("/cooking/nav")#
			</div>
			<div class="content">
				<div class="left">
					<div class="content">
						#contentForLayout()#
						
						<div class="tweetthis">
							<a href="http://twitter.com/share" class="twitter-share-button" data-count="horizontal" data-via="cookingwheels">Tweet</a><script type="text/javascript" src="http://platform.twitter.com/widgets.js"></script>
						</div>
					</div>
				</div>
				<div class="right">
					#includePartial("/cooking/sidebar")#
				</div>
				<div class="paddles"></div>
			</div>
		</div>
		<div class="footer">
			<div class="wrapper">
				<div class="block">
					<h3>Subscribe and Connect</h3>
					<ul>
						<li class="icon twitter"><a href="http://twitter.com/cookingwheels">Twitter</a></li>
						<li class="icon rss"><a href="/rss">RSS Feed</a></li>
					</ul>
				</div>
				<div class="block">
					<h3>Credits & Connect</h3>
					<ul>
						<li>Created by <a href="http://johncblandii.com">John C. Bland II</a></li>
						<li>Designed by <a href="">Chris Peters</a></li>
						<li>Inspired by <a href="http://coldfusioncookbook.com">ColdFusion Cookbook</a></li>
					</ul>
				</div>
				<div class="block">
					<h3>Powered by...</h3>
					<a href="##" class="cfwheels">ColdFusion on Wheels</a>
					<p>Built with <br /><a href="##">ColdFusion on Wheels</a>.</p>
					<p><a href="##">Download the<br />source code</a> at GitHub.</p>
				</div>
			</div>
		</div>
		#googleAnalyticsTag()#
	</cfoutput>
	</body>
</html>
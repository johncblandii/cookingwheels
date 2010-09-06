<cfoutput>
	<h1 class="withcredits">Sign In</h1>
	<p class="credits">Authenticate directly or with Twitter.</p>
	
	#outputFlash("error", "error")#
	
	<div class="twitterconnect">
		#linkTo(route="authtwitter", text="<img src='http://twitter-badges.s3.amazonaws.com/t_logo-c.png' alt='Follow cookingwheels on Twitter'/>")#
	</div>
	
	<h2>-or-</h2>
	#errorMessagesFor("$user")#
	#startFormTag()#
		#textField(label="Username", objectname="$user", property="username")#
		#passwordField(label="Password", objectname="$user", property="password")#
		#submitTag(value="Sign In")#
	#endFormTag()#
	
	<p>#linkTo(action="resetpassword", text="Forget your Password?")#
	
</cfoutput>
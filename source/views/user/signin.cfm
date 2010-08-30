<cfoutput>
	<h1 class="withcredits">Sign In</h1>
	<p class="credits">Welcome back!</p>
	#errorMessagesFor("$user")#
	
	#outputFlash("error")#
	
	<div class="twitterconnect">
		#linkTo(route="authtwitter", text="Twitter")#
	</div>
	
	<h2>-or-</h2>
	#startFormTag()#
		#textField(label="Username", objectname="$user", property="username")#
		#passwordField(label="Password", objectname="$user", property="password")#
		#submitTag(value="Sign In")#
	#endFormTag()#
	
</cfoutput>
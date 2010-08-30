<cfoutput>
	<h1 class="withcredits">Sign In</h1>
	<p class="credits">Welcome back!</p>
	#errorMessagesFor("$user")#
	
	<div id="##signin"></div>
	
	#startFormTag()#
		#textField(label="Username", objectname="$user", property="username")#
		#passwordField(label="Password", objectname="$user", property="password")#
		#submitTag(value="Sign In")#
	#endFormTag()#
</cfoutput>
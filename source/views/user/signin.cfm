<cfoutput>
	<h1>Sign In</h1>
		#errorMessagesFor("$user")#
		#startFormTag()#
			#textField(label="Username", objectname="$user", property="username")#
			#passwordField(label="Password", objectname="$user", property="password")#
			#submitTag()#
		#endFormTag()#
</cfoutput>
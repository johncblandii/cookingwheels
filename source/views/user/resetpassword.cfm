<cfoutput>
	<h1 class="withcredits">Reset Password</h1>
	<p class="credits">Oops...replaced your password, eh?</p>
	
	#errorMessagesFor("$user")#
	#outputFlash("success,error")#
	#startFormTag()#
		#textField(label="Email Address", objectname="$user", property="emailaddress")#
		#textField(label="Username", objectname="$user", property="username")#
		#submitTag(value="Get Password!")#
	#endFormTag()#
</cfoutput>
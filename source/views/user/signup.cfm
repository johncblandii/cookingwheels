<cfoutput>
	<h1>Sign Up</h1>
	#errorMessagesFor("$user")#
	#startFormTag()#
		<fieldset>
			<legend>Authentication</legend>
			#textField(label="Username", objectname="$user", property="username")#
			#passwordField(label="Username", objectname="$user", property="password")#
			#passwordField(label="Confirm Your Password", objectname="$user", property="passwordConfirmation")#
		</fieldset>
		<fieldset>
			<legend>Information</legend>
			#textField(label="Email Address", objectname="$user", property="emailaddress")#
			#textField(label="First Name", objectname="$user", property="firstname")#
			#textField(label="Middle Initial", objectname="$user", property="middleinitial")#
			#textField(label="Last Name", objectname="$user", property="lastname")#
			#textField(label="Suffix", objectname="$user", property="suffix")#
		</fieldset>
		#submitTag()#
	#endFormTag()#
</cfoutput>
<cfoutput>
	<h1>Sign Up</h1>
	<p id="introduction">Get in the game</p>
	<p>Sign up to gain access to creating and commenting on recipes.</p>
	#errorMessagesFor("$user")#
	#startFormTag()#
		<fieldset>
			<legend>Authentication</legend>
			<p>Other login providers coming soon: Google, Twitter, Facebook, etc.</p>
			#textField(label="Username", objectname="$user", property="username")#
			#passwordField(label="Password", objectname="$user", property="password")#
			#passwordField(label="Confirm Your Password", objectname="$user", property="passwordConfirmation")#
			<p>Don't worry about us reading your password...we hash them heavily so we can't read them.</p>
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
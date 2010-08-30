<cfoutput>
	<h1 class="withcredits">Get in the Kitchen</h1>
	<p class="credits">Sign up and start cooking!</p>
	<p>Sign up to gain access to creating and commenting on recipes.</p>
	#errorMessagesFor("$user")#
	#startFormTag()#
		<p>Other login providers coming soon: Google, Twitter, Facebook, etc.</p>
		#textField(label="Email Address <span class='required'>*</span>", objectname="$user", property="emailaddress")#
		<p class="credits">We will use this email address to find a profile picture through <a href="http://gravatar.com">Gravatar.com</a>.</p>
		#textField(label="Username <span class='required'>*</span>", objectname="$user", property="username")#
		#passwordField(label="Password <span class='required'>*</span>", objectname="$user", property="password")#
		#passwordField(label="Confirm Your Password <span class='required'>*</span>", objectname="$user", property="passwordConfirmation")#
		<p class="credits">Don't worry about us reading your password...we hash them heavily so we can't read them.</p>
		#textField(label="First Name", objectname="$user", property="firstname")#
		#textField(label="Middle Initial", objectname="$user", property="middleinitial")#
		#textField(label="Last Name", objectname="$user", property="lastname")#
		#textField(label="Suffix", objectname="$user", property="suffix")#
		#textField(label="Site Url", objectname="$user", property="siteurl")#
		<p class="credits">Don't forget to include the http:// portion of the url.</p>
		#textField(label="Twitter Name", objectname="$user", property="twitterusername")#
		#textField(label="Facebook Url", objectname="$user", property="facebookurl")#
		<p class="credits">Don't forget to include the http:// portion of the url.</p>
		#submitTag()#
	#endFormTag()#
</cfoutput>
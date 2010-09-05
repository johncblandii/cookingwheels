<cfoutput>
	<h1 class="withcredits">Manage Your Profile</h1>
	<p class="credits">#$data.getDisplayName()#</p>
		
	#errorMessagesFor("$data")#
	#startFormTag(argumentCollection=params)#
		#textField(label="Email Address <span class='required'>*</span>", objectname="$data", property="emailaddress")#
		<cfif NOT $data.isTwitterUser()>
			<p class="credits">We will use this email address to find a profile picture through <a href="http://gravatar.com">Gravatar.com</a>.</p>
		</cfif>
		<cfif NOT $data.isTwitterUser()>
			#passwordField(label="Password <span class='required'>*</span>", objectname="$data", property="password")#
			#passwordField(label="Confirm Your Password <span class='required'>*</span>", objectname="$data", property="passwordConfirmation")#
			<p class="credits">Don't worry about us reading your password...we hash them heavily so we can't read them.</p>
		</cfif>
		#textField(label="First Name", objectname="$data", property="firstname")#
		#textField(label="Middle Initial", objectname="$data", property="middleinitial")#
		#textField(label="Last Name", objectname="$data", property="lastname")#
		#textField(label="Suffix", objectname="$data", property="suffix")#
		#textField(label="Site Url", objectname="$data", property="siteurl")#
		<p class="credits">Don't forget to include the http:// portion of the url.</p>
		<cfif NOT $data.isTwitterUser()>
			#textField(label="Twitter Name", objectname="$data", property="twitterusername")#
		</cfif>
		
		#textArea(label="About You", objectname="$data", property="about")#
		#submitTag()#
	#endFormTag()#
</cfoutput>
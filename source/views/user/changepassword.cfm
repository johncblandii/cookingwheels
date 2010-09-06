<cfoutput>
	<h1 class="withcredits">Change Password</h1>
	<p class="credits">Use the form below to update your password.</p>
	
	<cfif NOT $user.isNew() AND $user.ispasswordreset>
		<p>Your password has been reset. You are required to change your password before continuing to use the site.</p>
	</cfif>
	<cfif session.user.isTwitterUser()>
		<p>You are authenticated via Twitter. There is no password to change.</p>
	<cfelse>
		#errorMessagesFor("$user")#
		#outputFlash("success,error")#
		#startFormTag()#
			#passwordField(label="Current Password", objectname="$user", property="oldpassword")#
			#passwordField(label="New Password", objectname="$user", property="password")#
			#passwordField(label="Confirm New Password", objectname="$user", property="passwordConfirmation")#
			#submitTag(value="Update Password")#
		#endFormTag()#
	</cfif>
</cfoutput>
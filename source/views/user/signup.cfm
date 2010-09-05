<cfoutput>
	<h1 class="withcredits">Get in the Kitchen</h1>
	<p class="credits">Sign up and start cooking!</p>
	
	<cfif istwitter>
		<h2>Almost there!</h2>
		<p>Fill out the form below to complete registration. 
	<cfelse>
		<p>Sign up to gain access to creating and commenting on recipes.</p>
	</cfif>
	
	<cfif NOT istwitter>
		<div class="twitterconnect">
			#linkTo(route="authtwitter", text="<img src='http://twitter-badges.s3.amazonaws.com/t_logo-c.png' alt='Follow cookingwheels on Twitter'/>")#
		</div>
		
		<h2>-or-</h2>
	</cfif>
	
	#errorMessagesFor("$user")#
	#startFormTag()#
		#textField(label="Email Address <span class='required'>*</span>", objectname="$user", property="emailaddress")#
		<cfif NOT istwitter>
			<p class="credits">We will use this email address to find a profile picture through <a href="http://gravatar.com">Gravatar.com</a>.</p>
		</cfif>
		#textField(label="Username <span class='required'>*</span>", objectname="$user", property="username")#
		<cfif NOT istwitter>
			#passwordField(label="Password <span class='required'>*</span>", objectname="$user", property="password")#
			#passwordField(label="Confirm Your Password <span class='required'>*</span>", objectname="$user", property="passwordConfirmation")#
			<p class="credits">Don't worry about us reading your password...we hash them heavily so we can't read them.</p>
		</cfif>
		#submitTag()#
	#endFormTag()#
</cfoutput>
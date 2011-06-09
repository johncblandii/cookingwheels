<cfcomponent extends="Controller" hint="Controller for Users">
<!--- CONSTRUCTOR --->
	<cffunction access="public" name="init" hint="Constructor">
		<cfset super.init() />
		<cfset filters(through="$authorize", only="manage,changepassword,signout") />
	</cffunction>

<!--- PUBLIC METHODS --->	
	<cffunction access="public" name="index" hint="Default">
		<cfparam name="params.page" type="numeric" default="1" />
		<cfset $users = model('user').findAll(order="lastname, firstname, username ASC", page=params.page) />
	</cffunction>
	
	<cffunction access="public" name="signup" hint="Registers a user for the site">
		<cfset var paramargs = StructNew() />
		<cfif isdefined("session.twitteruserprops")>
			<cfset $user = model("user").new(session.twitteruserprops) />
			<cfset istwitter = true />
			<cfset structDelete(session, "twitteruserprops") />
		<cfelse>
			<cfset $user = model("user").new() />
			<cfset istwitter = false />
		</cfif>
		<cfif isPost() AND isDefined("params.$user")>
			<cfset $user.setProperties(params.$user) />
			<cfif $user.valid() AND $user.save()>
				<cfset session.user = $user />
				<cfset paramargs.route = "userprofile" />
				<cfset paramargs.userid = session.user.id />
				<cfset paramargs.text = session.user.getDisplayName() />
				<cfset structDelete(session, "twitteruserprops") />
				<cftry>
					<cfset sendEmail(from=$getSetting("email.from.default"), 
									 to=$user.emailaddress, 
									 templates="/emailtemplates/registrationplain,/emailtemplates/registration", 
									 subject=$getSetting("email.registration.subject"), 
									 user=$user) />
				<cfcatch type="any"></cfcatch>
				</cftry>
				<cfset redirectTo(argumentCollection=paramargs) />
			</cfif>
		</cfif>
	</cffunction>
	
	<cffunction access="public" name="signin" hint="Signs a user into the site">
		<cfset var paramargs = StructNew() />
		<cfif isPost() AND isDefined("params.$user")>
			<cfset $user = model("user").findOneByUsername(params.$user.username) />
			<cfif isObject($user) AND $user.authenticate(params.$user.password)>
				<cfset session.user = $user />
				<cfif isDefined("session.redirectParams")>
					<cfset paramargs = structCopy(session.redirectParams) />
					<cfset structDelete(session, "redirectParams") />
				<cfelse>
					<cfset paramargs.route = "userprofile" />
					<cfset paramargs.userid = session.user.id />
					<cfset paramargs.text = session.user.getDisplayName() />
				</cfif>
				<cfset redirectTo(argumentCollection=paramargs) />
			<cfelse>
				<cfset flashInsert(error="Invalid username and/or password.") />
			</cfif>
			<cfset $user = false />
		</cfif>
		<cfif NOT isDefined("$user") OR (isDefined("$user") AND NOT isObject($user))>
			<cfset $user = model("user").new() />
		</cfif>
	</cffunction>
	
	<cffunction access="public" name="signout" hint="Signs a user into the site">
		<cfset StructDelete(session, "user") />
		<cfset StructDelete(session, "twitteruserprops") />
		<cfset redirectTo(route="home") />
	</cffunction>
	
	<cffunction access="public" name="resetpassword" hint="Reset the users password">
		<cfset var loc = structNew() />
		<cfif isPost() AND isDefined("params.$user")>
			<cfset $user = model("user").findOneByEmailAddressAndUsername(values="#params.$user.emailaddress#,#params.$user.username#") />
			<cfif isObject($user)>
				<cfset loc.result = $user.resetPassword() />
				<cfif loc.result.success>
					<cftry>
						<cfset sendEmail(from=$getSetting("email.from.default"), 
										 to=$user.emailaddress, 
										 templates="/emailtemplates/passwordresetplain,/emailtemplates/passwordreset", 
										 subject=$getSetting("email.passwordreset.subject"), 
										 user=$user,
										 userpassword=loc.result.password) />
					<cfcatch type="any"></cfcatch>
					</cftry>
					<cfset flashInsert(success="Your password was reset and emailed to "&$user.emailaddress&".") />
					<cfset redirectTo(action="resetpassword") />
				<cfelse>
					<cfset flashInsert(error="We were unable to reset your password.") />
				</cfif>
			<cfelse>
				<cfset flashInsert(error="We were unable to find a user.") />
			</cfif>
		</cfif>
		<cfif NOT isDefined("$user") OR (isDefined("$user") AND NOT isObject($user))>
			<cfset $user = model("user").new() />
		</cfif>
	</cffunction>
	
	<cffunction access="public" name="changepassword" hint="Changes the users password">
		<cfif isPost() AND isDefined("params.$user")>
			<cfset $user = model("user").findOneById(session.user.id) />
			<cfif $user.changePassword(argumentCollection=params.$user)>
				<cfset flashInsert(success="Your password was successfully changed.") />
				<cftry>
					<cfset sendEmail(from=$getSetting("email.from.default"), 
									 to=$user.emailaddress, 
									 templates="/emailtemplates/passwordchangedplain,/emailtemplates/passwordchanged", 
									 subject=$getSetting("email.passwordchanged.subject"), 
									 user=$user,
									 userpassword=params.$user.password) />
				<cfcatch type="any"></cfcatch>
				</cftry>
				<cfset redirectTo(action="changepassword") />
			<cfelse>
				<cfif NOT $user.hasErrors()>
					<!--- if there aren't any errors, the save failed. --->
					<cfset flashInsert(error="Unable to change password.") />
				</cfif>
			</cfif>
		</cfif>
		<cfif NOT isDefined("$user") OR (isDefined("$user") AND NOT isObject($user))>
			<cfset $user = model("user").new() />
		</cfif>
	</cffunction>
	
	<cffunction access="public" name="profile" hint="Shows a users profile">
		<cfparam name="params.userid" default="0" />
		<cfif params.userid EQ 0 AND NOT isLoggedIn()>
			<cfset redirectTo(route="users") />
		<cfelseif params.userid EQ 0 AND isLoggedIn()>
			<cfset params.userid = session.user.id />
		</cfif>
		
		<cfset $user = model("user").findOneById(params.userid) />
	</cffunction>
	
	<cffunction access="public" name="manage" hint="Manages a users profile">
		<cfset var paramargs = structNew() />
		<cfif isDefined("params.key") AND params.key NEQ "edit">
			<cfset redirectTo(route="user") />
		</cfif>
		<cfif NOT isDefined("params.userid") AND NOT isLoggedIn()>
			<cfset redirectTo(route="user") />
		</cfif>
		<cfset params.key = "edit" />
		<cfset params.value = session.user.id />
		<cfset paramargs.route = "userprofile" />
		<cfset paramargs.userid = session.user.id />
		<cfset paramargs.text = session.user.getDisplayName() />
		<cfset super.$doDetailPage(table="user", redirectParams=paramargs) />
		<cfset structdelete($data, "password") /><!--- remove the password so it isn't visible in the form --->
	</cffunction>
	
	<cffunction access="public" name="authtwitter" hint="Callback from twitter">
		<cfset var loc = StructNew() />
		<cftry>
			<cfset application.twitter = application.javaloader.create("twitter4j.Twitter").init() />
			<cfset application.twitter.setOAuthConsumer($getSetting("twitter.consumerkey"), $getSetting("twitter.consumersecret")) />
		<cfcatch type="any">
			<cfdump var="#cfcatch#">
		</cfcatch>
		</cftry>
		<cfset var loc.requestToken = application.twitter.getOAuthRequestToken()>
		<cfif NOT isDefined("session.twitter")>
			<cfset session.twitter = StructNew() />
		</cfif>
		<cfset session.twitter.oAuthRequestToken = loc.requestToken.getToken() />
		<cfset session.twitter.oAuthRequestTokenSecret = loc.requestToken.getTokenSecret() />
		<cflocation url="#loc.requestToken.getAuthorizationURL()#" addtoken="No" />
	</cffunction>
	
	<cffunction access="public" name="twitterauth" hint="Callback from twitter">
		<cfset var loc = StructNew() />
		<cftry>
			<cfset loc.accessToken = application.twitter.getOAuthAccessToken(session.twitter.oAuthRequestToken, session.twitter.oAuthRequestTokenSecret)>
			<!--- register the user --->
			<cfset loc.userprops = StructNew() />
			<cfset loc.userprops.oauthtoken = loc.accessToken.getToken() />
			<cfset loc.userprops.oauthsecret = loc.accessToken.getTokenSecret() />
			
			<cfset application.twitter.setOAuthAccessToken(loc.userprops.oauthtoken,loc.userprops.oauthsecret)>
			
			<cfset loc.userprops.username = loc.userprops.twitterusername = loc.accessToken.getScreenName() />
			<cfset loc.userinfo = application.twitter.showUser(loc.userprops.username) />
			
			<cfset loc.userprops.about = loc.userinfo.getDescription() />
			<cfset loc.userprops.profileimageurl = loc.userinfo.getProfileImageURL().toExternalForm() />
			
			<cfset loc.user = model("user").findOneByUsername(loc.userprops.username)/>
			<cfif NOT isObject(loc.user)>
				<!--- Initiate a registration --->
				<cfset session.twitteruserprops = loc.userprops />
				<cfset redirectTo(action="signup") />
			<cfelse>
				<!--- Update the users profile image --->
				<cfset loc.updateprops = structNew() />
				<cfset loc.updateprops.about = loc.userprops.about />
				<cfset loc.updateprops.profileimageurl = loc.userprops.profileimageurl />
				<cfset loc.updateprops.oauthtoken = loc.userprops.oauthtoken />
				<cfset loc.updateprops.oauthsecret = loc.userprops.oauthsecret />
				<cfset loc.user.setProperties(loc.updateprops) />
				<cfset loc.user.save() />
				<cfset session.user = loc.user />
				<cfset redirectTo(route="userprofile", userid=session.user.id, text=session.user.getDisplayName()) />
			</cfif>
		<cfcatch type="any">
			<!--- playing catch --->
		</cfcatch>
		</cftry>
		<cfset flashInsert(error="Unable to authorize with Twitter.") />
		<cfset redirectTo(action="signin") />
	</cffunction>
</cfcomponent>
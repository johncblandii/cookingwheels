<cfcomponent extends="Controller" hint="Controller for Users">
<!--- CONSTRUCTOR --->
	<cffunction access="public" name="init" hint="Constructor">
		<cfset super.init() />
	</cffunction>

<!--- PUBLIC METHODS --->	
	<cffunction access="public" name="index" hint="Defalt">
		<cfset $users = model('user').findAll(order="lastname, firstname, username ASC") />
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
				
				<cfset redirectTo(argumentCollection=paramargs) />
			</cfif>
		</cfif>
	</cffunction>
	
	<cffunction access="public" name="signin" hint="Signs a user into the site">
		<cfset var paramargs = StructNew() />
		<cfset $user = model("user").new() />
		<cfif isPost() AND isDefined("params.$user")>
			<cfset $user = $user.findOneByUsername(params.$user.username) />
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
			</cfif>
		</cfif>
	</cffunction>
	
	<cffunction access="public" name="signout" hint="Signs a user into the site">
		<cfset StructDelete(session, "user") />
		<cfset StructDelete(session, "twitteruserprops") />
		<cfset redirectTo(route="home") />
	</cffunction>
	
	<cffunction access="public" name="profile" hint="Shows a users profile">
		<cfif NOT isDefined("params.userid") AND NOT isLoggedIn()>
			<cfset redirectTo(route="user") />
		<cfelseif NOT isDefined("params.userid")>
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
		<cfset $doDetailPage(table="user", redirectParams=paramargs) />
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
			<cfdump var="#cfcatch#" abort="true" />
		</cfcatch>
		</cftry>
		<cfset flash(error="Unable to authorize with Twitter.") />
		<cfset redirectTo(action="signin") />
	</cffunction>
</cfcomponent>
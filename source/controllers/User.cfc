<cfcomponent extends="Controller" hint="Controller for Users">
<!--- CONSTRUCTOR --->
	<cffunction access="public" name="init" hint="Constructor">
		<cfset super.init() />
	</cffunction>

<!--- PUBLIC METHODS --->	
	<cffunction access="public" name="index" hint="Defalt">
	</cffunction>
	
	<cffunction access="public" name="signup" hint="Registers a user for the site">
		<cfset $user = model("user").new() />
		<cfif isPost() AND isDefined("params.$user")>
			<cfset $user.setProperties(params.$user) />
			<cfif $user.valid() AND $user.save()>
				<cfset session.user = $user />
				<cfset redirectTo(action="profile") />
			</cfif>
		</cfif>
	</cffunction>
	
	<cffunction access="public" name="signin" hint="Signs a user into the site">
		<cfset $user = model("user").new() />
		<cfif isPost() AND isDefined("params.$user")>
			<cfset $user = $user.findOneByUsername(params.$user.username) />
			<cfif isObject($user) AND $user.authenticate(params.$user.password)>
				<cfset session.user = $user />
				<cfset redirectTo(action="profile") />
			</cfif>
		</cfif>
	</cffunction>
	
	<cffunction access="public" name="signout" hint="Signs a user into the site">
		<cfset StructDelete(session, "user") />
		<cfset redirectTo(route="home") />
	</cffunction>
	
	<cffunction access="public" name="profile" hint="Shows a users profile">
	</cffunction>
</cfcomponent>
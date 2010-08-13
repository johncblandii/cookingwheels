<cfcomponent extends="Wheels" hint="Core controller with global functions">
<!--- CONSTRUCTOR --->
	<cffunction access="public" name="init" description="Constructor">
	</cffunction>
	
<!--- PUBLIC METHODS --->
	<cffunction access="public" name="isLoggedIn" description="Checks the session scope to see if the user is logged in">
		<cfreturn structKeyExists(session, "user") />
	</cffunction>
	
<!--- PRIVATE METHODS --->
	<cffunction access="private" name="$authorize" description="Authorizes the users access to a specific portion of the site">
		<cfreturn isLoggedIn() />
	</cffunction>
</cfcomponent>
<cfcomponent extends="Controller" hint="Controller for Account management">
<!--- CONSTRUCTOR --->
	<cffunction access="public" name="init" hint="Constructor">
		<cfset super.init() />
	</cffunction>

<!--- PUBLIC METHODS --->	
	<cffunction access="public" name="index" hint="Defalt">
	</cffunction>
	
	<cffunction access="public" name="signup" hint="Registers a user for the site">
	</cffunction>
	
	<cffunction access="public" name="signin" hint="Signs a user into the site">
	</cffunction>
	
	<cffunction access="public" name="signout" hint="Signs a user into the site">
	</cffunction>
</cfcomponent>
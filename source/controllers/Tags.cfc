<cfcomponent extends="Controller" hint="Tags controller">
<!--- CONSTRUCTOR --->
	<cffunction access="public" name="init" description="Constructor">
		<cfset super.init() />
		<cfset filters(through="$authorize", only="add") />
	</cffunction>

<!--- PUBLIC METHODS --->	
	<cffunction access="public" name="index" description="Lists all tags">
	</cffunction>
	
	<cffunction access="public" name="add" description="Adds a new tag via ajax">
		<cfset verifies(ajax=true) />
	</cffunction>
	
	<cffunction access="public" name="recipes" description="View recipes for a tag">
	</cffunction>
</cfcomponent>
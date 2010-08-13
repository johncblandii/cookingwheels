<cfcomponent extends="Controller" hint="Recipe controller">
<!--- CONSTRUCTOR --->
	<cffunction access="public" name="init" hint="Constructor">
		<cfset super.init() />
		<cfset filters(through="$authorize", only="manage") />
	</cffunction>

<!--- PUBLIC METHODS --->	
	<cffunction access="public" name="index" hint="Default">
	</cffunction>
	
	<cffunction access="public" name="recent" hint="Shows recent entries">
	</cffunction>
	
	<cffunction access="public" name="top10" hint="Shows the top 10 entries by rating">
	</cffunction>
	
	<cffunction access="public" name="recipe" hint="Shows one specific recipe entry">
	</cffunction>
	
	<cffunction access="public" name="manage" hint="Manages one specific recipe entry">
	</cffunction>
</cfcomponent>
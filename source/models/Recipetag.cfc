<cfcomponent extends="Model">
<!--- CONSTRUCTOR --->
	<cffunction access="public" name="init" hint="Constructor">
		<!--- RELATIONSHIPS --->
			<cfset belongsTo("recipe") />
			<cfset belongsTo("tag") />
	</cffunction>

<!--- CALLBACKS --->

<!--- PRIVATE METHODS --->

<!--- PUBLIC METHODS --->
</cfcomponent>
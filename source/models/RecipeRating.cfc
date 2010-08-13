<cfcomponent extends="Wheels">
<!--- CONSTRUCTOR --->
	<cffunction access="public" name="init" hint="Constructor">
		<!--- RELATIONSHIPS --->
			<cfset belongsTo("recipe") />
			<cfset belongsTo("user") />
	</cffunction>

<!--- CALLBACKS --->

<!--- PRIVATE METHODS --->

<!--- PUBLIC METHODS --->
</cfcomponent>
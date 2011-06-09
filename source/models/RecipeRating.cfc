<cfcomponent extends="Model">
<!--- CONSTRUCTOR --->
	<cffunction access="public" name="init" hint="Constructor">
		<!--- RELATIONSHIPS --->
			<cfset belongsTo("recipe") />
			<cfset belongsTo("user") />
	</cffunction>
</cfcomponent>
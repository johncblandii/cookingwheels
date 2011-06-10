<cfcomponent extends="Model">
<!--- CONSTRUCTOR --->
	<cffunction access="public" name="init" hint="Constructor">
		<!--- RELATIONSHIPS --->
			<cfset belongsTo(name="recipe", foreignkey="recipeid") />
			<cfset belongsTo(name="tag", foreignkey="tagid") />
	</cffunction>
</cfcomponent>
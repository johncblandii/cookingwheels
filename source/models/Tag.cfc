<cfcomponent extends="Model">
<!--- CONSTRUCTOR --->
	<cffunction access="public" name="init" hint="Constructor">
		<!--- RELATIONSHIPS --->
			<cfset belongsTo("recipetags") />
			<cfset belongsTo("user") />
			
		<!--- VALIDATIONS --->
			<cfset validatesLengthOf(properties="name", allowBlank=false, minimum=2, maximum=140) />
	</cffunction>

<!--- CALLBACKS --->

<!--- PRIVATE METHODS --->

<!--- PUBLIC METHODS --->
</cfcomponent>
<cfcomponent extends="Wheels">
<!--- CONSTRUCTOR --->
	<cffunction access="public" name="init" hint="Constructor">
		<!--- RELATIONSHIPS --->
			<cfset belongsTo("recipe") />
			<cfset belongsTo("user") />
			
		<!--- VALIDATIONS --->
			<cfset validatesLengthOf(properties="details", minimum=1) />
	</cffunction>

<!--- CALLBACKS --->

<!--- PRIVATE METHODS --->

<!--- PUBLIC METHODS --->

</cfcomponent>
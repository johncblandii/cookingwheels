<cfcomponent extends="Model">
<!--- CONSTRUCTOR --->
	<cffunction access="public" name="init" hint="Constructor">
		<!--- RELATIONSHIPS --->
			<cfset belongsTo("recipe") />
			<cfset belongsTo("user") />
			
		<!--- VALIDATIONS --->
			<cfset validatesLengthOf(properties="details", minimum=2, message="Comment wasn't long enough (2 characters)") />
			
		<!--- CALLBACKS --->
			<cfset beforeCreate("$beforeCreate") />
	</cffunction>

<!--- PRIVATE METHODS --->
	<cffunction access="private" name="$beforeCreate" hint="Callback to manage model before create">
		<cfif NOT isDefined("this.userid")>
			<cfset this.userid = session.user.id />
		</cfif>
	</cffunction>
</cfcomponent>
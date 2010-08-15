<cfcomponent extends="Model">
<!--- CONSTRUCTOR --->
	<cffunction access="public" name="init" hint="Constructor">
		<!--- RELATIONSHIPS --->
			<cfset belongsTo("recipetags") />
			<cfset belongsTo("user") />
			
		<!--- VALIDATIONS --->
			<cfset validatesLengthOf(properties="name", allowBlank=false, minimum=2, maximum=140) />
			
		<!--- CALLBACKS --->
			<cfset beforeSave("$beforeSave") />
	</cffunction>

<!--- PRIVATE METHODS --->
	<cffunction access="public" name="$beforeSave" hint="Callback to manage model before save">
		<cfif NOT isDefined("this.slug")>
			<cfset this.slug = rereplacenocase(this.name, "[^A-Z]", "", "all") />
		</cfif>
	</cffunction>

<!--- PUBLIC METHODS --->

	<cffunction access="public" name="createUnique" returntype="Numeric" hint="Saves a tag in the database only if it is unique">
		<cfargument name="name" type="string" required="true" />
		<cfset var loc = structNew() />
		<cfset loc.tag = findOne(where="name='#arguments.name#'") />
		<cfif NOT isObject(loc.tag)>
			<!--- @johncblandii this could possibly get cleaned up to not call another model but Wheels was giving me problems --->
			<cfset loc.tag = model("tag").new() />
			<cfset loc.tag.setProperties(arguments) />
			<cfset loc.tag.save() />
		</cfif>
		<cfreturn loc.tag.id />
	</cffunction>
</cfcomponent>
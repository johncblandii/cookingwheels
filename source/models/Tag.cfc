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
	
	<cffunction access="public" name="getTopTags" description="Pulls top tags">
		<cfargument name="maxRows" type="numeric" default="5" />
		<!--- for now just pull the last 5 in desc order --->
		<cfreturn findAll(maxRows=arguments.maxRows, order="id desc") />
	</cffunction>
	
	<cffunction access="public" name="getRecipes" hint="Returns recipes for the selected tag; use after finding a tag">
		<cfset var result = false />
		<cfset var recipetags = "" />
		<cfset var i = 1 />
		<cfif isDefined("this.id")>
			<cfset arguments.tagid = this.id />
			<cfset result = ArrayNew(1) />
			<cfset recipetags = model("recipe").findAllByTagID(argumentCollection=arguments) /> <!--- by using the arguments scope, we can pass in any findAll params from outside of the model --->
			<cfif isQuery(recipetags) AND recipetags.recordCount GT 0>
				<!--- there is probably a better Wheels way...but not at 3:39 AM --->
				<cfloop query="#recipetags#">
					<cfset result[i] = recipe />
					<cfset i = i+1 />
				</cfloop>
			</cfif>
		</cfif>
		<cfreturn result />
	</cffunction>
</cfcomponent>
<cfcomponent extends="Model">
<!--- CONSTRUCTOR --->
	<cffunction access="public" name="init" hint="Constructor">
		<!--- RELATIONSHIPS --->
			<cfset belongsTo("user") />
			<cfset belongsTo(name="lasteditedbyuser", class="user") />
			<cfset hasMany("comments") />
			<cfset hasMany(name="recipetag") />
			<cfset property(name="rating", sql="(SELECT ROUND(AVG(reciperatings.rating)) FROM reciperatings WHERE reciperatings.recipeid = recipes.id AND reciperatings.deletedat IS NULL)") />
			
		<!--- VALIDATIONS --->
			<cfset validatesLengthOf(properties="title", allowBlank=false, minimum=5, maximum=140) />
			<cfset validatesLengthOf(properties="problem", allowBlank=false, minimum=5, maximum=500) />
			<cfset validatesLengthOf(properties="solution", allowBlank=false, minimum=5, maximum=500) />
			<cfset validatesLengthOf(properties="details", allowBlank=false, minimum=5) />
			<cfset validatesLengthOf(properties="tags", allowBlank=false, minimum=2) />
			
		<!--- CALLBACKS --->
			<cfset beforeSave("$beforeSave") />
			<cfset afterSave("$afterSave") />
	</cffunction>

<!--- PRIVATE METHODS --->
	<cffunction access="private" name="$beforeSave" hint="Callback to manage model before a save">
		<cfif NOT isDefined("this.userid")>
			<cfset this.userid = session.user.id />
		</cfif>
		<cfif isDefined("session.user.id")>
			<cfset this.lasteditedbyuserid = session.user.id />
		</cfif>
	</cffunction>
	
	<cffunction access="private" name="$afterSave" hint="Callback to manage model after a save">
		<!--- Takes the string 'this.tags' and saves them to the database --->
		<cfset var loc = structNew() />
		<cfset loc.tagidlist = "" />
		<cfloop list="#this.tags#" index="tag" delimiters=" ">
			<cfset model("recipetag").create(recipeid=this.id, tagid=model("tag").createUnique(trim(tag))) />
		</cfloop>
	</cffunction>

<!--- PUBLIC METHODS --->
	<cffunction access="public" name="findAllByTagID" hint="Finds all recipes by tag id">
		<cfargument name="tagid" type="numeric" required="true" />
		<cfset var result = model("recipeTag").findAllByTagID(value=arguments.tagid, include="recipe") />
		<cfreturn result />
	</cffunction>
</cfcomponent>
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
			<cfset validatesFormatOf(properties="documentationlink", format="url", allowblank="true", message="The documentation url must be a valid url.") />
			
		<!--- PROPERTIES --->
			<cfset property(name="commentcount", sql="select count(id) from comments where comments.recipeid = recipes.id AND deletedat IS NULL") />
			
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
		<!--- this should probably use regex :) --->
		<cfif isDefined("documentationlink") AND (this.documentationlink DOES NOT CONTAIN "http://cfwheels.com" OR this.documentationlink DOES NOT CONTAIN "http://www.cfwheels.com")>
			<cfset this.documentationlink = "" />
		</cfif>
	</cffunction>
	
	<cffunction access="private" name="$afterSave" hint="Callback to manage model after a save">
		<!--- Takes the string 'this.tags' and saves them to the database --->
		<cfset var loc = structNew() />
		<cfset loc.tagidlist = this.tags />
		<cfset loadTags() />
		<cfloop list="#loc.tagidlist#" index="tag" delimiters=" ,;">
			<cfif NOT listFind(this.tags, tag)>
				<cfset model("recipetag").create(recipeid=this.id, tagid=model("tag").createUnique(trim(tag))) />
			</cfif>
		</cfloop>
	</cffunction>

<!--- PUBLIC METHODS --->
	<cffunction name="isApproved" hint="Checks 'approvedat' column for a value">
		<cfreturn isDefined("this.approvedat") AND len(this.approvedat) GT 0 />
	</cffunction>
	
	<cffunction access="public" name="findAllByTagID" hint="Finds all recipes by tag id">
		<cfargument name="tagid" type="numeric" required="true" />
		<cfset arguments.value = arguments.tagid />
		<cfset structdelete(arguments, "tagid") />
		<cfset arguments.include = "recipe" />
		<cfreturn model("recipetag").findAllByTagID(argumentCollection=arguments) />
	</cffunction>
	
	<cffunction access="public" name="loadTags" hint="Pulls recipe tags and sets them to a custom 'tags' property">
		<cfset var loc = structNew() />
		<cfset this.tags = "" />
		<cfif isDefined("this.id")>
			<cfset loc.tags = model("recipetag").findAllByRecipeID(value=this.id, include="tag") />
			<cfif isQuery(loc.tags) AND loc.tags.recordCount GT 0>
				<cfloop query="loc.tags">
					<cfset this.tags = listAppend(this.tags, name) />
				</cfloop>
			</cfif>
		</cfif>
	</cffunction>
	
	<cffunction access="public" name="getHomepageRecipes" hint="Pulls recipes specific to the homepage">
		<cfreturn findAll(maxRows=5, order="createdat DESC", include="user") />
	</cffunction>
	
	<cffunction access="public" name="findAll" hint="Override to force only approved recipes to show up">
		<cfargument name="forceApproved" required="false" type="boolean" default="true" />
		<cfif isDefined("arguments.forceApproved") AND arguments.forceApproved>
			<cfif NOT isDefined("arguments.where")>
				<cfset arguments.where = "" />
			<cfelse>
				<cfset arguments.where = arguments.where & " AND " />
			</cfif>
			<cfset arguments.where = trim(arguments.where & " approvedat <= now()") />
		</cfif>
		<cfset StructDelete(arguments, "forceApproved") />
		<cfreturn super.findAll(argumentCollection=arguments) />
	</cffunction>
</cfcomponent>
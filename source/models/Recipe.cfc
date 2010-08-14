<cfcomponent extends="Model">
<!--- CONSTRUCTOR --->
	<cffunction access="public" name="init" hint="Constructor">
		<!--- RELATIONSHIPS --->
			<cfset belongsTo("user") />
			<cfset belongsTo(name="lasteditedbyuser", class="user") />
			<cfset hasMany("comments") />
			<cfset hasMany(name="recipetags", shortcut="tags") />
			<cfset property(name="rating", sql="(SELECT ROUND(AVG(reciperatings.rating)) FROM reciperatings WHERE reciperatings.recipeid = recipes.id AND reciperatings.deletedat IS NULL)") />
			
		<!--- VALIDATIONS --->
			<cfset validatesLengthOf(properties="title", allowBlank=false, minimum=5, maximum=140) />
			<cfset validatesLengthOf(properties="problem", allowBlank=false, minimum=5, maximum=500) />
			<cfset validatesLengthOf(properties="solution", allowBlank=false, minimum=5, maximum=500) />
			<cfset validatesLengthOf(properties="details", allowBlank=false, minimum=5) />
			
		<!--- CALLBACKS --->
			<cfset beforeSave("$beforeSave") />
	</cffunction>

<!--- PRIVATE METHODS --->
	<cffunction access="public" name="$beforeSave" hint="Callback to manage model before a save">
		<cfif NOT isDefined("this.userid")>
			<cfset this.userid = session.user.id />
		</cfif>
		<cfif isDefined("session.user.id")>
			<cfset this.lasteditedbyuserid = session.user.id />
		</cfif>
	</cffunction>

<!--- PUBLIC METHODS --->
</cfcomponent>
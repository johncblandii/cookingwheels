<cfcomponent extends="Wheels">
<!--- CONSTRUCTOR --->
	<cffunction access="public" name="init" hint="Constructor">
		<!--- RELATIONSHIPS --->
			<cfset belongsTo("user") />
			<cfset belongsTo(name="lasteditedbyuser", class="user") />
			<cfset hasMany("comments") />
			<cfset hasMany(name="recipetags", shortcut="tags") />
			<cfset property(name="rating", sql="(SELECT ROUND(AVG(reciperatings.rating)) FROM reciperatings WHERE reciperatings.recordingid = recipe.id AND reciperatings.deletedat IS NULL)") />
			
		<!--- VALIDATIONS --->
			<cfset validatesPresenceOf(properties="title,problem,solution,details") />
			<cfset validatesLengthOf(properties="title", allowBlank=false, minimum=5, maximum=140) />
			<cfset validatesLengthOf(properties="problem", allowBlank=false, minimum=5, maximum=500) />
			<cfset validatesLengthOf(properties="solution", allowBlank=false, minimum=5, maximum=500) />
			<cfset validatesLengthOf(properties="details", allowBlank=false, minimum=5) />
	</cffunction>

<!--- CALLBACKS --->

<!--- PRIVATE METHODS --->

<!--- PUBLIC METHODS --->
</cfcomponent>
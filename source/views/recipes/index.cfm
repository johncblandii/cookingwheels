<cfoutput>
<h1>Recipes</h1>
<cfif isDefined("$recipes") AND isQuery($recipes) AND $recipes.recordCount GT 0>
	#includePartial(partial="recipes", $recipes=$recipes)#
<cfelse>
	<p>Get in the game! #linkTo(action="manage", text="Start cooking")#.</p>
</cfif>
</cfoutput>
<cfoutput>
	<h1>Latest Recipes</h1>
	<cfif isQuery($recipes) AND $recipes.recordCount GT 0>
		#includePartial(partial="/recipes/recipes", $recipes=$recipes)#
	<cfelse>
		<p>There are no recipes. #linkTo(route="newrecipe", text="Start the party")# off right!</p>
	</cfif>
</cfoutput>
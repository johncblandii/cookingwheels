<cfoutput>
	<h1>Latest Recipes</h1>
	<cfif NOT isArray($recipes) OR arraylen($recipes) EQ 0>
		<p>There are no recipes. #linkTo(route="newrecipe", text="Start the party")# off right!</p>
	<cfelse>
		#includePartial(partial="/recipes/recipes", $recipes=$recipes)#
	</cfif>
</cfoutput>
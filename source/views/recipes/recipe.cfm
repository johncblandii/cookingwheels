<cfoutput>
	<cfif isObject($recipe)>
		#includePartial(partial="recipe", $recipe=$recipe)#
	<cfelse>
		<h1>Recipe Not Found</h1>
		<p>This one does not exist but it can: #linkTo(route="newrecipe", text="start cooking")#!</p>
	</cfif>
</cfoutput>
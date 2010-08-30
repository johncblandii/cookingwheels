<cfoutput>
	<cfif isObject($recipe)>
		#includePartial(partial="recipe", $recipe=$recipe)#
	<cfelse>
		<h1>Missing Recipe</h1>
		<p>This recipe does not exist. #linkTo(route="newrecipe", text="Start cooking")# and submit it!</p>
	</cfif>
</cfoutput>
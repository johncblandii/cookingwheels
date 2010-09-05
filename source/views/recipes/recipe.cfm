<cfoutput>
	<cfif isObject($recipe)>
		#includePartial(partial="recipe", $recipe=$recipe)#
	<cfelse>
		<h1>Missing Recipe</h1>
		<p>This recipe does not exist or is not yet approved.</p>
	</cfif>
</cfoutput>
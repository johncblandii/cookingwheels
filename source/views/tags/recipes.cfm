<cfoutput>
	<h1>Recipes</h1>
	<p id="introduction">...tagged '#$recipetag.name#'</p>
	<cfif arraylen($recipes) GT 0>
		<cfloop array="#$recipes#" index="recipe">
			#includePartial(partial="/recipes/recipesimple", recipe=recipe)#
		</cfloop>
	<cfelse>
		<p>No recipes found. Feel free to #linkTo(route="newrecipe", text="create a recipe")# using this tag.</p>
	</cfif>
</cfoutput>
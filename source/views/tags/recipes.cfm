<cfoutput>
	<h1><a href="#urlFor(route="tagrss", slug=$recipetag.slug, text=$recipetag.name)#">#imageTag("rss_icon.png")#</a> '#$recipetag.name#'</h1>
	<p id="introduction">...tagged recipes</p>
	<cfif arraylen($recipes) GT 0>
		<cfloop array="#$recipes#" index="recipe">
			#includePartial(partial="/recipes/recipesimple", recipe=recipe)#
		</cfloop>
	<cfelse>
		<p>No recipes found. Feel free to #linkTo(route="newrecipe", text="create a recipe")# using this tag.</p>
	</cfif>
</cfoutput>
<cfoutput>
	<h1><a href="#urlFor(route="tagrss", slug=$recipetag.slug, text=$recipetag.name)#">#imageTag("icon_rss.png")#</a> Tagged '#$recipetag.name#'</h1>
	<cfif isDefined("$recipes") AND arraylen($recipes) GT 0>
		<p>The following recipes have been tagged <strong>#$recipetag.name#</strong>.</p>
		<ul class="recipelist">
			<cfloop array="#$recipes#" index="recipe">
				#includePartial(partial="/recipes/recipesimple", recipe=recipe)#
			</cfloop>
		</ul>
	<cfelse>
		<p>No recipes found. Feel free to #linkTo(route="newrecipe", text="create a recipe")# using this tag.</p>
	</cfif>
</cfoutput>
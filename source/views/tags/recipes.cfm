<cfoutput>
	<h1><a href="#urlFor(route="tagrss", slug=$recipetag.slug, text=encodeOutput($recipetag.name))#">#imageTag("icon_rss.png")#</a> Tagged '#$recipetag.name#'</h1>
	<cfif isDefined("$recipes") AND $recipes.recordCount GT 0>
		<p>The following recipes have been tagged <strong>#$recipetag.name#</strong>.</p>
		<ul class="recipelist">
			<cfloop query="$recipes">
				#includePartial(partial="/recipes/recipesimple", id=id, title=title, problem=problem, commentcount=commentcount, createdat=createdat, updatedat=updatedat, userid=userid, user=getUserDisplayName(username, firstname, middleinitial, lastname, suffix))#
			</cfloop>
		</ul>
	<cfelse>
		<p>No recipes found. Feel free to #linkTo(route="newrecipe", text="create a recipe")# using this tag.</p>
	</cfif>
</cfoutput>
<cfif isDefined("arguments.$recipe")>
	<cfset $recipe = arguments.$recipe />
</cfif>
<cfoutput>
	<h1 class="withcredits">#$recipe.title#</h1>
	<p class="credits">
		#getFormattedDate($recipe.getLatestDate())# by #linkTo(route="userprofile", userid=$recipe.userid, text=$recipe.user.getDisplayName())#
	</p>
	<br />
	<h3>Problem</h3>
	<p>#$recipe.problem#</p>
	<h3>Solution</h3>
	<p>#$recipe.solution#</p>
	<h3>Details</h3>
	<p>#paragraphFormat($recipe.details)#</p>
	
	<h3>Tagged</h3>
	<p>
		<cfloop array="#$recipe.recipeTag(include='tag')#" index="recipetag">
			#linkTo(route="tagrecipes", slug=recipetag.tag.slug, text=recipetag.tag.name)#
		</cfloop>
	</p>
	<hr />
	#includePartial(partial="/recipes/comments", $comments=$recipe.comments(include='user'))#
</cfoutput>
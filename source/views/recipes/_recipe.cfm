<cfif isDefined("arguments.$recipe")>
	<cfset $recipe = arguments.$recipe />
</cfif>
<cfoutput>
	<h1>#$recipe.title#</h1>
	<p class="recipe-utility">
		#getFormattedDate($recipe.getLatestDate())# by #linkTo(controller="user", action="profile", key=$recipe.userid, text=$recipe.user.getDisplayName())#
	</p>
	<p class="recipe-utility">
		Tags: 
		<cfloop array="#$recipe.recipeTag(include='tag')#" index="recipetag">
			#linkTo(route="tagrecipes", slug=recipetag.tag.slug, text=recipetag.tag.name)#
		</cfloop>
	</p>
	<h3>Problem</h3>
	<p>#$recipe.problem#</p>
	<h3>Solution</h3>
	<p>#$recipe.solution#</p>
	<h3>Details</h3>
	<p>#autoLink($recipe.details)#</p>
	#includePartial(partial="/recipes/comments", $comments=$recipe.comments(include='user'))#
</cfoutput>
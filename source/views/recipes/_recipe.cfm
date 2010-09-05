<cfif isDefined("arguments.$recipe")>
	<cfset $recipe = arguments.$recipe />
</cfif>
<cfoutput>
	<cfif len($recipe.approvedat) EQ 0>
		<div class="error">This recipe is not yet approved. Once it is approved, it will be available for public view.</div>
	</cfif>
	<h1 class="withcredits">#encodeOutput($recipe.title)#</h1>
	<p class="credits">
		<cfif isLoggedIn() AND $recipe.userid EQ session.user.id>#linkTo(route="managerecipe", key="edit", recipeid=$recipe.id, text="Edit")# | </cfif>
		#getFormattedDate($recipe.getLatestDate())# by #linkTo(route="userprofile", userid=$recipe.userid, text=$recipe.user.getDisplayName())#
	</p>
	<br />
	<h3>Problem</h3>
	<p>#encodeOutput($recipe.problem)#</p>
	<h3>Solution</h3>
	<p>#encodeOutput($recipe.solution)#</p>
	<h3>Details</h3>
	<p>#encodeOutput($recipe.details)#</p>
	
	<h3>Tagged</h3>
	<p>
		<cfloop array="#$recipe.recipeTag(include='tag')#" index="recipetag">
			#linkTo(route="tagrecipes", slug=recipetag.tag.slug, text=recipetag.tag.name)#
		</cfloop>
	</p>
	<hr />
	#includePartial(partial="/recipes/comments", $comments=$recipe.comments(include='user'))#
</cfoutput>
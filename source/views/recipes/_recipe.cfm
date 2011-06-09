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
		#getFormattedDate($recipe.getLatestDate())# by #linkTo(route="userprofile", userid=$recipe.userid, text=$recipe.user.getDisplayName())# | <a href="##comments">Jump to comments</a>
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
		<cfset tags = $recipe.recipeTag(include='tag') />
		<cfloop query="tags">
			#linkTo(route="tagrecipes", slug=slug, text=name)#
		</cfloop>
	</p>
	
	<cfif isDefined("$recipe.documentationlink") AND len($recipe.documentationlink) GT 0>
		<h3>Documentation Url</h3>
		<p>#autoLink($recipe.documentationlink)#</p>
	</cfif>
	
	<hr />
	#includePartial(partial="/recipes/comments", $comments=$recipe.comments(include='user'))#
</cfoutput>
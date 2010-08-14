<cfoutput>
<cfloop array="#$recipes#" index="recipe">
	<div class="recipe-#recipe.id# post type-post hentry category-events" id="recipe-#recipe.id#">
		<h2>#linkTo(route="recipe", rel="bookmark", title="Permanent link to " & recipe.title, recipeid=recipe.id, text=recipe.title)#</h2>
		<p class="byline">#dateformat(recipe.createdat, "MMMM dd, yyyy")# by #linkTo(route="userprofile", userid=recipe.user.id, text=recipe.user.getDisplayName())#</p>
		<div class="entry"><p>#recipe.problem#</p></div>
	</div>
</cfloop>
</cfoutput>
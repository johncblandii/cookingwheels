<cfif NOT isDefined("recipe.user")>
	<!--- In case the user wasn't included in the query, pull it here --->
	<cfset recipe.user = recipe.user() />
</cfif>
<cfoutput>
<h3>#linkTo(route="recipe", rel="bookmark", title="Permanent link to " & recipe.title, recipeid=recipe.id, text=recipe.title)#</h3>
<p class="byline">#dateformat(recipe.createdat, "MMMM dd, yyyy")# by #linkTo(route="userprofile", userid=recipe.user.id, text=recipe.user.getDisplayName())#</p>
<div class="entry"><p>#recipe.problem#</p></div>
</cfoutput>
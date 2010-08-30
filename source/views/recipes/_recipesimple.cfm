<cfif NOT isDefined("recipe.user")>
	<!--- In case the user wasn't included in the query, pull it here --->
	<cfset recipe.user = recipe.user() />
</cfif>
<cfoutput>
<li>
	#linkTo(class="title", route="recipe", rel="bookmark", title="Permanent link to " & recipe.title, recipeid=recipe.id, text=recipe.title)#
	<p class="credits">#dateformat(recipe.createdat, "MMMM dd, yyyy")# by #linkTo(route="userprofile", userid=recipe.user.id, text=recipe.user.getDisplayName())#</p>
	<p>#recipe.problem#</p>
</li>
</cfoutput>
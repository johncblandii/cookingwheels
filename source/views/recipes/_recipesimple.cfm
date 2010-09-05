<cfif NOT isDefined("recipe.user")>
	<!--- In case the user wasn't included in the query, pull it here --->
	<cfset recipe.user = recipe.user() />
</cfif>
<cfoutput>
<li>
	#linkTo(class="title", route="recipe", rel="bookmark", title="Permanent link to " & encodeOutput(recipe.title), recipeid=recipe.id, text=encodeOutput(recipe.title))#
	<p class="credits">#getFormattedDate(recipe.createdat, "MMMM dd, yyyy")# by #linkTo(route="userprofile", userid=recipe.user.id, text=encodeOutput(recipe.user.getDisplayName()))#</p>
	<p>#encodeOutput(recipe.problem)#</p>
</li>
</cfoutput>
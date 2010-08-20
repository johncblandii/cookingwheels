<cfoutput>
	<cfif NOT isObject($user)>
		<h1>Missing User</h1>
		<p id="introduction">Where's Waldo?</p>
	<cfelse>
		<h1><a href="#urlFor(route="userrss", userid=$user.id, text=$user.getDisplayName())#">#imageTag("rss_icon.png")#</a> #$user.getDisplayName()#</h1>
		<p id="introduction">Member since: #getFormattedDate($user.createdat)#</p>
		
		<h2>Recent Recipes</h2>
		<hr />
		<cfset $recipes = $user.getRecentRecipes() />
		<cfif NOT isArray($recipes) OR (isArray($recipes) AND arraylen($recipes) EQ 0)>
			Hrmm...no recipes. Someone is lurching and not submitting. Get'em!
		<cfelse>
			<cfloop array="#$recipes#" index="recipe">
				#includePartial(partial="/recipes/recipesimple", $recipe=recipe)#
			</cfloop>
		</cfif>
	</cfif>
</cfoutput>
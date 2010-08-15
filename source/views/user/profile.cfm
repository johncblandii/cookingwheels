<cfoutput>
	<cfif NOT isObject($user)>
		<h1>Missing User</h1>
		<p>Where's Waldo?</p>
	<cfelse>
		<h1>#$user.getDisplayName()#</h1>
		<p>Member since: #getFormattedDate($user.createdat)#</p>
		
		<h2>Recent Recipes</h2>
		<cfset $recipes = $user.recipes() />
		<cfif NOT isArray($recipes) OR (isArray($recipes) AND arraylen($recipes) EQ 0)>
			Hrmm...no recipes. Someone is lurching and not submitting. Get'em!
		<cfelse>
			<cfloop array="#$recipes#" index="recipe">
				#includePartial(partial="/recipes/recipesimple", $recipe=recipe)#
			</cfloop>
		</cfif>
	</cfif>
</cfoutput>
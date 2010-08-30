<cfoutput>
	<cfif NOT isObject($user)>
		<h1>Missing User</h1>
		<p id="introduction">Where's Waldo?</p>
		<p>We have no idea but the user you requested doesn't exist.</p>
	<cfelse>
		<h1 class="withcredits">#gravatarTag(rating="g", email=$user.emailaddress, size="60", default="mm")# #$user.getDisplayName()# <a href="#urlFor(route="userrss", userid=$user.id, text=$user.getDisplayName())#">#imageTag("icon_rss.png")#</a> </h1>
		<p class="credits">Member since: #getFormattedDate($user.createdat)#</p>
		<cfif len(trim($user.siteurl)) GT 0>
			<h3>Site</h3>
			<p>#autoLink($user.siteurl)#</p>
		</cfif>
		<cfif len(trim($user.twitterusername)) GT 0>
			<h3>Twitter</h3> 
			<p>@#$user.twitterusername#</p>
		</cfif>
		<cfif len(trim($user.facebookurl)) GT 0>
			<h3>Facebook</h3>
			<p>#$user.facebookurl#</p>
		</cfif>
		<h2>Recent Recipes</h2>
		<cfset $recipes = $user.getRecentRecipes() />
		<cfif NOT isArray($recipes) OR (isArray($recipes) AND arraylen($recipes) EQ 0)>
			Hrmm...no recipes. Someone is a grubber and not a cooker.
		<cfelse>
			<cfloop array="#$recipes#" index="recipe">
				#includePartial(partial="/recipes/recipesimple", $recipe=recipe)#
			</cfloop>
		</cfif>
	</cfif>
</cfoutput>
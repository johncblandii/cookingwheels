<cfoutput>
	<cfif NOT isObject($user)>
		<h1>Missing User</h1>
		<p id="introduction">Where's Waldo?</p>
		<p>We have no idea but the user you requested doesn't exist.</p>
	<cfelse>
		<h1 class="withcredits">#$user.getProfileImage()# #encodeOutput($user.getDisplayName())# <a href="#urlFor(route="userrss", userid=$user.id, text=encodeOutput($user.getDisplayName()))#">#imageTag("icon_rss.png")#</a> </h1>
		<p class="credits">
			<cfif isLoggedIn() AND session.user.id EQ $user.id>
				#linkTo(route="editprofile", userid=$user.id, key="edit", text="Edit")# | 
			</cfif>
			Member since: #getFormattedDate($user.createdat)#
		</p>
		<cfif len(trim($user.siteurl)) GT 0>
			<h3>Site</h3>
			<p>#autoLink($user.siteurl)#</p>
		</cfif>
		<cfif len(trim($user.twitterusername)) GT 0>
			<h3>Twitter</h3> 
			<p>#encodeOutput("@"&$user.twitterusername)#</p>
		</cfif>
		<cfif len(trim($user.facebookurl)) GT 0>
			<h3>Facebook</h3>
			<p>#encodeOutput($user.facebookurl)#</p>
		</cfif>
		<cfif len(trim($user.about)) GT 0>
			<h3>About</h3>
			<p>#encodeOutput($user.about)#</p>
		</cfif>
		<cfset $recipes = $user.getRecentRecipes() />
		<cfif isArray($recipes) AND isArray($recipes) AND arraylen($recipes) GT 0>
			<hr /><br />
			<h3>Recent Recipes</h3>
			<ul>
			<cfloop array="#$recipes#" index="recipe">
				#includePartial(partial="/recipes/recipesimple", $recipe=recipe)#
			</cfloop>
			</ul>
		</cfif>
	</cfif>
</cfoutput>
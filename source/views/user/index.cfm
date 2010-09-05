<cfparam name="params.page" type="numeric" default="1" />
<cfoutput>
	<h1>Our Community</h1>
	<ul class="userlist">
	<cfset i = 0 />
	<cfloop array="#$users#" index="user">
		<cfset i = i + 1 />
		<li class="#getAlternatingClass(i)#">
			#user.getProfileImage()#
			#linkTo(route="userprofile", userid=user.id, text=user.getDisplayName())#
			<br />
			<p class="credits">
				Joined: #getFormattedDate(user.createdat)#
				<br />
				<cfif len(user.twitterusername)>
					#encodeOutput("@"&user.twitterusername)# | 
				</cfif>
				Recipes: #arraylen(user.recipes())#
			</p>
		</li>
	</cfloop>
	</ul>
	<!---#paginationLinks(route="users", page=params.page)#--->
</cfoutput>
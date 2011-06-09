<cfparam name="params.page" type="numeric" default="1" />
<cfoutput>
	<h1>Our Community</h1>
	<ul class="userlist">
	<cfset i = 0 />
	<cfloop query="$users">
		<cfset i = i + 1 />
		<li class="#getAlternatingClass(i)#">
			#getUserProfileImage(profileimageurl, emailaddress)#
			#linkTo(route="userprofile", userid=id, text=getUserDisplayName(username, firstname, middleinitial, lastname, suffix))#
			<br />
			<p class="credits">
				Joined: #getFormattedDate(createdat)#
				<br />
				<cfif len(twitterusername)>
					#encodeOutput("@"&twitterusername)# | 
				</cfif>
				Recipes: #recipecount#
			</p>
		</li>
	</cfloop>
	</ul>
	#paginationLinks(route="users", page=params.page)#
</cfoutput>
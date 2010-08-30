<cfparam name="params.page" type="numeric" default="1" />
<cfoutput>
	<h1>Our Community</h1>
	<ul class="userlist">
	<cfloop array="#$users#" index="user">
		<li>
			#gravatarTag(rating="g", email=user.emailaddress, size="60", default="mm")#
			#linkTo(route="userprofile", userid=user.id, text=user.getDisplayName())#<br />
			<p class="credits">
				Member Since: #getFormattedDate(user.createdat)#
				<br />
				Total Recipes: #arraylen(user.recipes())#
			</p>
		</li>
	</cfloop>
	</ul>
	<!---#paginationLinks(route="users", page=params.page)#--->
</cfoutput>
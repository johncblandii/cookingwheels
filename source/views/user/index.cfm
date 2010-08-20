<cfparam name="params.page" type="numeric" default="1" />
<cfoutput>
	<h1>#arrayLen($users)# Registered Users</h1>
	<p id="introduction">Our faithful list of contributors</p>
	<cfloop array="#$users#" index="user">
		<p>#linkTo(route="userprofile", userid=user.id, text=user.getDisplayName())#</p>
	</cfloop>
	<!---#paginationLinks(route="users", page=params.page)#--->
</cfoutput>
<h1>Registered Users</h1>
<p id="introduction">Our faithful list of contributors</p>
<cfoutput>
	<cfloop array="#$users#" index="user">
		<p>#linkTo(route="userprofile", userid=user.id, text=user.getDisplayName())#</p>
	</cfloop>
</cfoutput>
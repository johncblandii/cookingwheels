<cfoutput>
	<cfif NOT isObject($user)>
		<h1>Missing User</h1>
		<p>Where's Waldo?</p>
	<cfelse>
		<h1>#$user.getDisplayName()#</h1>
		<p>Member since: #getFormattedDate($user.createdat)#</p>
	</cfif>
</cfoutput>
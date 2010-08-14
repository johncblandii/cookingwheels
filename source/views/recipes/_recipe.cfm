<cfoutput>
	<h1>#$recipe.title#</h1>
	<p class="recipe-utility">#getFormattedDate($recipe.getLatestDate())# by #linkTo(controller="user", action="profile", key=$recipe.userid, text=$recipe.user.getDisplayName())#</p>
	<p>#$recipe.problem#</p>
	<h3>Solution</h3>
	<p>#$recipe.solution#</p>
	<h3>Detailed explanation</h3>
	<p>#autoLink($recipe.details)#</p>
	#includePartial(partial="comments", b=3, $comments=$recipe.comments(include='user'))#
</cfoutput>
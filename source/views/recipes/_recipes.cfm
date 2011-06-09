<cfoutput>
<cfloop query="$recipes">
	<ul class="recipelist recipe-#id#" id="recipe-#id#">
		#includePartial(partial="/recipes/recipesimple", id=id, title=title, problem=problem, commentcount=commentcount, createdat=createdat, updatedat=updatedat, userid=userid, user=getUserDisplayName(username, firstname, middleinitial, lastname, suffix))#
	</ul>
</cfloop>
</cfoutput>
<cfoutput>
<li>
	#linkTo(class="title", route="recipe", rel="bookmark", title="Permanent link to " & encodeOutput(title), recipeid=id, text=encodeOutput(title))#
	<p class="credits">#getFormattedDate(createdat, "MMMM dd, yyyy")# by #linkTo(route="userprofile", userid=userid, text=encodeOutput(arguments.user))# | #commentcount# #linkTo(route="recipe", title="Skip to comments", recipeid=id, anchor="comments", text="Comments")#</p>
	<p>#encodeOutput(problem)#</p>
</li>
</cfoutput>
<cfset $comments = arguments.$comments />
<cfoutput>
	<div id="comments">
		<h2>Comments</h2>
		<p> Read and submit questions, clarifications, and corrections about this recipe.</p>
		<cfif NOT isDefined("$comments") OR (isArray($comments) AND NOT arraylen($comments) GT 0)>
			<p><em>There are no comments for this chapter. Be the first to comment!</em></p>
		<cfelse>
			[<a href="##comment">Add Comment</a>]
			<ol class="commentlist">
				<cfloop array="#$comments#" index="comment">
					#includePartial(partial="/recipes/comment", $comment=comment)#
				</cfloop>
			</ol>
		</cfif>
		<cfif isLoggedIn()>
			#startFormTag(argumentCollection=params)#
				<a name="comment"></a>
				#errorMessagesFor("$newcomment")#
				<fieldset>
					<legend>Add Comment</legend>
					#textarea(label="Comment", objectname="$newcomment", property="details")#
					<div>
						#submitTag()#
					</div>
				</fieldset>
			#endFormTag()#
		<cfelse>
			<p><em>You must be #linkTo(route="signin", text="signed in")# to submit a comment.</em></p>
		</cfif>
	</div>
</cfoutput>
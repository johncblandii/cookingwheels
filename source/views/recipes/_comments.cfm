<cfset $comments = arguments.$comments />
<cfoutput>
	<div class="comments">
		<h2>Comments (#arraylen($comments)#)</h2>
		<p>Read and submit questions, clarifications, and corrections about this recipe.</p>
		<cfif NOT (isArray($comments) AND NOT arraylen($comments) GT 0)>
			[<a href="##comment">Add Comment</a>]
			<ol class="commentlist">
				<cfset i = 1 />
				<cfloop array="#$comments#" index="comment">
					#includePartial(partial="/recipes/comment", $index=i, $comment=comment)#
					<cfset i = i+1 />
				</cfloop>
			</ol>
		</cfif>
		<cfif isLoggedIn()>
			<cfif isArray($comments) AND arraylen($comments) GT 0>
				<hr />
			</cfif>
			#startFormTag(argumentCollection=params)#
				<a name="comment"></a>
				#errorMessagesFor("$newcomment")#
				#textarea(label="Comment", objectname="$newcomment", property="details")#
				<p class="credits">Wrap code with [code][/code] for it to show up in a code block.</p>
				#submitTag(value="Add Comment")#
			#endFormTag()#
		<cfelse>
			<p><em>You must be #linkTo(route="signin", text="signed in")# to submit a comment.</em></p>
		</cfif>
	</div>
</cfoutput>
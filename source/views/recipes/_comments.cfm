<cfset $comments = arguments.$comments />
<cfoutput>
	<a name="##comments"></a>
	<div class="comments">
		<h2>Comments (#$comments.recordCount#)</h2>
		<p>Read and submit questions, clarifications, and corrections about this recipe.</p>
		<cfif NOT (isQuery($comments) AND NOT $comments.recordCount GT 0)>
			[<a href="##comment">Add Comment</a>]
			<ol class="commentlist">
				<cfset i = 1 />
				<cfloop query="$comments">
					<li id="comment-#id#" class="comment #getAlternatingClass(currentRow)#">
						<div class="meta">
							#getUserProfileImage(profileimageurl, emailaddress)#
						</div>
						<div class="content">
							<h3 class="withcredits">#encodeOutput(getUserDisplayName(username, firstname, middleinitial, lastname, suffix))#</h3>
							<span class="credits">
								<a title="Permalink" href="##comment-#id#">#getFormattedDate(createdat)#</a>
							</span>
							<p>#encodeOutput(details)#</p>
						</div>
						<div class="paddles"></div>
					</li>
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
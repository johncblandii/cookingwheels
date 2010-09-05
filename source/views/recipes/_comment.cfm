<cfset $comment = arguments.$comment />
<cfoutput>
<li id="comment-#$comment.id#" class="comment #getAlternatingClass(i)#">
	<div class="meta">
		#$comment.user.getProfileImage()#
	</div>
	<div class="content">
		<h3 class="withcredits">#encodeOutput($comment.user.getDisplayName())#</h3>
		<span class="credits">
			<a title="Permalink" href="##comment-#$comment.id#">#getFormattedDate($comment.getLatestDate())#</a>
		</span>
		<p>#encodeOutput($comment.details)#</p>
	</div>
	<div class="paddles"></div>
</li>
</cfoutput>
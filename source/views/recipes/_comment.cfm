<cfset $comment = arguments.$comment />
<cfoutput>
<li id="comment-#$comment.id#" class="comment">
	<div class="comment-body">
		<div class="comment-author vcard">
			<img src="http://www.gravatar.com/avatar.php?gravatar_id=b3bf77f69098cf2fc5afeeda41034d61&amp;rating=PG&amp;size=32&amp;default=http://cfwheels.org:80/images/gravatar.gif" width="32" height="32" class="avatar" alt="ziggy's Gravatar">
			<cite class="fn">
				<strong>#$comment.user.getDisplayName()#</strong>
			</cite>
			<span class="says">says:</span>
		</div>
		<div class="comment-meta commentmetadata">
			<a href="##comment-#$comment.id#">#getFormattedDate($comment.getLatestDate())#</a>
		</div>
		<p>#$comment.details#</p>
	</div>
</li>
</cfoutput>
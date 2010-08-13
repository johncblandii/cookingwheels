<div id="comments">
	<h2> Comments </h2>
	<p> Read and submit questions, clarifications, and corrections about this chapter. </p>
	<p> There are no comments for this chapter. Be the first to comment! </p>
	<form action="/docs/comment##add-comment" id="add-comment" method="post">
		<fieldset>
			<legend>Add Comment</legend>
			<div>
				<label for="comment-name">Your Name</label>
				<input id="comment-name" name="comment[name]" type="text" value="" />
			</div>
			<div>
				<label for="comment-email">Email</label>
				<input id="comment-email" name="comment[email]" type="text" value="" />
			</div>
			<div>
				<label for="comment-url">Website</label>
				<input id="comment-url" name="comment[url]" type="text" value="" />
			</div>
			<div>
				<label for="comment-comments">Comments</label>
				<textarea id="comment-comments" name="comment[comments]"></textarea>
			</div>
			<div> 
				<script type="text/javascript">
				//<![CDATA[
				    <!--
					   var RecaptchaOptions = {
						  theme : 'clean',
					   };
				    //-->
				//]]>
				</script>
				<label for="recaptcha_response_field">Type the two words:</label>
				<script type="text/javascript" src="http://api.recaptcha.net/challenge?k=6Lf-0gkAAAAAAHgC850bY413tsXIPe73wgW-yGYc"></script>
				<noscript>
					<iframe src="http://api.recaptcha.net/noscript?k=6Lf-0gkAAAAAAHgC850bY413tsXIPe73wgW-yGYc" height="300" width="500" frameborder="0"></iframe>
					<br />
					<textarea name="recaptcha_challenge_field" rows="3" cols="40"></textarea>
					<input type="hidden" name="recaptcha_response_field" value="manual_challenge" />
				</noscript>
			</div>
			<div>
				<input id="chapter-id" name="chapter[id]" type="hidden" value="1" />
				<input type="submit" value="Submit Comment" />
			</div>
		</fieldset>
	</form>
</div>
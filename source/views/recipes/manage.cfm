<cfoutput>
	<cfif $data.isNew()>
		<h1>Submit a Recipe</h1>
		<p>Note: All recipes are reviewed by an admin before they show up on the site.</p>
	<cfelse>
		<h1>Edit Recipe</h1>
	</cfif>
	#errorMessagesFor("$data")#
	#startFormTag(argumentCollection=params)#
		#textField(label="Title", objectname="$data", property="title")#
		#textField(label="Problem", objectname="$data", property="problem")#
		#textField(label="Solution", objectname="$data", property="solution")#
		#textArea(label="Details", objectname="$data", property="details", class="tinymce")#
		<p class="credits">
			Wrap code with [code][/code] for it to show up in a code block.<br />
			Use [gist]0123456789[/gist] to use a <a href="https://gist.github.com/">GitHub gist</a>.
		</p>
		#textField(label="Tags", objectname="$data", property="tags")#
		<p class="credits">Separate tags with a space or comma. At least one tag is required.</p>
		#textField(label="Documentation Url", objectname="$data", property="documentationlink")#
		<p class="credits">This should be a url to the cfwheels docs page.</p>
		#submitTag()#
	#endFormTag()#
</cfoutput>
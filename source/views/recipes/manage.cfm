<cfoutput>
	<cfif $data.isNew()>
		<h1>Submit a Recipe</h1>
	<cfelse>
		<h1>Edit Recipe</h1>
	</cfif>
	#errorMessagesFor("$data")#
	#startFormTag()#
		#textField(label="Title", objectname="$data", property="title")#
		#textField(label="Problem", objectname="$data", property="problem")#
		#textField(label="Solution", objectname="$data", property="solution")#
		#textArea(label="Details", objectname="$data", property="details")#
		#submitTag()#
	#endFormTag()#
</cfoutput>
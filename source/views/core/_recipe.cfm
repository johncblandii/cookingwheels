<cfoutput>
	<h1> Recipe: Using Google Apps SMTP </h1>
	<p class="recipe-utility">March 9, 2009 @ 10:03 AM by <a href="/user/profile/3">raulriera</a></p>
	<p> You have a Google Apps account and wish to send emails using their SMTP servers. </p>
	<h3>Solution</h3>
	<p> Use the sendEmail() function and specify the useSSL, server, and port attributes to match gmail's requirements. </p>
	<h3>Detailed explanation</h3>
	<p> The sendEmail() function wraps around the CFMAIL tag and because GMail's servers require a secure connection you need to specify the following code in your /config/settings.cfm file (or in the appropriate Wheels environment) </p>
	<code>&lt;cfset set(functionName="sendEmail", server="smtp.gmail.com", username="yourEmail@yourwebsite.com", password="yourPassword", port="587", useTLS="yes") /&gt;</code>
	<p>The previous piece of code will set a default setting for all the sendEmail() functions used in your application, so all that is left is send the desired email from your controller like so: </p>
	<code>&lt;cfset sendEmail(from="yourEmail@yourwebsite.com", to="recipient@hiswebsite.com, subject="Email subject", template="yourEmailTemplateViewFile", type="html") /&gt;</code>
	<p> Remember that the content of the email will be stored in the file you pass into the template argument. A quick "gotcha" moment: by default the type argument is set to "text" in the CFMAIL tag, so be sure to pass in type="html" if your emails will be formatted. </p>
	#includePartial("/core/comments")#
</cfoutput>
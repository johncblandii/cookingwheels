<cfparam name="user" />
<cfparam name="password" type="string" />
<cfoutput>
<p>#user.getDisplayName()#, Your password has been reset.  Your new password is now "#password#".</p>

<p>Sincerely,</p>

<p>
Automated Support Team<br />
CookingWheels.com
</p>
</cfoutput>
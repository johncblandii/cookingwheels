<cfparam name="user" />
<cfparam name="password" type="string" />
<cfoutput>
#user.getDisplayName()#, Your password has been reset.  Your new password is now "#password#".

Sincerely,

Automated Support Team
CookingWheels.com
</cfoutput>
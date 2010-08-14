<cffunction name="outputFlash">
	<cfargument name="key" required="true" type="string" />
	<cfif flashKeyExists(arguments.key)>
		<cfoutput>
		<div class="flash-message">#flash(arguments.key)#</div>
		</cfoutput>
	</cfif>
</cffunction>

<cffunction name="getFormattedDate">
	<cfargument name="date" type="string" required="true" />
	<cfreturn dateFormat(arguments.date, "MMMM dd, yyyy") & " at " & timeFormat(arguments.date, "short") />
</cffunction>
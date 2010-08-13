<cffunction name="outputFlash">
	<cfargument name="key" required="true" type="string" />
	<cfif flashKeyExists(arguments.key)>
		<cfoutput>
		<div class="flash-message">#flash(arguments.key)#</div>
		</cfoutput>
	</cfif>
</cffunction>
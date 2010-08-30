<cfcomponent extends="Wheels">
<!--- PUBLIC METHODS --->
	<cffunction access="public" name="getLatestDate" returntype="String" hint="Gets the latest date; either createdat or updatedat">
		<cfif isDefined("this.updatedat") AND len(this.updatedat) GT 0>
			<cfreturn this.updatedat />
		<cfelseif isDefined("this.createdat") AND len(this.createdat) GT 0>
			<cfreturn this.createdat />
		<cfelse>
			<cfreturn "unknown" />
		</cfif>
	</cffunction>
	
	<cffunction access="public" name="fixUrl" returntype="String" hint="Prepends http:// if it is missing from a url">
		<cfargument name="url" type="string" required="true" />
		<cfset arguments.url = trim(arguments.url) />
		<cfif arguments.url DOES NOT CONTAIN "http://" AND arguments.url NEQ "">
			<cfset arguments.url = "http://"&trim(arguments.url) />
		</cfif>
		<cfreturn arguments.url />
	</cffunction>
	
	<cffunction access="private" name="sanitizeHtml" returntype="String" hint="Cleans up HTML in fields">
		
	</cffunction>
</cfcomponent>
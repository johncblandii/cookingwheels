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
</cfcomponent>
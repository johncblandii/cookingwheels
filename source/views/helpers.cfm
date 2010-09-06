<cffunction access="public" name="outputFlash" hint="Outputs a Wheels 'flash' message with the appropriate html wrapping">
	<cfargument name="keys" required="true" type="string" hint="A list of flash keys to output" />
	<cfargument name="cssclass" type="string" default="error" />
	<cfset var key = "" />
	<cfloop list="#arguments.keys#" index="key">
		<cfif flashKeyExists(key)>
			<cfoutput>
			<div class="#arguments.cssclass#">#flash(key)#</div>
			</cfoutput>
		</cfif>
	</cfloop>
</cffunction>

<cffunction access="public" name="getFormattedDate" hint="Formats a date to the global date output">
	<cfargument name="date" type="string" required="true" />
	<!---<cfreturn dateFormat(arguments.date, "MMMM dd, yyyy") & " at " & timeFormat(arguments.date, "short") />--->
	<cfreturn timeAgoInWords(date) & " ago"/>
</cffunction>

<cffunction access="public" name="getAlternatingClass" hint="Returns the alternate class if necessary">
	<cfargument name="index" required="true" type="numeric" />
	<cfset var result = "" />
	<cfif (i MOD 2) EQ 0>
		<cfset result = "alternate" />
	</cfif>
	<cfreturn result />
</cffunction>

<cffunction access="public" name="encodeOutput" returntype="String" hint="Encodes 'content' for HTML output">
	<cfargument name="content" required="true" type="string" />
	<cftry>
		<!--- trim output --->
		<cfset arguments.content = trim(arguments.content) />
		<!--- make the output safe --->
		<cfset arguments.content = application.esapi.encoder().encodeForHTML(arguments.content) />
		<cfset arguments.content = replace(replace(arguments.content, "&##x5b;&##x2f;code&##x5d;", "</code>", "all"), "&##x5b;code&##x5d;", "<code>", "all") />
		<cfreturn replaceNoCase(replaceNoCase(arguments.content, chr(13), "", "all"), chr(10), "<br />", "all") />
	<cfcatch type="any">
		<!--- If encoding fails, simply ignore the content. Don't take a chance displaying it. --->
		<cfreturn "" />
	</cfcatch>
	</cftry>
</cffunction>
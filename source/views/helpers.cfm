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
		<cfset arguments.content = replace(arguments.content, "&##x5b;&##x2f;code&##x5d;", "</code>", "all") />
		<cfset arguments.content = replace(replace(arguments.content, "&##x5b;&##x2f;gist&##x5d;", ".js""></script>", "all"), "&##x5b;gist&##x5d;", "<script src=""https://gist.github.com/", "all") />
		<cfreturn replaceNoCase(replaceNoCase(arguments.content, chr(13), "", "all"), chr(10), "<br />", "all") />
	<cfcatch type="any">
		<!--- If encoding fails, simply ignore the content. Don't take a chance displaying it. --->
		<cfreturn "" />
	</cfcatch>
	</cftry>
</cffunction>

<cffunction access="public" name="getUserDisplayName" returntype="String" hint="Returns the users display name">
	<cfargument name="username" type="string" />
	<cfargument name="firstname" type="string" />
	<cfargument name="middleinitial" type="string" />
	<cfargument name="lastname" type="string" />
	<cfargument name="suffix" type="string" />
	<cfset var result = "" />
	<cfif isDefined("arguments.firstname") AND len(trim(arguments.firstname)) GT 0>
		<cfset result = result & " " & trim(arguments.firstname) /> 
	</cfif>
	<cfif isDefined("arguments.middleinitial") AND len(trim(arguments.middleinitial)) GT 0>
		<cfset result = result & " " & arguments.middleinitial & "." /> 
	</cfif>
	<cfif isDefined("arguments.lastname") AND len(trim(arguments.lastname)) GT 0>
		<cfset result = result & " " & trim(arguments.lastname) /> 
	</cfif>
	<cfif isDefined("arguments.suffix") AND len(trim(arguments.suffix)) GT 0>
		<cfset result = result & " " & arguments.suffix /> 
	</cfif>
	<cfset result = trim(result) />
	<cfif len(result) EQ 0>
		<cfset result = arguments.username />
	</cfif>
	<cfreturn result />
</cffunction>

<cffunction access="public" name="getUserProfileImage" hint="Returns the users profile image url or a gravatar image">
	<cfargument name="profileimageurl" type="string" />
	<cfargument name="emailaddress" type="string" />
	<cfif isDefined("arguments.profileimageurl") AND len(trim(arguments.profileimageurl)) GT 0>
		<cfreturn "<img width='60' src='#arguments.profileimageurl#' />" />
	<cfelseif isDefined("arguments.emailaddress")>
		<cfreturn gravatarTag(rating="g", email=arguments.emailaddress, size="60", default="mm") />
	</cfif>
</cffunction>
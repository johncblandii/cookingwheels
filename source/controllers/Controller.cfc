<cfcomponent extends="Wheels" hint="Core controller with global functions">
<!--- CONSTRUCTOR --->
	<cffunction access="public" name="init" description="Constructor">
		<cfset filters(through="$initializeProperties") />
	</cffunction>
	
<!--- PUBLIC METHODS --->
	<cffunction access="public" name="isLoggedIn" description="Checks the session scope to see if the user is logged in">
		<cfreturn structKeyExists(session, "user") />
	</cffunction>
	
<!--- PRIVATE METHODS --->
	<cffunction access="private" name="$initializeProperties" description="Initializes global properties for all controllers">
		<!---<cfset $latesttags = model("tag").getTopTags() />--->
	</cffunction>

	<cffunction access="private" name="$authorize" description="Authorizes the users access to a specific portion of the site; redirects if fails">
		<cfif NOT isLoggedIn()>
			<cfset session.redirectParams = structCopy(params) />
			<cfset redirectTo(route="signin") />
		</cfif>
	</cffunction>
	
	<cffunction access="private" name="$getSetting" hint="Returns the setting from the database">
		<cfargument name="keyname" type="string" required="true" />
		<cfreturn model("setting").getSettingValue(arguments.keyname) />
	</cffunction>
	
	<cffunction access="private" name="$doDetailPage" hint="Manages CRUD interaction">
		<cfargument name="table" required="true" />
		<cfargument name="redirectParams" required="true" />
		<cfargument name="queryArgs" type="struct" required="false" default="#StructNew()#" />
		<cfif NOT isDefined("params.key")>
			<cfset redirectTo(action=arguments.redirectAction) />
		</cfif>
		<cfswitch expression="#params.key#">
			<cfcase value="edit">
				<cfif NOT isDefined("params.value") OR (isDefined("params.value") AND NOT isNumeric(params.value))>
					<cfset redirectTo(argumentCollection=arguments.redirectParams) />
				</cfif>
				<cfset arguments.queryArgs.key = params.value />
				<cfset arguments.queryArgs.returnas = "objects" />
				<cfset $data = model(arguments.table).findByKey(argumentCollection=arguments.queryArgs) />
			</cfcase>
			<cfcase value="delete">
				<cfif NOT isDefined("params.value") OR (isDefined("params.value") AND NOT isNumeric(params.value))>
					<cfset redirectTo(argumentCollection=arguments.redirectParams) />
				</cfif>
				<cfset $doDelete(arguments.table, arguments.redirectAction) />
			</cfcase>
			<cfdefaultcase>
				<cfset $data = model(arguments.table).new() />
			</cfdefaultcase>
		</cfswitch>
		
		<cfif isPost() AND structkeyexists(params, "$data")>
			<cfset $data.setProperties(params.$data) />
			<cfif $data.save()>
				<cfset flashInsert(success="Save complete.") />
				<cfif isDefined("arguments.redirectParams.resultkeys") AND isDefined("arguments.redirectParams.resultvalues")
					  AND listlen(arguments.redirectParams.resultkeys) EQ listlen(arguments.redirectParams.resultvalues)>
					<cfset index = 1 />				
					<cfloop list="#arguments.redirectParams.resultkeys#" index="key">
						<cfset val = listGetAt(arguments.redirectParams.resultvalues, index) />
						<cfif isDefined("$data['#val#']")>
							<cfset arguments.redirectParams["#key#"] = $data["#val#"] />
						</cfif>
						<cfset index = index + 1 /><!--- @johncblandii not using ++ to leave this compatible with older versions of CF --->
					</cfloop>
					<cfset structDelete(arguments.redirectParams, "resultkeys") />
					<cfset structDelete(arguments.redirectParams, "resultvalues") />
				</cfif>
				<cfset redirectTo(argumentCollection=arguments.redirectParams) />
			</cfif>
		</cfif>
	</cffunction>
	
	<cffunction access="private" name="$doDelete">
		<cfargument name="table" required="true" />
		<cfargument name="redirectAction" required="true" />
		<cfif structkeyexists(params, "value")>
			<cfset $data = model(arguments.table).findByKey(params.value) />
			
			<cfif isobject($data)>
				<cfset $data.delete() />
			</cfif>
		</cfif>
		
		<cfset redirectTo(action=arguments.redirectAction) />
	</cffunction>
</cfcomponent>
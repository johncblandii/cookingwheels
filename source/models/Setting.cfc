<cfcomponent extends="Model">
<!--- CONSTRUCTOR --->
	<cffunction access="public" name="init" hint="Constructor">
		<!--- VALIDATIONS --->
			<cfset validatesPresenceOf(properties="name,value", allowblank=false) />
	</cffunction>

<!--- PUBLIC METHODS --->
	<cffunction access="public" name="getSettingValue" returntype="String">
		<cfargument name="keyname" type="string" required="true" />
		<cfset var result = "" />
		<cfset var setting = super.findOneByKeyname(arguments.keyname) />
		<cfif isObject(setting)>
			<cfset result = setting.value />
		</cfif>
		<cfreturn result />
	</cffunction>
</cfcomponent>
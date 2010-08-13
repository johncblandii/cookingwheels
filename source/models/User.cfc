<cfcomponent extends="Wheels">
<!--- CONSTRUCTOR --->
	<cffunction access="public" name="init" hint="Constructor">
		<!--- RELATIONSHIPS --->
			<cfset belongsTo("usertype") />
			<cfset hasMany("recipes") />
			<cfset hasMany("comments") />
			<cfset hasMany("reciperatings") />
			
		<!--- VALIDATIONS --->
			<cfset validatesPresenceOf(properties="password") />
			<cfset validatesUniquenessOf(properties="username", allowBlank=false, minimum=5, maximum=25) />
			<cfset validatesUniquenessOf(properties="emailaddress", allowBlank=false, minimum=5, maximum=140) />
			<cfset validatesFormatOf(properties="emailaddress", format="email") />
			<cfset validatesConfirmationOf(properties="password") />
		
		<!--- CALLBACKS --->
			<cfset beforeValidationOnCreate("$beforeValidationOnCreate") />
			<cfset beforeCreate("$saltPassword") />
			<cfset beforeUpdate("$beforeUpdate") />
	</cffunction>

<!--- PRIVATE METHODS --->
	<cffunction access="private" name="$beforeValidationOnCreate" hint="Callback to process the model before validation on create">
		<!--- set a default password if the user didn't select one --->
		<cfif NOT isDefined("this.password")>
			<cfset this.password = getUniqueValue() />
		</cfif>
	</cffunction>
	
	<cffunction access="private" name="$beforeUpdate" hint="Callback to process the model before an update">
		<!--- if the password has changed, salt it --->
		<cfif hasChanged("password")>
			<cfset $saltPassword() />
		</cfif>
	</cffunction>

	<cffunction access="private" name="$saltPassword" hint="Takes the stored password and salts it then updates the password.">
		<cfset this.passwordsalt = getUniqueValue() />
		<cfset this.password = $hashPasssword(this.password, this.passwordsalt) />
	</cffunction>
	
	<cffunction access="public" name="$getPassswordHash" hint="Hashes the password with a salt">
		<cfargument name="pw" type="string" required="true" hint="Password to hash" />
		<cfargument name="pwsalt" type="string" required="true" hint="Salt to use with pw in hash" />
		<cfset arguments.pw = hash(arguments.pw & arguments.pwsalt, 'SHA-512') />
		<cfloop from="1" to="1025" index="i">
			<cfset arguments.pw = hash(arguments.pw & arguments.pwsalt, 'SHA-512') />
		</cfloop>
		<cfreturn arguments.pw />
	</cffunction>
	
	<cffunction access="private" name="getUniqueValue" hint="Gets a unique value for passwords and salts">
		<cfreturn mid(CreateUUID(), 1, 7) />
	</cffunction>

<!--- PUBLIC METHODS --->
	<cffunction access="public" name="updatePassword" returntype="boolean" hint="Updates the users password; note: model.password must be set first">
		<cfset var args = structNew() />
		<cfset $saltPassword() />
		<cfset args.password = this.password />
		<cfset args.passwordsalt = this.passwordsalt />
		<cfreturn this.update(properties=args) />
	</cffunction>

	<cffunction access="public" name="authenticate" returntype="boolean" hint="Authenticates a users credentials">
		<cfargument name="pw" type="string" required="true" hint="Password" />
		<cfif NOT isDefined("this.password") OR NOT isDefined("this.passwordsalt")>
			<cfreturn false />
		<cfelse>
			<cfreturn NOT compare($getPassswordHash(arguments.pw, this.passwordsalt), this.password) />
		</cfif>
	</cffunction>

	<cffunction access="public" name="getDisplayName" returntype="String" hint="Returns the users display name">
		<cfset var result = "" />
		<cfif len(trim(this.firstname)) GT 0>
			<cfset result = result & " " & trim(this.firstname) /> 
		</cfif>
		<cfif len(trim(this.middleinitial)) GT 0>
			<cfset result = result & " " & this.middleinitial & "." /> 
		</cfif>
		<cfif len(trim(this.lastname)) GT 0>
			<cfset result = result & " " & trim(this.lastname) /> 
		</cfif>
		<cfif len(trim(this.suffix)) GT 0>
			<cfset result = result & " " & this.suffix /> 
		</cfif>
		<cfset result = trim(result) />
		<cfif len(result) EQ 0>
			<cfset result = this.username />
		</cfif>
		<cfreturn result />
	</cffunction>
	
	<cffunction access="public" name="resetPassword" returntype="Struct" hint="Resets a users password and returns a struct with the new password [key: password] and update result [key: success]">
		<cfset var result = structNew() /> 
		<cfset var props = structNew() />
		<cfset props.ispasswordreset = "1" />
		<cfset props.password = generatePassword() />
		<cfset setProperties(props) />
		<cfset result.password = props.password />
		<cfset result.success = update() />
		<cfreturn result />
	</cffunction>
</cfcomponent>
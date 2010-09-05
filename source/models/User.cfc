<cfcomponent extends="Model">
<!--- CONSTRUCTOR --->
	<cffunction access="public" name="init" hint="Constructor">
		<!--- RELATIONSHIPS --->
			<cfset belongsTo("usertype") />
			<cfset hasMany("recipes") />
			<cfset hasMany("comments") />
			<cfset hasMany("reciperatings") />
			
		<!--- VALIDATIONS --->
			<cfset validatesUniquenessOf(properties="username", allowBlank=false, minimum=5, maximum=25, message="This username is already registered. Please use a different one.") />
			<cfset validatesUniquenessOf(properties="emailaddress", message="This email address is already registered. Please use a different one.") />
			<cfset validatesFormatOf(properties="emailaddress", allowBlank=false, minimum=5, maximum=140, format="email", message="Invalid email address.") />
			<cfset validatesFormatOf(properties="siteurl", format="url", allowblank="true", message="The site url must be a valid url.") />
			<cfset validatesFormatOf(properties="facebookurl", format="url", allowblank="true", message="The Facebook url must be a valid url.") />
			<cfset validatesFormatOf(properties="profileimageurl", format="url", allowblank="true", message="The profile image url must be a valid url.") />
			<cfset validatesConfirmationOf(property="password") />
		
		<!--- CALLBACKS --->
			<cfset beforeCreate("$beforeCreate") />
			<cfset beforeUpdate("$beforeUpdate") />
	</cffunction>

<!--- PRIVATE METHODS --->
	<cffunction access="private" name="$beforeCreate" hint="Callback to process the model before creating an entry">
		<cfif NOT isDefined("this.password")>
			<cfset $saltPassword() />
		</cfif>
		<cfset $sanitizeUrls() />
	</cffunction>
	
	<cffunction access="private" name="$beforeUpdate" hint="Callback to process the model before updating an entry">
		<cfif hasChanged("password")>
			<cfset $saltPassword() />
		</cfif>
		<cfset $sanitizeUrls() />
	</cffunction>
	
	<cffunction access="private" name="$sanitizeUrls" hint="Cleans up the user profile urls">
		<cfif isDefined("this.siteurl")>
			<cfset this.siteurl = fixUrl(this.siteurl) />
		</cfif>
		<cfif isDefined("this.facebookurl")>
			<cfset this.facebookurl = fixUrl(this.facebookurl) />
		</cfif>
		<cfif isDefined("this.twitterusername")>
			<cfset replace(this.twitterusername, "@", "", "all") />
		</cfif>
	</cffunction>
	
	<cffunction access="private" name="$saltPassword" hint="Takes the stored password and salts it then updates the password.">
		<cfif isDefined("this.password")>
			<cfset this.passwordsalt = getUniqueValue() />
			<cfset this.password = $getPassswordHash(this.password, this.passwordsalt) />
		</cfif>
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
		<cfif isDefined("this.firstname") AND len(trim(this.firstname)) GT 0>
			<cfset result = result & " " & trim(this.firstname) /> 
		</cfif>
		<cfif isDefined("this.middleinitial") AND len(trim(this.middleinitial)) GT 0>
			<cfset result = result & " " & this.middleinitial & "." /> 
		</cfif>
		<cfif isDefined("this.lastname") AND len(trim(this.lastname)) GT 0>
			<cfset result = result & " " & trim(this.lastname) /> 
		</cfif>
		<cfif isDefined("this.suffix") AND len(trim(this.suffix)) GT 0>
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
	
	<cffunction access="public" name="getRecentRecipes" hint="Returns the users latest recipes">
		<cfreturn super.recipes(maxRows=5) />
	</cffunction>
	
	<cffunction access="public" name="getProfileImage" hint="Returns the users profile image url or a gravatar image">
		<cfif isDefined("this.profileimageurl") AND len(trim(this.profileimageurl)) GT 0>
			<cfreturn "<img width='60' src='#this.profileimageurl#' />" />
		<cfelseif isDefined("this.emailaddress")>
			<cfreturn gravatarTag(rating="g", email=this.emailaddress, size="60", default="mm") />
		</cfif>
	</cffunction>
	
	<cffunction access="public" name="isTwitterUser" returntype="boolean" hint="Returns whether or not the user is a twitter or direct auth user.">
		<cfreturn isDefined("this.oauthtoken") />
	</cffunction>
</cfcomponent>
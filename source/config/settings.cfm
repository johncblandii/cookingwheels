<cfset set(dataSourceName="cookingwheels") />
<cfset set(URLRewriting="On")>

<!--- FUNCTIONS DEFAULTS --->
	<cfset set(functionName="findAll", perPage=20) />
	<cfset set(functionName="mailTo", encode=true) />
	
	<cfset set(functionName="validatesConfirmationOf", message="[property] doesn't match confirmation") />
	<cfset set(functionName="validatesExclusionOf", message="[property] is reserved", allowBlank=false) />
	<cfset set(functionName="validatesFormatOf", message="Format invalid: [property]", allowBlank=false) />
	<cfset set(functionName="validatesInclusionOf", message="[property] is not included in the list", allowBlank=false) />
	<cfset set(functionName="validatesLengthOf", message="[property] is the wrong length") />
	<cfset set(functionName="validatesNumericalityOf", message="[property] is not a number", allowBlank=false, onlyInteger=false) />
	<cfset set(functionName="validatesPresenceOf", message="[property] is empty") />
	<cfset set(functionName="validatesUniquenessOf", message="[property] must be unique") />
	
	<cfset set(functionName="javascriptIncludeTag", type="text/javascript") />
	
<!--- MISC DEFAULTS --->
	<cfset set(obfuscateUrls="true") />
	<cfset set(reloadPassword="cookit") />
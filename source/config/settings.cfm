<cfset set(dataSourceName="cookingwheels") />
<cfset set(URLRewriting="On")>

<!--- FUNCTIONS DEFAULTS --->
	<!--- Google Analytics Plugin --->
	<cfset set(google.analytics.trackerId="UA-7157770-2") />
	
	<!--- Framework --->
	<cfset set(functionName="findAll", perPage=20, returnas="object") />
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
	
	<cfset set(functionName="errorMessagesFor", class="error", showDuplicates=false) />
	<cfset set(functionName="textField", labelPlacement="before", prependToLabel="<div>", append="</div>") />
	<cfset set(functionName="dateSelect", labelPlacement="before", prependToLabel="<div>", append="</div>") />
	<cfset set(functionName="dateTimeSelect", labelPlacement="before", prependToLabel="<div>", append="</div>") />
	<cfset set(functionName="fileField", labelPlacement="before", prependToLabel="<div>", append="</div>") />
	<cfset set(functionName="passwordField", labelPlacement="before", prependToLabel="<div>", append="</div>") />
	<cfset set(functionName="radioButton", labelPlacement="wrap") />
	<cfset set(functionName="checkBox", labelPlacement="wrap") />
	<cfset set(functionName="select", labelPlacement="before", prependToLabel="<div>", append="</div>") />
	<cfset set(functionName="textArea", labelPlacement="before", prependToLabel="<div>", append="</div>") />
	<cfset set(functionName="timeSelect", labelPlacement="before", prependToLabel="<div>", append="</div>") />
	
<!--- MISC DEFAULTS --->
	<cfset set(obfuscateUrls="true") />
	<cfset set(reloadPassword="cookit") />
	<cfset set(sendEmailOnError=true) />
	<cfset set(errorEmailAddress="dev-team@cookingwheels.com") />
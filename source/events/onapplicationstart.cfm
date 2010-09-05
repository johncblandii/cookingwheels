<cfset application.javaloader = javaLoader() />
<cfset application.esapi = application.javaloader.create("org.owasp.esapi.ESAPI") />
<cfset application.esapi.securityConfiguration().setResourceDirectory("lib") />
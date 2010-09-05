<cfset application.javaloader = javaLoader() />
<cfset application.esapi = application.javaloader.create("org.owasp.esapi.ESAPI") />
<cfset application.esapi.securityConfiguration().setResourceDirectory("lib") />
<cfset application.twitter = application.javaloader.create("twitter4j.Twitter").init() />
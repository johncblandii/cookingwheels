<cfcomponent extends="Controller" hint="Controller for RSS feeds">
<!--- CONSTRUCTOR --->
	<cffunction access="public" name="init" hint="Constructor">
		<cfset super.init() />
	</cffunction>

<!--- PRIVATE METHODS --->
	<cffunction access="private" name="getCoreRSSData" hint="Returns the core RSS elements">
		<!--- Set the feed metadata. --->
		<cfset var rssdata = structNew() />
		<cfset rssdata.title = "CookingWheels.com - Recipes" />
		<cfset rssdata.link = "http://cookingwheels.com" />
		<cfset rssdata.description = "Recipes from CookingWheels.com" /> 
		<cfset rssdata.version = "rss_2.0" />
		<cfset rssdata.language = "en" />
		<cfset rssdata.managingEditor = "John C. Bland II" />
		<cfset rssdata.webmaster = "John C. Bland II" />
		<cfset rssdata.pubDate = now() />
		<cfset rssdata.lastBuildDate = now() />
		<cfset rssdata.ttl = 60 />
		<cfset rssdata.generator = "ColdFusion through CFWheels on Railo" />
		<cfset rssdata.item = ArrayNew(1) />
		<cfreturn rssdata />
	</cffunction>
	
	<cffunction access="private" name="renderRSS" description="Renders RSS to the browser">
		<cfargument name="recipes" type="any" required="true" /><!--- we handle non-array scenarios below --->
		<cfset var rssxml = "" />
		<cfset var i = 1 />
		<cfset var rssdata = getCoreRSSData() />
		<cfif isArray(arguments.recipes)>
			<cfloop array="#arguments.recipes#" index="recipe">
				<cfset rssdata.item[i] = StructNew() />
				<cfset rssdata.item[i].title = recipe.title />
				<cfset rssdata.item[i].author = recipe.user.getDisplayName() />
				<cfset rssdata.item[i].description = structNew() />
				<cfset rssdata.item[i].description.value = "<h3>Author</h3>" & linkTo(onlypath=false, route="userprofile", userid=recipe.user.id, text=recipe.user.getDisplayName()) & "<h1>Problem</h1><p>" & recipe.problem & "</p><h2>Solution</h2></p>" & recipe.solution & "</p>" />
				<cfset rssdata.item[i].guid = structNew() />
				<cfset rssdata.item[i].guid.isPermaLink = true />
				<cfset rssdata.item[i].guid.value = urlFor(onlypath=false, route="recipe", recipeid=recipe.id, text=recipe.title) />
				<cfset rssdata.item[i].pubdate = recipe.createdat />
				<cfset rssdata.item[i].comments = rssdata.item[i].guid.value & "##comments" />
				<cfset i = i+1 />
			</cfloop>
		</cfif>
		<cffeed action="create" name="#rssdata#" xmlvar="rssxml" />
		<cfcontent type="text/xml" reset="true" /><cfset renderText(rssxml) />
	</cffunction>

<!--- PUBLIC METHODS --->	
	<cffunction access="public" name="index" hint="All feeds for every user">
		<cfset renderRSS(model("recipe").findAll(include="user", order="createdat DESC", maxRows="20")) />
	</cffunction>
	
	<cffunction access="public" name="user" hint="Feeds by user">
		<cfparam name="params.userid" type="numeric" default="-1" /><!--- set an invalid user id so it returns nothing --->
		<cfset renderRSS(model("recipe").findAllByUserID(value=params.userid, include="user", order="createdat DESC", maxRows="20")) />
	</cffunction>
</cfcomponent>
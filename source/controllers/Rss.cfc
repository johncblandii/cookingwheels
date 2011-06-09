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
		<cfset rssdata.webmaster = "John C. Bland II (http://www.johncblandii.com)" />
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
		<cfif isQuery(arguments.recipes) AND arguments.recipes.recordCount GT 0>
			<cfloop query="arguments.recipes">
				<cfset local.username = getUserDisplayName(username, firstname, middleinitial, lastname, suffix) />
				<cfset rssdata.item[i] = StructNew() />
				<cfset rssdata.item[i].title = title />
				<cfset rssdata.item[i].author = local.username />
				<cfset rssdata.item[i].description = structNew() />
				<cfset rssdata.item[i].description.value = "<h3>Author</h3>" & linkTo(onlypath=false, route="userprofile", userid=userid, text=local.username) & "<h1>Problem</h1><p>" & problem & "</p><h2>Solution</h2></p>" & solution & "</p>" />
				<cfset rssdata.item[i].guid = structNew() />
				<cfset rssdata.item[i].guid.isPermaLink = true />
				<cfset rssdata.item[i].guid.value = urlFor(onlypath=false, route="recipe", recipeid=id, text=title) />
				<cfset rssdata.item[i].pubdate = createdat />
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
	
	<cffunction access="public" name="tag" hint="Feeds by user">
		<cfparam name="params.slug" type="string" default="n/a" /><!--- set an invalid user id so it returns nothing --->
		<cfset var tag = model("tag").findOneBySlug(value=params.slug) />
		<cfset var recipes = "" />
		<cfif isObject(tag)>
			<cfset recipes = tag.getRecipes(include="user", order="createdat DESC", maxRows="20") />
		</cfif>
		<cfset renderRSS(recipes) />
	</cffunction>
</cfcomponent>
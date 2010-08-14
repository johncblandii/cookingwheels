﻿<cfcomponent extends="Controller" hint="Recipe controller">
<!--- CONSTRUCTOR --->
	<cffunction access="public" name="init" hint="Constructor">
		<cfset super.init() />
		
	</cffunction>

<!--- PUBLIC METHODS --->
	<cffunction access="public" name="index" hint="Default">
		<cfset recent() />
	</cffunction>
	
	<cffunction access="public" name="recent" hint="Shows recent entries">
		<cfset $recipes = model("recipe").findAll(maxRows=10, include="user", order="createdat DESC") />
	</cffunction>
	
	<cffunction access="public" name="top10" hint="Shows the top 10 entries by rating">
	</cffunction>
	
	<cffunction access="public" name="recipe" hint="Shows one specific recipe entry">
		<cfset $recipe = model("recipe").findOneByID(value=params.recipeid, include="user") />
		<cfset $newcomment = model("comment").new() />
		<cfif isPost() AND isDefined("params.$newcomment")>
			<cfset params.$newcomment.recipeid = params.recipeid />
			<cfset $newcomment.setProperties(params.$newcomment) />
			<cfif $newcomment.save()>
				<cfset redirectTo(argumentCollection=params) /><!--- self-redirect --->
			</cfif>
		</cfif>
	</cffunction>
	
	<cffunction access="public" name="manage" hint="Manages one specific recipe entry">
		<cfset var redirect = StructNew() />
		<cfset redirect.route = "recipe" />
		<cfset redirect.resultkeys = "recipeid,text" />
		<cfset redirect.resultvalues = "id,title" />
		<cfif NOT isDefined("params.key")>
			<cfset params.key = "new" />
		</cfif>
		<cfset $doDetailPage("recipe", redirect) />
	</cffunction>
</cfcomponent>
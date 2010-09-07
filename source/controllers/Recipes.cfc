<cfcomponent extends="Controller" hint="Recipe controller">
<!--- CONSTRUCTOR --->
	<cffunction access="public" name="init" hint="Constructor">
		<cfset super.init() />
		<cfset filters(through="$authorize", only="manage") />
	</cffunction>

<!--- PUBLIC METHODS --->
	<cffunction access="public" name="index" hint="Default">
		<cfset recent() />
	</cffunction>
	
	<cffunction access="public" name="recent" hint="Shows recent entries">
		<cfset pagetitle = "Recent Recipes" />
		<cfset $recipes = model("recipe").findAll(maxRows=10, include="user", order="createdat DESC") />
	</cffunction>
	
	<cffunction access="public" name="top10" hint="Shows the top 10 entries by rating">
		<cfset pagetitle = "Top 10 Recipes" />
	</cffunction>
	
	<cffunction access="public" name="recipe" hint="Shows one specific recipe entry">
		<cfset var args = StructNew() />
		<cfif NOT isDefined("params.recipeid")>
			<cfset redirectTo(action="index") />
		</cfif>
		<cfset args.value = params.recipeid />
		<cfset args.include = "user" />
		<cfif isLoggedIn()>
			<cfset args.forceApproved = false />
		</cfif>
		<cfset $recipe = model("recipe").findOneByID(argumentCollection=args) />
		<cfset $newcomment = model("comment").new() />
		<cfif isPost() AND isDefined("params.$newcomment")>
			<cfset params.$newcomment.recipeid = params.recipeid />
			<cfset $newcomment.setProperties(params.$newcomment) />
			<cfif $newcomment.save()>
				<cfset redirectTo(argumentCollection=params) /><!--- self-redirect --->
			</cfif>
		</cfif>
		<cfif isObject($recipe)>
			<cfif (NOT $recipe.isApproved() AND NOT isLoggedIn()) OR
					(isLoggedIn() AND NOT $recipe.isApproved() AND $recipe.user.id NEQ session.user.id)>
				<cfset $recipe = false />
			<cfelse>
				<cfset pagetitle = $recipe.title />
			</cfif>
		</cfif>
	</cffunction>
	
	<cffunction access="public" name="manage" hint="Manages one specific recipe entry">
		<cfset var redirect = StructNew() />
		<cfif isDefined("params.recipeid")>
			<cfset params.value = params.recipeid />
		</cfif>
		<cfif NOT isDefined("params.key")>
			<cfset params.key = "new" />
		</cfif>
		<cfif params.key NEQ "new">
			<cfset redirect.route = "recipe" />
			<cfset redirect.resultkeys = "recipeid,text" />
			<cfset redirect.resultvalues = "id,title" />
		</cfif>
		<cfset $doDetailPage("recipe", redirect) />
		
		<cfif isPost() AND NOT $data.isNew()>
			<cftry>
				<cfset sendEmail(from=$getSetting("email.from.default"), 
								 to=$getSetting("email.to.admins"), 
								 templates="/emailtemplates/newrecipeplain,/emailtemplates/newrecipe", 
								 subject=$getSetting("email.recipe.new.subject"), 
								 user=$data.user(),
								 recipe=$data) />
			<cfcatch type="any">
				<cfdump var="#cfcatch#" abort="true" />
			</cfcatch>
			</cftry>
			<cfset redirectTo(route="managerecipe", recipeid=$data.id, text=$data.title) />
		</cfif>
		
		<cfif NOT $data.isNew()>
			<cfif $data.userid NEQ session.user.id>
				<cfset redirectTo(action="index") />
			</cfif>
			<cfset $data.loadTags() />
		</cfif>
	</cffunction>
</cfcomponent>
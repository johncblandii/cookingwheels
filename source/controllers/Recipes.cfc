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
	
	<cffunction access="public" name="approve" hint="Approve the recipe">
		<cfif NOT isLoggedIn() OR (isLoggedIn() AND session.user.usertypeid NEQ 1)>
			<cfset redirectTo(route="home") />
		<cfelseif NOT isDefined("params.recipeid")>
			<cfset redirectTo(controller="recipes") />
		</cfif>
		<cfset args.value = params.recipeid />
		<cfset args.include = "user" />
		<cfif isLoggedIn() AND session.user.usertypeid EQ 1>
			<cfset args.forceApproved = false />
		</cfif>
		
		<cfset $recipe = model("recipe").findOneByID(argumentCollection=args) />
		<cfset $recipe.approvedat = now() />
		<cfif $recipe.save(callbacks=false, validate=false)>
			<cfset sendEmail(from=$getSetting("email.from.default"), 
							 to=$recipe.user.emailaddress,
							 bcc= $getSetting("email.to.admins"),
							 templates="/emailtemplates/approvedrecipeplain,/emailtemplates/approvedrecipe", 
							 subject=$getSetting("email.recipe.approved.subject"), 
							 user=$recipe.user,
							 recipe=$recipe) />
			<cfset redirectTo(route="recipe", recipeid=$recipe.id, key=$recipe.title) />
		</cfif>
		<cfdump var="#$recipe.allerrors()#" abort />
		<cfabort />
	</cffunction>
	
	<cffunction access="public" name="recipe" hint="Shows one specific recipe entry">
		<cfset var args = StructNew() />
		<cfif NOT isDefined("params.recipeid")>
			<cfset redirectTo(controller="recipes") />
		</cfif>
		<cfset args.value = params.recipeid />
		<cfset args.include = "user" />
		<cfif isLoggedIn() AND session.user.usertypeid EQ 1>
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
					(isLoggedIn() AND NOT $recipe.isApproved() AND ($recipe.user.id NEQ session.user.id AND session.user.usertypeid NEQ 1))>
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
		<cfif isLoggedIn()>
			<cfset local.queryArgs = {forceApproved=false} />
		</cfif>
		<cfset super.$doDetailPage("recipe", redirect, local.queryArgs) />
		
		<cfif isPost() AND NOT $data.isNew()>
			<cftry>
				<cfset sendEmail(from=$getSetting("email.from.default"), 
								 to=$getSetting("email.to.admins"), 
								 templates="/emailtemplates/newrecipeplain,/emailtemplates/newrecipe", 
								 subject=$getSetting("email.recipe.new.subject"), 
								 user=$data.user(),
								 recipe=$data) />
			<cfcatch type="any">
			</cfcatch>
			</cftry>
			<cfset redirectTo(route="managerecipe", recipeid=$data.id, text=$data.title) />
		</cfif>
		
		<cfif NOT $data.isNew()>
			<cfif $data.userid NEQ session.user.id AND session.user.usertypeid NEQ 1>
				<cfset redirectTo(controller="recipes") />
			</cfif>
			<cfset $data.loadTags() />
		</cfif>
	</cffunction>
</cfcomponent>
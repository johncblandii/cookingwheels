<cfcomponent extends="Controller" hint="Tags controller">
<!--- CONSTRUCTOR --->
	<cffunction access="public" name="init" description="Constructor">
		<cfset super.init() />
		<cfset filters(through="$authorize", only="add") />
	</cffunction>

<!--- PUBLIC METHODS --->	
	<cffunction access="public" name="index" description="Lists all tags">
		<cfset $tags = model("tag").findAll(order="name ASC") />
	</cffunction>
	
	<cffunction access="public" name="add" description="Adds a new tag via ajax">
		<cfset verifies(ajax=true, params="tagname") />
		<cfif NOT model("tag").exists(where="name='#params.tagname#'")>
			<cfset tag = model("tag").new() />
			<cfset tag.name = params.tagname />
			<cfreturn tag.save() />
		<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>
	
	<cffunction access="public" name="recipes" description="View recipes for a tag">
		<!--- @johncblandii this isn't named $tag because of line 135 in wheels/view/miscellaneous.cfm; it references $tag --->
		<cfset $recipetag = model("tag").findOneBySlug(params.slug) />
		<cfif isObject($recipetag)>
			<cfset $recipes = model("recipe").findAll(where="recipetags.tagid="&$recipetag.id, include="recipetag") />
		<cfelse>
			<cfset redirectTo(action="index") />
		</cfif>
	</cffunction>
</cfcomponent>
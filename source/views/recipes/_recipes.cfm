<cfoutput>
<cfloop array="#$recipes#" index="recipe">
	<ul class="recipelist recipe-#recipe.id#" id="recipe-#recipe.id#">
		#includePartial(partial="/recipes/recipesimple", recipe=recipe)#
	</ul>
</cfloop>
</cfoutput>
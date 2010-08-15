<cfoutput>
<cfloop array="#$recipes#" index="recipe">
	<div class="recipe-#recipe.id# post type-post hentry category-events" id="recipe-#recipe.id#">
		#includePartial(partial="/recipes/recipesimple", recipe=recipe)#
	</div>
</cfloop>
</cfoutput>
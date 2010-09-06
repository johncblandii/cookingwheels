<cfparam name="user" />
<cfparam name="recipe" />

<cfoutput>
#user.getDisplayName()#</strong> created a new recipe.

--Title--
#recipe.title#

--Problem--
#recipe.problem#

--Solution--
#recipe.solution#

--Details--
#recipe.details#

--Tags--
#recipe.tags#

--Documentation Link--
#recipe.documentationlink#
</cfoutput>
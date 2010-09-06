<cfparam name="user" />
<cfparam name="recipe" />

<cfoutput>
<p><strong>#user.getDisplayName()#</strong> created a new recipe.</p>

<p>
<strong>Title</strong><br />
#recipe.title#
</p>

<p>
<strong>Problem</strong><br />
#recipe.problem#
</p>

<p>
<strong>Solution</strong><br />
#recipe.solution#
</p>

<p>
<strong>Details</strong><br />
#recipe.details#
</p>

<p>
<strong>Tags</strong><br />
#recipe.tags#
</p>

<p>
<strong>Documentation Link</strong><br />
#recipe.documentationlink#
</p>
</cfoutput>
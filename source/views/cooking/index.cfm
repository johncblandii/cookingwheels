<h1>Welcome!</h1>
<p id="introduction">Enjoy, learn, and <strike>share</strike> cook!</p>

<h2>Latest Recipes</h2>
<cfoutput>
	#includePartial(partial="/recipes/recipes", $recipes=$recipes)#
</cfoutput>
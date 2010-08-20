<h1>Welcome to Cooking Wheels!</h1>
<p id="introduction">Enjoy, learn, and share.</p>

<h2>Latest Recipes</h2>
<cfoutput>
	#includePartial(partial="/recipes/recipes", $recipes=$recipes)#
</cfoutput>
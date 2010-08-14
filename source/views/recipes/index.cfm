<cfoutput>
<div id="blog">
	<h1>Recent Recipes</h1>
	<cfif isarray($recipes) AND arraylen($recipes) GT 0>
		<p id="introduction">There's always room for more but here are the most recent recipes.</p>
		#includePartial(partial="recipes", $recipes=$recipes)#
	<cfelse>
		<p id="introduction">Get in the game! #linkTo(action="manage", text="Submit a recipe")#.</p>
	</cfif>
</div>
</cfoutput>
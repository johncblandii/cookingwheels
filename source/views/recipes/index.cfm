<cfoutput>
<div id="blog">
	<h1>Recipes</h1>
	<cfif isarray($recipes) AND arraylen($recipes) GT 0>
		<p id="introduction">There's always room for more!</p>
		#includePartial(partial="recipes", $recipes=$recipes)#
	<cfelse>
		<p id="introduction">Get in the game! #linkTo(action="manage", text="Start cooking")#.</p>
	</cfif>
</div>
</cfoutput>
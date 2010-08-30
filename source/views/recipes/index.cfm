<cfoutput>
<h1>Recipes</h1>
<cfif isDefined("$recipes") AND isarray($recipes) AND arraylen($recipes) GT 0>
	#includePartial(partial="recipes", $recipes=$recipes)#
<cfelse>
	<p>Get in the game! #linkTo(action="manage", text="Start cooking")#.</p>
</cfif>
</cfoutput>
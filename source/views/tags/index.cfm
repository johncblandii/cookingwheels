<cfoutput>
	<h1>Tags</h1>
	<cfif isArray($tags) AND arraylen($tags) GT 0>
		<p id="introduction">...you're it!</p>
		<p>Tags are like categories. They help segment a recipe to fit into one or more "categories" for easy reference. To add a tag, #linkTo(route="newrecipe", text="start cooking")# and set the tags before you save it.</p>
		<ul class="taglist">
		<cfloop array="#$tags#" index="tag">
			<li>#linkTo(route="tagrecipes", slug=tag.slug, text=tag.name)#</li> 
		</cfloop>
		</ul>
	<cfelse>
		<p id="introduction">#linkTo(route="newrecipe", text="Submit a post")# and tag it!</p>
	</cfif>
</cfoutput>
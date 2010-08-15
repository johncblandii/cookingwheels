<cfoutput>
	<h1>Tags</h1>
	<cfif isArray($tags) AND arraylen($tags) GT 0>
		<ul id="taglist">
		<cfloop array="#$tags#" index="tag">
			<li>#linkTo(route="tagrecipes", slug=tag.slug, text=tag.name)#</li> 
		</cfloop>
		</ul>
	<cfelse>
		<p id="introduction">#linkTo(route="newrecipe", text="Submit a post")# and tag it!</p>
	</cfif>
</cfoutput>
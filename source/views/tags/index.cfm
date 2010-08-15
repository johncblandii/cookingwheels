<cfoutput>
	<h1>Tags</h1>
	<ul id="taglist">
	<cfloop array="#$tags#" index="tag">
		<li>#linkTo(route="tagrecipes", slug=tag.slug, text=tag.name)#</li> 
	</cfloop>
	</ul>
</cfoutput>
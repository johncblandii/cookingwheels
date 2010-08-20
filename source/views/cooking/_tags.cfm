<cfparam name="arguments.title" type="string" default="Tags" />
<cfoutput>
<h2>#arguments.title#</h2>
<ul>
	<cfloop array="#arguments.$tags#" index="tag">
		<li>#linkTo(route="tagrecipes", slug=tag.slug, text=tag.name)#</li>
	</cfloop>
</ul>
</cfoutput>
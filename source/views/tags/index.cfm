﻿<cfoutput>
	<h1 class="withcredits">Tags</h1>
	<cfif isQuery($tags) AND $tags.recordCount GT 0>
		<p class="credits">...you're it!</p>
		<br />
		<p>Tags are like categories. They help segment a recipe to fit into one or more "categories" for easy reference. To add a tag, #linkTo(route="newrecipe", text="start cooking")# and set the tags before you save it.</p>
		<h3>Current Tags</h3>
		<ul class="taglist">
		<cfloop query="$tags">
			<li>#linkTo(route="tagrecipes", slug=slug, text=encodeOutput(name))#</li> 
		</cfloop>
		</ul>
	<cfelse>
		<p id="introduction">#linkTo(route="newrecipe", text="Submit a post")# and tag it!</p>
	</cfif>
</cfoutput>
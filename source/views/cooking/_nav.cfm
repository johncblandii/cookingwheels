﻿<cfoutput>
	<ul class="navigation">
		<li>#linkTo(route="home", text="Home")#</li>
		<li>#linkTo(controller="recipes", text="Recipes")#</li>
		<li>#linkTo(controller="tags", text="Tags")#</li>
		<li>#linkTo(route="users", text="Users")#</li>
		<li>#linkTo(controller="faq", text="FAQ")#</li>
		<li>#linkTo(controller="contact", text="Contact Us")#</li>
	</ul>
</cfoutput>
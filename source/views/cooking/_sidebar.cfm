<cfoutput>
<h1>Cooking Wheels</h1>
<p id="introduction" style="line-height: ."> Get'cha cook on! </p>
<ul>
	<li>#linkTo(route="newrecipe", text="Submit a Recipe")#</li>
</ul>

<cfif isDefined("$latesttags")>
	#includePartial(title="Last 5 Tags", partial="/cooking/tags", $tags=$latesttags)#
</cfif>
</cfoutput>
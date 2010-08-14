<!---
@johncblandii 
The use of some specific routes here is to circumvent having to create multiple controls [ie - Recipe and Recipes].
--->

<!--- USER --->
	<cfset addRoute(name="userprofile", pattern="user/[userid]/[text]", controller="user", action="profile") />
	<cfset addRoute(name="userprofile", pattern="user/[userid]", controller="user", action="profile") />
	<cfset addRoute(name="userprofile", pattern="user", controller="user", action="profile") />

<!--- TAG --->
	<cfset addRoute(name="top10recipes", pattern="tag/[tagname]/recipes", controller="tags", action="recipes") />
	<cfset addRoute(name="top10recipes", pattern="tag/add", controller="tags", action="add") />

<!--- RECIPE --->
	<cfset addRoute(name="newrecipe", pattern="recipe/submit/[key]/[value]", controller="recipes", action="manage") />
	<cfset addRoute(name="newrecipe", pattern="recipe/submit/[key]", controller="recipes", action="manage") />
	<cfset addRoute(name="newrecipe", pattern="recipe/submit", controller="recipes", action="manage", key="new") />
	<cfset addRoute(name="editrecipe", pattern="recipe/[recipeid]/edit", controller="recipes", action="manage") />
	<cfset addRoute(name="recipe", pattern="recipe/[recipeid]/[text]", controller="recipes", action="recipe") />

<!--- DEFAULT --->
	<cfset addRoute(name="home", pattern="", controller="cooking", action="index") />
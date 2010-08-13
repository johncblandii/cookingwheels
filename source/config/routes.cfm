<!---
@johncblandii 
The use of some specific routes here is to circumvent having to create multiple controls [ie - Recipe and Recipes].
--->

<!--- TAG --->
	<cfset addRoute(name="top10recipes", pattern="tag/[tagname]/recipes", controller="tags", action="recipes") />
	<cfset addRoute(name="top10recipes", pattern="tag/add", controller="tags", action="add") />

<!--- RECIPE --->
	<cfset addRoute(name="managerecipe", pattern="recipe/[recipeid]/manage", controller="recipes", action="manage") />
	<cfset addRoute(name="recipe", pattern="recipe/[recipeid]/[text]", controller="recipes", action="recipe") />

<!--- DEFAULT --->
	<cfset addRoute(name="home", pattern="", controller="cooking", action="index") />
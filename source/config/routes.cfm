<!---
@johncblandii 
The use of some specific routes here is to circumvent having to create multiple controls [ie - Recipe and Recipes].
--->

<!--- USER --->
	<cfset addRoute(name="signout", pattern="user/signout", controller="user", action="signout") />
	<cfset addRoute(name="signup", pattern="user/signup", controller="user", action="signup") />
	<cfset addRoute(name="signin", pattern="user/signin", controller="user", action="signin") />
	<cfset addRoute(name="userprofile", pattern="user/[userid]/[text]", controller="user", action="profile") />
	<cfset addRoute(name="userprofile", pattern="user/[userid]", controller="user", action="profile") />
	<cfset addRoute(name="user", pattern="user", controller="user", action="index") />

<!--- TAG --->
	<cfset addRoute(name="tagrecipes", pattern="tag/[slug]/recipes", controller="tags", action="recipes") />
	<cfset addRoute(name="addtag", pattern="tag/add", controller="tags", action="add") />

<!--- RECIPE --->
	<cfset addRoute(name="newrecipe", pattern="recipe/submit/[key]/[value]", controller="recipes", action="manage") />
	<cfset addRoute(name="newrecipe", pattern="recipe/submit/[key]", controller="recipes", action="manage") />
	<cfset addRoute(name="newrecipe", pattern="recipe/submit", controller="recipes", action="manage", key="new") />
	<cfset addRoute(name="editrecipe", pattern="recipe/[recipeid]/edit", controller="recipes", action="manage") />
	<cfset addRoute(name="recipe", pattern="recipe/[recipeid]/[text]", controller="recipes", action="recipe") />

<!--- DEFAULT --->
	<cfset addRoute(name="home", pattern="", controller="cooking", action="index") />
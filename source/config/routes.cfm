<!---
@johncblandii 
The use of some specific routes here is to circumvent having to create multiple controls [ie - Recipe and Recipes].
--->

<!--- RSS --->
	<cfset addRoute(name="tagrss", pattern="rss/tag/[slug]", controller="rss", action="tag") />
	<cfset addRoute(name="userrss", pattern="rss/user/[userid]/[text]", controller="rss", action="user") />
	<cfset addRoute(name="userrss", pattern="rss/user/[userid]", controller="rss", action="user") />
	<cfset addRoute(name="rss", pattern="rss", controller="rss", action="index") />
	
<!--- USER --->
	<cfset addRoute(name="authtwitter", pattern="user/authtwitter", controller="user", action="authtwitter") />
	<cfset addRoute(name="twitterauth", pattern="user/twitterauth", controller="user", action="twitterauth") />
	<cfset addRoute(name="signout", pattern="user/signout", controller="user", action="signout") />
	<cfset addRoute(name="signup", pattern="user/signup", controller="user", action="signup") />
	<cfset addRoute(name="signin", pattern="user/signin", controller="user", action="signin") />
	<cfset addRoute(name="resetpassword", pattern="user/resetpassword", controller="user", action="resetpassword") />
	<cfset addRoute(name="changepassword", pattern="user/changepassword", controller="user", action="changepassword") />
	<cfset addRoute(name="editprofile", pattern="user/[userid]/m/[key]", controller="user", action="manage") />
	<cfset addRoute(name="userprofile", pattern="user/[userid]/[text]", controller="user", action="profile") />
	<cfset addRoute(name="userprofile", pattern="user/[userid]", controller="user", action="profile") />
	<cfset addRoute(name="user", pattern="user", controller="user", action="index") />
	<cfset addRoute(name="users", pattern="users", controller="user", action="index") />

<!--- TAG --->
	<cfset addRoute(name="tagrecipes", pattern="tag/[slug]/recipes", controller="tags", action="recipes") />
	<cfset addRoute(name="addtag", pattern="tag/add", controller="tags", action="add") />

<!--- RECIPE --->
	<cfset addRoute(name="newrecipe", pattern="recipe/submit/[key]/[value]", controller="recipes", action="manage") />
	<cfset addRoute(name="newrecipe", pattern="recipe/submit/[key]", controller="recipes", action="manage") />
	<cfset addRoute(name="newrecipe", pattern="recipe/submit", controller="recipes", action="manage", key="new") />
	<cfset addRoute(name="approverecipe", pattern="recipe/[recipeid]/approve", controller="recipes", action="approve") />
	<cfset addRoute(name="managerecipe", pattern="recipe/[recipeid]/m/[key]", controller="recipes", action="manage") />
	<!---
		<cfset addRoute(name="recipe", pattern="recipe/[recipeid]/[text]", controller="recipes", action="recipe") />
	--->
	<cfset addRoute(name="recipe", pattern="recipe/[recipeid]", controller="recipes", action="recipe") />

<!--- DEFAULT --->
	<cfset addRoute(name="home", pattern="", controller="cooking", action="index") />
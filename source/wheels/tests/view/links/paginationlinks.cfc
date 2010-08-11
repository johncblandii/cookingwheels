<cfcomponent extends="wheelsMapping.Test">

	<cfset params = {controller="dummy", action="dummy"}>

	<cffunction name="setup">
		<cfset var loc = StructNew()>
		<cfset copies.application.wheels.routes = Duplicate(application.wheels.routes)>
		<cfset copies.application.wheels.namedRoutePositions = Duplicate(application.wheels.namedRoutePositions)>
		<cfset controller = $controller(name="dummy").$createControllerObject(params)>
		<cfset loc.route = StructNew()>
		<cfset loc.route.name = "pagination">
		<cfset loc.route.pattern = "pag/ina/tion/[special]">
		<cfset loc.route.controller = "pagi">
		<cfset loc.route.action = "nation">
		<cfset loc.route.variables = "special">
		<cfset ArrayInsertAt(application.wheels.routes, 2, loc.route)>
		<cfset application.wheels.namedRoutePositions.pagination = 2>
	</cffunction>

	<cffunction name="teardown">
		<cfset application.wheels.routes = Duplicate(copies.application.wheels.routes)>
		<cfset application.wheels.namedRoutePositions = Duplicate(copies.application.wheels.namedRoutePositions)>
	</cffunction>
	
	<cffunction name="test_current_page">
		<cfset var loc = StructNew()>
		<cfset loc.authors = model("author").findAll(page=2, perPage=3, order="lastName")>
		<cfset loc.link = controller.linkTo(text="2", params="page=2")>
		<cfset result = controller.paginationLinks(linkToCurrentPage=true)>
		<cfset assert("result Contains '#loc.link#'")>
		<cfset result = controller.paginationLinks(linkToCurrentPage=false)>
		<cfset assert("result Does Not Contain '#loc.link#' AND result Contains '2'")>
	</cffunction>

	<cffunction name="test_route">
		<cfset var loc = StructNew()>
		<cfset loc.authors = model("author").findAll(page=2, perPage=3, order="lastName")>
		<cfset loc.link = controller.linkTo(route="pagination", special=99, text="3", params="page=3")>
		<cfset result = controller.paginationLinks(route="pagination", special=99)>
		<cfset assert("result Contains '#loc.link#' AND result Contains '?page='")>
	</cffunction>

	<cffunction name="test_page_as_route_param">
		<cfset var loc = StructNew()>
		<cfset loc.authors = model("author").findAll(page=2, perPage=3, order="lastName")>
		<cfset loc.addToPattern = "/[page]">
		<cfset loc.addToVariables = ",page">
		<cfset application.wheels.routes[2].pattern = application.wheels.routes[2].pattern & loc.addToPattern>
		<cfset application.wheels.routes[2].variables = application.wheels.routes[2].variables & loc.addToVariables>
		<cfset loc.link = controller.linkTo(route="pagination", special=99, text="3", page=3)>
		<cfset result = controller.paginationLinks(route="pagination", special=99, pageNumberAsParam=false)>
		<cfset assert("result Contains '#loc.link#' AND result Does Not Contain '?page='")>
	</cffunction>
	
</cfcomponent>
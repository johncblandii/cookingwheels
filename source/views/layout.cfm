<!--- Place HTML here that should be used as the default layout of your application --->
<html>
	<body>
		<cfoutput>
			#includePartial("/core/nav")#
			#includeContent()#
		</cfoutput>
	</body>
</html>
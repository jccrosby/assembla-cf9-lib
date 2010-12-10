<cfcomponent aaccessors="true">
	
	<cffunction name="getAllSpaces" access="remote" returntype="Array">
		<cfargument name="authToken" required="true" type="string"/>
		<cfset spaces = new cfc.Spaces() />
		<cfreturn spaces.getSpaces( arguments.authToken ) />
	</cffunction>

	<cffunction name="getTicketsForSpace" access="remote" returntype="Array">
		<cfargument name="authToken" required="true" type="string" />
		<cfargument name="spaceId" required="true" type="string" />
		<cfargument name="page" required="false" type="numeric" default="1"/>
		<cfset tickets = new cfc.Tickets() />
		<cfreturn tickets.getTickets( arguments.authToken, arguments.spaceId, arguments.page ) />
	</cffunction>
	
</cfcomponent>
<cfcomponent aaccessors="true">
	
	<cffunction name="getSpaces" access="remote" returntype="Array">
		<cfargument name="authToken" required="true" type="string"/>
		<cfset spaces = new Spaces() />
		<cfreturn spaces.getSpaces( arguments.authToken ) />
	</cffunction>

	<cffunction name="getSpaceTickets" access="remote" returntype="Array">
		<cfargument name="authToken" required="true" type="string" />
		<cfargument name="spaceId" required="true" type="string" />
		<cfargument name="reportID" required="true" type="numeric" default="0" />
		<cfargument name="page" required="false" type="numeric" default="1"/>
		<cfset tickets = new Tickets() />
		<cfreturn tickets.getTicketReport( arguments.authToken, arguments.spaceId, arguments.reportID, arguments.page ) />
	</cffunction>

	<cffunction name="getSpaceUsers" access="remote" returntype="Array">
		<cfargument name="authToken" required="true" type="string" />
		<cfset spaces = new Spaces() />
		<cfreturn spaces.getSpaceUsers( arguments.authToken ) />
	</cffunction>
	
</cfcomponent>
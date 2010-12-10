﻿<cfcomponent>
<!--- http://www.assembla.com/spaces/<space_id>/tickets/ --->
	<cffunction name="getTickets" access="public" returntype="array" output="true">
		<cfargument name="authToken" type="string" required="true" />
		<cfargument name="spaceId" type="string" required="true" />
		<cfargument name="page" type="numeric" required="false" default="1" />
		
		<cfset tickets = arrayNew( 1 ) />
		<!--- Request tickets --->
		<!--- Create request --->
		<cfset rest = "spaces/" & arguments.spaceId & "/tickets" />
		<cfset svc = new AssemblaRequest( rest, arguments.authToken ) />
		
		<!--- Load the request --->
		<cfset result = svc.load() />
		
		<cfset xmlResult = xmlParse( result ) />
		
		<!--- Parse spaces XML respone into Array of space objects --->
		<!--- handle the response --->
		
		<cfloop index="i" from="1" to="#arrayLen( xmlResult.tickets.XmlChildren )#" step="1">
			<cfset ticketXML = xmlResult.tickets[ "ticket" ][ i ] />
			<cfset newTicket = new vo.Ticket() />
			
			<cfset newTicket.setId( numberFormat( ticketXML.id.XmlText, "9" ) ) />
			<cfset newTicket.setNumber( numberFormat( ticketXML.number.XmlText, "9" ) ) />
			<cfset newTicket.setSummary( ticketXML.summary.XmlText ) />
			<cfset newTicket.setReporterId( ticketXML["reporter-id"].XmlText ) />
			<cfset newTicket.setAssignedToId( ticketXML["assigned-to-id"].XmlText ) />
			<cfset newTicket.setPriority( ticketXML.status.XmlText ) />
			<cfset newTicket.setStatus( ticketXML.priority.XmlText ) />
			<cfset newTicket.setComponentId( ticketXML["component-id"].XmlText ) />
			<cfset newTicket.setDescription( ticketXML.description.XmlText ) />
			<cfset newTicket.setMilestoneId( ticketXML["milestone-id"].XmlText ) />
			<cfset newTicket.setSpaceId( ticketXML["space-id"].XmlText ) />
			<cfset newTicket.setCreatedOn( _parseISODateTime( ticketXML["created-on"].XmlText ) ) />
			<cfset newTicket.setUpdatedAt( _parseISODateTime( ticketXML["updated-at"].XmlText ) ) />
			<cfset newTicket.setWorkingHours( numberFormat( ticketXML["working-hours"].XmlText, "9" ) ) />
			
			<cfset arrayAppend( tickets, newTicket ) />
		</cfloop>
		
		<!--- Return array --->
		<cfreturn tickets />
	</cffunction>
	
	<cffunction name="_parseISODateTime" access="private" returntype="string">
		<cfargument name="Date" type="string" required="true" hint="ISO 8601 date/time stamp." />
		 
		<cfreturn arguments.Date.ReplaceFirst("^.*?(\d{4})-?(\d{2})-?(\d{2})T([\d:]+).*$","$1-$2-$3 $4") />
	</cffunction>
	
</cfcomponent>
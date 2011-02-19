<cfcomponent output="true">

<!--- http://www.assembla.com/spaces/<space_id>/tickets/report/<report_id> --->
	<cffunction name="getTicketReport" access="public" returntype="array">
		<cfargument name="authToken" type="string" required="true" />
		<cfargument name="spaceId" type="string" required="true" />
		<cfargument name="reportID" type="numeric" required="false" default="0" />
		<cfargument name="page" type="numeric" required="false" default="1" />
		
		<cfset tickets = arrayNew( 1 ) />
		<!--- Request tickets --->
		<!--- Create request --->
		<cfset rest = "spaces/" & arguments.spaceId & "/tickets/report/" & arguments.reportID />
		<cfif arguments.page gt 1>
			<cfset rest = rest & "?page=" & arguments.page />
		</cfif>
		<cfset svc = new AssemblaRequest( rest, arguments.authToken ) />
		
		<!--- Load the request --->
		<cfset result = svc.load() />
		<cfif isXML( result )>
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
				
				<!--- Custom fields --->
				<cfif structKeyExists(ticketXML, "custom-fields") and structKeyExists( ticketXML["custom-fields"], "XMLChildren" )>
					<cfset fieldXML = ticketXML["custom-fields"].XmlChildren />
					<cfloop index="j" from="1" to="#arrayLen(fieldXML)#">
						<cfset field = fieldXML[j] />
						
						<cfif field.XmlAttributes.name eq "Original Estimatation">
							<cfset newTicket.setOrigHourEst(field.XmlText) />
						</cfif>
						
						<cfif field.XmlAttributes.name eq "Type">
							<cfset newTicket.setTicketType(field.XmlText) />
						</cfif>
						
					</cfloop>
				</cfif>
				
				<cfset arrayAppend( tickets, newTicket ) />
			</cfloop>
		</cfif>
		<!--- Return array --->
		<cfreturn tickets />
	</cffunction>
	
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
		
		<cfif isXML( result )>
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
				
				<!--- Custom fields --->
				<!--- TODO: Move this to a helper method --->
				<cfif structKeyExists(ticketXML, "custom-fields") and structKeyExists( ticketXML["custom-fields"], "XMLChildren" )>
					<cfset fieldXML = ticketXML["custom-fields"].XmlChildren />
					<cfloop index="j" from="1" to="#arrayLen(fieldXML)#">
						<cfset field = fieldXML[j] />
						
						<cfif field.XmlAttributes.name eq "Original Estimatation">
							<cfset newTicket.setOrigHourEst(field.XmlText) />
						</cfif>
						
						<cfif field.XmlAttributes.name eq "Type">
							<cfset newTicket.setTicketType(field.XmlText) />
						</cfif>
						
					</cfloop>
				</cfif>
				
				<cfset arrayAppend( tickets, newTicket ) />
			</cfloop>
		</cfif>
		<!--- Return array --->
		<cfreturn tickets />
	</cffunction>
	
	
	
	<!--- HELPER METHODS --->
	<cffunction name="_parseISODateTime" access="private" returntype="string">
		<cfargument name="Date" type="string" required="true" hint="ISO 8601 date/time stamp." />
		 
		<cfreturn arguments.Date.ReplaceFirst("^.*?(\d{4})-?(\d{2})-?(\d{2})T([\d:]+).*$","$1-$2-$3 $4") />
	</cffunction>
	
</cfcomponent>
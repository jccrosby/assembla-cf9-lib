<cfset authKey = "amNjcm9zYnk6MTExNXNk" />
<cfset assembla = new api.assembla.cfc.AssemblaFacade() />
<cfset spaces = assembla.getSpaces( authKey ) />
<!---<cfset users = assembla.getSpaceUsers( authKey ) />--->
<cfoutput>
	
	<cfloop array="#spaces#" index="space">
		#space.getName()#</br>
		<cfset spaceTickets = assembla.getSpaceTickets( authKey, space.getID() ) />
		<ol>
			<cfloop array="#spaceTickets#" index="ticket">
				<li>#ticket.getNumber()#: #ticket.getSummary()#</li>
			</cfloop>
		</ol>
	</cfloop>
	
</cfoutput>
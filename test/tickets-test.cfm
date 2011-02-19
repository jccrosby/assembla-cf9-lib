<!--- cfset tickets = new api.assembla.cfc.Tickets() />
<cfdump var="#tickets.getTickets( "cmVhbGV5ZXM6UjNhbDN5M3Mh", "cMuYuGor8r37BoeJe5avMc", 1 )#" --->
<!---<cfhttp url="http://localhost/api/assembla/index.cfm?key=cmVhbGV5ZXM6UjNhbDN5M3Mh&rest=tickets/cMuYuGor8r37BoeJe5avMc/1" />--->
<!---<cfoutput>#cfhttp.FileContent#</cfoutput>--->

<!---<cfhttp url="https://www.assembla.com/spaces/ticket_reports/show/23101?space_id=csg">
	<cfhttpparam type="header" name="Accept" value="application/xml" />
	<cfhttpparam type="header" name="Authorization" value="#toBase64('realeyes:R3al3y3s!')#" />
</cfhttp>
<cfoutput>#cfhttp.FileContent#</cfoutput>--->
<!---
<cfset xmlResult = xmlparse( cfhttp.FileContent ) />
--->
<!---
<cfloop index="i" from="1" to="#arrayLen( xmlResult.tickets.XmlChildren )#" step="1">
	<cfset ticketXML = xmlResult.tickets[ "ticket" ][ i ] />
	<cfoutput>#ticketXML["assigned-to-id"].xmlText#</cfoutput><br/>
	<cfoutput>#ticketXML.description.xmlText#</cfoutput><br/>
</cfloop>
--->

<cfset assemblaSVC = new api.assembla.cfc.Tickets() />
<cfset tickets = assemblaSVC.getTickets( toBase64('jccrosby:1115sd'), "axzLLWoCyr34BxeJe5d-aX" ) />
<cfdump var="#tickets#">
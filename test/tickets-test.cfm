<!--- cfset tickets = new api.assembla.cfc.Tickets() />
<cfdump var="#tickets.getTickets( "cmVhbGV5ZXM6UjNhbDN5M3Mh", "cMuYuGor8r37BoeJe5avMc", 1 )#" --->
<cfhttp url="http://localhost/api/assembla/index.cfm?key=cmVhbGV5ZXM6UjNhbDN5M3Mh&rest=tickets/cMuYuGor8r37BoeJe5avMc/1" />
<!---<cfoutput>#cfhttp.FileContent#</cfoutput>--->
<cfdump var="#deserializeJSON( cfhttp.FileContent )#">

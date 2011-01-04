<cfset svc = new api.assembla.cfc.Milestones() />
<cfset authKey = toBase64("realeyes:164qw874r4") />
<cfset spaceID = "cMuYuGor8r37BoeJe5avMc" />
<cfset result = svc.getMileStones( authKey, spaceId ) />
<cfdump var="#result#" />
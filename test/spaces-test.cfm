<cfhttp url="http://www.assembla.com/spaces/my_spaces">
	<cfhttpparam type="header" name="Accept" value="application/xml" />
	<cfhttpparam type="header" name="Authorization" value="#toBase64("realeyes:164qw874r4")#" />
</cfhttp>
<cfset xmlResult = xmlParse( cfhttp.FileContent ) />
<cfdump var="#xmlResult#">

<!---<cfset spaces = new api.assembla.cfc.Spaces() />
<cfdump var="#spaces.getSpaces( "cmVhbGV5ZXM6UjNhbDN5M3Mh" )#">--->
<!---
<cfhttp url="http://localhost/api/assembla/index.cfm?key=cmVhbGV5ZXM6UjNhbDN5M3Mh&rest=spaces" />
<cfdump var="#deserializeJSON( cfhttp.FileContent )#">
--->

<cfset dtSpaceID = "cMuYuGor8r37BoeJe5avMc" /><!--- digital tutors space --->
<cfset reSpaceID = "d14djwor0r350meJe5d-aX" /><!--- realeyes media space --->
<!---<cfset spaces = new api.assembla.cfc.Spaces() />
<cfdump var="#spaces.getSpaceUsers( "cmVhbGV5ZXM6UjNhbDN5M3Mh", reSpaceID )#">--->
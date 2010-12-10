<cfset spaces = new api.assembla.cfc.Spaces() />
<cfdump var="#spaces.getSpaces( "cmVhbGV5ZXM6UjNhbDN5M3Mh" )#">
<!---<p>API class</p>
<cfhttp url="http://localhost/api/assembla/index.cfm?key=cmVhbGV5ZXM6UjNhbDN5M3Mh&rest=spaces" />
<cfdump var="#deserializeJSON( cfhttp.FileContent )#">--->

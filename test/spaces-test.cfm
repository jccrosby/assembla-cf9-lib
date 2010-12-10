<!--- cfset spaces = new api.assembla.cfc.Spaces() />
<cfdump var="#spaces.getSpaces( "spaces/my_spaces" )#" --->
<cfhttp url="http://office.realeyes.com/api/assembla/index.cfm?rest=spaces/my_spaces" />
<cfdump var="#deserializeJSON( cfhttp.FileContent )#">

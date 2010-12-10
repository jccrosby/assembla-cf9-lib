<cfcomponent>
	<cffunction name="getSpaces" access="public" returntype="array" output="false">
		<cfargument name="authToken" type="string" required="true" />
		<cfset spaces = arrayNew( 1 ) />
		<!--- Request spaces --->
		<!--- Create request --->
		<cfset svc = new AssemblaRequest( "spaces/my_spaces", arguments.authToken ) />
		
		<!--- Load the request --->
		<cfset result = svc.load() />
		
		<cfset xmlResult = xmlParse( result ) />
		
		<!--- Parse spaces XML respone into Array of space objects --->
		<!--- handle the response --->
		
		<cfloop index="i" from="1" to="#arrayLen( xmlResult.spaces.XmlChildren )#" step="1">
			<cfset spaceXML = xmlResult.spaces[ "space" ][ i ] />
			<cfset newSpace = new vo.Space() />
			<cfset newSpace.setId( spaceXML.id.XmlText ) />
			<cfset newSpace.setName( spaceXML.name.XmlText ) />
			<cfset newSpace.setDescription( spaceXML.description.XmlText ) />
			<cfset newSpace.setParentId( spaceXML["parent-id"].XmlText ) />
			<cfset arrayAppend( spaces, newSpace ) />
		</cfloop>
		
		<!--- Return array --->
		<cfreturn spaces />
	</cffunction>
</cfcomponent>
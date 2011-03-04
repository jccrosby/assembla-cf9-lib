<cfcomponent>
	
	<cffunction name="init" access="public" returntype="Components">
		<cfreturn this/>
	</cffunction>
	
	<cffunction name="getComponents" access="public" returntype="array" output="false">
		<cfargument name="authToken" type="string" required="true" />
		<cfargument name="spaceID" type="string" required="true" />
		<cfset components = arrayNew( 1 ) />
		<!--- Request spaces --->
		<!--- Create request --->
		<cfset svc = new AssemblaRequest( "spaces/" & arguments.spaceID & "/tickets/components", arguments.authToken ) />
		
		<!--- Load the request --->
		<cfset result = svc.load() />
		
		<cfset xmlResult = xmlParse( result ) />
		
		<!--- Parse spaces XML respone into Array of space objects --->
		<!--- handle the response --->
		
		<cfloop index="i" from="1" to="#arrayLen( xmlResult.components.XmlChildren )#" step="1">
			<cfset componentXML = xmlResult.components[ "component" ][ i ] />
			<cfset newComponent = new vo.Component() />
			<cfset newComponent.setId( componentXML.id.XmlText ) />
			<cfset newComponent.setName( componentXML.name.XmlText ) />
			<cfset arrayAppend( components, newComponent ) />
		</cfloop>
			
		<!--- Return array --->
		<cfreturn components />
	</cffunction>
	
</cfcomponent>
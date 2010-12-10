<cfcomponent aaccessors="true">
	
	<cffunction name="getAllSpaces" access="remote" returntype="Aray">
		<cfargument name="authToken" required="true" type="string"/>
		
		<cfset spaces = arrayNew(1) />
		<cfset spaces = new cfc.Spaces( arguments.authToken ) />
		<cfreturn spaces />
	</cffunction>
	
</cfcomponent>
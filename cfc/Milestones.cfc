<cfcomponent>
	<cffunction name="getMilestones" access="public" returntype="array" output="false">
		<cfargument name="authToken" type="string" required="true" />
        <cfargument name="spaceId" type="string" required="true" />
        
		<cfset miletones = arrayNew( 1 ) />
		<!--- Request spaces --->
		<!--- Create request --->
		<cfset svc = new AssemblaRequest( "spaces/" & arguments.spaceId & "/milestones", arguments.authToken ) />
		
		<!--- Load the request --->
		<cfset result = svc.load() />
		
		<cfset xmlResult = xmlParse( result ) />
		
		<!--- Parse spaces XML respone into Array of space objects --->
		<!--- handle the response --->
		
		<cfloop index="i" from="1" to="#arrayLen( xmlResult.milestones.XmlChildren )#" step="1">
			<cfset milestoneXML = xmlResult.spaces[ "milestone" ][ i ] />
			<cfset newMilestone = new vo.MileStone() />
			<cfset newSpace.setId( milestoneXML.id.XmlText ) />
			<cfset newSpace.setTitle( milestoneXML.title.XmlText ) />
			<cfset newSpace.setDescription( milestoneXML.description.XmlText ) />
			<cfset newSpace.setSpaceId( milestoneXML.["space-id"].XmlText ) />
			<cfset newSpace.setIsCompleted( milestoneXML["is-completed"].XmlText ) />
            <cfset newSpace.setReleaseLevel( milestoneXML["release-notes"].XmlText ) />
            <cfset newSpace.setReleaseNotes( milestoneXML["completed-date"].XmlText ) />
            <cfset newSpace.setPrettyReleaseLevel( milestoneXML["pretty-release-level"].XmlText ) />
			<cfset arrayAppend( milestones, newMilestone ) />
		</cfloop>
			
		<!--- Return array --->
		<cfreturn spaces />
	</cffunction>
	
</cfcomponent>
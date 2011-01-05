<cfcomponent>
	<cffunction name="getSpaceMilestones" access="public" returntype="array" output="false">
		<cfargument name="authToken" type="string" required="true" />
        <cfargument name="spaceId" type="string" required="true" />
        
		<cfset milestones = arrayNew( 1 ) />
		<!--- Request spaces --->
		<!--- Create request --->
		<cfset svc = new AssemblaRequest( "spaces/" & arguments.spaceId & "/milestones", arguments.authToken ) />
		
		<!--- Load the request --->
		<cfset result = svc.load() />
		
		<cfset xmlResult = xmlParse( result ) />
		
		<!--- Parse spaces XML respone into Array of space objects --->
		<!--- handle the response --->
		
		<cfloop index="i" from="1" to="#arrayLen( xmlResult.milestones.XmlChildren )#" step="1">
			<cfset milestoneXML = xmlResult.milestones[ "milestone" ][ i ] />
			<cfset newMilestone = new vo.Milestone() />
			<cfset newMilestone.setId( milestoneXML.id.XmlText ) />
			<cfset newMilestone.setTitle( milestoneXML.title.XmlText ) />
			<cfset newMilestone.setDescription( milestoneXML.description.XmlText ) />
			<cfset newMilestone.setSpaceId( milestoneXML["space-id"].XmlText ) />
            <cfset completed = milestoneXML["is-completed"].XmlText />
            <cfif completed>
				<cfset newMilestone.setIsCompleted( true ) />
            <cfelse>
            	<cfset newMilestone.setIsCompleted( false ) />
            </cfif>
            <cfset newMilestone.setCompletedDate( milestoneXML["completed-date"].XmlText ) />
            <cfset newMilestone.setReleaseLevel( milestoneXML["release-notes"].XmlText ) />
            <cfset newMilestone.setReleaseNotes( milestoneXML["completed-date"].XmlText ) />
            <cfset newMilestone.setPrettyReleaseLevel( milestoneXML["pretty-release-level"].XmlText ) />
			<cfset arrayAppend( milestones, newMilestone ) />
		</cfloop>
			
		<!--- Return array --->
		<cfreturn milestones />
	</cffunction>
	
</cfcomponent>
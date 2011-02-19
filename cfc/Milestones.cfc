<cfcomponent output="true">
	
	<cfscript>
		dateUtil = new util.DateUtil();
	</cfscript>

	<cffunction name="getSpaceMilestones" access="public" returntype="array">
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
		<cfif structKeyExists(xmlresult, "milestones")>
			<cfloop index="i" from="1" to="#arrayLen( xmlResult.milestones.XmlChildren )#" step="1">
				<cfset milestoneXML = xmlResult.milestones[ "milestone" ][ i ] />
				<cfset newMilestone = new vo.Milestone() />
				<cfset newMilestone.setId( milestoneXML.id.XmlText ) />
				<cfset newMilestone.setTitle( milestoneXML.title.XmlText ) />
				<cfset newMilestone.setDescription( milestoneXML.description.XmlText ) />
				<cfset newMilestone.setSpaceId( milestoneXML["space-id"].XmlText ) />
				<cfset newMilestone.setCreatedByAID( milestoneXML["created-by"].XmlText ) />
	            <cfset completed = milestoneXML["is-completed"].XmlText />
	            
				<cfif completed>
					<cfset newMilestone.setIsCompleted( true ) />
	            <cfelse>
	            	<cfset newMilestone.setIsCompleted( false ) />
	            </cfif>
				
				<cfset createdAt = dateUtil.ISOToDateTime(milestoneXML["created-at"].XmlText )/>
				<cfif createdAt neq "">
		            <cfset newMilestone.setCreatedAt(parseDateTime(createdAt)) />
				</cfif>
				
				<cfset dueDate = dateUtil.ISOToDateTime(milestoneXML["due-date"].XmlText )/>
				<cfif dueDate neq "">
		            <cfset newMilestone.setDueDate(parseDateTime(dueDate)) />
				</cfif>
	            
				<cfset completedDate = milestoneXML["completed-date"].XmlText />
				<cfif completedDate neq "">
					<cfset newMilestone.setCompletedDate( dateUtil.ISOToDateTime( )) />
				</cfif>
				
	            <cfset newMilestone.setReleaseLevel( milestoneXML["release-notes"].XmlText ) />
	            <cfset newMilestone.setReleaseNotes( milestoneXML["completed-date"].XmlText ) />
	            <cfset newMilestone.setPrettyReleaseLevel( milestoneXML["pretty-release-level"].XmlText ) />
				<cfset arrayAppend( milestones, newMilestone ) />
			</cfloop>
		</cfif>
			
		<!--- Return array --->
		<cfreturn milestones />
	</cffunction>
	
</cfcomponent>
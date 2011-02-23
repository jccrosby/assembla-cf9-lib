<cfcomponent output="true">
	
	<cfscript>
		dateUtil = new util.DateUtil();
	</cfscript>
	
	<cffunction name="getTimeEntries" access="public" returntype="array">
		<cfargument name="authToken" type="string" required="true" />
		<cfargument name="spaceID" type="string" required="true" />
		<cfargument name="fromDate" type="date" required="true" />
		<cfargument name="untilDate" type="date" required="true" />
		
		<!--- FIXME: This is a special case, trying to get to all the time data --->
		<cfset requestURL = "https://www.assembla.com/spaces/" & arguments.spaceID & "/time_entries" />
		<cfhttp method="get" url="#requestURL#">
			<cfhttpparam type="header" name="Accept" value="application/xml">
			<cfhttpparam type="header" name="Authorization" value="#arguments.authToken#" />
			<cfhttpparam type="formfield" name="from_date" value="#arguments.fromDate#">
			<cfhttpparam type="formfield" name="until_date" value="#arguments.untilDate#">
		</cfhttp>
		<cfset result = cfhttp.FileContent />
		
		<cfset tasks = arrayNew(1)/>
		
		<cfif isXML(result)>
			<cfset xmlResult = xmlParse(result) />
			<!--- Parse spaces XML respone into Array of space objects --->
			<!--- handle the response --->
			<cfloop index="i" from="1" to="#arrayLen( xmlResult.tasks.XmlChildren )#" step="1">
				<cfscript>
					taskXML = xmlResult.tasks[ "task" ][ i ];
					task = new vo.Task();
					
					task.setId(taskXML.id.xmlText);
					task.setHours(taskXML.hours.xmlText);
					task.setDescription(taskXML.description.xmlText);
					task.setSpaceID(taskXML["space-id"].xmlText);
					task.setTicketID(taskXML["ticket-id"].xmltext);
					task.setUserID(taskXML["user-id"].xmlText);
					task.setBilled(taskXML.billed.xmlText);
					
					ticketNumber = taskXML["ticket-number"].xmlText;
					if(ticketNumber != "")
						task.setTicketNumber(ticketNumber);
					
					beginAt = dateUtil.ISOToDateTime(taskXML["begin-at"].xmlText);
					if(beginAt != "")
						task.setBeginAt(parseDateTime(beginAt));
					
					endAt = dateUtil.ISOToDateTime(taskXML["end-at"].xmlText);
					if(endAt != "")
						task.setEndAt(parseDateTime(endAt));

					createdAt = dateUtil.ISOToDateTime(taskXML["created-at"].xmlText);
					if(createdAt != "")
						task.setCreatedAt(parseDateTime(createdAt));
					
					updatedAt = dateUtil.ISOToDateTime(taskXML["updated-at"].xmlText);
					if(updatedAt != "")
						task.setUpdatedAt(parseDateTime(updatedAt));
					
					arrayAppend(tasks, task);
				</cfscript>
			</cfloop>
		</cfif>
		
		<cfreturn tasks/>
	</cffunction>
	
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
			<!--- TODO: Fix 'tags' is undefined <cfset newSpace.setTags( spaceXML["tags"].XmlText ) />--->
			<cfset arrayAppend( spaces, newSpace ) />
		</cfloop>
			
		<!--- Return array --->
		<cfreturn spaces />
	</cffunction>
	
	<cffunction name="getSpaceUsers" access="public" returntype="array" output="false">
		<cfargument name="authToken" type="string" required="true" />
		<cfargument name="spaceId" type="string" required="true" />
		<cfset users = arrayNew( 1 ) />
		
		<!--- Request space users --->
		<!--- Create request --->
		<cfset svc = new AssemblaRequest( "spaces/" & arguments.spaceId & "/users", arguments.authToken ) />
		
		<!--- Load the request --->
		<cfset result = svc.load() />
		<cfset xmlResult = xmlParse( result ) />
		
		<!--- Parse spaces XML respone into Array of space objects --->
		<!--- handle the response --->
		
		<cfloop index="i" from="1" to="#arrayLen( xmlResult.users.XmlChildren )#" step="1">
			<cfset usersXML = xmlResult.users[ "user" ][ i ] />
			<cfset newUser = new vo.User() />
			<cfset newUser.setID( usersXML.id.xmlText ) />
			<cfset newUser.setLoginName( usersXML["login_name"].xmlText ) />
			<cfset arrayAppend( users, newUser) />
		</cfloop>
		
		<!--- Return array --->
		<cfreturn users />
	</cffunction>
</cfcomponent>
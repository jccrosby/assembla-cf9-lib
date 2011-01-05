<!--- Defaults --->
<cfparam name="authToken" default="" type="string" />
<cfparam name="url.format" default="json" type="string" />
<cfset result = new cfc.Result() />
<cfset api = new api.assembla.cfc.AssemblaFacade() />

<!--- Functions --->
<cffunction name="checkAuthToken">
	<cfif len( authToken ) lte 0>
		<cfthrow errorcode="NO_AUTH_TOKEN" detail="You must provide an authentication token.">
	</cfif>
</cffunction>

<cffunction name="outputResult" returntype="void">
	<cfargument name="result" required="true" type="cfc.Result" />
	<cfargument name="format" required="false" type="string" default="json" />
    
    <cfif arguments.format is "json">
        <cfsavecontent variable="output">
            <cfcontent type="application/json">
            <cfoutput>#serializeJSON( arguments.result )#</cfoutput>
        </cfsavecontent>
        <cfoutput>#output#</cfoutput>
    <cfelseif arguments.format is "txt">
    	<cfoutput>#serializeJSON( arguments.result )#</cfoutput>
	<cfelseif arguments.format is "dump">
    	<cfdump var="#arguments.result#" />
    </cfif>
</cffunction>

<!--- Get to work --->
<cftry>

<!--- Get the authtoken - if there is one --->
<cfif structKeyExists( url, "key" )>
	<cfset authToken = url.key />
</cfif>

<cfset restList = listToArray( url.rest, "/" ) />
<cfset restLen = arrayLen( restList ) />
        
<cfdump var="#restList#" />

<cfset result.setMessage( "" ) />
<cfset result.setStatus( "success" ) />
<!--- Determine what call to make based on the params sent --->

<cfset spaceID = restList[1] />
        
<!--- // Get the Spaces for the authenticated user ////////////// --->
<cfif restLen is 1 and restList[1] is "spaces">
	<!--- http://www.assembla.com/spaces/my_spaces --->
	<cfset result.setResult( variables.api.getSpaces( authToken ) ) />
<cfelse>
	
    <cfset spaceId = restList[1] />
    
	<!--- // Get Milestones for a Space //////////////// --->
	<cfif findNoCase( "/milestones", url.rest ) gt 0>
		<!--- API URL: http://{baseurl}/index.cfm?key={key}&rest=spaces/{spaceid}/milestones --->        
		<!--- http://www.assembla.com/spaces/<space_id>/milestones/ --->
		<cfset result.setResult( variables.api.getSpaceMilestones( authtoken, spaceId ) ) />

    <cfelseif findNoCase( "/users", url.rest ) gt 0>
    	<cfset result.setResult( variables.api.getSpaceUsers( authtoken, spaceId ) ) />
        
	<cfelseif findNoCase( "/tickets", url.rest ) gt 0>
    	
        <cfset reportId = restList[3] />
        
    	<!--- API URL: http://{baseurl}/index.cfm?key={key}&rest=tickets/{spaceid}[/{page-number}] --->
		<!--- Reqeust for tickets: should have tickets/{space-id}/{page-number} --->
		<cfif restlen is 3>
			<cfset result.setResult( variables.api.getSpaceTickets( authToken, spaceId, reportId ) ) />
		<cfelseif restLen is 4>
            <cfset pageNumber = restList[4] />
			<cfset result.setResult( variables.api.getSpaceTickets( authToken, spaceId, reportId, pageNumber ) ) />
		</cfif>
	</cfif>
</cfif>


<!--- cfswitch expression="#restList[1]#">
	
	<!--- Reqeust for spaces --->
	<cfcase value="spaces">

		<cfset spaceID = restList[2] />
        
        <!--- // Get the Spaces for the authenticated user ////////////// --->
        <cfif restLen is 1>
			<!--- http://www.assembla.com/spaces/my_spaces --->
            <cfset result.setResult( variables.api.getSpaces( authToken ) ) />
        <cfelseif restLen gt 2>
        	<!--- // Get Milestones for a Space //////////////// --->
            <cfif findNoCase( "/milestones", url.rest )>
                <!--- API URL: http://{baseurl}/index.cfm?key={key}&rest=spaces/{spaceid}/milestones --->        
                <!--- http://www.assembla.com/spaces/<space_id>/milestones/ --->
                <cfset result.setResult( variables.api.getSpaceMilestones( authtoken, spaceId ) ) />
            </cfif>
        </cfif>
	</cfcase>

	<cfcase value="tickets">
       	<!--- API URL: http://{baseurl}/index.cfm?key={key}&rest=tickets/{spaceid}[/{page-number}] --->
		<!--- Reqeust for tickets: should have tickets/{space-id}/{page-number} --->
		<cfif restlen is 4>
        	<cfset spaceId = restList[2] />
            <cfset reportId = restList[3] />
            <cfset pageNumber = restList[4] />
			<cfset result.setResult( variables.api.getSpaceTickets( authToken, spaceId, reportId, pageNumber ) ) />
		<cfelseif restLen is 3>
           	<cfset spaceId = restList[2] />
            <cfset reportId = restList[3] />
			<cfset result.setResult( variables.api.getSpaceTickets( authToken, spaceId, reportId ) ) />
		</cfif>
	</cfcase>
	
	<!--- Nothing matched --->
	<cfdefaultcase>
		<cfset result.setMessage( "Your request was not found in the API." ) />
		<cfset result.setStatus( "fault" ) />
		<cfset result.setResult( "" ) />
	</cfdefaultcase>
	
</cfswitch --->

<cfset outputResult( result, url.format ) />

<!--- Display the error --->
<cfcatch type="any">
	<cfset result.setMessage( cfcatch.message ) />
	<cfset result.setStatus( "fault" ) />
	<cfset outputResult( result, url.format ) />	
</cfcatch>
</cftry>
<!--- Defaults --->
<cfparam name="authToken" default="" type="string" />
<cfset result = new cfc.Result() />

<!--- Functions --->
<cffunction name="checkAuthToken">
	<cfif len( authToken ) lte 0>
		<cfthrow errorcode="NO_AUTH_TOKEN" detail="You must provide an authentication token.">
	</cfif>
</cffunction>

<cffunction name="returnResult">
	<cfargument name="result" required="true" type="cfc.Result" />
	<cfargument name="format" required="false" type="string" default="JSON" />
	<cfsavecontent variable="output">
		<cfcontent type="application/json">
		<cfoutput>#serializeJSON( arguments.result )#</cfoutput>
	</cfsavecontent>
	<cfreturn output />
</cffunction>

<!--- Get to work --->
<cftry>

<!--- Get the authtoken - if there is one --->
<cfif structKeyExists( url, "key" )>
	<cfset authToken = url.key />
</cfif>
<cfset api = new api.assembla.cfc.AssemblaAPI() />
<cfset restList = listToArray( url.rest, "/" ) />
<cfdump var="#restList#"/>
<!--- Determine what call to make based on the params sent --->
<cfswitch expression="#restList[1]#">
	
	<!--- Reqeust for spaces --->
	<cfcase value="spaces">
		<cfset result.setResult( api.getAllSpaces( authToken ) ) />
	</cfcase>
	
	<!--- Nothing matched --->
	<cfdefaultcase>
		<cfset result.setMessage( "Your request was not found in the API." ) />
		<cfset result.setStatus( "fault" ) />
		<cfset result.setResult( "" ) />
	</cfdefaultcase>
	
</cfswitch>

<cfoutput>#returnResult( result )#</cfoutput>

<!--- Display the error --->
<cfcatch type="any">
	<cfset result.setMessage( cfcatch.message ) />
	<cfset result.setStatus( "fault" ) />
	<cfoutput>		
#returnResult( result )#
	</cfoutput>	
</cfcatch>
</cftry>
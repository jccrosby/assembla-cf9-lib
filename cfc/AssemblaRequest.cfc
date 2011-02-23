<cfcomponent accessors="true">
	
    <cfproperty name="protocol" type="string" default="http" />
    <cfproperty name="uri" type="string" default="www.assembla.com" />
    <cfproperty name="method" type="string" default="GET" />
    <cfproperty name="authToken" type="string" />
    <cfproperty name="data" type="string" />
	<cfproperty name="rest" type="string" />

	<cffunction name="init" access="public" returntype="string">
		<cfargument name="rest" required="true" type="string">
		<cfargument name="authToken" required="false" type="string" default="">	
		<cfargument name="data" required="false" type="string" default="">
		<cfargument name="protocol" required="false" type="string" default="http">	
		<cfargument name="uri" required="false" type="string" default="www.assembla.com">
		<cfargument name="method" required="false" type="string" default="GET">	
		
		<cfscript>
			this.setRest( arguments.rest );
			this.setAuthToken( arguments.authToken );
			this.setProtocol( arguments.protocol );
			this.setURI( arguments.uri );
			this.setMethod( arguments.method );
			this.setData( arguments.data );
		</cfscript>
		
	</cffunction>
	
	<cffunction name="load" access="remote" returntype="string">
        <cfset var result = "" />
        <cftry>
			
	        <cfhttp url="#this.getURL()#" 
				method="#this.getMethod()#">
	        	<cfhttpparam type="header" name="Accept" value="application/xml" />
	        	<cfhttpparam type="header" name="Authorization" value="#this.getAuthToken()#" />
	        </cfhttp>
	        <cfset result = cfhttp.FileContent />
			
        <cfcatch type="any">
			<cfthrow errorcode="CFHTTP_FAILED" message="#cfcatch.message#" detail="#cfcatch.detail#" >
        </cfcatch>
        </cftry>
        
		<cfreturn result />
	</cffunction>
    
    <!--- ////////////////////////////////////////////////// --->
    <cffunction name="getURL" returntype="string" access="public">
    	<cfreturn this.getProtocol() & "://" & this.getURI() & "/" & this.getRest() />
    </cffunction>	
    
</cfcomponent>
<cfcomponent>
	
    <cfproperty name="protocol" type="string" default="http" />
    <cfproperty name="uri" type="string" />
    <cfproperty name="method" type="string" default="GET" />
    <cfproperty name="data" type="string" />
    <cfproperty name="username" type="string" />
    <cfproperty name="password" type="string" />

	<cffunction name="load" access="public" returntype="string">
        <cfargument name="request" type="struct" required="yes">
        
        <cfset var result = "" />
        
        <cftry>
        <cfhttp url="#this.getURL()#" method="#this.getMethod()#" 
        	username="#this.getUsername()#" password="#this.getPassword()#" />
        
        <cfset result = cfhttp.FileContent />
        <cfcatch type="any">
        	<cflog application="yes" type="#cfcatch.Type#" text="#cfcatch.Detail#" />
        </cfcatch>
        </cftry>
        
		<cfreturn result />
	</cffunction>
    
    <!--- ////////////////////////////////////////////////// --->
    <cffunction name="getURL" returntype="string" access="private">
    	<cfreturn this.getProtocol() & "://" & this.getURI() />
    </cffunction>	
    
</cfcomponent>
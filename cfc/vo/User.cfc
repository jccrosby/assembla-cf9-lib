<cfcomponent accessors="true">

	<cfproperty name="type" type="string" default="User" />
	<cfproperty name="id" type="string" />
	<cfproperty name="loginName" type="string" />

	<cfproperty name="email" type="string" />
	<cfproperty name="organization" type="string" />
	<cfproperty name="website" type="string" />
	<cfproperty name="firstIm" type="string" />
	<cfproperty name="secondIm" type="string" />
		
	<cffunction name="init" access="public" returntype="User">
		<cfset setType( "User" ) />
		<cfreturn this />
	</cffunction>
	
</cfcomponent>
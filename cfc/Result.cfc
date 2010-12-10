<cfcomponent accessors="true">
	
	<cfproperty name="result" type="any" getter="true" />
	<cfproperty name="message" type="string" default="Unknown error" getter="true" />	
	<cfproperty name="status" type="string" default="fault" getter="true" />
	
	<cffunction name="init" returntype="Result">
		<cfreturn this />
	</cffunction>
	
	
</cfcomponent>
<cfcomponent accessors="true">
	
	<cfproperty name="type" default="Component" type="string">
	<cfproperty name="id" default="0" type="string">
	<cfproperty name="projectID" default="" type="string">
	<cfproperty name="name" default="" type="string">
	
	<cffunction name="init" access="public" returntype="api.assembla.cfc.vo.Component">
		<cfscript>
			this.setType("Component");
		</cfscript>
		<cfreturn this/>
	</cffunction>
	
</cfcomponent>
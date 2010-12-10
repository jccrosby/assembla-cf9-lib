<cfcomponent accessors="true">
	
	<cfproperty name="type" default="Space" type="string">
	<cfproperty name="name" default="" type="string">
	<cfproperty name="description" default="" type="string">
	<cfproperty name="id" default="" type="string">
	<cfproperty name="parentId" default="" type="string">
	
	<cffunction name="init" returntype="Space">
		<cfset setType( "Space" ) />
		<cfreturn this />
	</cffunction>
	
</cfcomponent>
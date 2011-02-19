<cfcomponent accessors="true">
	
	<cfproperty name="type" default="Space" type="string">
	<cfproperty name="name" default="" type="string">
	<cfproperty name="description" default="" type="string">
	<cfproperty name="id" default="" type="string">
	<cfproperty name="parentId" default="" type="string">
	<cfproperty name="tags" default="" type="string">
	
	
	<cffunction name="init" returntype="Space">
		<cfset setType( "Space" ) />
		<cfset setId( "" ) />
		<cfset setName( "" ) />
		<cfset setDescription( "" ) />
		<cfset setParentId( "" ) />
		<cfset setTags( "" ) />
		<cfreturn this />
	</cffunction>
	
</cfcomponent>
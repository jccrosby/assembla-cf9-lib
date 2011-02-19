<cfcomponent accessors="true">
	
	<cfproperty name="type" default="Milestone" type="string">
	<cfproperty name="title" default="" type="string">
	<cfproperty name="description" default="" type="string">
	<cfproperty name="id" default="" type="string">
	<cfproperty name="spaceId" default="" type="string">
    <cfproperty name="completedDate" default="" type="date">
    <cfproperty name="dueDate" default="" type="date">
    <cfproperty name="createdAt" default="" type="date">
    <cfproperty name="createdByAID" default="" type="string">
    <cfproperty name="isCompleted" default="" type="string">
    <cfproperty name="releaseLevel" default="" type="string">
    <cfproperty name="releaseNotes" default="" type="string">
    <cfproperty name="prettyReleaseLevel" default="" type="string">
	
	<cffunction name="init" returntype="Milestone">
		<cfset setType( "Milestone" ) />
		<cfreturn this />
	</cffunction>
	
</cfcomponent>
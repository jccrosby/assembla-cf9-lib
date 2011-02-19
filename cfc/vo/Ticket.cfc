<cfcomponent accessors="true">

	<cfproperty name="type" type="string" default="Ticket" setter="false" />
	<cfproperty name="id" type="string" />
	<cfproperty name="number" type="string" />
	<cfproperty name="summary" type="string" />
	<cfproperty name="reporterId" type="string" />
	<cfproperty name="spaceId" type="string" />
	<cfproperty name="assignedToId" type="string" />
	<cfproperty name="componentId" type="string"  />
	<cfproperty name="priority" type="string" />
	<cfproperty name="status" type="string" />
	<cfproperty name="description" type="string" />
	<cfproperty name="milestoneId" type="string" />
	<cfproperty name="createdOn" type="date" />
	<cfproperty name="updatedAt" type="date" />
	<cfproperty name="ticketType" type="string" />
	<cfproperty name="workingHours" type="numeric" default="0.0" />
	<cfproperty name="origHourEst" type="numeric" default="0.0" />
	
	<!--- 
	//=========================================
	// Init Methods
	//=========================================
	 --->
	
	<cffunction name="init" returntype="Ticket">
		<cfreturn this />
	</cffunction>	
	
</cfcomponent>
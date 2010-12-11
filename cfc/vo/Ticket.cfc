<cfcomponent accessors="true">
<!--- 
<tickets>
	<ticket>
		<assigned-to-id></assigned-to-id>
		<component-id type="integer"></component-id>
		<created-on type="datetime">2007-12-03T09:57:47-03:00</created-on>

		<description>This is the ticket description</description>
		<milestone-id type="integer"></milestone-id>
		<number type="integer">1</number>
		<priority type="integer">3</priority>

		<reporter-id>user_id</reporter-id>
		<space-id>space_id</space-id>
		<status type="integer">0</status>
		<summary>This is the summary</summary>

		<updated-at type="datetime">2007-12-03T11:12:01-03:00</updated-at>
                <working_hour type="float">4.0</working_hour>
       </ticket>
</tickets>
 --->
 
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
	<cfproperty name="workingHour" type="string" />
	<cfproperty name="createdOn" type="date" />
	<cfproperty name="updatedAt" type="date" />
	<cfproperty name="workingHours" type="numeric" default="0.0" />
	
	
</cfcomponent>
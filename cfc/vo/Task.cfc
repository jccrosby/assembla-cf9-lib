<cfcomponent output="false" accessors="true">
	
	<cfproperty name="type" type="string" default="Task" />
	<cfproperty name="id" type="numeric" />
	<cfproperty name="BeginAt" type="date" />
	<cfproperty name="Billed" type="boolean" />
	<cfproperty name="CreatedAt" type="date" />
	<cfproperty name="Description" type="string" />
	<cfproperty name="EndAt" type="date" />
	<cfproperty name="Hours" type="numeric" />
	<cfproperty name="SpaceID" type="string" />
	<cfproperty name="TicketID" type="string" />
	<cfproperty name="TicketNumber" type="numeric" />
	<cfproperty name="UpdatedAt" type="date" />
	<cfproperty name="UserID" type="string" />
	
	<!--- 
	//=========================================
	// Init Methods
	//=========================================
	 --->
	
	<cffunction name="init" returntype="Task">
		<cfscript>
			this.setType("Task");
			return this;
		</cfscript>
	</cffunction>	
	
</cfcomponent>
<cfcomponent>
	<cffunction name="ISOToDateTime" access="public" returntype="string" output="false" hint="Converts an ISO 8601 date/time stamp with optional dashes to a ColdFusion date/time stamp.">
		<cfargument name="Date" type="string" required="true" hint="ISO 8601 date/time stamp."/>
		<cfreturn ARGUMENTS.Date.ReplaceFirst("^.*?(\d{4})-?(\d{2})-?(\d{2})T([\d:]+).*$","$1-$2-$3 $4") />
	</cffunction>
</cfcomponent>
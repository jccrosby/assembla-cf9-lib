<cfcomponent>

	<cffunction name="getUserProfile" access="public" returntype="vo.User">
		<cfargument name="authtoken" required="true" type="string" />
		<cfargument name="user" required="true" type="vo.User" />
		
		<cfset req = new AssemblaRequest( "user/best_profile/" & user.getId(), arguments.authToken ) />
		
		<cfscript>
			result = req.load();
			xmlResult = xmlParse( result );
			arguments.user.setEmail( xmlresult.user.email.xmlText );
			arguments.user.setOrganization( xmlresult.user.organization.xmlText );
			arguments.user.setWebsite( xmlresult.user.website.xmlText );
			arguments.user.setFirstIm( xmlresult.user.second_im.xmlText );
			arguments.user.setSecondIm( xmlresult.user.first_im.xmlText );
		</cfscript>
		
		<cfreturn arguments.user />
	</cffunction>

</cfcomponent>
<!--- john  --->
<!---<cfhttp url="http://www.assembla.com/user/best_profile/a6CKkon2ar34QQeJe5afGb">--->
<!--- david --->
<!---<cfhttp url="http://www.assembla.com/user/best_profile/asDyH4GXar3yQ8ab7jnrAJ">
	<cfhttpparam type="header" name="Accept" value="application/xml" />
	<cfhttpparam type="header" name="Authorization" value="cmVhbGV5ZXM6UjNhbDN5M3Mh" />
</cfhttp>
<cfdump var="#xmlParse( cfhttp.FileContent )#">--->
<cfset user = new api.assembla.cfc.vo.User() />
<cfset user.setId( "a6CKkon2ar34QQeJe5afGb" ) />
<cfset user.setLoginName( "jccrosby" ) />
<cfset users = new api.assembla.cfc.Users() />
<cfset result = users.getUserProfile( "cmVhbGV5ZXM6UjNhbDN5M3Mh", user ) />
<cfdump var="#result#">
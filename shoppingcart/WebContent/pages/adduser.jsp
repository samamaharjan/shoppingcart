<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Shopping Cart</title>
<link rel="stylesheet"	href="<%= request.getContextPath() %>/css/style.css" type="text/css" />
<script language="JavaScript">
	function submitForm(formId) {
		if(formId.username.value.length < 1) {
			alert("Enter Username");
			return false;
		}
		if(formId.password.value.length < 1) {
			alert("Enter Password");
			return false;
		}	
		if(formId.cpassword.value.length < 1) {
			alert("Enter Confirm Password");
			return false;
		}
		
		if(formId.password.value != formId.cpassword.value){
			alert("Enter Same Password");
			return false;
		}
		
		if(formId.email.value.length < 1) {
			alert("Enter Email");
			return false;
		}			
	}
</script>
</head>
<body>
	<div id="container">
		<jsp:include page="/includes/header.jsp" />
		<jsp:include page="/includes/topnav.jsp" />

		<div id="content">
			<div id="content-header">Sign Up</div>
			<div id="content-main">
				<table width="100%" cellpadding="0" cellspacing="0" border="0">
					<tr>
						<td valign="top" align="center">
					       	<form name="frm" action="<%= request.getContextPath() %>/controller?action=adduser" method="POST" onSubmit="return submitForm(document.frm)" >
								<table class="contentText" width="40%" cellspacing="5"	cellpadding="5" border="0">
									<tr>
										<td align="center" colspan="2" class="status"><c:out value="${status}" /></td>
									</tr>									
									<tr>
										<td colspan="2" class="contentTxtHdr">Customer Detail </td>
									</tr>

									<tr>
										<td align="right">Username:&nbsp;<span class="required">*</span></td>
										<td align="left"><input type="text" name="username"></td>
									</tr>
									
									<tr>
										<td align="right">Password:&nbsp;<span class="required">*</span></td>
										<td align="left"><input type="password" name="password"></td>
									</tr>
									
									<tr>
										<td align="right">Confirm Password:&nbsp;<span class="required">*</span></td>
										<td align="left"><input type="password" name="cpassword"></td>
									</tr>
									
									<tr>
										<td align="right">Email:&nbsp;<span class="required">*</span></td>
										<td align="left"><input type="text" name="email"></td>
									</tr>
									
									<tr>
										<td align="right">First Name:</td>
										<td align="left"><input type="text" name="firstName"></td>
									</tr>
									
									<tr>
										<td align="right">Last Name:</td>
										<td align="left"><input type="text" name="lastName"></td>
									</tr>
									
									<tr>
										<td align="right">Street Address:</td>
										<td align="left"><input type="text" name="address1"></td>
									</tr>
									
									<tr>
										<td align="right">Apt#:</td>
										<td align="left"><input type="text" name="address2"></td>
									</tr>
									
									<tr>
										<td align="right">City:</td>
										<td align="left"><input type="text" name="city"></td>
									</tr>	
									
									<tr>
										<td align="right">State:</td>
										<td align="left">
											<select name="stateId">
												<option value="">Select</option>
												<c:forEach var="id" items="${stateList}"  >
												<option value="<c:out value="${id.stateId}" escapeXml="false"/>"><c:out value="${id.stateName}" escapeXml="false"/></option>
												</c:forEach>
											</select>
										</td>
									</tr>
									
									<tr>
										<td align="right">Country:</td>
										<td align="left"><input type="text" name="country"></td>
									</tr>									
									<tr>
										<td>&nbsp;</td>
										<td>
											<input type="reset"	name="rst" value=" Clear ">&nbsp;&nbsp;<input type="submit" name="sbmt" value=" Submit "></td>
									</tr>
								</table>
							</form>   										
						</td>
					</tr>
					
				</table>
			</div>
		</div>
	</div>
</body>
</html>
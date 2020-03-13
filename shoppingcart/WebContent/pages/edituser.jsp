<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Shopping Cart</title>
<link rel="stylesheet"	href="<%= request.getContextPath() %>/css/style.css" type="text/css" />
<script language="JavaScript">
	function submitForm(formId) {		
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
			<div id="content-header">Account</div>
			<div id="content-main">
				<table width="100%" cellpadding="0" cellspacing="0" border="0">
					<tr>
						<td valign="top" align="center">
					       	<form name="frm" action="<%= request.getContextPath() %>/controller?action=edituser" method="POST" onSubmit="return submitForm(document.frm)" >
								<table class="contentText" width="40%" cellspacing="5"	cellpadding="5" border="0">
									<tr>
										<td align="center" colspan="2" class="status"><c:out value="${status}" /></td>
									</tr>									
									<tr>
										<td colspan="2" class="contentTxtHdr">Customer Detail </td>
									</tr>

									<tr>
										<td align="right">Username:&nbsp;<span class="required">*</span></td>
										<td align="left"><c:out value="${user.userName}" escapeXml="false"/></td>
									</tr>
									
									<tr>
										<td align="right">Email:&nbsp;<span class="required">*</span></td>
										<td align="left"><input type="text" name="email" value="<c:out value="${user.email}" escapeXml="false"/>"></td>
									</tr>
									
									<tr>
										<td align="right">First Name:</td>
										<td align="left"><input type="text" name="firstName" value="<c:out value="${user.firstName}" escapeXml="false"/>"></td>
									</tr>
									
									<tr>
										<td align="right">Last Name:</td>
										<td align="left"><input type="text" name="lastName" value="<c:out value="${user.lastName}" escapeXml="false"/>"></td>
									</tr>
									
									<tr>
										<td align="right">Street Address:</td>
										<td align="left"><input type="text" name="address1" value="<c:out value="${user.address1}" escapeXml="false"/>"></td>
									</tr>
									
									<tr>
										<td align="right">Apt#:</td>
										<td align="left"><input type="text" name="address2" value="<c:out value="${user.address2}" escapeXml="false"/>"></td>
									</tr>
									
									<tr>
										<td align="right">City:</td>
										<td align="left"><input type="text" name="city" value="<c:out value="${user.city}" escapeXml="false"/>"></td>
									</tr>	
									
									<tr>
										<td align="right">State:</td>
										<td align="left">
											<select name="stateId">
												<option value="">Select</option>
												<c:forEach var="id" items="${stateList}"  >
												<option value="<c:out value="${id.stateId}" escapeXml="false"/>" <c:if test="${id.stateId == user.stateId}"> selected</c:if>><c:out value="${id.stateName}" escapeXml="false"/></option>
												</c:forEach>
											</select>
										</td>
									</tr>
									
									<tr>
										<td align="right">Country:</td>
										<td align="left"><input type="text" name="country" value="<c:out value="${user.country}" escapeXml="false"/>"></td>
									</tr>									
									<tr>
										<td>&nbsp;</td>
										<td>
											<input type="hidden" name="userId" value="<c:out value="${user.userId}" escapeXml="false"/>">
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
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
	}
</script>
</head>
<body>
	<div id="container">
		<jsp:include page="/includes/header.jsp" />
		<jsp:include page="/includes/topnav.jsp" />

		<div id="content">
			<div id="content-header">Log In</div>
			<div id="content-main">
				<table width="100%" cellpadding="0" cellspacing="0" border="0">
					<tr>
						<td valign="top" align="center">
					       	<form name="frm" action="<%= request.getContextPath() %>/controller?action=login" method="POST" onSubmit="return submitForm(document.frm)" >
								<table class="contentText" width="40%" cellspacing="5"	cellpadding="5" border="0">
									<tr>
										<td align="center" colspan="2" class="status"><c:out value="${status}" /></td>
									</tr>
									<tr>
										<td align="center" colspan="2">&nbsp;</td>
									</tr>									
									<tr>
										<td colspan="2" class="contentTxtHdr">Existing Customer </td>
									</tr>

									<tr>
										<td align="right">Username:</td>
										<td align="left"><input type="text" name="username"></td>
									</tr>
									<tr>
										<td align="right">Password:</td>
										<td align="left"><input type="password" name="password"></td>
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
					<tr>
						<td valign="top" align="center">
							<form name="signupfrm"	 action="<%= request.getContextPath() %>/controller?action=signupp" method="POST" >
							<table class="contentText" width="40%" cellspacing="5"	cellpadding="5" border="0">
								<tr>
									<td class="contentTxtHdr">New Customer Sign Up</td>									
								</tr>
								<tr>
									<td>Create a account today. </td>									
								</tr>
								<tr>
									<td><input type="submit" name="sbmt" value=" Create New Account "></td>									
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
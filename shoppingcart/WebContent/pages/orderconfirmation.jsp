<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Shopping Cart</title>
<link rel="stylesheet"
	href="<%= request.getContextPath() %>/css/style.css" type="text/css" />
</head>
<body>
	<div id="container">
		<jsp:include page="/includes/header.jsp" />
		<jsp:include page="/includes/topnav.jsp" />

		<div id="content">
			<div id="content-header">Order Confirmation</div>
			<div id="content-main">
				<table width="100%" cellpadding="0" cellspacing="0" border="0">
					<c:choose>
						<c:when test="${!empty orderId}">
						<tr>
							<td>Thank You</td>
						</tr>
						<tr>
							<td>Your order&nbsp;<c:out value="${orderId}" escapeXml="false" />&nbsp;has been placed.</td>
						</tr>
						</c:when>
						<c:otherwise>
							<tr>
								<td align="center" colspan="2" class="status"><c:out value="${status}" /></td>
							</tr>
						</c:otherwise>
					</c:choose>
			
					
				</table>
			</div>
		</div>
	</div>
</body>
</html>
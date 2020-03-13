<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Shopping Cart</title>
<link rel="stylesheet"href="<%= request.getContextPath() %>/css/style.css" type="text/css" />
<script language="JavaScript">
function addToCart(formId, itemId) {	
	formId.action="<%= request.getContextPath() %>/controller?action=addtocart&itemId="+itemId;
	formId.submit();	
}
</script>
</head>
<body>
	<div id="container">
		<jsp:include page="/includes/header.jsp" />
		<jsp:include page="/includes/topnav.jsp" />

		<div id="content">
			<div id="content-header">Products</div>
			<div id="content-main">
				<table width="100%" cellpadding="0" cellspacing="0" border="0">
					<tr>
						<td valign="top" width="200">
							<table width="100%" cellpadding="2" cellspacing="2" border="1">
								<tr>
									<td><a href="<%=request.getContextPath() %>/controller?action=products">All</a></td>
								</tr>									
							<c:forEach var="id" items="${productTypeList}"  >
								<tr>
									<td><a href="<%=request.getContextPath() %>/controller?action=products&productTypeId=<c:out value="${id.productTypeId}" escapeXml="false"/>"><c:out value="${id.productTypeName}" escapeXml="false"/></a></td>
								</tr>	
							</c:forEach>
							</table>
						</td>
						<td valign="top">
							<table width="100%" cellpadding="2" cellspacing="2" border="1">								
							<tr>
								<th>Item Name</th>
								<th>Price</th>
								<th>Quantity Available</th>
								<th>Action</th>
							</tr>
							 
							<c:forEach var="id" items="${itemList}"  >
								<tr>
									<td><c:out value="${id.itemName}" escapeXml="false"/></td>
									<td align="right">$<fmt:formatNumber type="number" pattern="0.00" value="${id.itemPrice}" />
									<td align="right"><c:out value="${id.itemQuantity}" escapeXml="false"/></td>
									<td align="right">
									<c:choose>
										<c:when test="${id.itemQuantity > 0}">
											<input onclick="return addToCart(document.frm, <c:out value="${id.itemId}" escapeXml="false"/>)" type="button" name="btn" value="Add To Cart">
										</c:when>
										<c:otherwise>
											Out Of Stock
										</c:otherwise>
										
									</c:choose>
									</td>
								</tr>
								
							</c:forEach>
							<form name="frm" method="POST">
							</form>
							</table>
						</td>
					</tr>
				</table>
			</div>
		</div>

	</div>
</body>
</html>
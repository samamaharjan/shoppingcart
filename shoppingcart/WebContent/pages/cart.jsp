<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Shopping Cart</title>
<link rel="stylesheet"href="<%= request.getContextPath() %>/css/style.css" type="text/css" />
<script language="JavaScript">
function editQuantity(formId, itemId) { 
	var quantityField = document.getElementById("quantity_"+itemId);
	var quantity = quantityField.value; 
	if(!quantity.length < 1){
		if(!isInteger(quantity)){
			alert("Quantity must be number");
			return false;
		}
		
		
		if(quantity < 1){
			alert("Quantity must be greater than 0");
			return false;
		}
		
		formId.action="<%= request.getContextPath() %>/controller?action=editcart&itemId="+itemId+"&quantity="+quantity;
		formId.submit();
	} else{
		alert("Please insert quantity");
		return false;
	}	
}

function removeItem(formId, itemId) { 
	formId.action="<%= request.getContextPath() %>/controller?action=removeitem&itemId="+itemId;
	formId.submit();	
}

function continueShopping(formId) { 
	formId.action="<%= request.getContextPath() %>/controller?action=products";
	formId.submit();	
}
function proceedToCheckout(formId) { 
	formId.action="<%= request.getContextPath() %>/controller?action=orderp";
	formId.submit();	
}

function isInteger(s){
	var i;
    for (i = 0; i < s.length; i++){   
        var c = s.charAt(i);
        if (((c < "0") || (c > "9"))) return false;
    }
    return true;
}
</script>
</head>
<body>
	<div id="container">
		<jsp:include page="/includes/header.jsp" />
		<jsp:include page="/includes/topnav.jsp" />

		<div id="content">
			<div id="content-header">Cart</div>
			<div id="content-main">
				<table width="100%" cellpadding="2" cellspacing="0" border="0">
					<tr>
						<td valign="top">
							<table width="100%" cellpadding="2" cellspacing="2" border="1">								
							<tr>
								<th>Item Name</th>
								<th>Quantity</th>
								<th>Price</th>
							</tr>	
							<c:choose>
							 <c:when test="${!empty cartItemList}">		
							 	<c:set var="totalPrice" value="0" />											
								<c:forEach var="id" items="${cartItemList}"  >
									<tr>
										<td><c:out value="${id.itemName}" escapeXml="false"/></td>									
										<td align="right">
											<input type="text" name="quantity" id="quantity_<c:out value="${id.itemId}" escapeXml="false"/>"  size="4" value="<c:out value="${id.itemQuantity}" escapeXml="false"/>">
											<input onclick="return editQuantity(document.frm, <c:out value="${id.itemId}" escapeXml="false"/>)" type="button" name="btn" value="Update"> &nbsp; 
											<input onclick="return removeItem(document.frm, <c:out value="${id.itemId}" escapeXml="false"/>)" type="button" name="btn" value="Remove"></td>
										<td align="right">$<fmt:formatNumber type="number" pattern="0.00" value="${id.price}" />
									</tr>	
									<c:set 	var="totalPrice" value="${totalPrice + id.price}"/>
								</c:forEach>
								<tr>
									<td align="right" colspan="2">Total Price</td>
									<td align="right">$<fmt:formatNumber type="number" pattern="0.00" value="${totalPrice}" /></td>
								</tr>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="3">No Items Found</td>
								</tr>
							</c:otherwise>
							</c:choose>
							<form name="frm" method="POST">
							</form>
							</table>
						</td>
					</tr>
					<tr>
						<td align="right">
							<form name="frm1" method="POST">
							<input onclick="return continueShopping(document.frm1)" type="button" name="sbmt" value=" Continue Shopping ">
							<c:if test="${!empty cartItemList}">								
							<input onclick="return proceedToCheckout(document.frm1)" type="button" name="sbmt" value=" Proceed To Checkout ">
							</c:if>
							</form>
						</td>
					</tr>
				</table>
			</div>
		</div>

	</div>
</body>
</html>
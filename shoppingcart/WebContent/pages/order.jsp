<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Shopping Cart</title>
<link rel="stylesheet"href="<%= request.getContextPath() %>/css/style.css" type="text/css" />
<script language="JavaScript">
function submitForm(formId) {		
	
	if(formId.shipFirstName.value.length < 1) {
		alert("Enter Shipping First Name");
		return false;
	}

	if(formId.shipLastName.value.length < 1) {
		alert("Enter Shipping Last Name");
		return false;
	}	
	
	if(formId.shipAddress1.value.length < 1) {
		alert("Enter Shipping Street Address");
		return false;
	}
	
	if(formId.shipCity.value.length < 1) {
		alert("Enter Shipping City");
		return false;
	}	
	
	if(formId.shipStateId.selectedIndex == 0) {
		alert("Select Shipping State");
		return false;
	}
	
	if(formId.shipCountry.value.length < 1) {
		alert("Enter Shipping Country");
		return false;
	}	
	
	
	if(formId.billCardHolderName.value.length < 1) {
		alert("Enter Card Holder Name");
		return false;
	}	
	if(formId.billCardType.selectedIndex == 0) {
		alert("Select Card Type");
		return false;
	}
	
	if(formId.billMonth.selectedIndex == 0) {
		alert("Select Expiry Month");
		return false;
	}
	if(formId.billYear.selectedIndex == 0) {
		alert("Select Expiry Year");
		return false;
	}
	
	if(formId.billCardNumber.value.length < 1) {
		alert("Enter Card Number");
		return false;
	}	
	if(formId.billAddress1.value.length < 1) {
		alert("Enter Billinging Street Address");
		return false;
	}
		
	if(formId.billCity.value.length < 1) {
		alert("Enter Billing City");
		return false;
	}	
	
	if(formId.billStateId.selectedIndex == 0) {
		alert("Select Billing State");
		return false;
	}
	
	if(formId.billCountry.value.length < 1) {
		alert("Enter Billing Country");
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
			<div id="content-header">Order</div>
			<div id="content-main">
				<form name="frm" action="<%= request.getContextPath() %>/controller?action=placeorder" method="POST" onSubmit="return submitForm(document.frm)">
				<table width="100%" cellpadding="2" cellspacing="0" border="0">
					<tr>
						<td valign="top">
							<table width="100%" cellpadding="2" cellspacing="2" border="0">	
								<tr>
									<td valign="top">
										<table class="contentText" cellspacing="2"	cellpadding="2" border="0">					
											<tr>
												<td colspan="2" class="contentTxtHdr">Shipping Information</td>
											</tr>
			
											<tr>
												<td align="right">First Name:&nbsp;<span class="required">*</span></td>
												<td align="left"><input type="text" name="shipFirstName" value="<c:out value="${user.firstName}" escapeXml="false"/>"></td>
											</tr>
											
											<tr>
												<td align="right">Last Name:&nbsp;<span class="required">*</span></td>
												<td align="left"><input type="text" name="shipLastName" value="<c:out value="${user.lastName}" escapeXml="false"/>"></td>
											</tr>
											
											<tr>
												<td align="right">Street Address:&nbsp;<span class="required">*</span></td>
												<td align="left"><input type="text" name="shipAddress1" value="<c:out value="${user.address1}" escapeXml="false"/>"></td>
											</tr>
											
											<tr>
												<td align="right">Apt#:&nbsp;</td>
												<td align="left"><input type="text" name="shipAddress2" value="<c:out value="${user.address2}" escapeXml="false"/>"></td>
											</tr>
											
											<tr>
												<td align="right">City:&nbsp;<span class="required">*</span></td>
												<td align="left"><input type="text" name="shipCity" value="<c:out value="${user.city}" escapeXml="false"/>"></td>
											</tr>	
											
											<tr>
												<td align="right">State:&nbsp;<span class="required">*</span></td>
												<td align="left">
													<select name="shipStateId">
														<option value="">Select</option>
														<c:forEach var="id" items="${stateList}"  >
														<option value="<c:out value="${id.stateId}" escapeXml="false"/>" <c:if test="${id.stateId == user.stateId}"> selected</c:if>><c:out value="${id.stateName}" escapeXml="false"/></option>
														</c:forEach>
													</select>
												</td>
											</tr>
											
											<tr>
												<td align="right">Country:&nbsp;<span class="required">*</span></td>
												<td align="left"><input type="text" name="shipCountry" value="<c:out value="${user.country}" escapeXml="false"/>"></td>
											</tr>	
										</table>										
									</td>
									<td valign="top">
										<table class="contentText" cellspacing="2"	cellpadding="2" border="0">					
											<tr>
												<td colspan="2" class="contentTxtHdr">Billing Information</td>
											</tr>
			
											<tr>
												<td align="right">Card Holder Name:&nbsp;<span class="required">*</span></td>
												<td align="left"><input type="text" name="billCardHolderName" value=""></td>
											</tr>
											<tr>
												<td align="right">Card Type:&nbsp;<span class="required">*</span></td>
												<td align="left">
													<select name="billCardType">
														<option value="">Select</option>
														<option value="Visa">Visa</option>
														<option value="Master">Master</option>
														<option value="Discover">Discover</option>
													</select>												
												</td>
											</tr>
											<tr>
												<td align="right">Expiry Date:&nbsp;<span class="required">*</span></td>
												<td align="left">
													<select name="billMonth">
														<option value="">Select</option>
														<option value="1">January</option>
														<option value="2">February</option>
														<option value="3">March</option>
														<option value="4">April</option>
														<option value="5">May</option>
														<option value="6">June</option>
														<option value="7">July</option>
														<option value="8">August</option>
														<option value="9">September</option>
														<option value="10">October</option>
														<option value="11">November</option>
														<option value="12">December</option>
													</select>
													<select name="billYear">
														<option value="">Select</option>
														<option value="2020">2020</option>
														<option value="2021">2021</option>
														<option value="2022">2014</option>
														<option value="2023">2015</option>
														<option value="2024">2016</option>
														<option value="2025">2017</option>
														<option value="2026">2018</option>
														<option value="2027">2019</option>														
													</select>												
												</td>
											</tr>											
											<tr>
												<td align="right">Card Number:&nbsp;<span class="required">*</span></td>
												<td align="left"><input type="text" name="billCardNumber" value=""></td>
											</tr>																						
											
											<tr>
												<td align="right">Street Address:&nbsp;<span class="required">*</span></td>
												<td align="left"><input type="text" name="billAddress1" value=""></td>
											</tr>
											
											<tr>
												<td align="right">Apt#:&nbsp;</td>
												<td align="left"><input type="text" name="billAddress2" value=""></td>
											</tr>
											
											<tr>
												<td align="right">City:&nbsp;<span class="required">*</span></td>
												<td align="left"><input type="text" name="billCity" value=""></td>
											</tr>	
											
											<tr>
												<td align="right">State:&nbsp;<span class="required">*</span></td>
												<td align="left">
													<select name="billStateId">
														<option value="">Select</option>
														<c:forEach var="id" items="${stateList}"  >
														<option value="<c:out value="${id.stateId}" escapeXml="false"/>"><c:out value="${id.stateName}" escapeXml="false"/></option>
														</c:forEach>
													</select>
												</td>
											</tr>
											
											<tr>
												<td align="right">Country:&nbsp;<span class="required">*</span></td>
												<td align="left"><input type="text" name="billCountry" value=""></td>
											</tr>	
										</table>													
									</td>
								</tr>	
							</table>
						</td>
					</tr>
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
											<c:out value="${id.itemQuantity}" escapeXml="false"/>											
										<td align="right">$<fmt:formatNumber type="number" pattern="0.00" value="${id.price}" />
									</tr>	
									<c:set 	var="totalPrice" value="${totalPrice + id.price}"/>
								</c:forEach>
								<tr>
									<td align="right" colspan="2">Shipping Charge</td>
									<td align="right">$<fmt:formatNumber type="number" pattern="0.00" value="0" /></td>
								</tr>								
								<tr>
									<td align="right" colspan="2">Total Price</td>
									<td align="right">
									$<fmt:formatNumber type="number" pattern="0.00" value="${totalPrice}" />
									<input type="hidden" name="totalPrice" value="${totalPrice}">
									</td>
								</tr>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="3">No Items Found</td>
								</tr>
							</c:otherwise>
							</c:choose>
							</table>
						</td>
					</tr>
					<tr>
						<td align="right">
							<c:if test="${!empty cartItemList}">					
							<input type="submit" name="sbmt" value=" Place Order ">
							</c:if>
						</td>
					</tr>
				</table>
				</form>
			</div>
		</div>

	</div>
</body>
</html>
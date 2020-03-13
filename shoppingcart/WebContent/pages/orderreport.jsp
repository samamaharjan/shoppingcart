<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Shopping Cart</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css" type="text/css" />
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/blue/jquery-ui.min.css" type="text/css" />
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/commonscript.js"></script>
<script language="JavaScript">
$(document).ready(function(){	
	$("#fromDate").datepicker({
		showButtonPanel: true,			
		showOn: "button",
		buttonImage: "<%= request.getContextPath() %>/images/cal.gif",
		buttonImageOnly: true,
		dateFormat: 'mm/dd/yy'		
	});
	
	$("#toDate").datepicker({
		showButtonPanel: true,			
		showOn: "button",
		buttonImage: "<%= request.getContextPath() %>/images/cal.gif",
		buttonImageOnly: true,
		dateFormat: 'mm/dd/yy'		
	});		
});

function submitForm(formId) {		
	var fromDate = $("#fromDate");		

	if(!(fromDate.val() == "")){					
		if(!validateDate(fromDate)){
   			return false;
  		}					
	}else{
		alert("Enter From Date");
		return false;
	}
	
	var toDate = $("#toDate");
	if(!(toDate.val() == "") ){						
		if(!validateDate(toDate)){
   			return false;
  		}
	}else{
		alert("Enter To Date");
		return false;
	}
	
	if(!(fromDate.val() == "" &&  toDate.val() == "")){
    	if(!validatedates(fromDate.val(), toDate.val())){
    		return false;
    	}
	}
		
}

function validatedates(date1Str, date2Str){
	
	var date1=new Date(Date.parse(date1Str));
	var date2=new Date(Date.parse(date2Str));
	
	if ( date2 < date1 ){
		alert("From Date cannot be greater than To Date");
		return false;
	}

	return true;
}

var dtCh= "/";
var minYear=1900;
var maxYear=2100;
</script>
</head>
<body>
	<div id="container">
		<jsp:include page="/includes/header.jsp" />
		<jsp:include page="/includes/topnav.jsp" />

		<div id="content">
			<div id="content-header">Order Report</div>
			<div id="content-main">
				<table width="100%" cellpadding="0" cellspacing="0" border="0">
					<tr>
						<td valign="top" width="220">
							<table width="100%" cellpadding="2" cellspacing="0" border="1">
								<tr>
									<td>
										<form name="frm" action="<%= request.getContextPath() %>/controller?action=orderreport" method="POST" onSubmit="return submitForm(document.frm)" >
											<table width="100%" cellpadding="0" cellspacing="2" border="0">
												<tr>
													<td class="contentTxtBold">From Date:</td>
													<td><input type="text" name="fromDate" id="fromDate" size="8" value="<c:out value="${param.fromDate}" escapeXml="false"/>"/></td>									 
												</tr>
												<tr>
													<td class="contentTxtBold">To Date:</td>
													<td><input type="text" name="toDate" id="toDate" size="8" value="<c:out value="${param.toDate}" escapeXml="false"/>"/></td>									 
												</tr>
												<tr>
													<td colspan="2">&nbsp;</td>
												</tr>														
												<tr>
													<td align="center" colspan="2"><input type="submit" name="sbmt" value=" Run Report "></td>
												</tr>																																					
											</table>
										</form>	
									</td>
								</tr>	
							</table>	
						</td>
						<td valign="top">
							<table width="100%" cellpadding="2" cellspacing="0" border="1">		
							<tr>
								<td colspan="4" align="center" class="contentTxtBold" style="font-size:16px" >Order Report</td>
							</tr>						
							<tr>
								<th>Order Id</th>
								<th>Order Status</th>
								<th>Order Amount</th>
								<th>Order Time</th>
							</tr>
							<c:choose>
							<c:when test="${!empty orderList}">
							<c:forEach var="id" items="${orderList}"  >
								
								<tr>
									<td><c:out value="${id.orderId}" escapeXml="false"/></td>
									<td><c:out value="${id.orderStatus}" escapeXml="false"/></td>
									<td align="right">$<fmt:formatNumber type="number" pattern="0.00" value="${id.orderAmount}" />
									<td align="right"><c:out value="${id.orderDateTime}" escapeXml="false"/></td>
								</tr>

							</c:forEach>
							</c:when>
							<c:otherwise>
							<tr>
								<td colspan="4">No order(s) found</td>
							</tr>
							</c:otherwise>
							</c:choose>							
							</table>
						</td>
					</tr>
				</table>
			</div>
		</div>

	</div>
</body>
</html>
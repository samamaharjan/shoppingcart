<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div id="topnav">
	<ul>
		<li><a href="<%=request.getContextPath() %>/controller?action=home">Home</a></li>
		<li><a href="<%=request.getContextPath() %>/controller?action=products">Products</a></li>
		<li><a href="<%=request.getContextPath() %>/controller?action=viewcart">View Cart</a></li>
		<c:if test="${!empty appuser}">
		<li><a href="<%=request.getContextPath() %>/controller?action=edituserp">Account</a></li>
		<li><a href="<%=request.getContextPath() %>/controller?action=orderreportp">Order Report</a></li>
		</c:if>
	</ul>
</div>
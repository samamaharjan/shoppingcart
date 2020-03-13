<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div id="header" align="center">
	<div id="header-left">
	<img src="<%=request.getContextPath()%>/images/logo.png" width="80" height="72" />
	</div>
	<div id="hd-middle">
		Shopping Cart
	</div>
	<div id="header-right">
		<c:choose>
			<c:when test="${!empty appuser.userName}">
				<div>
					<div>
						Welcome&nbsp;<c:out value="${appuser.userName}" escapeXml="false" />
					</div>
					<div class="headerLink">
						<a href="<%=request.getContextPath()%>/controller?action=logout">Log Off</a>
					</div>
				</div>
			</c:when>
			<c:otherwise>
				<dvi class="headerLink">
					<a href="<%=request.getContextPath() %>/controller?action=loginp">Login</a>&nbsp;|&nbsp;<a href="<%=request.getContextPath() %>/controller?action=signupp">Sign Up</a>
				</dvi>	
				</c:otherwise>
		</c:choose>
	</div>
</div>
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
			<div id="content-header">Home</div>
			<div id="content-main">
				<table width="100%" cellpadding="0" cellspacing="0" border="0">
					<tr>
						<td valign="top">
						</td>
					</tr>
				</table>
			</div>
		</div>

	</div>
</body>
</html>
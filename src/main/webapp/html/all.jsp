<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>无标题文档</title>
<style type="text/css">
	*{
		margin: 0px;
		padding: 0px;
		margin: auto;
	}
	.cotation{
		width: 980px;
		height: 1000px;
		margin: auto;
	}
	.top1{
		width: 980px;
		height: 75px;
		margin: auto;
	}
	.all{
		float: left;
		width: 980px;
		height: 500px;
		margin: auto;
	}
	.left{
		width: 190px;
		height: 500px;
		float: left;
		outline: solid 1px #C3BEBE;
	}

	.right{
		float:right; 
		width: 780px;
		height: 500px;
	
	}
	.top{
		width: 780px;
		height: 283px;
	}
	.botton{
		clear: both;
		width: 780px;
		height: 217px;
		outline: solid 1px #C3BEBE;
	}
	.footer{
		margin-top: 10px;
		width: 980px;
		height: 59px;
		float: left;
	}
	</style>
</head>

<body>
<div class="cotation">
<div class="top1">
	<iframe src="${pageContext.request.contextPath}/html/top.jsp" width="980px" height="75px" frameborder="0" scrolling="no"></iframe>
</div>
<div class="all">
	<div class="left">	
		<iframe src="${pageContext.request.contextPath}/html/left.jsp" width="190px" height="500px" frameborder="0" scrolling="no"></iframe>
	</div>
	<div class="right">
		<div class="top">
			<iframe src="${pageContext.request.contextPath}/html/top2.jsp" width="780px" height="283px" frameborder="0" scrolling="no"></iframe>
		</div>
		<div class="botton">
			<iframe src="${pageContext.request.contextPath}/html/botton.jsp" width="780px" height="217px" frameborder="0" scrolling="no"></iframe>
		</div>
	</div>
</div>
<div class="footer">
	<iframe src="${pageContext.request.contextPath}/html/footer.html" height="59px" width="980px" frameborder="0" scrolling="no"></iframe>
</div>
</div>
</body>
</html>

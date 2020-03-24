<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>交友</title>
<link href="${pageContext.request.contextPath}/css/makefriends.css" rel="stylesheet" />
	<link rel="stylesheet" href="/management/lib/layui/css/layui.css" media="all">
	<!-- 注意：如果你直接复制所有代码到本地，上述css路径需要改成你本地的 -->
	<script type="text/javascript" src="${pageContext.request.contextPath}/management/lib/layui/layui.js" charset="utf-8"></script>
	<%--<script type="text/javascript" src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>--%>
	<script type="text/javascript" src="${pageContext.request.contextPath}/management/js/xadminwsf.js"></script>
	<script src="${pageContext.request.contextPath}/management/js/jquery3.3.1.min.js"></script>
</head>

<body>
<div id="top" style="width: 1200px;margin:auto">
<iframe src="top.jsp" width="1200px" height="75px" scrolling="no" frameborder="0px"></iframe>
</div>
<div id="main">
	<div id="main_top">
	<ul>
		<a href="javascript:change('friendList.jsp');"><li>我的好友</li></a>
		<a href="javascript:change('strangers.jsp');"><li>陌生人</li></a>
		<a href="javascript:change('BlackList.jsp');"><li>黑名单</li></a>
		<a href="javascript:change('waitFriend.jsp');"><li>好友申请</li></a>
		<a href="javascript:change('email.jsp');"><li>发邮件</li></a>
		<a href="javascript:change('recvEmailBox.jsp');"><li>收件箱</li></a>
		<a href="javascript:change('sendEmailBox.jsp');"><li>发件箱</li></a>
		<a href="javascript:change('recycleEmailBox.jsp');"><li>回收站</li></a>
	</ul>
	</div>
	<div id="main_content">
		<div style="width: 970px;height: 480px;text-align: center;">
			<iframe id="frame" src="friendList.jsp" width="100%" height="100%">

			</iframe>
		</div>
	</div>
</div>
<div id="foot">
	<iframe src="footer.html" width="980px" height="59px" frameborder="0"></iframe>
</div>
</body>
<script>
    //定义每个页面的地址数组
    function change(x){
        $("#frame").attr("src",x);
    }
    function b(){
        if(man.value == 0)
            alert("收件人不能为空！");
    }
</script>
</html>

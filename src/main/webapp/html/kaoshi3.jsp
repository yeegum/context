<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>无标题文档</title>
<link href="${pageContext.request.contextPath}/css/kaoshi2.css" rel="stylesheet"/>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/management/lib/layui/css/layui.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/management/js/jquery3.3.1.min.js"></script>
	<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
	<script src="${pageContext.request.contextPath}/management/lib/layui/layui.js" charset="utf-8"></script>
</head>

<body>
<div class="main">
	<div class="top">
		<iframe style="width: 980px;height: 75px;" scrolling="no" src="${pageContext.request.contextPath}/html/top.jsp" frameborder="0"></iframe>
	</div>
	<div class="mid">
		<div class="midtop">
			<div class="midtopleft" style="cursor:pointer">
				<ul>
					<li onClick="kaoshi3()" style="background-color:#46586a;">考试记录</li>
					<li onClick="kaoshi2()" style="background-color:#46586a;">参加考试</li>
					<%--<li onClick="kaoshi()" style="background-color:#d05054; ">模拟测试</li>--%>
				</ul>
			</div>
			<div class="midtopright">
				<ul>
					<li>亲爱的${sessionScope.user.nickname}，您好！</li>
					<li><img style="width: 33px;height: 33px;margin-top: 2px" src="${sessionScope.user.faceimg}"/></li>
					<a href="/logout"><li class="zhuxiao" style="text-align: center;font-size: 14px;line-height: 28px">注销</li></a>

				</ul>
			</div>
		</div>
		<div class="midmain">
			<div class="midmaintop">
				<ul>
					<li style="width: 81px;font-weight: bold;background-color: #d5dbe6">试卷名</li>
					<li style="width: 277px;font-weight: bold;background-color: #d5dbe6">考试时长</li>
					<li style="width: 257px;font-weight: bold;background-color: #d5dbe6">考试用时</li>
					<li style="width: 80px;font-weight: bold;background-color: #d5dbe6">总分数</li>
					<li style="width: 106px;font-weight: bold;background-color: #d5dbe6">得分</li>
					<li style="width: 55px;font-weight: bold;background-color: #d5dbe6">状态</li>
					<li style="width: 109px;font-weight: bold;background-color: #d5dbe6">操作</li>
				</ul>
			</div>
			<div class="midmainmid" id="records">

			</div>
			<div class="midmainbot">
				<ul>
					<li class="btn" style="text-align: center;font-size: 14px;line-height: 28px" onclick="getPage(1,limit)">首页</li>
					<li class="btn" style="text-align: center;font-size: 14px;line-height: 28px;margin-left: 10px" onclick="getPage(pageCur-1,limit)">上一页</li>
					<li class="btn" style="text-align: center;font-size: 14px;line-height: 28px;margin-left: 10px" onclick="getPage(pageCur+1,limit)" >下一页</li>
					<li class="btn" style="text-align: center;font-size: 14px;line-height: 28px;margin-left: 10px" onclick="getPage(999,limit)">尾页</li>
					<li style="font-size: 14px;margin-left: 7px;margin-top: 5px;">总记录<span id="count"></span>条&nbsp;-共<span id="pages"></span>页&nbsp;-当前第<span id="pageCur"></span>页</li>
					<li style="font-size: 14px;margin-left: 10px;margin-top: 5px;margin-top: 5px;">每页&nbsp;</li>
					<li><input id="limitChange" style="text-align: center;width: 30px;height: 18px;margin-top: 5px;" type="text" value="3"/>&nbsp;</li>
					<li style="font-size: 14px;margin-top: 5px;margin-top: 5px;">条&nbsp;</li>
					<li class="btn" onclick="limitChange()" style="text-align: center;font-size: 14px;line-height: 28px;margin-left:  10px ;width: 30px">√</li>
					<li style="font-size: 14px;margin-left: 30px;margin-top: 5px;margin-top: 5px;">跳转至&nbsp;</li>
					<li><input id="pageTo" style="text-align: center;width: 30px;height: 18px;margin-top: 5px;" type="text" value="1"/>&nbsp;</li>
					<li style="font-size: 14px;margin-top: 5px;margin-top: 5px;">页&nbsp;</li>
					<li class="btn" style="text-align: center;font-size: 14px;line-height: 28px;margin-left: 10px" onclick="pageTo()">GO</li>

				</ul>
			</div>
			<script>
				var pageCur = 1;
				var limit = 3;

				getPage(pageCur,limit);
				function getPage(page,limit) {
					var url = "/show/historyRecords";
					$.ajax({
						type: "POST",
						url: url,
						data:{
							page:page,
							limit:limit
						},
						success: function(res){
							var list = res.data;
							$("#records").empty();
							for(var i = 0; i<list.length;i++){
								var obj = list[i];
								// $("#records")

								var str = "<ul>" +
										"<li style=\"width: 81px;\">"+obj.paper.par_name+"</li>\n" +
										"<li style=\"width: 277px;\">"+obj.paper.test_length_time+"分钟</li>\n" +
										"<li style=\"width: 257px;\">"+obj.usetime+"分钟</li>\n" +
										"<li style=\"width: 80px;\">"+obj.allScore+"分</li>\n" +
										"<li style=\"width: 106px;\">"+obj.score+"分</li>\n" +
										"<li style=\"width: 55px;\">"+obj.status+"</li>\n" +
										"<li style=\"width: 109px;\"><button onclick=\"turnToView("+obj.paper.par_id+")\" class=\"layui-btn layui-btn-xs layui-btn-danger\" id=\""+obj.paper.par_id+"\">查看试卷</button></li>" +
										"</ul>";
								$("#records").append(str);
							}
							$("#count").text(res.count);
							$("#pages").text(Math.ceil(res.count/limit));
							pageCur = page;
							if(pageCur>Math.ceil(res.count/limit)) pageCur=Math.ceil(res.count/limit);
							if(pageCur<1) pageCur = 1;
							$("#pageCur").text(pageCur);
						}
					});
				}


				function limitChange() {
					limit = $("#limitChange").val();
					getPage(1,limit);
				}
				function pageTo() {
					pageCur = $("#pageTo").val();
					getPage(pageCur,limit);
				}

				function turnToView(par_id) {
					location.href="/exam/record?par_id="+par_id;
				}

			</script>
		</div>
	</div>
	<div class="bot">
		<iframe style="width: 980px;height: 75px;" scrolling="no" src="footer.html" frameborder="0"></iframe>
	</div>	
</div>
<script type="text/javascript">
	function kaoshi(){
		window.location.replace("kaoshi.jsp");
	}
	function kaoshi2(){
		window.location.replace("kaoshi2.jsp");
	}
	function kaoshi3(){
		window.location.replace("kaoshi3.jsp");
	}
</script>
</body>
</html>


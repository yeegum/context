<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>无标题文档</title>
<link href="../css/kaoshi.css" rel="stylesheet"/>
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
					<li onClick="kaoshi()" style="background-color:#d05054; ">模拟测试</li>
				</ul>
			</div>
			<div class="midtopright">
				<ul>
					<li>亲爱的${sessionScope.user.nickname}，您好！</li>
					<li><img style="width: 33px;height: 33px;margin-top: 2px" src="${sessionScope.user.faceimg}"/></li>
					<li class="zhuxiao" style="text-align: center;font-size: 14px;line-height: 28px">注销</li>
				</ul>
			</div>
		</div>
		<div class="bord">
		<div class="midtop2">
			<h5 style="width:64px;height: 35px; text-align: center;line-height: 37px;border-bottom: solid 3px #66c9f3;">生成试卷</h5>
		</div>
		<div class="midmain">
			<div class="midmain1">
				<ul>
					<li>所属科目</li>
					<li>
					<select onChange="change()" id="sel" style="width: 345px;height: 32px;font-size: 10px">
					<option selected="selected" value="3">&nbsp;&nbsp;请选择科目</option>
					<option value="0">
					&nbsp;&nbsp;java</option>
					<option value="1">
					&nbsp;&nbsp;html</option>
					</select> 
					</li>
				</ul>
			</div>
			<div class="midmain2" id="jav">
				<ul>
					<li>考试模板</li>
					<li>
					<select style="width: 345px;height: 32px;font-size: 10px">
					<option selected="selected" >&nbsp;&nbsp;java</option>
					</select> 
					</li>
				</ul>
			</div>
			<div class="midmain3" id="htm">
				<ul>
					<li>考试模板</li>
					<li>
					<select style="width: 345px;height: 32px;font-size: 10px">
					<option selected="selected" >&nbsp;&nbsp;第一阶段第一周周测试卷</option>
					<option>&nbsp;&nbsp;第一阶段第二周周测试卷</option>
					<option>&nbsp;&nbsp;第一阶段第三周周测试卷</option>
					</select> 
					</li>
				</ul>
			</div>
			<div class="pamidmain4">
			<div onClick="neiye1()" class="midmain4">
				<span style="font-size: 10px;line-height: 28px;margin-left: 5px"><a href="test_in1.html">参加考试</a></span>
			</div>
			</div>
		</div>
		</div>
	</div>
	<div class="bot">
		<iframe style="width: 980px;height: 75px;" scrolling="no" src="footer.html" frameborder="0"></iframe>
	</div>	
</div>
<script type="text/javascript">
	function change(){
		var jav=document.getElementById("jav");
		var htm=document.getElementById("htm");
		var sel=document.getElementById("sel");
		if(sel.value==0){
			jav.style.display="block";
			htm.style.display="none";
		}
		else if(sel.value==1){
			jav.style.display="none";
			htm.style.display="block";
		}
		else if(sel.value==3){
			alert("请选择科目");
		}
	}
	function kaoshi(){
		window.location.replace("kaoshi.jsp");
	}
	function kaoshi2(){
		window.location.replace("kaoshi2.jsp");
	}
	function kaoshi3(){
		window.location.replace("kaoshi3.jsp");
	}
	function neiye1(){
		window.location.replace("");
	}
</script>
</body>
</html>

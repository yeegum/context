<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
	<meta charset="utf-8">
	<title>考试</title>
	<link href="${pageContext.request.contextPath}/css/test_in.css" rel="stylesheet"/>
	<script type="text/javascript" src="${pageContext.request.contextPath}/management/js/jquery3.3.1.min.js"></script>
	<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
	<%--<link href="${pageContext.request.contextPath}/management/lib/layui/css/layui.css" rel="stylesheet"/>--%>
	<script src="${pageContext.request.contextPath}/management/lib/layui/layui.js" charset="utf-8"></script>
</head>

<body >
<form id="form1" name="form1" method="post">
<div class="main">
    <a name="top"></a>
	<div class="main_title">
		<a href="#">${ViewInfo.paperInfo.paper.par_name}</a>
	</div>
	<div class="main_message">
		<p>考试编号: EXAM-${ViewInfo.paperInfo.paper.par_id}</p>
		<p>试卷总分: <span id="allSocre"></span></p>
		<p>ta的分数: ${ViewInfo.examRecord.sum_score}</p>
	</div>
	<div>
		<% int count = 1;%>
		<script>
			var all_score = 0;
			var usermap = {};
			var userScoremap = {};
			<c:forEach items="${ViewInfo.userAnswerList}" var="userAnswer" >
				var qid = "${userAnswer.que_id}";
				var ans = "${userAnswer.ask}";
				var score = "${userAnswer.score}";
				usermap[qid] = ans;
				userScoremap[qid] = score;
			</c:forEach>

			var analysismap ={}
			<c:forEach items="${ViewInfo.queWithOptionList}" var="analyList" >
			var qid = "${analyList.que.que_id}";
			var analysis = "${analyList.que.analysis}";
			analysismap[qid] = analysis;
			</c:forEach>
		</script>
		<c:forEach items="${ViewInfo.paperInfo.relList}" var="temp">
			<div class="main_radio_title">
				<span>${temp.typeName} (总共${temp.relInfo.que_count}题，每题${temp.relInfo.que_score}分)</span>
			</div>
			<c:forEach items="${ViewInfo.queWithOptionList}" var="qList">
				<c:choose>
					<c:when test="${qList.que.que_type_id==temp.relInfo.que_type_id}">
						<c:choose>
							<c:when test="${temp.typeName=='单选题'}">
								<div class="main_radio_question">
									<div class="choose" style="margin-top: 20px; padding-left: 25px;"><span><%=count++%>:${qList.que.ask}  --总题号${qList.que.que_id}</span><br/></div>
									<c:forEach items="${qList.optionList}" var="opt">
										<div class="choose"><input disabled type="radio" id="${opt.que_id}${opt.que_op}"  value="${opt.que_op}"/>${opt.que_op}.<span>${opt.statement} </span></div>
										<script>
											var qid = "${qList.que.que_id}";
											var useropt = usermap[qid];
											// alert(useropt);
											var opt = "${opt.que_op}";
											if( useropt.indexOf(opt) != -1){
												$("#${opt.que_id}${opt.que_op}").prop("checked",true);
											}
										</script>
									</c:forEach>
								</div>
							</c:when>
							<c:when test="${temp.typeName=='多选题'}">
								<div class="main_radio_question">
									<div class="choose" style="margin-top: 20px; padding-left: 25px;"><span><%=count++%>:${qList.que.ask}  --总题号${qList.que.que_id}</span><br/></div>
									<c:forEach items="${qList.optionList}" var="opt">
										<div class="choose" style="padding-left: 15px;"><input disabled type="checkbox" id="${opt.que_id}${opt.que_op}"  value="${opt.que_op}"/><span>${opt.que_op}.${opt.statement}</span></div>
										<script>
											var qid = "${qList.que.que_id}";
											var useropt = usermap[qid];
											var opt = "${opt.que_op}";
											if( useropt.indexOf(opt) != -1){
												$("#${opt.que_id}${opt.que_op}").prop("checked",true);
											}
										</script>
									</c:forEach>
								</div>
							</c:when>
							<c:when test="${temp.typeName=='主观题'}">
								<div class="main_radio_question">
									<div style="margin-top: 15px;margin-left: 15px;"><span><%=count++%>:${qList.que.ask}  --总题号${qList.que.que_id}</span><br/>
										<textarea id="${qList.que.que_id}"   style="border: solid 1px #cccccc; border-radius: 5px;" rows="7" cols="90"></textarea>
										<script>
											var qid = "${qList.que.que_id}";
											var useropt = usermap[qid];
											$("#${qList.que.que_id}").text(useropt);
										</script>
									</div>
								</div>
							</c:when>
							<c:when test="${temp.typeName=='填空题'}">
								<div class="main_fill_black">
									<div style="margin-top: 15px;margin-left: 15px;">
										<span><%=count++%>:${qList.que.ask}  --总题号${qList.que.que_id}</span><br/>
										<input  type="text" style="width: 670px;height: 32px;border: solid 1px #cccccc; border-radius: 5px;margin-top: 20px;" />
										<script>
											var qid = "${qList.que.que_id}";
											var useropt = usermap[qid];
											$("#${opt.que_id}${opt.que_op}").val(useropt);
										</script>
									</div>
								</div>
							</c:when>
						</c:choose>

						<%--<div style="margin-top: 15px;margin-left: 15px;"><span>得分:</span><span id="score${qList.que.que_id}"></span><br/>--%>
						<div style="margin-top: 15px;margin-left: 15px;"><span>答案:</span><span id="rightAsk${qList.que.que_id}"></span><br>
							<%--<span>得分:</span><input type="text" style="width: 30px;" name="${qList.que.que_id}" id="score${qList.que.que_id}"></input><br/>--%>
							<span>得分:</span>

							<select style="width: 40px;" name="${qList.que.que_id}" id="score${qList.que.que_id}"></select>
							<br>
							<textarea id="analy${qList.que.que_id}"  style="border: solid 1px #cccccc; border-radius: 5px;" rows="7" cols="90"></textarea>
							<script>
								var qid = "${qList.que.que_id}";
								<%--var analysis = "答案:${qList.que.right_ask}\n"--%>
								 analysis = analysismap[qid];
								$("#analy${qList.que.que_id}").text(analysis);
								var rightAsk = "${qList.que.right_ask}";
								$("#rightAsk${qList.que.que_id}").text(rightAsk);

								var score = userScoremap[qid];
								<%--$("#score${qList.que.que_id}").val(score);--%>
								for(var i = 0;i<="${temp.relInfo.que_score}";i++){
									var emp ;
									if(i==score){
										emp = "<option value=\""+i+"\" selected>"+i+"</option>";
									}else{
										emp = "<option value=\""+i+"\">"+i+"</option>";
									}

									$("#score${qList.que.que_id}").append(emp);
								}
							</script>
						</div>
					</c:when>
				</c:choose>

			</c:forEach>

			<script>
				all_score+=${temp.relInfo.que_count}*${temp.relInfo.que_score};
			</script>
		</c:forEach>
		<script>
			$("#allSocre").text(all_score);
		</script>
	</div>
<br/>
<br/>
<br/>

    <input type="hidden" name="par_id" value="${ViewInfo.paperInfo.paper.par_id}">
</div>
<a name="btm22"></a>
<div class="operation">

	<br>
	<%--<div class="remain_time" id="remain_time">--%>
		<%--剩余时间：0:0--%>
	<%--</div>--%>
	<div class="back_top">
		<a href="#top" style="color: white;font-size: 12px;">回到顶部</a>
	</div>
	<div class="back_top">
		<a href="#btm22" style="color: white;font-size: 12px;">回到底部</a>
	</div>
	<div class="sub" onclick="updateUserScore()">
		<a class="tijiao">审批</a>
	</div>
</div>
	<input type="hidden" name="par_id" value="${ViewInfo.paperInfo.paper.par_id}">
	<input type="hidden" name="userid" id="getParId" >
	<script>
		layui.use('layer', function(){
			var layer = layui.layer;

		});
		$(function () {
			var val = $("#getParId").val(getQueryVariable("userid"));
		})
	</script>

</form>
<script>


	function updateUserScore() {
		var url = "${pageContext.request.contextPath}/exam/correctionPaper";
		$.ajax({
			type: "POST",
			url: url,
			data:$("#form1").serialize(),
			success: function(data){
				//var parse = JSON.parse(data);

				layer.alert(data.msg,function () {
					//刷新父页面
					window.parent.location.reload();
					var index = parent.layer.getFrameIndex(window.name);
					//再执行关闭
					parent.layer.close(index);
				});

			}
		});

	}

		//获取url中的参数 的方法
	function getQueryVariable(variable)
	{
		var query = window.location.search.substring(1);
		var vars = query.split("&");
		for (var i=0;i<vars.length;i++) {
			var pair = vars[i].split("=");
			if(pair[0] == variable){return pair[1];}
		}
		return(false);
	}



</script>

</body>


</html>

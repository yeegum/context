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
	<script src="${pageContext.request.contextPath}/management/lib/layui/layui.js" charset="utf-8"></script>
</head>

<body>
<form id="form1" name="form1" action="#" method="post">
<div class="main">
    <a name="top"></a>
	<div class="main_title">
		<a href="#">${ViewInfo.paperInfo.paper.par_name}</a>
	</div>
	<div class="main_message">
         <p>考试编号: EXAM-${ViewInfo.paperInfo.paper.par_id}</p>
		<p>试卷总分: <span id="allSocre"></span></p>
	</div>
	<div>
		<% int count = 1;%>
		<script>
			var all_score = 0;
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
										<div class="choose"><input disabled type="radio" id="${opt.que_id}${opt.que_op}" name="${opt.que_id}" value="${opt.que_op}"/>${opt.que_op}.<span>${opt.statement} </span></div>
										<script>
											var rightopt = "${qList.que.right_ask}";
											var opt = "${opt.que_op}";
											if( rightopt.indexOf(opt) != -1){
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
										<div class="choose" style="padding-left: 15px;"><input disabled type="checkbox" id="${opt.que_id}${opt.que_op}" name="${opt.que_id}" value="${opt.que_op}"/><span>${opt.que_op}.${opt.statement}</span></div>
										<script>
											var rightopt = "${qList.que.right_ask}";
											var opt = "${opt.que_op}";
											if( rightopt.indexOf(opt) != -1){
												$("#${opt.que_id}${opt.que_op}").prop("checked",true);
											}
										</script>
									</c:forEach>
								</div>
							</c:when>
							<c:when test="${temp.typeName=='主观题'}">
								<div class="main_radio_question">
									<div style="margin-top: 15px;margin-left: 15px;"><span><%=count++%>:${qList.que.ask}  --总题号${qList.que.que_id}</span><br/>
										<textarea id="${qList.que.que_id}" name="${qList.que.que_id}" style="border: solid 1px #cccccc; border-radius: 5px;" rows="7" cols="90"></textarea>
										<script>
											var qid = "${qList.que.que_id}";
											// var useropt = usermap[qid];

											$("#${qList.que.que_id}").text("${qList.que.right_ask}");
										</script>
									</div>
								</div>
							</c:when>
							<c:when test="${temp.typeName=='填空题'}">
								<div class="main_fill_black">
									<div style="margin-top: 15px;margin-left: 15px;">
										<span><%=count++%>:${qList.que.ask}  --总题号${qList.que.que_id}</span><br/>
										<input name="${qList.que.que_id}" type="text" style="width: 670px;height: 32px;border: solid 1px #cccccc; border-radius: 5px;margin-top: 20px;" />
									</div>
								</div>
							</c:when>
						</c:choose>
						<%--<div style="margin-top: 15px;margin-left: 15px;"><span>得分:</span><span id="score${qList.que.que_id}"></span><br/>--%>
						<div style="margin-top: 15px;margin-left: 15px;">
							<%--<span>答案:</span><span id="rightAsk${qList.que.que_id}"></span><br><span>得分:</span><span id="score${qList.que.que_id}"></span><br/>--%>

							<textarea id="analy${qList.que.que_id}" name="${qList.que.que_id}" style="border: solid 1px #cccccc; border-radius: 5px;" rows="7" cols="90"></textarea>
							<script>
								var qid = "${qList.que.que_id}";
								<%--var analysis = "答案:${qList.que.right_ask}\n"--%>
								 analysis = analysismap[qid];
								$("#analy${qList.que.que_id}").text(analysis);
								var rightAsk = "${qList.que.right_ask}";
								$("#rightAsk${qList.que.que_id}").text(rightAsk);

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

</form>
<script>
	layui.use('layer', function(){
		var layer = layui.layer;

	});
</script>
</body>

</html>

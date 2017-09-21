<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link href="resources/css/newtech.css" rel="stylesheet" type="text/css">
    <link href="resources/css/newtech2.css" rel="stylesheet" type="text/css">
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>9월 3주차 신기술 찬/반 투표</title>
</head>
<body>

<%@ include file="/header.jsp"%>
  <div class="polls_heading">
	<h2>9월 3주차 신기술 찬/반 투표 : </h2>
  <h1>자바는 한물갔다!</h1>
  </div>
  <div class="polls_body">
	<button type="button" id="pro">한물가지 않았다.<br>니들이 활용 못할 뿐.</button>
	<script type="text/javascript">
		$(function(){

			$('#pro').click(function(){
				$.ajax({
                    type : "POST",
                    url : "proInsert.do",
                    dataType:"text",
                    success : function(data) {
                    	if($.isNumeric(data))
                    	{
                    		alert("찬성하셨습니다.");
                        	$('#proCount').text(data);
                    	}
                    	else
                    	{
                    		if(data=='p')
                    			alert("이미 찬성하셨습니다.");
                    		else
                    			alert("이미 반대하셨습니다.");
                    	}

                    },
                    error:function(request,status,error){
                        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                       }
            	});

			});

      $('#con').click(function(){
				$.ajax({
                    type : "POST",
                    url : "conInsert.do",
                    dataType:"text",
                    success : function(data) {
                    	if($.isNumeric(data))
                    	{
                    		alert("찬성하셨습니다.");
                        	$('#proCount').text(data);
                    	}
                    	else
                    	{
                    		if(data=='p')
                    			alert("이미 찬성하셨습니다.");
                    		else
                    			alert("이미 반대하셨습니다.");
                    	}
                    },
                    error:function(request,status,error){
                        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                       }
            	});
			});

		});
	</script>
  <div class="polls_between">VS</div>
	<button type="button" id="con">한물갔다.
    <br>밥벌이 하고 싶으면 파이썬이나 배우자.</button>
  <br>

  <button type="button" id="polls_result_btn">금주 신기술 동향 투표 결과 확인하기</button>
  <br><br>
    <a id="polls_result" href ="newtech2.jsp">금주 신기술 동향 투표 결과 확인하기</a>
</div>

      <!-- 게시판 영역 -->
			<div class="board">
				<!-- 검색창, 검색 정렬들의 패널 -->
				<div class="panel panel-default">

					<div class="panel-body">
						<div class="panel pull-left">
							<form>
								<div class="input-group">
									<input type="text" class="form-control" size="50" placeholder="검색어를 입력하세요...">
										<div class="input-group-btn">
											<button type="button" class="btn btn-success">검색</button>
										</div>
									</div>
								</form>
							</div>
							<div class="panel pull-right">
								<div class="sort_options">

									<select class="selectpicker">
										<option>최신순</option>
										<option>인기높은순</option>
										<option>김말순</option>
										<option>떡튀순</option>
									</select>

								</div>
							</div>
						</div>
						<button onclick="location.href='boardCode.do'" style="color:white;">SSIPPAL</button>
						<!-- 게시판 테이블 -->
						<div class="table-responsive">
							<table id="myTable" class="table table-hover table-striped">
								<thead>
									<tr>
										<th>글번호</th>
										<th class="col-md-5">제목</th>
										<th>카테고리</th>
										<th>작성자</th>
										<th>추천수</th>
										<th>조회수</th>
										<th>작성일자</th>
									</tr>
								</thead>
								<tbody>
									<c:set var="num" value="1"/>
									<c:forEach var="l" items="${list }">

										<tr onclick="location.href='boardOne.do?bcode=${l.bcode}'">

											<td>${num }</td>
											<c:set var="num" value="${num+1 }"/>
											<td>${l.title }<span id="reply_num">&nbsp;[${l.isdelete}]</span>
											</td>
											<td>${l.code.name}</td>
											<td>
												<div class="profile">
													<a href="profile.jsp">
														<img class="img-circle" src="//lh3.googleusercontent.com/-6V8xOA6M7BA/AAAAAAAAAAI/AAAAAAAAAAA/rzlHcD0KYwo/photo.jpg?sz=120"/>
													</a>
													${l.writerid }
												</div>
											</td>
											<td>${l.point.best*(5)+l.point.good*(3)+l.point.bad*(-3)+l.point.worst*(-5) }</td>
											<td>${l.point.viewnum }</td>
											<td>${l.postdate }</td>
										</tr>

									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>

				</div>





		</body>
		<%-- <%@ include file="/footer.jsp"%> --%>
	</html>

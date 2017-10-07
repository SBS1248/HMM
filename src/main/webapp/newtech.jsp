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
<link href="resources/css/index.css" rel="stylesheet" type="text/css">
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script type="text/javascript">
	function viewcount(bcode)
	{
		$.ajax({
            type : "GET",
            url : "viewcount.do?bcode="+bcode,
           	success:function(){},
            error:function(request,status,error){
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
               }
    	});
	};
</script>

<script type="text/javascript">
	// 타자기
	window.onload = typeWriter;

	var i = 0;
	var txt = '모두가 하나되는 국내 최고 IT 커뮤니티에 여러분을 초대합니다!';
	var speed = 80;

	function typeWriter() {
		if (i < txt.length) {
			document.getElementById("demo").innerHTML += txt.charAt(i);
			i++;
			setTimeout(typeWriter, speed);
		}
	}
	function viewcount(bcode)
	{
		$.ajax({
            type : "GET",
            url : "viewcount.do?bcode="+bcode,
           	success:function(){},
            error:function(request,status,error){
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
               }
    	});
	};

	function checkBoard(bcode){
		var data = '${sessionScope.member}';
		if(data ==''){
			alert("로그인 후 이용 바랍니다");
			$("#loginModal").modal('show');
		}
		else
		{
			viewcount(bcode);
			location.href="boardOne.do?bcode="+bcode;
		}
	}

	function checkWrite()
	{
			location.href="boardcode.do?dis=${dis}";
	}


	function onEnterSearch()
	{
		var keyCode = window.event.keyCode;
		var keyword = $('input[name=search]').val();
		if (keyCode == 13) {
			location.href="boardSearch.do?dis="+'${dis}'+"&keyword="+keyword;
		}
	}
</script>

<title>9월 3주차 신기술 찬/반 투표</title>
</head>
<body>

<%@ include file="/header.jsp"%>
  <div class="polls_heading">
	<h2>9월 3주차 신기술 찬/반 투표 : </h2>
  <h1>객체지향 프로그래밍 VS 절차지향 프로그래밍, 무엇이 더 나을까?</h1>
  </div>
  <div class="polls_body">
	<button type="button" id="pro">형식보다는 실용성.<br>객체지향 프로그래밍이 곧 미래이다.</button>
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
	<button type="button" id="con">물이 위에서 아래로 흐르듯이,
    <br>순차지향 프로그래밍은 곧 자연의 이치이다.</button>
  <br>

  <button type="button" id="polls_result_btn" onclick="location.href='newtech2.jsp'">금주 신기술 동향 투표 결과 확인하기</button>

</div>
<div class="polls_footer">
  <div class="container">
		<!-- 게시판 영역 -->
		<div class="board_area">
			<!-- 검색창, 검색 정렬들의 패널 -->
			<div clas="board">

				<div class="board-heading">

					<%-- 글쓰기 버튼 --%>
					<div id="writebutton">
						<button id="write" type="button" onclick="checkWrite()">글쓰기</button>
					</div>

					<%-- 검색바 --%>
					<div id="search_bar">
						<input type="text" name="search" placeholder="검색어를 입력하세요.." onkeydown='javascript:onEnterSearch()'>
					</div>

					<%-- 게시글 정렬 --%>
					<div class="sort_options">
						<select class="selectpicker">
							<option>최신순</option>
							<option>인기높은순</option>
							<option>김말순</option>
							<option>떡튀순</option>
						</select>
					</div>

				</div>

				<div class="board-body">
					<!-- 게시판 테이블 -->
					<div class="hmm_table">
						<table id="myTable">
							<thead>
								<tr>
									<th>글번호</th>
									<th
										style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden">제목</th>
									<th>카테고리</th>
									<th>작성자</th>
									<th>추천 점수</th>
									<th>조회수</th>
									<th>작성일자</th>
								</tr>
							</thead>
							<tbody>
								<c:set var="num" value="1" />
								<c:forEach var="l" items="${list }">

									<tr>

										<td>${num }</td>
										<c:set var="num" value="${num+1 }" />
										<td id="td_title"><a onclick="checkBoard(${l.bcode})"
											style="cursor: pointer">${l.title }</a><span id="reply_num">&nbsp;[${l.isdelete}]</span></td>

										<td>${l.code.name}</td>
										<td>
											<div class="profile">
												<a href="profile.jsp"> <img class="img-circle" src="#" />
												</a> ${l.writerid }
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
		</div>
	</div>
</body>
	</html>

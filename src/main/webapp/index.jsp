<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="org.springframework.ui.Model"%>
<c:if test="${list eq null}">
	<script>
		window.location.href = "boardLists.do?dis=0";
	</script>
</c:if>
<!DOCTYPE html>
<html>
<head>
<title>Hmm | 국내 최고 개발자 커뮤니티</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="resources/css/index.css" rel="stylesheet" type="text/css">
<link
	href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css"
	rel="stylesheet">
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script
	src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>
<link
	href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css"
	rel="stylesheet">
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>

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
		var data = '${sessionScope.member}';
		if(data =='' || data == null){
			alert("로그인 후 이용 바랍니다");
			$("#loginModal").modal('show');
		}
		else
		{
			location.href="boardcode.do";
		}
	}

</script>
</head>

<body>
	<%@ include file="/header.jsp"%>
	<div class="jumbotron jumbotron-billboard">
		<div class="img"></div>
		<div class="container">
			<h1>Hmm...!</h1>
			<p id="demo"></p>
		</div>
	</div>

	<div class="container">
		<!-- 게시판 영역 -->
		<div class="board_area">
			<!-- 검색창, 검색 정렬들의 패널 -->
			<div class="board">

				<div class="board-heading">

					<%-- 글쓰기 버튼 --%>
					<div id="writebutton">
						<button id="write" type="button" onclick="checkWrite()">글쓰기</button>
					</div>

					<%-- 검색바 --%>
					<div id="search_bar">
						<input type="text" name="search" placeholder="검색어를 입력하세요..">
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
									<th>제목</th>
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

										<td id="table_num">${num }</td>
										<c:set var="num" value="${num+1 }" />
										<td id="td_title"><a href="#"
											onclick="checkBoard(${l.bcode})">${l.title }<span
												id="reply_num">&nbsp;[${l.isdelete}]</span>
										</a></td>
										<td id="table_category">${l.code.name}</td>
										<td>
											<div class="profile">
												<a href="profile.jsp"> <img class="img-circle" src="#" />
												</a> ${l.writerid }
											</div>
										</td>
										<td id="table_point">${l.point.best*(5)+l.point.good*(3)+l.point.bad*(-3)+l.point.worst*(-5) }</td>
										<td id="table_viewcount">${l.point.viewnum }</td>
										<td id="table_date">${l.postdate }</td>
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
<%@ include file="/footer.jsp"%>
</html>

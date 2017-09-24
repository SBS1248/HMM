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
<link rel="icon" href="resources/img/신보선/신보선.jpg" type="image/gif" sizes="16x16">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="resources/css/index.css" rel="stylesheet" type="text/css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

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
		<div clas="board">

			<div class="board-heading">

				<%-- 글쓰기 버튼 --%>
				<div id="writebutton">
					<button id="write" type="button" class="btn btn-primary btn-md" onclick="location.href='boardcode.do'">글쓰기</button>
				</div>

				<%-- 검색바 --%>

					<form>
						<div class="input-group">
							<input type="text" class="form-control" size="50" placeholder="검색어를 입력하세요...">
								<%-- 검색버튼 --%>
								<div class="input-group-btn">
									<button type="button" class="btn btn-success">검색</button>
								</div>
							</div>
						</form>

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
									<th style="white-space: nowrap; text-overflow:ellipsis; overflow:hidden">제목</th>
									<th>카테고리</th>
									<th>작성자</th>
									<th>추천 점수</th>
									<th>조회수</th>
									<th>작성일자</th>
								</tr>
							</thead>
							<tbody>
								<c:set var="num" value="1"/>
								<c:forEach var="l" items="${list }">

									<tr>

										<td>${num }</td>
										<c:set var="num" value="${num+1 }"/>
										<td>
											<a onclick="viewcount(${l.bcode})" href="boardOne.do?bcode=${l.bcode}">${l.title }<span id="reply_num">&nbsp;[${l.isdelete}]</span>
											</a>
										</td>

										<td>${l.code.name}</td>
										<td>
											<div class="profile">
												<a href="profile.jsp">
													<img class="img-circle" src="#"/>
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
		</div>
</div>
	</body>
<%@ include file="/footer.jsp"%>
</html>

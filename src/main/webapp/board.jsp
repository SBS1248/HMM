<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" href="resources/img/신보선/신보선.jpg" type="image/gif" sizes="16x16">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


<link href="resources/css/board.css" rel="stylesheet" type="text/css">
<title>Hmm 게시판</title>

</head>
<body>
<%@ include file="/header.jsp"%>
<div id="writebutton">
			<button id="write" type="button" class="btn btn-primary btn-md" onclick="location.href='boardcode.do'">내
				글쓰기</button>
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
			<%-- <button onclick="location.href='boardCode.do'" style="color:white;">SSIPPAL</button> --%>
			<!-- 게시판 테이블 -->
			<div class="table-responsive">
				<table class="table table-hover table-striped">
					<thead>
						<tr>
							<th>글번호</th>
							<th class="col-md-5">제목</th>
							<th>카테고리</th>
							<th>작성자</th>
							<th>추천 점수</th>
							<th>조회수</th>
							<th>작성일자</th>
						</tr>
					</thead>

					<c:set var="num" value="1" />

					<tbody>
						<c:forEach var="l" items="${list }">

							<tr>
								<td>${num }</td>
								<c:set var="num" value="${num+1 }" />
								<td><a href="boardOne.do?bcode=${l.bcode}">${l.title }<span id="reply_num">&nbsp;[${l.isdelete}]</span></a></td>
								<td>${l.code.name}</td>
								<td>
									<div class="profile">
										<a href="profile.jsp"> <img class="img-circle"
											src="//lh3.googleusercontent.com/-6V8xOA6M7BA/AAAAAAAAAAI/AAAAAAAAAAA/rzlHcD0KYwo/photo.jpg?sz=120" /></a>
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

</html>

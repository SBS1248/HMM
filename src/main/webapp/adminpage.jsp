<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="resources/css/adminpage.css" rel="stylesheet" type="text/css">
<link rel="icon" href="resources/img/신보선/신보선.jpg" type="image/gif" sizes="16x16">
<link href="resources/css/board.css" rel="stylesheet" type="text/css">
	<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
	<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
  <script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>
  <link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
  <script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>
<title>관리자 페이지</title>
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
		<div class="board-body">
					<!-- 게시판 테이블 -->
					<div class="hmm_table">
						<table id="myTable">
							<thead>
								<tr>
									<th>성함 </th>
									<th>이메일주소</th>
									<th>내용</th>
									<th>작성일자</th>
									<th>읽음여부</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach var="s" items="${slist}">
							<tr>
							<td style="text-align: center;">${s.sername}</td>
							<td style="text-align: center;">${s.seradd}</td>
							<td style="text-align: center;">${s.sercontent}</td>
							<td style="text-align: center;">${s.yncheck }</td>
							</tr>
							</c:forEach>

							</tbody>
						</table>
					</div>
				</div>

					
</body>
</html>
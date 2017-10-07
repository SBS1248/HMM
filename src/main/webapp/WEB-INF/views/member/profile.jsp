<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="resources/css/profile.css" rel="stylesheet" type="text/css">
<title>프로필 상세보기</title>
</head>
<body>
	<%@ include file="/header.jsp"%>
	<div class="container">
		<div class="row">
			<div class="profile-header-container">
				<div class="profile-header-img">
					<c:choose>
						<c:when test="${null eq pInfo.photo}">
							<img class="img-circle" id="profileImg"
								src="resources/img/defaultImg.jpg" alt="profileImg" />
						</c:when>
						<c:when test="${null ne pInfo.photo}">
							<img class="img-circle" id="profileImg" src="${pInfo.photo}"
								alt="profileImg" />
						</c:when>
					</c:choose>
					<!-- badge -->
					<div class="rank-label-container">
						<span class="label label-default rank-label">${pInfo.id}</span>
					</div>
				</div>
			</div>
			<h2>이메일 : ${pInfo.email}</h2>
			<h2>메달갯수 : ${pInfo.havmedal}</h2>
			<h2>경험치 : ${pInfo.exp}</h2>
			<h2>신고횟수 : ${pInfo.report}</h2>
			<h2>작성한 글 갯수 : ${pInfo.boardCount}</h2>
			<h2>작성한 댓글 갯수 : ${pInfo.commentsCount}</h2>
		</div>
	</div>

</body>
</html>
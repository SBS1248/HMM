<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
			<meta name="viewport" content="width=device-width, initial-scale=1">
				<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
					<link href="resources/css/profile.css" rel="stylesheet" type="text/css">
						<title>프로필 상세보기</title>
					</head>
					<body>
						<%@ include file="/header.jsp"%>
						<div class="container">
							<div class="profile_area banner">

								<%-- 프로필 사진 공간 --%>
								<div class="profile_area profile_img">

									<c:choose>
										<c:when test="${null eq pInfo.photo}">
											<img id="profile_user_img" src="resources/img/defaultImg.jpg"/>
										</c:when>
										<c:when test="${null ne pInfo.photo}">
											<img id="profile_user_img" src="${pInfo.photo}"/>
										</c:when>
									</c:choose>

								</div>

								<h3	id="profile_id">${pInfo.id}</h3>
							</div>
							<div class="profile_area intro">
								<h3>회원 가입일 : ${pInfo.enrolldate}</h3>
								<h3>이메일 : ${pInfo.email}</h3>
								<h3>메달갯수 : ${pInfo.havmedal}</h3>
								<h3>경험치 : ${pInfo.exp}</h3>
								<h3>신고횟수 : ${pInfo.report}</h3>
								<h3>작성한 글 갯수 : ${pInfo.boardCount}</h3>
								<h3>작성한 댓글 갯수 : ${pInfo.commentsCount}</h3>
							</div>
						</div>

					</body>
				</html>

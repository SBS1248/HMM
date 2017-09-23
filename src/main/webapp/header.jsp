<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Hmm | 전 세계의 개발자들을 널리 이롭게 하리라.</title>
<meta charset="utf-8">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="resources/css/header.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Pacifico"
	rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<script type="text/javascript">
	function profileUpdate() {
		location.href = "updateProfile.do";
	}

</script>

<%@ include file="WEB-INF/views/member/login.jsp"%>
<%@ include file="WEB-INF/views/member/insertMember.jsp"%>

<body>
	<c:set var="member" value="${sessionScope.member}" />
	<c:set var="password" value="${member.password}" />
	<%
		System.out.println("헤더 페이지 세션 값 : " + session.getAttribute("member"));
	%>

	<!-- 최상단 네비게이션바와 사이드바 -->
	<div id="wrapper">
		<nav class="navbar navbar-fixed-top topnav" role="navigation">
			<div class="container-fluid">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle collapsed"
						data-toggle="collapse" data-target="#navbar" aria-expanded="false"
						aria-controls="navbar"></button>
					<div class="navbar-brand">
						<a id="menu-toggle" href="#"
							class="glyphicon glyphicon-align-justify btn-menu toggle">
						</a>
					</div>
				</div>
				<div id="navbar" class="collapse navbar-collapse">

					<ul class="nav navbar-nav">
						<!-- 홈페이지 로고 -->
<li><a id="home_logo" href="index.jsp">Hmm</a></li>
						<!-- 로그인 관련 메뉴 및 모달 -->
						<c:choose>
							<c:when test="${null eq member }">
								<ul class="nav navbar-nav">
									<li data-toggle="modal" data-target="#loginModal"><a
										style="cursor: pointer"> <span
											class="glyphicon glyphicon-log-in"></span> 로그인
									</a></li>
									<li data-toggle="modal" data-target="#insertModal"><a
										style="cursor: pointer"> <span
											class="glyphicon glyphicon-user"></span> 회원가입
									</a></li>
								</ul>
							</c:when>

							<c:when test="${null ne member }">
								<ul class="nav navbar-nav">
									<li onclick="profileUpdate();"><a href="#"> <span
											class="glyphicon glyphicon-user"> ${member.id} </span>
									</a></li>
									<li data-toggle="modal" data-target="#myModal"><a href="logout.do"> <span
											class="glyphicon glyphicon-log-in"></span> 로그아웃
									</a></li>
								</ul>
							</c:when>
						</c:choose>
					</ul>
				</div>
			</div>
		</nav>
		<!-- 사이드바 -->
		<div id="sidebar-wrapper">

			<ul class="sidebar-nav">
				<li><a href="boardLists.do?dis=4"> <span
						class="glyphicon glyphicon-comment"></span>&nbsp;&nbsp;아무말 대잔치
				</a></li>
				<li><a href="boardLists.do?dis=5"> <span
						class="glyphicon glyphicon-globe"></span>&nbsp;&nbsp;프로젝트 게시판
				</a></li>
				<li><a href="boardLists.do?dis=1"> <span
						class="glyphicon glyphicon-briefcase"></span>&nbsp;&nbsp;기업 게시판
				</a></li>
				<li><a href="boardLists.do?dis=3"> <span
						class="glyphicon glyphicon-education"></span>&nbsp;&nbsp;신기술 게시판
				</a></li>
				<li><a href="boardLists.do?dis=2"> <span
						class="glyphicon glyphicon-question-sign"></span>&nbsp;&nbsp;Q & A
				</a></li>
				<li><a href="itemLists.do"> <span
						class="glyphicon glyphicon-shopping-cart"></span>&nbsp;&nbsp; 캐쉬샵
				</a></li>

				<li><a href="#"><span class="glyphicon glyphicon-info-sign"></span>&nbsp;&nbsp;
						About Hmm</a></li>
				<li><a href="#contact"><span
						class="glyphicon glyphicon-earphone"></span>&nbsp;&nbsp; 연락처</a></li>
				<li><a href="#googleMap"><span
						class="glyphicon glyphicon-map-marker"></span>&nbsp;&nbsp; 찾아오시는 길</a>
				</li>
			</ul>

		</div>

	</div>
	<script>
		$("#menu-toggle").click(function(e) {
			e.preventDefault();
			$("#wrapper").toggleClass("active");
		});
	</script>
</body>

</html>

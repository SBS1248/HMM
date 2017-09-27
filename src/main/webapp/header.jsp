<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link rel="icon" href="resources/img/hmm.JPG" type="image/gif"
	sizes="32x16">
<link href="resources/css/header.css" rel="stylesheet" type="text/css">
<link
	href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css"
	rel="stylesheet">
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script
	src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>

<%-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> --%>
</head>
<script type="text/javascript">
	function profileUpdate() {
		location.href = "updateProfile.do";
	}

	function checkLogin() {
		var member = '${sessionScope.member}';
		if (member == '') {
			alert("로그인 후 이용해 주세요");
			$('#loginModal').modal('show');
		} else {
			location.href = "itemLists.do";
		}
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
					<button id="menu-toggle" href="#"
						class="glyphicon glyphicon-align-justify btn-menu toggle"></button>
				</div>
				<div id="navbar" class="collapse navbar-collapse">

					<ul class="nav navbar-nav">
						<!-- 홈페이지 로고 -->
						<li><button onclick="location.href='index.jsp'"
								id="home_logo">Hmm</button></li>
						<!-- 로그인 관련 메뉴 및 모달 -->
						<c:choose>
							<c:when test="${null eq member }">
								<ul class="nav navbar-nav">
									<li data-toggle="modal" data-target="#loginModal"
										id="header_login"><a style="cursor: pointer"> <span
											class="glyphicon glyphicon-log-in"></span> 로그인
									</a></li>
									<li data-toggle="modal" data-target="#insertModal"
										id="header_insert"><a style="cursor: pointer"> <span
											class="glyphicon glyphicon-user"></span> 회원가입
									</a></li>
								</ul>
							</c:when>

							<c:when test="${null ne member }">
								<ul class="nav navbar-nav">
									<li onclick="profileUpdate();"><a href="#"> <span
											class="glyphicon glyphicon-user"> ${member.id} </span>
									</a></li>
									<li data-toggle="modal" data-target="#myModal"><a
										href="logout.do"> <span class="glyphicon glyphicon-log-in"></span>
											로그아웃
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
						class="glyphicon glyphicon-globe"></span>&nbsp;&nbsp;프로젝트 & 소스
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
				<li><a onclick="checkLogin()" style="cursor:pointer"> <span
						class="glyphicon glyphicon-shopping-cart"></span>&nbsp;&nbsp; 따루샵
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

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
			<meta name="viewport" content="width=device-width, initial-scale=1">
				<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
					<link href="resources/css/newtech2.css" rel="stylesheet" type="text/css">
						<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
						<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
						<title>신기술 투표 결과</title>
						<script type="text/javascript">
							$(function () {

								$.ajax({
									type: "GET",
									url: "multiCount.do",
									success: function (data) {
										var as = eval(data);
										var sum = as[0] + as[1];
										alert("찬성수" + as[0] + "반대수" + as[1] + "찬성률" + a[0] / sum + "반대율" + a[1] / sum);

									},
									error: function (request, status, error) {
										alert("code:" + request.status + "\nmessage:" + request.responseText + "\nerror:" + error);
									}
								});

							});
						</script>
					</head>

					<body onload="move();move2();participants_num1();participants_num2();">
						<%@ include file="/header.jsp"%>

						<h1 class="title">9월 3주차 신기술 찬/반 투표<br>객체지향 프로그래밍 VS 절차지향 프로그래밍, 무엇이 더 나을까?</h1>

						<div class="container">
							<div class="chart">
								<div id="option-yes" class="the_options">
									<div class="results">
										<span class="on" id="on1"></span>
									</div>
									<h3 class="option-label">형식보다는 실용성.<br>
											객체지향 프로그래밍이 곧 미래이다.
											<span class="count" id="chart_on1"></span><br>
											<span id="head_counts1"></span>
										</h3>
									</div>
									<div class="the_vs_ball_area">
										<div class="the_vs_ball">VS</div>
									</div>
									<div id="option-no" class="the_options">
										<div class="results">
											<span class="on" id="on2"></span>
										</div>
										<h3 class="option-label">물이 위에서 아래로 흐르듯이,<br>
												순차지향 프로그래밍은 곧 자연의 이치이다.
												<span class="count" id="chart_on2"></span><br>
												<span id="head_counts2"></span>
											</h3>
										</div>

									</div>
								</div>

								<div id="participants">
									<h2>총 투표 참여자 : 200명</h2>
								</div>

								<script>
									function move() {
										var elem = document.getElementById("on1");
										var elem2 = document.getElementById("chart_on1");

										var width = 0;
										var id = setInterval(frame, 60);
										function frame() {
											if (width >= 38) {
												clearInterval(id);
											} else {
												width++;
												elem.style.width = width + '%';
												elem2.innerHTML = width * 1 + '%';
											}
										}
									}

									function participants_num1() {
										var elem = document.getElementById("head_counts1");

										var width = 0;
										var id = setInterval(frame, 30);
										function frame() {
											if (width >= 76) {
												clearInterval(id);
											} else {
												width++;
												elem.innerHTML = width * 1 + '명';
											}
										}
									}

									function move2() {
										var elem = document.getElementById("on2");
										var elem3 = document.getElementById("chart_on2");

										var width = 0;
										var id = setInterval(frame, 60);
										function frame() {
											if (width >= 62) {
												clearInterval(id);
											} else {
												width++;
												elem.style.width = width + '%';
												elem3.innerHTML = width * 1 + '%';
											}
										}
									}

									function participants_num2() {
										var elem = document.getElementById("head_counts2");

										var width = 0;
										var id = setInterval(frame, 30);
										function frame() {
											if (width >= 124) {
												clearInterval(id);
											} else {
												width++;
												elem.innerHTML = width * 1 + '명';
											}
										}
									}
								</script>
							</body>

						</html>

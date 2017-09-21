<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="resources/css/newtech2.css" rel="stylesheet" type="text/css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>신기술 투표 결과</title>
<script type="text/javascript">
		$(function(){

			$.ajax({
                type : "GET",
                url : "multiCount.do",
                success : function(data) {
                	var as=eval(data);
                	var sum=as[0]+as[1];
                	alert("찬성수"+as[0]+"반대수"+as[1]+"찬성률"+a[0]/sum+"반대율"+a[1]/sum);

                },
                error:function(request,status,error){
                    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                   }
        	});

		});
	</script>
</head>

<body onload="move();move2();">
	<%@ include file="/header.jsp"%>

	<h1 class="title">자바는 한물갔다?!</h1>


	<div class="chart">
		<div id="option-1" class="option">
			<div class="results">
				<div class="on" id="on1"></div>
			</div>
      <h3 class="option-label">한물가지 않았다! 니들이 활용 못할 뿐.
        <span class="count">38% <span class="head_counts">38명</span></span>
      </h3>
		</div>
		<div class="between">VS</div>
		<div id="option-2" class="option">
			<div class="results">
				<div class="on" id="on2"></div>
			</div>
      <h3 class="option-label">한물갔다! 발벌이 하고 싶으면 파이썬이나 배우자.
        <span class="count">62% <span class="head_counts">62명</span></span>
      </h3>
		</div>
	</div>


	<%-- <div class="chart">
  <div id="option-1" class="option">
    <div class="results">
      <div class="on" style="width: 38%;"></div>
    </div>
    <h3 class="option-label">한물가지 않았다! 니들이 활용 못할 뿐.
      <span class="count">38% <span class="head_counts">38명</span></span>
    </h3>
  </div>
  <div class="between">VS</div>
  <div id="option-2" class="option">
    <div class="results">
      <div class="on" style="width: 62%;"></div>
    </div>
    <h3 class="option-label">한물갔다! 발벌이 하고 싶으면 파이썬이나 배우자.
      <span class="count">62% <span class="head_counts">62명</span></span>
    </h3>
  </div>
</div> --%>
	<div id="participants">총 투표 참여자 : 100명</div>

	<script>

function move() {
  var elem = document.getElementById("on1");
  var width = 0;
  var id = setInterval(frame, 30);
  function frame() {
    if (width >= 38) {
      clearInterval(id);
    } else {
      width++;
      elem.style.width = width + '%';
      elem.innerHTML = width * 1  + '%';
    }
  }
}

function move2() {
  var elem = document.getElementById("on2");
  var width = 0;
  var id = setInterval(frame, 30);
  function frame() {
    if (width >= 62) {
      clearInterval(id);
    } else {
      width++;
      elem.style.width = width + '%';
      elem.innerHTML = width * 1  + '%';
    }
  }
}


</script>
</body>

</body>
</html>

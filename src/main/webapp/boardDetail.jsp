<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" href="resources/img/신보선/신보선.jpg" type="image/gif"
	sizes="16x16">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link href="resources/css/boardDetail.css" rel="stylesheet"
	type="text/css">
<script type="text/javascript">
	$(function(){
		$.ajax({
            type : "POST",
            url : "leveling.do?exp=${writer.exp}",
            success : function(data) {

            	$('#lev').val(data.level);
            	$('#per').val(data.percent);
            },
            error:function(request,status,error){
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
               }
    	});

		$('.post_rate_btns').click(function(){

			if(${member.membercode}==${writer.membercode})
			{
				alert("본인의 글은 공감할 수 없습니다.");
				return;
			}

			var recom="";
			var message="";
			var point;
			var pan;
			var btnName=$(this).attr('id');

			if(btnName=='bBest')
			{
				recom='best';
				message='Best';
				point=5;
			}
			else if(btnName=='bGood')
			{
				recom='good';
				message='Good';
				point=3;
			}
			else if(btnName=='bBad')
			{
				recom='bad';
				message='Bad';
				point=3;
			}
			else
			{
				recom='worst';
				message='Worst';
				point=5;
			}

			pan=$('#b'+recom);

			$.ajax({
	            type : "POST",
	            url : "recompoint.do?id=${member.id}",
	            success : function(data) {
	            	alert("현재 포인트는 "+ data+" 입니다.");
	            	if(point>data)
	            	{
	            		alert("포인트 부족으로 "+message+" 공감할 수 없습니다.");
	            	}
	            	else
	            	{
	            		$.ajax({
	    		            type : "GET",
	    		            url : "recommendation.do?recom="+recom+"&bcode=${board.bcode}",
	    		            success : function(data) {
	    		            	alert("게시글에 "+message+" 공감하셨습니다.\n현재 남은 포인트는 "+ data.point+" 입니다.");

	    		            	pan.text(data.recom);
	    		            	$('#bcal').text(data.cal);

	    		            },
	    		            error:function(request,status,error){
	    		                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	    		               }
	    		    	});
	            	}
	            },
	            error:function(request,status,error){
	                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	               }

	    	});
		});

		$('#bMedal').click(function(){
			$.ajax({
	            type : "POST",
	            url : "havmedal.do?membercode=${member.membercode}",
	            success : function(data) {
	            	alert("현재 보유 메달은 "+ data+"개 입니다.");
	            	if(data<1)
	            	{
	            		alert("메달이 부족합니다. 메달을 구매해주세요.");
	            	}
	            	else
	            	{
	            		$.ajax({
	    		            type : "GET",
	    		            url : "bmedal.do?bcode=${board.bcode}&membercode=${member.membercode}",
	    		            success : function(data) {
	    		            	alert("게시글에 메달을 달아주었습니다.");

	    		            	$('#bmedal').text(data);
												$('#pmdiv').css("display","block");

	    		            },
	    		            error:function(request,status,error){
	    		                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	    		               }
	    		    	});
	            	}
	            },
	            error:function(request,status,error){
	                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	               }
	    	});
		});

		$('#report_post').click(function(){
			$.ajax({
	            type : "POST",
	            url : "isbreport.do?bcode=${board.bcode}",
	            success : function(data) {
	            	if(data==0)
	            	{
	            		$.ajax({
	    		            type : "GET",
	    		            url : "breport.do?bcode=${board.bcode}",
	    		            success : function(data) {
	    		            	alert("게시글을 신고하셨습니다.");
	    		            },
	    		            error:function(request,status,error){
	    		                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	    		               }
	    		    	});
	            	}
	            	else
	            		alert("이미 신고하셨습니다.");
	            },
	            error:function(request,status,error){
	                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	               }
	    	});

		});

	});

	function crecommendation(ccode,flag)
	{
		var recom;
		var pan;
		var message;

		if(flag=='g')
		{
			recom="good";
			pan=$('#g'+ccode);
			message="Good";
		}
		else
		{
			recom="bad";
			pan=$('#b'+ccode);
			message="Bad";
		}

		$.ajax({
            type : "POST",
            url : "recompoint.do?id=${member.id}",
            success : function(data) {
            	alert("현재 포인트는 "+ data+" 입니다.");
            	if(data<3)
            	{
            		alert("포인트 부족으로 "+message+" 공감할 수 없습니다.");
            	}
            	else
            	{
            		$.ajax({
    		            type : "GET",
    		            url : "crecommendation.do?recom="+recom+"&ccode="+ccode,
    		            success : function(data) {
    		            	alert("댓글에 "+message+" 공감하셨습니다.\n현재 남은 포인트는 "+ data.point+" 입니다.");

    		            	pan.text(data.recom);
    		            	$('#c'+ccode).text(data.cal);
    		            },
    		            error:function(request,status,error){
    		                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
    		               }
    		    	});
            	}
            },
            error:function(request,status,error){
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
               }
    	});

	}

	function cmedal(ccode)
	{
		$.ajax({
            type : "POST",
            url : "havmedal.do?membercode=${member.membercode}",
            success : function(data) {
            	alert("현재 보유 메달은 "+ data+"개 입니다.");
            	if(data<1)
            	{
            		alert("메달이 부족합니다. 메달을 구매해주세요.");
            	}
            	else
            	{
            		$.ajax({
    		            type : "GET",
    		            url : "cmedal.do?ccode="+ccode+"&membercode=${member.membercode}",
    		            success : function(data) {
    		            	alert("댓글에 메달을 달아주었습니다.");

    		            	$('#m'+ccode).text(data);
    		            	$('#mdiv'+ccode).css("display","block");
    		            },
    		            error:function(request,status,error){
    		                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
    		               }
    		    	});
            	}
            },
            error:function(request,status,error){
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
               }
    	});

	}

	function creport(ccode)
	{

		$.ajax({
            type : "POST",
            url : "iscreport.do?ccode="+ccode,
            success : function(data) {
            	if(data==0)
            	{
            		$.ajax({
    		            type : "GET",
    		            url : "creport.do?ccode="+ccode,
    		            success : function(data) {
    		            	alert("댓글을 신고하셨습니다.");
    		            },
    		            error:function(request,status,error){
    		                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
    		               }
    		    	});
            	}
            	else
            		alert("이미 신고하셨습니다.");
            },
            error:function(request,status,error){
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
               }
    	});



	}
</script>
<title>Hmm 게시판</title>
</head>
<body>
	<%@ include file="/header.jsp"%>

	<!-- 게시글 상세보기 -->
	<div class="boardDetail_area">

		<%-- 제목 및 상단 정보	--%>
		<div class="boardDetail">
			<div class="boardDetail-header">
				<div class="boardDetail_title">
					<h2>${board.title}&nbsp;&nbsp;&nbsp;<span id="posted_from">${board.code.name }게시판</span>
					</h2>
				</div>
				<br>
				<div class="boardDetail_author">
					작성자 : ${writer.id} &nbsp;&nbsp;&nbsp; 레벨 : <input disabled id="lev" />
					&nbsp;&nbsp;&nbsp; 경험치 : ${writer.exp}점 &nbsp;&nbsp;&nbsp;&nbsp;
					경험치 진행도 : <input disabled id="per" />%
				</div>
				<br>
				<div class="boardDetail_date">
					<button type="button" id="bMedal">메달 주기!</button>
					<%-- 메달 갯수가 1 이상일때만 노출, 아니면 display : none --%>

					&nbsp;&nbsp;&nbsp;

					<c:if test="${board.point.medal ne 0}">
						<span class="current_medal_number">
							게시글 메달 갯수 :<span id="bmedal"> ${board.point.medal}</span>
						</span>
					</c:if>

					<c:if test="${board.point.medal eq 0}">
						<span class="current_medal_number" id="pmdiv" style="display: none;">
							게시글 메달 갯수 :<span id="bmedal"> ${board.point.medal}</span>
						</span>
					</c:if>


					<span id="board_postdate">작성일 : ${board.postdate}</span>
					<button id="report_post"><span class="glyphicon glyphicon-alert"></span>&nbsp;&nbsp;게시글 신고하기</button><br>

				</div>
				<br>
				<%-- 파일? --%>
				<c:if test="${files ne null}">
					<c:set var="num" value="1" />
					<c:forEach var="f" items="${files}">
								file${num } : name = ${f.originname }, filelink=${f.filelink }<br>
						<c:set var="num" value="${num+1 }" />
					</c:forEach>
				</c:if>
			</div>

			<div class="boardDetail-contents">${board.content}</div>


<hr>
			<div class="boardDetail-footer">
				<button type="button" class="post_rate_btns" id="bBest">최고다!</button>
				&nbsp;&nbsp;<span id="bbest">${board.point.best}</span> 개&nbsp;&nbsp;&nbsp;&nbsp;

				<button type="button" class="post_rate_btns" id="bGood">좋아요 :)</button>
				&nbsp;&nbsp;<span id="bgood">${board.point.good}</span> 개&nbsp;&nbsp;&nbsp;&nbsp;


				<button type="button" class="post_rate_btns" id="bBad">안 좋아요 :(</button>
				&nbsp;&nbsp;<span id="bbad">${board.point.bad}</span> 개&nbsp;&nbsp;&nbsp;&nbsp;


				<button type="button" class="post_rate_btns" id="bWorst">최악이다!</button>
				&nbsp;&nbsp;<span id="bworst">${board.point.worst}</span> 개&nbsp;&nbsp;&nbsp;&nbsp; <br> <br>
				게시글 점수 합계 : <span id="bcal">${board.point.cal}</span><br>
			</div>
			</div>
			<%-- 댓글 공간 --%>
			<div class="comment_section">
				<c:if test="${comments ne null}">
					<c:set var="num" value="1" />

					<c:forEach var="c" items="${comments}">

						<div class="comments">
							<div class="comments-heading">
								<span id="reply_number">${num }번째 댓글</span>

								<%-- 댓글 메달 파트. 메달이 1개 이상일 때만 갯수 노출 --%>
								<c:if test="${c.point.medal ne 0}">
									<span class="current_medal_number">
										<i id="the_medal" class="fa fa-star-o" aria-hidden="true"></i> x <span id="m${c.ccode}">${c.point.medal } </span>
									</span>
								</c:if>

								<c:if test="${c.point.medal eq 0}">
									<span class="current_medal_number" id="mdiv${c.ccode }" style="display: none;">
										<i id="the_medal" class="fa fa-star-o" aria-hidden="true"></i> x <span id="m${c.ccode}">${c.point.medal } </span>
									</span>
								</c:if>

								<span	id="give_medal" onclick="cmedal(${c.ccode},'cm')">메달 주기</span>

								<div class="comment_authordate">
									<span>작성자 : ${c.writerid }</span> &nbsp;&nbsp;&nbsp;&nbsp; 작성일
									: ${c.postdate}
								</div>
							</div>

							<div class="comments-body">${c.content }</div>
							<div class="comments-footer">
                <div class="comment_point">댓글 점수 : <span id="c${c.ccode}">${c.point.cal }</span></div>
								<div class="comment_rate">
									<button id="report_comment" onclick="creport(${c.ccode})">
										<span class="glyphicon glyphicon-alert"></span>&nbsp;&nbsp;댓글
										신고하기
									</button>
									공감 : <span id="g${c.ccode}">${c.point.good }</span>&nbsp;
									<button type="button" class="comment_rate_btn" id="btn_good"
										onclick="crecommendation(${c.ccode},'g')">
										<i class="fa fa-thumbs-o-up" aria-hidden="true"></i> YES!
									</button>
									&nbsp; 비공감 : <span id="b${c.ccode}">${c.point.bad }</span>&nbsp;
									<button type="button" class="comment_rate_btn" id="btn_bad"
										onclick="crecommendation(${c.ccode},'b')">
										<i class="fa fa-thumbs-o-down" aria-hidden="true"></i> NO!
									</button>
								</div>
							</div>
						</div>

						<c:set var="num" value="${num+1 }" />

					</c:forEach>

				</c:if>
			</div>

		</div>
	</div>

</body>

</html>

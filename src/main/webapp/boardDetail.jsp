<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<jsp:useBean id="today" class="java.util.Date" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link href="resources/css/boardDetail.css" rel="stylesheet"	type="text/css">
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

			if('${member.membercode}'=='${writer.membercode}')
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
			if('${member.membercode}'=='${writer.membercode}')
			{
				alert("본인의 글에 메달을 부여할 수 없습니다.");
				return;
			}

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
			if('${member.membercode}'=='${writer.membercode}')
			{
				alert("본인의 글을 신고할 수 없습니다.");
				return;
			}

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

		$('#bedit').click(function(){
			if('${member.id}'=='${writer.id}')
			{
				location.href="beforedit.do?bcode=${board.bcode}";
			}
			else
			{
				alert("본인이 작성한 게시글이 아닙니다.");
				return;
			}
		});
	});

	function crecommendation(ccode,flag,mid)
	{
		if('${member.id}'==mid)
		{
			alert("본인의 댓글은 추천할 수 없습니다.");
			return;
		}

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

	function cmedal(ccode,mid)
	{
		if('${member.id}'==mid)
		{
			alert("본인의 댓글에 메달을 부여할 수 없습니다.");
			return;
		}

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

	function creport(ccode,mid)
	{
		if('${member.id}'==mid)
		{
			alert("본인의 댓글을 신고할 수 없습니다.");
			return;
		}

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

	function writeComment()
	{
		if($('#newComment').length>0)
		{
			alert("작성중인 댓글이 있습니다.");
			return;
		}
		if($('#newRecomments').length>0)
		{
			alert("작성 중인 대댓글이 있습니다.");
			return;
		}
		var now = new Date();
		var date=now.getFullYear()+"-"+(now.getMonth()+1)+"-"+now.getDate()+" "+now.getHours()+":"+now.getMinutes()+":"+now.getSeconds();

		$('#commentsAdd').append("<div class='comments' id='newComments'>"+
					"<div class='comments-heading'>"+
					"<span id='reply_number' class='commentNumber'>댓글</span>"+
					"<span id='comment_writer'>작성자 : ${member.id }</span> <span id='comment_date'> 작성일 : "+date+"</span>"+
					"</div>"+
					"<div class='comments-body'>"+
					"<textArea id='newCArea'></textArea>"+
					"<button id='post_comment' onclick='newCButton()'>댓글 작성하기</button>"+
					"</div>"+
					"</div>");

		 $("body").animate({	scrollTop: $('#newComments').offset().top}, 500);
		 $('#newCArea').focus();
	}


// 새로 댓글 작성시
	function newCButton()
	{
		$.ajax({
            type : "POST",
            url : "writeComment.do",
            data:{"bcode":'${board.bcode}',"content":$('#newCArea').val(),"writerid":'${member.id}'},
            success : function(commentData) {
            	$('#newComments').replaceWith(
            			"<div class='comments' id='pa"+commentData.ccode+"'>"+
            			"<div class='comments-heading'>"+
            			"<span id='comment_writer'>작성자!!! : "+commentData.writerid+"</span>"+
						"<span id='report_comment' onclick='creport("+commentData.ccode+",\""+commentData.writerid+"\")'><span class='glyphicon glyphicon-alert'></span>&nbsp;&nbsp;댓글신고하기123123</span>"+
						"<span id='comment_date'>작성일!!! : "+commentData.postdate+"</span>"+
						"</div>"+
            			"<div class='comments-body'>"+commentData.content+"</div>"+
            			"<div class='comments-footer'>"+
						"<div class='comment_edit_add'>"+
						"<button onclick=beforeCEdit("+commentData.ccode+")>수정하기</button>"+
						"<button id=\"wcomment"+commentData.ccode+"\" onclick=\"wcomment("+commentData.ccode+")\">대댓글 달기</button>"+
						"</div>"+
            			"<div class='comment_rate'>"+
						"<button id='give_medal' onclick='cmedal("+commentData.ccode+",\""+commentData.writerid+"\")'>메달 주기</button>"+
            			"공감 : <span id='g"+commentData.ccode+"'>"+commentData.point.good+"</span>&nbsp;"+
            			"<button type='button' class='comment_rate_btn' id='btn_good'onclick='crecommendation("+commentData.ccode+",\"g\",\""+commentData.writerid+"\")'><i class='fa fa-thumbs-o-up' aria-hidden='true'></i> YES!</button>"+
            			"&nbsp; 비공감 : <span id='b"+commentData.ccode+"'>"+commentData.point.bad+"</span>&nbsp;"+
            			"<button type='button' class='comment_rate_btn' id='btn_bad'	onclick='crecommendation("+commentData.ccode+",\"b\",\""+commentData.writerid+"\")'><i class='fa fa-thumbs-o-down' aria-hidden='true'></i> NO!</button>"+
						"댓글 점수 : <span id='c"+commentData.ccode+"'>"+commentData.point.cal+"</span>"+
            			"</div></div></div>"
            	);
            },
            error:function(request,status,error){
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
               }
    	});
	}

	function wcomment(code)
	{
		if($('#newComment').length>0)
		{
			alert("작성중인 댓글이 있습니다.");
			return;
		}
		if($('#newRecomments').length>0)
		{
			alert("작성 중인 대댓글이 있습니다.");
			return;
		}

		var now = new Date();
		var date=now.getFullYear()+"-"+(now.getMonth()+1)+"-"+now.getDate()+" "+now.getHours()+":"+now.getMinutes()+":"+now.getSeconds();
		var parentComment=$('#wcomment'+code).parents('div[class=comments]');//자신 바로 위의 댓글이나 대댓글을 찾는다.

		while(parentComment.next().attr('class')!='comments')
		{//자신 바로 위의 댓글이나 대댓글을 찾는다.
			if(parentComment.next().length<=0) break;
			parentComment=parentComment.next();
		}

		parentComment.after("<div class=recomments id='newRecomments'>"+
			"<div class='comments-heading'>"+
			"<span id='reply_number' class='commentNumber'>대댓글</span>"+
			"<span id='comment_writer'>작성자 : ${member.id }</span> <span id='comment_date'>작성일 : "+date+
			"</span></div>"+
			"<div class='comments-body'>"+
			"<textArea id='newCArea'></textArea>"+
			"<button onclick='newUCButton("+code+")'>대댓글 작성하기</button>"+
			"</div>"+
		"</div>");

		$("body").animate({	scrollTop: $('#newCArea').offset().top-200}, 500);
		$('#newCArea').focus();
	}

	function newUCButton(code)
	{
		$.ajax({
            type : "POST",
            url : "writeUComment.do",
            data:{"bcode":'${board.bcode}',"content":$('#newCArea').val(),"writerid":'${member.id}',"upper":code},
            success : function(commentData) {
            	$('#newRecomments').replaceWith(
            			"<div class='recomments' id='pa"+commentData.ccode+"'>"+
            			"<div class='comments-heading'>"+
            			"<span id='reply_number' class='commentNumber'>대댓글</span>" +
            			"<span id='comment_writer'>작성자123 : "+commentData.writerid+"</span><span id='comment_date'>작성일123 : "+commentData.postdate+"</span>"+
						"<span id='report_comment' onclick='creport("+commentData.ccode+",\""+commentData.writerid+"\")'><span class='glyphicon glyphicon-alert'></span>&nbsp;&nbsp;댓글신고하기</span>"+
						"</div>"+
            			"<div class='comments-body'>"+commentData.content+"</div>"+
            			"<div class='comments-footer'>"+
						"<button onclick=beforeCEdit("+commentData.ccode+")>수정하기</button>"+
						"<div class='comment_rate'>"+
						"<span id='give_medal' onclick='cmedal("+commentData.ccode+",\""+commentData.writerid+"\")'>메달 주기</span>"+
						"공감 : <span id='g"+commentData.ccode+"'>"+commentData.point.good+"</span>&nbsp;"+
            			"<button type='button' class='comment_rate_btn' id='btn_good'onclick='crecommendation("+commentData.ccode+",\"g\",\""+commentData.writerid+"\")'><i class='fa fa-thumbs-o-up' aria-hidden='true'></i> YES!</button>"+
            			"&nbsp; 비공감 : <span id='b"+commentData.ccode+"'>"+commentData.point.bad+"</span>&nbsp;"+
            			"<button type='button' class='comment_rate_btn' id='btn_bad'	onclick='crecommendation("+commentData.ccode+",\"b\",\""+commentData.writerid+"\")'><i class='fa fa-thumbs-o-down' aria-hidden='true'></i> NO!</button>"+
									"<span id='comment_point'>댓글 점수123 : <span id='c"+commentData.ccode+"'>"+commentData.point.cal+"</span></span>"+
            			"</div></div></div>"
            	);
            },
            error:function(request,status,error){
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
               }
    	});
	}

	function beforeCEdit(ccode,text)
	{//대댓글 전수정
		if($('#editRecomments').length>0)
		{
			alert('수정 중인 댓글이 있습니다.');
			return;
		}
		$.ajax({
            type : "POST",
            url : "beforeCEdit.do?ccode="+ccode,
            success : function(commentData) {

            	if('${member.id}'!=commentData.writerid)
            	{
            		if(commentData.lev==2)alert("본인이 작성하지 않은 대댓글은 수정할 수 없습니다.");
            		else alert("본인이 작성하지 않은 댓글은 수정할 수 없습니다.");

            		return;
            	}

            	var flag='comments';
            	if(commentData.lev==2) flag="recomments";

            	$('#pa'+ccode).replaceWith(
            		"<div class="+flag+" id='editRecomments'>"+
            		"<div class='comments-heading'>"+
            		"<span>작성자 : "+commentData.writerid+"</span> 작성일 : "+commentData.postdate+
            		"</div>"+
            		"<div class='comments-body'>"+
            		"<textArea id='newCArea'>"+commentData.content+"</textArea>"+
            		"<button onclick=\"afterCEdit("+ccode+",\'"+text+"\')\">댓글 수정하기</button>"+
            		"<button onclick=\"deleteComment("+ccode+",\'"+text+"\')\">댓글 삭제하기</button>"+
            		"</div>"+
            		"</div>"
            	);
            },
            error:function(request,status,error){
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
               }
    	});
	}

	function afterCEdit(ccode,text)
	{//대댓글 후수정
		$.ajax({
            type : "POST",
            url : "afterCEdit.do",
            data:{"ccode":ccode,"content":$('#newCArea').val()},
            success : function(commentData) {
            	var flag='comments';
                if(commentData.lev==2) flag="recomments";

                var reC="<button id=\"wcomment"+commentData.ccode+"\" onclick=\"wcomment("+commentData.ccode+")\">대댓글 달기</button>";
                if(commentData.lev==2) reC="";

                $('#editRecomments').replaceWith(
            		"<div class="+flag+" id='pa"+commentData.ccode+"'>"+
            		"<div class='comments-heading'>"+
					"<button id='report_comment' onclick='creport("+commentData.ccode+",\""+commentData.writerid+"\")'><span class='glyphicon glyphicon-alert'></span>&nbsp;&nbsp;대댓글신고하기</button>"+
					"<span id='comment_date'>작성일 : "+commentData.postdate+"</span>"+
					"<span id='comment_writer'>작성자 : "+commentData.writerid+"</span>"+
					"</div>"+
            		"<div class='comments-body'>"+commentData.content+"</div>"+
            		"<div class='comments-footer'>"+
					"<button onclick=beforeCEdit("+commentData.ccode+")>대댓글 수정하기</button>"+
					reC+
            		"<div class='comment_rate'>"+
					"<span id='give_medal' onclick='cmedal("+commentData.ccode+",\""+commentData.writerid+"\")'>메달 주기</span>"+
            		"공감 : <span id='g"+commentData.ccode+"'>"+commentData.point.good+"</span>&nbsp;"+
            		"<button type='button' class='comment_rate_btn' id='btn_good'onclick='crecommendation("+commentData.ccode+",\"g\",\""+commentData.writerid+"\")'><i class='fa fa-thumbs-o-up' aria-hidden='true'></i> YES!</button>"+
            		"&nbsp; 비공감 : <span id='b"+commentData.ccode+"'>"+commentData.point.bad+"</span>&nbsp;"+
            		"<button type='button' class='comment_rate_btn' id='btn_bad'	onclick='crecommendation("+commentData.ccode+",\"b\",\""+commentData.writerid+"\")'><i class='fa fa-thumbs-o-down' aria-hidden='true'></i> NO!</button>"+
					"댓글 점수 : <span id='c"+commentData.ccode+"'>"+commentData.point.cal+"</span>"+
            		"</div></div></div>"
            	);
            },
            error:function(request,status,error){
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
               }
    	});
	}

	function deleteComment(ccode,text)
	{
		$.ajax({
            type : "GET",
            url : "deleteComment.do?ccode="+ccode,
            success : function(commentData) {
            	alert("댓글이 삭제 처리되었습니다.");

            	var flag='comments';
                if(commentData.lev==2) flag="recomments";

                var reC="<button disabled><strike>대댓글 달기</strike></button>";
                if(commentData.lev==2) reC="";

            	$('#editRecomments').replaceWith(
                		"<div class="+flag+" id='pa"+commentData.ccode+"'>"+
                		"<div class='comments-heading'>"+
                		"<div id='reply_num_and_give_medal_area'>"+
                		"<span id='give_medal'><strike>메달 주기</strike></span>"+
                		"</div>"+
                		"<div class='comment_authordate'><span>작성자 : "+commentData.writerid+"</span> 작성일 : "+commentData.postdate+"</div>"+
                		"<button disabled><strike>수정하기</strike></button>"+
                		reC+
                		"</div>"+
                		"<div class='comments-body'>"+commentData.content+"</div>"+
                		"<div class='comments-footer'>"+
                		"<div class='comment_rate'>"+
                		"공감 : <span id='g"+commentData.ccode+"'>"+commentData.point.good+"</span>&nbsp;"+
                		"<button type='button' class='comment_rate_btn' id='btn_good' disabled><i class='fa fa-thumbs-o-up' aria-hidden='true'></i><strike> YES!</strike></button>"+
                		"&nbsp; 비공감 : <span id='b"+commentData.ccode+"'>"+commentData.point.bad+"</span>&nbsp;"+
                		"<button type='button' class='comment_rate_btn' id='btn_bad' disabled><i class='fa fa-thumbs-o-down' aria-hidden='true'></i><strike> NO!</strike></button>"+
										"<div class='comment_point'>	댓글 점수 : <span id='c"+commentData.ccode+"'>"+commentData.point.cal+"</span></div>"+
                		"</div></div></div>"
                	);
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

<div class="container">

	<!-- 게시글 상세보기 -->
	<div class="boardDetail_area">

		<%-- 제목 및 상단 정보	--%>
		<div class="boardDetail">
			<div class="boardDetail-header">
				<div class="boardDetail_title">
					<h2>${board.title}&nbsp;&nbsp;&nbsp;<a id="posted_from" href="boardLists.do?dis=${board.distinguish}"><span>${board.code.name } 게시판</span></a>
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
							<span class="glyphicon glyphicon-certificate"></span> x <span id="bmedal"> ${board.point.medal}</span>
						</span>
					</c:if>

					<c:if test="${board.point.medal eq 0}">
						<span class="current_medal_number" id="pmdiv">
							게시글 메달 갯수 :<span id="bmedal"> ${board.point.medal}</span>
						</span>
					</c:if>

					<span id="board_postdate">작성일 : ${board.postdate}</span>

					<span id="board_viewcount">조회수 : ${board.point.viewnum }</span>
				</div>
				<br>
				<%-- 파일 --%>
				<c:if test="${files ne null}">
					<c:set var="num" value="1" />
					<c:forEach var="f" items="${files}">
								file${num } : <a href="filedown.do?atcode=${f.atcode }">${f.originname }</a><br>
						<c:set var="num" value="${num+1 }" />
					</c:forEach>
				</c:if>
			</div>

			<div class="boardDetail-contents">
				<div id="boardDetail-content">${board.content}</div>
			</div>

			<button id="bedit">수정하기</button>
			<button id="post_comment" onclick="writeComment()">댓글달기</button>
			<button id="report_post"><span class="glyphicon glyphicon-alert"></span>&nbsp;&nbsp;게시글 신고하기</button>

<hr>
			<div class="boardDetail-footer">
				<button type="button" class="post_rate_btns" id="bBest">최고다!</button>
				&nbsp;&nbsp;<span id="bbest">${board.point.best}</span> 개&nbsp;&nbsp;&nbsp;&nbsp;

				<button type="button" class="post_rate_btns" id="bGood">좋아요 :)</button>
				&nbsp;&nbsp;<span id="bgood">${board.point.good}</span> 개&nbsp;&nbsp;&nbsp;&nbsp;


				<button type="button" class="post_rate_btns" id="bBad">안 좋아요 :(</button>
				&nbsp;&nbsp;<span id="bbad">${board.point.bad}</span> 개&nbsp;&nbsp;&nbsp;&nbsp;


				<button type="button" class="post_rate_btns" id="bWorst">최악이다!</button>
				&nbsp;&nbsp;<span id="bworst">${board.point.worst}</span> 개&nbsp;&nbsp;&nbsp;&nbsp;
				<span id="post_score_total">게시글 점수 합계 : <span id="bcal">${board.point.cal}</span></span>
			</div>

			</div>

		<!-- 댓글 파트 -->
			<div class="comment_section" id="commentsAdd">
				<fmt:formatDate value="${today}" pattern="yyyy-MM-dd" var="toDay"/>
				
				<c:if test="${comments ne null}">

					<c:forEach var="c" items="${comments}">

					<c:set var="postdate" value="${fn:substring(c.postdate,0,10) }"/>
					<c:set var="tpostdate" value="${fn:substring(c.postdate,10,19) }"/>

					<c:if test="${c.lev eq 1}">
						<c:set var="classLev" value="comments"/>
					</c:if>

					<c:if test="${c.lev eq 2}">
						<c:set var="classLev" value="recomments"/>
					</c:if>
<%-- ---------------------------------------------- --%>
					<c:if test="${c.isdelete eq 'y' }">

						<div class='${classLev }' id='pa${c.ccode }'>
                			<div class='comments-heading'>
                				<div id='reply_num_and_give_medal_area'>
                					<c:if test="${c.lev eq 1}">
										<span id="reply_number" class="commentNumber"></span>
									</c:if>

									<c:if test="${c.lev eq 2}">
										<span id="reply_number" class="commentNumber">대댓글</span>
									</c:if>

                					<span id='give_medal'><strike>메달 주기</strike></span>
									<span id="comment_writer">작성자 : ${c.writerid}</span>
                				</div>
                				
                				<div class='comment_authordate'>
                					<span id="comment_date">작성일 : ${c.postdate }</span>
                				</div>
                				
                				
                				
                				
                				
                				
                				<button disabled><strike>수정하기</strike></button>
                				<c:if test="${c.lev ne 2}">
										<button disabled><strike>대댓글 달기</strike></button>
								</c:if>
                			</div>
                			<div class='comments-body'>${c.content }</div>
                			<div class='comments-footer'>
                				<div class='comment_point'>	댓글 점수 : <span id='ccommentData.ccode'>${c.point.cal }</span></div>
                				<div class='comment_rate'>
                					<button id='report_comment' disabled><span class='glyphicon glyphicon-alert'></span>&nbsp;&nbsp;<strike>댓글신고하기</strike></button>
                					공감 : <span id='gcommentData.ccode'>${c.point.good }</span>&nbsp;
                					<button type='button' class='comment_rate_btn' id='btn_good' disabled><i class='fa fa-thumbs-o-up' aria-hidden='true'></i><strike> YES!</strike></button>
                					&nbsp; 비공감 : <span id='bcommentData.ccode'>${c.point.bad }</span>&nbsp;
                					<button type='button' class='comment_rate_btn' id='btn_bad' disabled><i class='fa fa-thumbs-o-down' aria-hidden='true'></i><strike> NO!</strike></button>
                				</div>
                			</div>
                		</div>
					</c:if>
<%-- ---------------------------------------------- --%>
					<c:if test="${c.isdelete ne 'y' }">
						<div class='${classLev }'  id="pa${c.ccode }">
						<div class="comments-heading">

							<span id="comment_writer">작성자zxc : <a href="profile.do?profileId=${c.writerid }">${c.writerid }</a></span>

								<c:if test="${c.lev eq 1}">
									<span id="reply_number" class="commentNumber"></span>
								</c:if>

								<c:if test="${c.lev eq 2}">
									<span id="reply_number" class="commentNumber">대댓글</span>
								</c:if>

								<%-- 댓글 메달 파트. 메달이 1개 이상일 때만 갯수 노출 --%>
								<c:if test="${c.point.medal eq 0}">
										<script>
											$('.current_medal_number').css('display','none');
										</script>
								</c:if>

								<div class="current_medal_number" id="mdiv${c.ccode }" style="display:none;">
										<span id="m${c.ccode}">${c.point.medal } </span>
									</div>

								<button id="report_comment"	onclick="creport(${c.ccode},'${c.writerid }')">
									<span class="glyphicon glyphicon-alert"></span>&nbsp;&nbsp;댓글	신고하기</button>
										
								
								<span id="comment_date">작성일 : ${c.postdate}</span>
								



						</div>

						<div class="comments-body">${c.content }<br></div>
						<div class="comments-footer">

							<div class="comment_edit_add">
								<button id="comment_edit" onclick="beforeCEdit(${c.ccode })">수정하기</button>
								<c:if test="${c.lev ne 2}">
									<button id="wcomment${c.ccode }" onclick="wcomment(${c.ccode})">대댓글 달기</button>
								</c:if>
							</div>
							<div class="comment_rate">
								<span id="give_medal" onclick="cmedal(${c.ccode},'${c.writerid }')">메달 주기</span>
									공감 : <span id="g${c.ccode}">${c.point.good }</span>&nbsp;
									<button type="button" class="comment_rate_btn" id="btn_good"
										onclick="crecommendation(${c.ccode},'g','${c.writerid }')">
										<i class="fa fa-thumbs-o-up" aria-hidden="true"></i> YES!
									</button>
									&nbsp; 비공감 : <span id="b${c.ccode}">${c.point.bad }</span>&nbsp;
									<button type="button" class="comment_rate_btn" id="btn_bad"
										onclick="crecommendation(${c.ccode},'b','${c.writerid }')">
										<i class="fa fa-thumbs-o-down" aria-hidden="true"></i> NO!
									</button>
									<span id="comment_point">
									댓글 점수 : <span id="c${c.ccode}">${c.point.cal }</span>
									</span>
							</div>
						</div>

					</div>
					</c:if>

				</c:forEach>

				</c:if>

			</div>

		</div>

	</div>
</body>

</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
			alert("작성중인 댓글이 있습니다.개새야");
			return;
		}
		var now = new Date();
		var date=now.getFullYear()+"-"+(now.getMonth()+1)+"-"+now.getDate();
		var comment=$('.commentNumber').last();
		var num=1;

		if(comment.length>0)
		{
			num=parseInt(comment.text().slice(0,-5))+1;
		}

		$('#commentsAdd').append("<div class='comments' id='newComments'>"+
					"<div class='comments-heading'>"+
						"<div id='reply_num_and_give_medal_area'>"+
							"<span id='reply_number' class='commentNumber'>"+num+"번째 댓글</span>"+
						"</div>"+

						"<div class='comment_authordate'>"+
							"<span>작성자 : ${member.id }</span> 작성일 : "+date+
						"</div>"+
					"</div>"+
					"<div class='comments-body'>"+
					"<textArea id='newCArea'></textArea>"+
					"<button onclick='newCButton("+num+")'>댓글 작성하기</button>"+
					"</div>"+
				"</div>");

		 $("body").animate({	scrollTop: $('.commentNumber').last().offset().top}, 500);
		 $('#newCArea').focus();
	}

	function newCButton(num)
	{
		$.ajax({
            type : "POST",
            url : "writeComment.do",
            data:{"bcode":'${board.bcode}',"content":$('#newCArea').val(),"writerid":'${member.id}'},
            success : function(commentData) {
            	$('#newComments').replaceWith(
            			"<div class='comments' id='pa"+commentData.ccode+"'>"+
            			"<div class='comments-heading'>"+
            			"<div id='reply_num_and_give_medal_area'>"+
            			"<span id='reply_number' class='commentNumber'>"+num+"번째 댓글</span>"+
            			"<button id='give_medal' onclick='cmedal("+commentData.ccode+",\""+commentData.writerid+"\")'>메달 주기</button>"+
            			"</div>"+
            			"<div class='comment_authordate'><span>작성자 : "+commentData.writerid+"</span> 작성일 : "+commentData.postdate+"</div>"+
            			"<button onclick=beforeCEdit("+commentData.ccode+",$(this).prev().prev().children('span[class=commentNumber]').text())>수정하기</button>"+
            			"<button id=\"wcomment"+commentData.ccode+"\" onclick=\"wcomment("+commentData.ccode+")\">대댓글 달기</button>"+
            			"</div>"+
            			"<div class='comments-body'>"+commentData.content+"</div>"+
            			"<div class='comments-footer'>"+
            			"<div class='comment_point'>	댓글 점수 : <span id='c"+commentData.ccode+"'>"+commentData.point.cal+"</span></div>"+
            			"<div class='comment_rate'>"+
            			"<button id='report_comment' onclick='creport("+commentData.ccode+",\""+commentData.writerid+"\")'><span class='glyphicon glyphicon-alert'></span>&nbsp;&nbsp;댓글신고하기</button>"+
            			"공감 : <span id='g"+commentData.ccode+"'>"+commentData.point.good+"</span>&nbsp;"+
            			"<button type='button' class='comment_rate_btn' id='btn_good'onclick='crecommendation("+commentData.ccode+",\"g\",\""+commentData.writerid+"\")'><i class='fa fa-thumbs-o-up' aria-hidden='true'></i> YES!</button>"+
            			"&nbsp; 비공감 : <span id='b"+commentData.ccode+"'>"+commentData.point.bad+"</span>&nbsp;"+
            			"<button type='button' class='comment_rate_btn' id='btn_bad'	onclick='crecommendation("+commentData.ccode+",\"b\",\""+commentData.writerid+"\")'><i class='fa fa-thumbs-o-down' aria-hidden='true'></i> NO!</button>"+
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
		if($('#newRecomments').length>0)
		{
			alert("작성 중인 대댓글이 있습니다. 개새야");
			return;
		}
		var now = new Date();
		var date=now.getFullYear()+"-"+(now.getMonth()+1)+"-"+now.getDate();
		var parentComment=$("#wcomment"+code).parentsUntil(".comments").parent();//버튼의 부모 댓글 확인
		var pnum=parentComment.find('#reply_number').text().slice(0,-5);
		var num=1;

		if(parentComment.next().length>0)
		{
			while(parentComment.next().attr('class')!='comments')
			{
				var flag=true;
				parentComment=parentComment.next();
				if(parentComment.next().length<=0)			break;
			}
		}

		if(parentComment.attr('class')=='recomments')
		{
			var pnumL=pnum.length+1;
			num=parseInt(parentComment.find('#reply_number').text().slice(pnumL,-6))+1;
		}

		parentComment.after("<div class=recomments id='newRecomments'>"+
				"<div class='comments-heading'>"+
				"<div id='reply_num_and_give_medal_area'>"+
					"<span id='reply_number' class='commentNumber'>"+pnum+"-"+num+"번째 대댓글</span>"+
				"</div>"+
				"<div class='comment_authordate'>"+
					"<span>작성자 : ${member.id }</span> 작성일 : "+date+
				"</div>"+
			"</div>"+
			"<div class='comments-body'>"+
			"<textArea id='newCArea'></textArea>"+
			"<button onclick='newUCButton("+code+","+num+","+pnum+")'>대댓글 작성하기</button>"+
			"</div>"+
		"</div>");
		$("body").animate({	scrollTop: $('#newCArea').last().offset().top-200}, 500);
		$('#newCArea').focus();
	}

	function newUCButton(code,num,pnum)
	{
		$.ajax({
            type : "POST",
            url : "writeUComment.do",
            data:{"bcode":'${board.bcode}',"content":$('#newCArea').val(),"writerid":'${member.id}',"upper":code},
            success : function(commentData) {
            	$('#newRecomments').replaceWith(
            			"<div class='recomments' id='pa"+commentData.ccode+"'>"+
            			"<div class='comments-heading'>"+
            			"<div id='reply_num_and_give_medal_area'>"+
            			"<span id='reply_number' class='commentNumber'>"+pnum+"-"+num+"번째 대댓글</span>" +
            			"<button id='give_medal' onclick='cmedal("+commentData.ccode+",\""+commentData.writerid+"\")'>메달 주기</button>"+
            			"</div>"+
            			"<div class='comment_authordate'><span>작성자 : "+commentData.writerid+"</span> 작성일 : "+commentData.postdate+"</div>"+
            			"<button onclick=beforeCEdit("+commentData.ccode+",$(this).prev().prev().children('span[class=commentNumber]').text())>수정하기</button>"+
            			"</div>"+
            			"<div class='comments-body'>"+commentData.content+"</div>"+
            			"<div class='comments-footer'>"+
            			"<div class='comment_point'>	댓글 점수 : <span id='c"+commentData.ccode+"'>"+commentData.point.cal+"</span></div>"+
            			"<div class='comment_rate'>"+
            			"<button id='report_comment' onclick='creport("+commentData.ccode+",\""+commentData.writerid+"\")'><span class='glyphicon glyphicon-alert'></span>&nbsp;&nbsp;댓글신고하기</button>"+
            			"공감 : <span id='g"+commentData.ccode+"'>"+commentData.point.good+"</span>&nbsp;"+
            			"<button type='button' class='comment_rate_btn' id='btn_good'onclick='crecommendation("+commentData.ccode+",\"g\",\""+commentData.writerid+"\")'><i class='fa fa-thumbs-o-up' aria-hidden='true'></i> YES!</button>"+
            			"&nbsp; 비공감 : <span id='b"+commentData.ccode+"'>"+commentData.point.bad+"</span>&nbsp;"+
            			"<button type='button' class='comment_rate_btn' id='btn_bad'	onclick='crecommendation("+commentData.ccode+",\"b\",\""+commentData.writerid+"\")'><i class='fa fa-thumbs-o-down' aria-hidden='true'></i> NO!</button>"+
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
			alert('수정 중인 댓글이 있습니다. 개새야');
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
            		"<div id='reply_num_and_give_medal_area'>"+
            		"<span id='reply_number' class='commentNumber'>"+text+"수정</span>"+
            		"</div>"+
            		"<div class='comment_authordate'>"+
            		"<span>작성자 : "+commentData.writerid+"</span> 작성일 : "+commentData.postdate+
            		"</div></div>"+
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
            		"<div id='reply_num_and_give_medal_area'>"+
            		"<span id='reply_number' class='commentNumber'>"+text+"</span>" +
            		"<button id='give_medal' onclick='cmedal("+commentData.ccode+",\""+commentData.writerid+"\")'>메달 주기</button>"+
            		"</div>"+
            		"<div class='comment_authordate'><span>작성자 : "+commentData.writerid+"</span> 작성일 : "+commentData.postdate+"</div>"+
            		"<button onclick=beforeCEdit("+commentData.ccode+",$(this).prev().prev().children('span[class=commentNumber]').text())>수정하기</button>"+
            		reC+
            		"</div>"+
            		"<div class='comments-body'>"+commentData.content+"</div>"+
            		"<div class='comments-footer'>"+
            		"<div class='comment_point'>	댓글 점수 : <span id='c"+commentData.ccode+"'>"+commentData.point.cal+"</span></div>"+
            		"<div class='comment_rate'>"+
            		"<button id='report_comment' onclick='creport("+commentData.ccode+",\""+commentData.writerid+"\")'><span class='glyphicon glyphicon-alert'></span>&nbsp;&nbsp;댓글신고하기</button>"+
            		"공감 : <span id='g"+commentData.ccode+"'>"+commentData.point.good+"</span>&nbsp;"+
            		"<button type='button' class='comment_rate_btn' id='btn_good'onclick='crecommendation("+commentData.ccode+",\"g\",\""+commentData.writerid+"\")'><i class='fa fa-thumbs-o-up' aria-hidden='true'></i> YES!</button>"+
            		"&nbsp; 비공감 : <span id='b"+commentData.ccode+"'>"+commentData.point.bad+"</span>&nbsp;"+
            		"<button type='button' class='comment_rate_btn' id='btn_bad'	onclick='crecommendation("+commentData.ccode+",\"b\",\""+commentData.writerid+"\")'><i class='fa fa-thumbs-o-down' aria-hidden='true'></i> NO!</button>"+
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
                		"<span id='reply_number' class='commentNumber'>"+text+"</span>" +
                		"<button id='give_medal'><strike>메달 주기</strike></button>"+
                		"</div>"+
                		"<div class='comment_authordate'><span>작성자 : "+commentData.writerid+"</span> 작성일 : "+commentData.postdate+"</div>"+
                		"<button disabled><strike>수정하기</strike></button>"+
                		reC+
                		"</div>"+
                		"<div class='comments-body'>"+commentData.content+"</div>"+
                		"<div class='comments-footer'>"+
                		"<div class='comment_point'>	댓글 점수 : <span id='c"+commentData.ccode+"'>"+commentData.point.cal+"</span></div>"+
                		"<div class='comment_rate'>"+
                		"<button id='report_comment' disabled><span class='glyphicon glyphicon-alert'></span>&nbsp;&nbsp;<strike>댓글신고하기</strike></button>"+
                		"공감 : <span id='g"+commentData.ccode+"'>"+commentData.point.good+"</span>&nbsp;"+
                		"<button type='button' class='comment_rate_btn' id='btn_good' disabled><i class='fa fa-thumbs-o-up' aria-hidden='true'></i><strike> YES!</strike></button>"+
                		"&nbsp; 비공감 : <span id='b"+commentData.ccode+"'>"+commentData.point.bad+"</span>&nbsp;"+
                		"<button type='button' class='comment_rate_btn' id='btn_bad' disabled><i class='fa fa-thumbs-o-down' aria-hidden='true'></i><strike> NO!</strike></button>"+
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
					<h2>${board.title}&nbsp;&nbsp;&nbsp;<a href="#"><span id="posted_from">${board.code.name }게시판</span></a>
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

					<span id="board_postdate">작성일 : ${board.postdate}</span> <span id="board_viewcount">조회수 : ${board.point.viewnum }</span>

				</div>
				<br>
				<%-- 파일? --%>
				<c:if test="${files ne null}">
					<c:set var="num" value="1" />
					<c:forEach var="f" items="${files}">
								file${num } : <a href="filedown.do?atcode=${f.atcode }">${f.originname }</a><br>
						<c:set var="num" value="${num+1 }" />
					</c:forEach>
				</c:if>
			</div>

			<div class="boardDetail-contents">${board.content}</div>
			<button id="bedit">글 수정하기</button><button id="report_post"><span class="glyphicon glyphicon-alert"></span>&nbsp;&nbsp;게시글 신고하기</button>
			<button id="post_comment" onclick="writeComment()">댓글달기</button>
<hr>
			<div class="boardDetail-footer">
				<button type="button" class="post_rate_btns" id="bBest">최고다!</button>
				&nbsp;&nbsp;<span id="bbest">${board.point.best}</span> 개&nbsp;&nbsp;&nbsp;&nbsp;

				<button type="button" class="post_rate_btns" id="bGood">좋아요 :)</button>
				&nbsp;&nbsp;<span id="bgood">${board.point.good}</span> 개&nbsp;&nbsp;&nbsp;&nbsp;

				<button type="button" class="post_rate_btns" id="bBad">안 좋아요 :(</button>
				&nbsp;&nbsp;<span id="bbad">${board.point.bad}</span> 개&nbsp;&nbsp;&nbsp;&nbsp;

				<button type="button" class="post_rate_btns" id="bWorst">최악이다!</button>
				&nbsp;&nbsp;<span id="bworst">${board.point.worst}</span> 개
				<span id="board_postpt"> 게시글 점수 합계 : <span id="bcal">${board.point.cal}</span></span><br>
			</div>
			</div>
			<%-- 댓글 공간 --%>
			<div>

			</div>

			<div class="comment_section" id="commentsAdd">
				<c:if test="${comments ne null}">
					<c:set var="num" value="1" />
					<c:set var="cnum" value="1"/>

					<c:forEach var="c" items="${comments}">

					<c:if test="${c.isdelete eq 'y' }">

						<div class=comments id='pa${c.ccode }'>
                			<div class='comments-heading'>
                				<div id='reply_num_and_give_medal_area'>
                					<c:if test="${c.lev eq 1}">
										<span id="reply_number" class="commentNumber">${num }번째 댓글</span>
										<c:set var="cnum" value="1"/>
										<c:set var="num" value="${num+1 }" />
									</c:if>

									<c:if test="${c.lev eq 2}">
										<span id="reply_number" class="commentNumber">${num-1}-${cnum }번째 대댓글</span>
										<c:set var="cnum" value="${cnum+1}"/>
									</c:if>
                					<button id='give_medal'><strike>메달 주기</strike></button><span class='glyphicon glyphicon-alert'></span>&nbsp;&nbsp;<strike>댓글신고하기</strike></button>
                				</div>

                				<div class='comment_authordate'><span>작성자 : ${c.writerid}</span> 작성일 : ${c.postdate }</div>
                					<button disabled><strike>수정하기</strike></button>
                					<c:if test="${c.lev ne 2}">
										<button id="wcomment${c.ccode }" onclick="wcomment(${c.ccode})">대댓글 달기</button>
									</c:if>
                			</div>
                			<div class='comments-body'>${c.content }</div>
                			<div class='comments-footer'>

                				<div class='comment_point'>	댓글 점수 : <span id='ccommentData.ccode'>${c.point.cal }</span></div>
                				<div class='comment_rate'>
                					<button id='report_comment' disabled>
                					공감 : <span id='gcommentData.ccode'>${c.point.good }</span>&nbsp;
                					<button type='button' class='comment_rate_btn' id='btn_good' disabled><i class='fa fa-thumbs-o-up' aria-hidden='true'></i><strike> YES!</strike></button>
                					&nbsp; 비공감 : <span id='bcommentData.ccode'>${c.point.bad }</span>&nbsp;
                					<button type='button' class='comment_rate_btn' id='btn_bad' disabled><i class='fa fa-thumbs-o-down' aria-hidden='true'></i><strike> NO!</strike></button>
                				</div>
                			</div>
                		</div>
					</c:if>

					<c:if test="${c.isdelete ne 'y' }">
						<div class="comments" id="pa${c.ccode }">
						<div class="comments-heading">

							<div id="reply_num_and_give_medal_area">
								<c:if test="${c.lev eq 1}">
									<span id="reply_number" class="commentNumber">${num }번째 댓글</span>
									<c:set var="cnum" value="1"/>
									<c:set var="num" value="${num+1 }" />
								</c:if>

								<c:if test="${c.lev eq 2}">
									<span id="reply_number" class="commentNumber">${num-1}-${cnum }번째 대댓글</span>
									<c:set var="cnum" value="${cnum+1}"/>
								</c:if>

								<%-- 댓글 메달 파트. 메달이 1개 이상일 때만 갯수 노출 --%>
								<c:if test="${c.point.medal eq 0}">
										<script>
											$('.current_medal_number').css('display','none');
										</script>
								</c:if>

								<div class="current_medal_number" id="mdiv${c.ccode }"
										style="display: none;">
										<span id="m${c.ccode}">${c.point.medal } </span>
									</div>

								<button id="give_medal" onclick="cmedal(${c.ccode},'${c.writerid }')">메달 주기</button>
								<button id="report_comment" onclick="creport(${c.ccode},'${c.writerid }')">
									<span class="glyphicon glyphicon-alert"></span>&nbsp;&nbsp;댓글 신고하기</button>
									<span>작성자 : ${c.writerid }</span> 작성일 : ${c.postdate}
							</div>

							<c:if test="${c.lev ne 2}">

							</c:if>

						</div>

						<div class="comments-body">${c.content }<br></div>
						<div class="comments-footer">
							<div class="comment_point">
								<button id="comment_edit" onclick="beforeCEdit(${c.ccode },$(this).prev().prev().children('span[class=commentNumber]').text())">수정하기</button>
								<button id="wcomment${c.ccode }" onclick="wcomment(${c.ccode})">대댓글 달기</button>
							</div>
							<div class="comment_rate">

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
								댓글 점수 : <span id="c${c.ccode}">${c.point.cal }</span>
							</div>
						</div>
						<script type="text/javascript">
						if('${c.lev}'=='2')
						{
							$('#pa${c.ccode }').attr("class","recomments");
						}
					</script>
					</div>
					</c:if>

				</c:forEach>

				</c:if>

			</div>

		</div>

	</div>
</body>

</html>

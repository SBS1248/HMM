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
	<link href="resources/css/newtech.css" rel="stylesheet" type="text/css">
<link href="resources/css/index.css" rel="stylesheet" type="text/css">
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>${week }주차 신기술 찬/반 투표</title>

<script type="text/javascript">
	function checkBoard(bcode){
		var data = '${sessionScope.member}';
		if(data ==''){
			alert("로그인 후 이용 바랍니다");
			$("#loginModal").modal('show');
		}
		else
		{
			viewcount(bcode);
			location.href="boardOne.do?bcode="+bcode;
		}
	}

	function checkWrite()
	{
			location.href="boardcode.do?dis=3";
	}

	function viewcount(bcode)
	{
		$.ajax({
            type : "GET",
            url : "viewcount.do?bcode="+bcode,
           	success:function(){},
            error:function(request,status,error){
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
               }
    	});
	};

	$(function(){
		$('#agree').click(function()
		{
			if('${member}'=='')
			{
				alert("로그인이 필요합니다.");
				return;
			}
			else
			{
				$.ajax({
		            type : "GET",
		            url : "isVote.do?id=${member.id}",
		           	success:function(data)
		           	{
		           		if(data=='0')
		           		{
		           			$.ajax({
		    		            type : "GET",
		    		            url : "agree.do?id=${member.id}&wscode=${weeksubject.wscode}",
		    		           	success:function()
		    		           	{
		    		           		alert("찬성 투표하셨습니다.");
		    		           	},
		    		            error:function(request,status,error){
		    		                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		    		               }
		    		    	});
		           		}
		           		else if(data=='1') alert("이미 찬성 투표하셨습니다.");
		           		else alert("이미 반대 투표하셨습니다.");
		           	},
		            error:function(request,status,error){
		                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		               }
		    	});
			}
		});

		$('#disagree').click(function()
		{
			if('${member}'=='')
			{
				alert("로그인이 필요합니다.");
				return;
			}
			else
			{
				$.ajax({
		            type : "GET",
		            url : "isVote.do?id=${member.id}",
		           	success:function(data)
		           	{
		           		if(data=='0')
		           		{
		           			$.ajax({
		    		            type : "GET",
		    		            url : "disagree.do?id=${member.id}&wscode=${weeksubject.wscode}",
		    		           	success:function()
		    		           	{
		    		           		alert("반대 투표하셨습니다.");
		    		           	},
		    		            error:function(request,status,error){
		    		                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		    		               }
		    		    	});
		           		}
		           		else if(data=='1') alert("이미 찬성 투표하셨습니다.");
		           		else alert("이미 반대 투표하셨습니다.");
		           	},
		            error:function(request,status,error){
		                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		               }
		    	});
			}
		});
	});
</script>
</head>
<body>

<%@ include file="/header.jsp"%>
  <div class="polls_heading">
	<h2><span id="week">${week }</span>주차 신기술 찬/반 투표 </h2>
  <h1>${weeksubject.title }</h1>
  </div>
  <div class="polls_body">
	<button type="button" id="agree">${weeksubject.agree }</button>
  <div class="polls_between">VS</div>
	<button type="button" id="disagree">${weeksubject.disagree }</button>
  <button type="button" id="polls_result_btn" onclick="location.href='newTechResult.do?wscode=${weeksubject.wscode}'">금주 신기술 동향 투표 결과 확인하기</button>
  </div>



  <div class="container">
		<!-- 게시판 영역 -->
		<div class="board_area">
			<!-- 검색창, 검색 정렬들의 패널 -->
			<div class="board">

				<div class="board-heading">

					<%-- 글쓰기 버튼 --%>
					<div id="writebutton">
						<button id="write" type="button" onclick="checkWrite()">글쓰기</button>
					</div>

					<%-- 검색바 --%>
					<div id="search_bar">
						<input type="text" name="search" placeholder="검색어를 입력하세요..">
					</div>

					<%-- 게시글 정렬 --%>
					<div class="sort_options">
						<select class="selectpicker">
							<option>최신순</option>
							<option>인기높은순</option>
							<option>김말순</option>
							<option>떡튀순</option>
						</select>
					</div>

				</div>

				<div class="board-body">
					<!-- 게시판 테이블 -->
					<div class="hmm_table">
						<table id="myTable">
							<thead>
								<tr>
									<th>글번호</th>
									<th style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden">제목</th>
									<th>카테고리</th>
									<th>작성자</th>
									<th>추천 점수</th>
									<th>조회수</th>
									<th>작성일자</th>
								</tr>
							</thead>
							<tbody>
								<c:set var="num" value="1" />
								<c:forEach var="l" items="${list }">

									<tr>

										<td>${num }</td>
										<c:set var="num" value="${num+1 }" />
										<td id="td_title"><a onclick="checkBoard(${l.bcode})"
											style="cursor: pointer">${l.title }</a><span id="reply_num">&nbsp;[${l.isdelete}]</span></td>

										<td>${l.code.name}</td>
                    <td id="td_profile">
												<a href="profile.do?profileId=${l.writerid }"> <img class="img-circle" src="#" />
													${l.writerid }
												</a>
										</td>
										<td>${l.point.cal }</td>
										<td>${l.point.viewnum }</td>
										<td>${l.postdate }</td>
									</tr>

								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>

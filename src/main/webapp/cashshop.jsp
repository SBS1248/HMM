<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="resources/css/cashshop.css">
<link rel="stylesheet" type="text/css"
	href="resources/css/cashshop2.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>CashShop</title>
<style type="text/css">
tr, td {
	border: 1px solid black;
}
</style>
<script type="text/javascript">
/* 스크롤 되는 메뉴 */
 $(document).ready(function(){
  var $doc           = $(document);
  var position       = 0;
  var top = $doc.scrollTop(); //현재 스크롤바 위치
  var screenSize     = 0;        // 화면크기
  var halfScreenSize = 0;    // 화면의 반
  /*사용자 설정 값 시작*/
  var pageWidth      = 1000; // 페이지 폭, 단위:px
  var leftOffet      = 600;  // 중앙에서의 폭(왼쪽 -, 오른쪽 +), 단위:px
  var leftMargin     = 909; // 페이지 폭보다 화면이 작을때 옵셋, 단위:px, leftOffet과 pageWidth의 반만큼 차이가 난다.
  var speed          = 1100;     // 따라다닐 속도 : "slow", "normal", or "fast" or numeric(단위:msec)
  var easing         = 'swing'; // 따라다니는 방법 기본 두가지 linear, swing
  var $layer         = $('#floating'); // 레이어 셀렉팅
  var layerTopOffset = 188;   // 레이어 높이 상한선, 단위:px
  $layer.css('z-index', 10);   // 레이어 z-인덱스
  /*사용자 설정 값 끝*/
  //좌우 값을 설정하기 위한 함수
  function resetXPosition()
  {
    $screenSize = $('body').width();// 화면크기
    halfScreenSize = $screenSize/2;// 화면의반 
    xPosition = halfScreenSize + leftOffet;
    if ($screenSize < pageWidth)
      xPosition = leftMargin;
    $layer.css('left', xPosition);
  }
  // 스크롤 바를 내린 상태에서 리프레시 했을 경우를 위해
  if (top > 0 )
    $doc.scrollTop(layerTopOffset+top);
  else
    $doc.scrollTop(0);
  // 최초 레이어가 있을 자리 세팅
  $layer.css('top',layerTopOffset);
  resetXPosition();
  //윈도우 크기 변경 이벤트가 발생하면
  $(window).resize(resetXPosition);
  //스크롤이벤트가 발생하면
  $(window).scroll(function(){
    yPosition = $doc.scrollTop()+layerTopOffset;
    $layer.animate({"top":yPosition }, {duration:speed, easing:easing, queue:false});
  });
});

/* 스크롤 메뉴 end */

	/* 페이지 이동  */
	$(document).ready(function(){

    $(".filter-button").click(function(){
        var value = $(this).attr('data-filter');
        
        if(value == "all")
        {
            //$('.filter').removeClass('hidden');
            $('.filter').show('1000');
        }
        else
        {
//            $('.filter[filter-item="'+value+'"]').removeClass('hidden');
//            $(".filter").not('.filter[filter-item="'+value+'"]').addClass('hidden');
            $(".filter").not('.'+value).hide('3000');
            $('.filter').filter('.'+value).show('3000');
            
        }
    });
    
    if ($(".filter").removeClass("active")) {
$(this).removeClass("active");
}
$(this).addClass("active");

});
	
	/* 배너 마우스 오버 */
	$(function(){
		$("#flotImg").hover(function(){
			$(this).find("#banner").css('display','none');
			$(this).find("#test").show();
		},function(){
			$(this).find("#banner").css('display','');
			$(this).find("#test").hide();
		});
	});
		
</script>
<c:set var="ddaru" value="${member.ddaru}" scope="session" />
<%@ include file="/header.jsp"%>
</head>
<body id="body">

	<div class="jumbotron">
		<div class="container text-center">
			<h1>Hmm CashShop</h1>
			<p style="font-size: 30px;">Cash shop</p>
		</div>
	</div>

	<div class="container">
		<div id="residualcash" style="margin: 0px;">
			<p style="text-align: center; width: 100%;">
				<b>남은 따루 : </b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input
					id="cash" name="cash" type="text" value="${ddaru}  따루"
					readonly>
				<button id="myitem" class="w3-button w3-round-xlarge w3-black"
					data-toggle="modal" data-target="#myitemes">내 아이템보기</button>
			</p>
		</div>
		<div class="row">
			<div class="col-sm-3">
				<div class="left-sidebar">
					<h2 style="font-family:">Category</h2>
					<div class="panel-group category-products" id="accordian">
						<!--category-productsr-->
						<div class="panel panel-default">
							<div class="panel-heading">
								<h4 class="panel-title">
									<a href="#" class="filter-button" data-filter="all">ALL</a>
								</h4>
							</div>
						</div>
						<div class="panel panel-default">
							<div class="panel-heading">
								<h4 class="panel-title">
									<a data-toggle="collapse" data-parent="#accordian"
										href="#emoticon" class="collapsed filter-button"
										data-filter="emoticon"> <span class="badge pull-right"><i
											class="fa fa-plus"></i></span> EMOTICON
									</a>
								</h4>
							</div>
							<div id="emoticon" class="panel-collapse collapse"
								style="height: 0px;">
								<div class="panel-body">
									<ul>
										<li><a href="#" class="filter-button" data-filter="bad">Bad</a></li>
										<li><a href="#" class="filter-button" data-filter="happy">Happy</a></li>
										<li><a href="#" class="filter-button" data-filter="sad">Sad</a></li>
										<li><a href="#" class="filter-button" data-filter="crazy">Crazy</a></li>
									</ul>
								</div>
							</div>
						</div>
						<div class="panel panel-default">
							<div class="panel-heading">
								<h4 class="panel-title">
									<a data-toggle="collapse" data-parent="#accordian" href="#edge"
										class="collapsed filter-button" data-filter="border">
										EDGE,BORDER </a>
								</h4>
							</div>
							<div id="edge" class="panel-collapse collapse"></div>
						</div>

						<div class="panel panel-default">
							<div class="panel-heading">
								<h4 class="panel-title">
									<a data-toggle="collapse" data-parent="#accordian"
										href="#medal" class="collapsed filter-button"
										data-filter="medal"> MEDAL </a>
								</h4>
							</div>
							<div id="medal" class="panel-collapse collapse"></div>
						</div>
					</div>
					<!--/category-products-->

					<div class="shipping text-center">
						<!--shipping-->

					</div>
					<!--/shipping-->

				</div>
			</div>

			<div class="col-sm-9 padding-right">
				<div id="items" class="items">
					<!--features_items-->
					<h2 class="title text-center">ITEMS</h2>

					<!--------------------------------------------------emticon---------------------------------------------------------------------------- -->

					<div class="col-sm-4 filter emoticon bad ">
						<div class="product-image-wrapper" style="margin-bottom: 27px;">
							<div class="single-products">
								<div class="productinfo text-center">
									<br> <br> <br> <img
										style="width: 190px; height: 180px;"
										src="http://mblogthumb1.phinf.naver.net/20160420_291/donga-bacchus_14611160044242ryl6_GIF/002.gif?type=w2">
									<br> <br> <br>
								</div>
								<div class="product-overlay">
									<div class="overlay-content">
										<h2>250따루</h2>
										<a href="#" class="btn btn-sdefault add-to-cart"
											data-toggle="modal" data-target="#buyModal"><i
											class="fa fa-shopping-cart"></i>구매하기</a> <a href="#"
											class="btn btn-default add-to-cart" data-toggle="modal"
											data-target="#cashModal"><i class="fa fa-shopping-cart"></i>충전하기</a>
									</div>
								</div>
							</div>
							<div class="choose"></div>
						</div>
					</div>
					<div class="col-sm-4 filter emoticon happy">
						<div class="product-image-wrapper" style="margin-bottom: 27px;">
							<div class="single-products">
								<div class="productinfo text-center">
									<br> <br> <br> <img
										style="width: 190px; height: 180px;"
										src="https://item.kakaocdn.net/do/96c4a590bb9fee0f9b570f1245fdf7b0f43ad912ad8dd55b04db6a64cddaf76d">
									<br> <br> <br>
								</div>
								<div class="product-overlay">
									<div class="overlay-content">
										<h2>250따루</h2>
										<a href="#" class="btn btn-default add-to-cart"
											data-toggle="modal" data-target="#buyModal"><i
											class="fa fa-shopping-cart"></i>구매하기</a> <a href="#"
											class="btn btn-default add-to-cart" data-toggle="modal"
											data-target="#cashModal"><i class="fa fa-shopping-cart"></i>충전하기</a>
									</div>
								</div>
							</div>
							<div class="choose"></div>
						</div>
					</div>
					<div class="col-sm-4 filter emoticon happy">
						<div class="product-image-wrapper" style="margin-bottom: 27px;">
							<div class="single-products">
								<div class="productinfo text-center">
									<br> <br> <br> <img
										style="width: 190px; height: 180px;"
										src="https://item.kakaocdn.net/do/f43d6e06d6563b7409e38f05f6df3666f43ad912ad8dd55b04db6a64cddaf76d">

									<br> <br> <br>
								</div>
								<div class="product-overlay">
									<div class="overlay-content">
										<h2>250따루</h2>
										<a href="#" class="btn btn-default add-to-cart"
											data-toggle="modal" data-target="#buyModal"><i
											class="fa fa-shopping-cart"></i>구매하기</a> <a href="#"
											class="btn btn-default add-to-cart" data-toggle="modal"
											data-target="#cashModal"><i class="fa fa-shopping-cart"></i>충전하기</a>
									</div>
								</div>
							</div>
							<div class="choose"></div>
						</div>
					</div>
					<div class="col-sm-4 filter emoticon happy">
						<div class="product-image-wrapper" style="margin-bottom: 27px;">
							<div class="single-products">
								<div class="productinfo text-center">
									<br> <br> <br> <img
										style="width: 190px; height: 180px;"
										src="https://item.kakaocdn.net/do/af2e957732dad678a8b5f540f8b31045f43ad912ad8dd55b04db6a64cddaf76d">

									<br> <br> <br>
								</div>
								<div class="product-overlay">
									<div class="overlay-content">
										<h2>150따루</h2>
										<a href="#" class="btn btn-default add-to-cart"
											data-toggle="modal" data-target="#buyModal"><i
											class="fa fa-shopping-cart"></i>구매하기</a> <a href="#"
											class="btn btn-default add-to-cart" data-toggle="modal"
											data-target="#cashModal"><i class="fa fa-shopping-cart"></i>충전하기</a>
									</div>
								</div>

							</div>
							<div class="choose"></div>
						</div>
					</div>
					<div class="col-sm-4 filter emoticon happy">
						<div class="product-image-wrapper" style="margin-bottom: 27px;">
							<div class="single-products">
								<div class="productinfo text-center">
									<br> <br> <br> <img
										style="width: 190px; height: 180px;"
										src="https://item.kakaocdn.net/do/c50482b35a90fbcca8622c92c9552ba8f43ad912ad8dd55b04db6a64cddaf76d">

									<br> <br> <br>
								</div>
								<div class="product-overlay">
									<div class="overlay-content">
										<h2>150따루</h2>
										<a href="#" class="btn btn-default add-to-cart"
											data-toggle="modal" data-target="#buyModal"><i
											class="fa fa-shopping-cart"></i>구매하기</a> <a href="#"
											class="btn btn-default add-to-cart" data-toggle="modal"
											data-target="#cashModal"><i class="fa fa-shopping-cart"></i>충전하기</a>
									</div>
								</div>

							</div>
							<div class="choose"></div>
						</div>
					</div>
					<div class="col-sm-4 filter emoticon happy">
						<div class="product-image-wrapper" style="margin-bottom: 27px;">
							<div class="single-products">
								<div class="productinfo text-center">
									<br> <br> <br> <img
										style="width: 190px; height: 180px;"
										src="http://mblogthumb2.phinf.naver.net/20130521_45/ssunde1_1369117742177yoCHe_GIF/%B0%F8%B0%A8.gif?type=w2">

									<br> <br> <br>
								</div>
								<div class="product-overlay">
									<div class="overlay-content">
										<h2>150따루</h2>
										<a href="#" class="btn btn-default add-to-cart"
											data-toggle="modal" data-target="#buyModal"><i
											class="fa fa-shopping-cart"></i>구매하기</a> <a href="#"
											class="btn btn-default add-to-cart" data-toggle="modal"
											data-target="#cashModal"><i class="fa fa-shopping-cart"></i>충전하기</a>
									</div>
								</div>
							</div>
							<div class="choose"></div>
						</div>
					</div>
					<!--  ------------------------------------------border, edge----------------------------------------------------------------->
					<div class="col-sm-4 filter border">
						<div class="product-image-wrapper" style="margin-bottom: 24px;">
							<div class="single-products">
								<div class="productinfo text-center">
									<br> <br> <br> <img
										style="width: 190px; height: 180px;"
										src="http://cfs12.planet.daum.net/upload_control/pcp_download.php?fhandle=NVNzZWFAZnMxMi5wbGFuZXQuZGF1bS5uZXQ6LzExMjgyOTY2LzExNC8xMTQ4OC5naWY=&filename=colorline15.gif">

									<br> <br> <br>
								</div>
								<div class="product-overlay">
									<div class="overlay-content">
										<h2>150따루</h2>
										<a href="#" class="btn btn-default add-to-cart"
											data-toggle="modal" data-target="#buyModal"><i
											class="fa fa-shopping-cart"></i>구매하기</a> <a href="#"
											class="btn btn-default add-to-cart" data-toggle="modal"
											data-target="#cashModal"><i class="fa fa-shopping-cart"></i>충전하기</a>
									</div>
								</div>
							</div>
							<div class="choose"></div>
						</div>
					</div>

					<div class="col-sm-4 filter border">
						<div class="product-image-wrapper" style="margin-bottom: 24px;">
							<div class="single-products">
								<div class="productinfo text-center">
									<br> <br> <br> <img
										style="width: 190px; height: 180px;"
										src="http://cfile208.uf.daum.net/R400x0/1717D03C5030651A1D14E0">

									<br> <br> <br>
								</div>
								<div class="product-overlay">
									<div class="overlay-content">
										<h2>150따루</h2>
										<a href="#" class="btn btn-default add-to-cart"
											data-toggle="modal" data-target="#buyModal"><i
											class="fa fa-shopping-cart"></i>구매하기</a> <a href="#"
											class="btn btn-default add-to-cart" data-toggle="modal"
											data-target="#cashModal"><i class="fa fa-shopping-cart"></i>충전하기</a>
									</div>
								</div>
							</div>
							<div class="choose"></div>
						</div>
					</div>

					<div class="col-sm-4 filter border">
						<div class="product-image-wrapper" style="margin-bottom: 24px;">
							<div class="single-products">
								<div class="productinfo text-center">
									<br> <br> <br> <img
										style="width: 190px; height: 180px;"
										src="http://cfs11.planet.daum.net/upload_control/pcp_download.php?fhandle=NVNzZWFAZnMxMS5wbGFuZXQuZGF1bS5uZXQ6LzExMjgyOTY2LzExMy8xMTM1NC5naWY=&filename=color_line26.gif">

									<br> <br> <br>
								</div>
								<div class="product-overlay">
									<div class="overlay-content">
										<h2>150따루</h2>
										<a href="#" class="btn btn-default add-to-cart"
											data-toggle="modal" data-target="#buyModal"><i
											class="fa fa-shopping-cart"></i>구매하기</a> <a href="#"
											class="btn btn-default add-to-cart" data-toggle="modal"
											data-target="#cashModal"><i class="fa fa-shopping-cart"></i>충전하기</a>
									</div>
								</div>
							</div>
							<div class="choose"></div>
						</div>
					</div>

					<div class="col-sm-4 filter border">
						<div class="product-image-wrapper" style="margin-bottom: 24px;">
							<div class="single-products">
								<div class="productinfo text-center">
									<br> <br> <br> <img
										style="width: 190px; height: 180px;"
										src="http://cfile207.uf.daum.net/image/1308F4084979EADEFAA475">
									<br> <br> <br>
								</div>
								<div class="product-overlay">
									<div class="overlay-content">
										<h2>150따루</h2> 

										<a href="#" class="btn btn-default add-to-cart"
											data-toggle="modal" data-target="#buyModal"><i
											class="fa fa-shopping-cart"></i>구매하기</a> <a href="#"
											class="btn btn-default add-to-cart" data-toggle="modal"
											data-target="#cashModal"><i class="fa fa-shopping-cart"></i>충전하기</a>
									</div>
								</div>
							</div>
							<div class="choose"></div>
						</div>
					</div>

					<div class="col-sm-4 filter border">
						<div class="product-image-wrapper" style="margin-bottom: 24px;">
							<div class="single-products">
								<div class="productinfo text-center">
									<br> <br> <br> <img
										style="width: 190px; height: 180px;"
										src="http://cfile206.uf.daum.net/image/144186064979ED58DACE1E">
									<br> <br> <br>
								</div>
								<div class="product-overlay">
									<div class="overlay-content">
										<h2>150따루</h2>
										<a href="#" class="btn btn-default add-to-cart"
											data-toggle="modal" data-target="#buyModal"><i
											class="fa fa-shopping-cart"></i>구매하기</a> <a href="#"
											class="btn btn-default add-to-cart" data-toggle="modal"
											data-target="#cashModal"><i class="fa fa-shopping-cart"></i>충전하기</a>
									</div>
								</div>
							</div>
							<div class="choose"></div>
						</div>
					</div>

					<div class="col-sm-4 filter border">
						<div class="product-image-wrapper" style="margin-bottom: 24px;">
							<div class="single-products">
								<div class="productinfo text-center">
									<br> <br> <br> <img
										style="width: 190px; height: 180px;"
										src="http://cfs9.blog.daum.net/image/36/blog/2008/01/27/16/16/479c2fb36d7d1&filename=1_e0o5i18276.gif">

									<br> <br> <br>
								</div>
								<div class="product-overlay">
									<div class="overlay-content">
										<h2>150따루</h2>
										<a href="#" class="btn btn-default add-to-cart"
											data-toggle="modal" data-target="#buyModal"><i
											class="fa fa-shopping-cart"></i>구매하기</a> <a href="#"
											class="btn btn-default add-to-cart" data-toggle="modal"
											data-target="#cashModal"><i class="fa fa-shopping-cart"></i>충전하기</a>
									</div>
								</div>
							</div>
							<div class="choose"></div>
						</div>
					</div>

					<!-- --------------------------------------------------------------------------medal-------------------------------------------------------------------- -->

					<div class="col-sm-4 filter medal">
						<div class="product-image-wrapper" style="margin-bottom: 24px;">
							<div class="single-products">
								<div class="productinfo text-center">
									<br> <br> <br> <img
										style="width: 100px; height: 100px;"
										src="https://sciencelevelup.kofac.re.kr/resources/images/mobile/course_big_icon_03.png">

									<br> <br> <br>
								</div>
								<div class="product-overlay">
									<div class="overlay-content">
										<h2>100따루</h2>
										<p>매달5개</p>
										<a href="#" class="btn btn-default add-to-cart"
											data-toggle="modal" data-target="#buyModal"><i
											class="fa fa-shopping-cart"></i>구매하기</a> <a href="#"
											class="btn btn-default add-to-cart" data-toggle="modal"
											data-target="#cashModal"><i class="fa fa-shopping-cart"></i>충전하기</a>
									</div>
								</div>
							</div>
							<div class="choose"></div>
						</div>
					</div>

					<div class="col-sm-4 filter medal">
						<div class="product-image-wrapper" style="margin-bottom: 24px;">
							<div class="single-products">
								<div class="productinfo text-center">
									<br> <br> <br> <img
										style="width: 100px; height: 100px;"
										src="https://sciencelevelup.kofac.re.kr/resources/images/mobile/course_big_icon_03.png">

									<br> <br> <br>
								</div>
								<div class="product-overlay">
									<div class="overlay-content">
										<h2>200따루</h2>
										<p>매달 10개</p>
										<a href="#" class="btn btn-default add-to-cart"
											data-toggle="modal" data-target="#buyModal"><i
											class="fa fa-shopping-cart"></i>구매하기</a> <a href="#"
											class="btn btn-default add-to-cart" data-toggle="modal"
											data-target="#cashModal"><i class="fa fa-shopping-cart"></i>충전하기</a>
									</div>
								</div>
							</div>
							<div class="choose"></div>
						</div>
					</div>

					<div class="col-sm-4 filter medal">
						<div class="product-image-wrapper" style="margin-bottom: 24px;">
							<div class="single-products">
								<div class="productinfo text-center">
									<br> <br> <br> <img
										style="width: 100px; height: 100px;"
										src="https://sciencelevelup.kofac.re.kr/resources/images/mobile/course_big_icon_03.png">

									<br> <br> <br>
								</div>
								<div class="product-overlay">
									<div class="overlay-content">
										<h2>150따루</h2>
										<p>매달 15개</p>
										<a href="#" class="btn btn-default add-to-cart"
											data-toggle="modal" data-target="#buyModal"><i
											class="fa fa-shopping-cart"></i>구매하기</a> <a href="#"
											class="btn btn-default add-to-cart" data-toggle="modal"
											data-target="#cashModal"><i class="fa fa-shopping-cart"></i>충전하기</a>
									</div>
								</div>
							</div>
							<div class="choose"></div>
						</div>
					</div>
				</div>
				<!--features_items-->
				<div class="category-tab">
					<!--category-tab-->
				</div>
				<!--/category-tab-->
				<div class="recommended_items">
					<!--recommended_items-->
				</div>
				<!--/recommended_items-->

			</div>
		</div>
	</div>

	<!--구매 Modal -->
	<div class="modal fade" id="buyModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="myModalLabel">구매하기</h4>
				</div>
				<div class="modal-body">정말로 구매 하시겠습니까 ?</div>
				<div class="modal-footer">
					<button id="thisbuy" type="button" data-dismiss="modal">결제하기</button>
					<button type="button" class="cancelbtn" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 아이템 보기 -->
	<div class="modal modal-center fade" id="myitemes" tabindex="-1"
		role="dialog" aria-labelledby="my80sizeCenterModalLabel">
		<div class="modal-dialog modal-80size modal-center" role="document"
			style="height: auto; width: 1300px;">
			<div id="myitemModal" class="modal-content modal-80size">
				<div class="modal-header">
					<h4 id="itemtitle" class="modal-title" id="myModalLabel">내 아이템</h4>
				</div>
				<div id="itemheight" class="modal-body" style="width: 1200px;">
					<table id="itemtable"
						style="margin-left: 100px;; width: 900px; height: auto; padding: 0px;">
						<tr>
							<td><span style="float: right; margin: 10px;"><button
										id="imagedel" class="close" type="button"
										style="color: black;">&times;</button></span><a id="itemdetail"
								href="#itdetail" data-toggle="modal"> <img
									src="http://mblogthumb1.phinf.naver.net/20160420_291/donga-bacchus_14611160044242ryl6_GIF/002.gif?type=w2">
							</a><br> <br>사용기한 : ${member.quitedate}</td>
							<td><span style="float: right; margin: 10px;"><button
										id="imagedel" class="close" type="button"
										style="color: black;">&times;</button></span><a id="itemdetail"
								href="#itdetail" data-toggle="modal"><img
									src="http://mblogthumb1.phinf.naver.net/20160420_291/donga-bacchus_14611160044242ryl6_GIF/002.gif?type=w2">
							</a><br> <br>사용기한 : ${member.quitedate}</td>
							<td><span style="float: right; margin: 10px;"><button
										id="imagedel" class="close" type="button"
										style="color: black;">&times;</button></span><a id="itemdetail"
								href="#itdetail" data-toggle="modal"><img
									src="http://mblogthumb1.phinf.naver.net/20160420_291/donga-bacchus_14611160044242ryl6_GIF/002.gif?type=w2">
							</a><br> <br>사용기한 : ${member.quitedate}</td>
							<td><span style="float: right; margin-right: 10px;"><button
										id="imagedel" class="close" type="button"
										style="color: black;">&times;</button></span><a id="itemdetail"
								href="#itdetail" data-toggle="modal"><img
									src="http://mblogthumb1.phinf.naver.net/20160420_291/donga-bacchus_14611160044242ryl6_GIF/002.gif?type=w2">
							</a><br> <br>사용기한 : ${member.quitedate}</td>
						</tr>
						<tr>
							<td><span style="float: right; margin: 10px;"><button
										id="imagedel" class="close" type="button"
										style="color: black;">&times;</button></span><a id="itemdetail"
								href="#itdetail" data-toggle="modal"><img
									src="http://mblogthumb1.phinf.naver.net/20160420_291/donga-bacchus_14611160044242ryl6_GIF/002.gif?type=w2">
							</a><br> <br>사용기한 : ${member.quitedate}</td>
							<td><span style="float: right; margin: 10px;"><button
										id="imagedel" class="close" type="button"
										style="color: black;">&times;</button></span><a id="itemdetail"
								href="#itdetail" data-toggle="modal"><img
									src="http://mblogthumb1.phinf.naver.net/20160420_291/donga-bacchus_14611160044242ryl6_GIF/002.gif?type=w2">
							</a><br> <br>사용기한 : ${member.quitedate}</td>
							<td><span style="float: right; margin: 10px;"><button
										id="imagedel" class="close" type="button"
										style="color: black;">&times;</button></span><a id="itemdetail"
								href="#itdetail" data-toggle="modal"><img
									src="http://mblogthumb1.phinf.naver.net/20160420_291/donga-bacchus_14611160044242ryl6_GIF/002.gif?type=w2">
							</a><br> <br>사용기한 : ${member.quitedate}</td>
							<td><span style="float: right; margin: 10px;"><button
										id="imagedel" class="close" type="button"
										style="color: black;">&times;</button></span><br> <a
								id="itemdetail" href="#itdetail" data-toggle="modal"><img
									src="http://mblogthumb1.phinf.naver.net/20160420_291/donga-bacchus_14611160044242ryl6_GIF/002.gif?type=w2">
							</a><br> <br>사용기한 : ${member.quitedate}</td>
						</tr>
						<tr>
							<td><span style="float: right; margin: 10px;"><button
										id="imagedel" class="close" type="button"
										style="color: black;">&times;</button></span><a id="itemdetail"
								href="#itdetail" data-toggle="modal"><img
									src="http://mblogthumb1.phinf.naver.net/20160420_291/donga-bacchus_14611160044242ryl6_GIF/002.gif?type=w2">
							</a><br> <br>사용기한 : ${member.quitedate}</td>
							<td><span style="float: right; margin: 10px;"><button
										id="imagedel" class="close" type="button"
										style="color: black;">&times;</button></span><a id="itemdetail"
								href="#itdetail" data-toggle="modal"><img
									src="http://mblogthumb1.phinf.naver.net/20160420_291/donga-bacchus_14611160044242ryl6_GIF/002.gif?type=w2">
							</a><br> <br>사용기한 : ${member.quitedate}</td>
							<td><span style="float: right; margin: 10px;"><button
										id="imagedel" class="close" type="button"
										style="color: black;">&times;</button></span><a id="itemdetail"
								href="#itdetail" data-toggle="modal"><img
									src="http://mblogthumb1.phinf.naver.net/20160420_291/donga-bacchus_14611160044242ryl6_GIF/002.gif?type=w2">
							</a><br> <br>사용기한 : ${member.quitedate}</td>
							<td><span style="float: right; margin: 10px;"><button
										id="imagedel" class="close" type="button"
										style="color: black;">&times;</button></span><a id="itemdetail"
								href="#itdetail" data-toggle="modal"><img
									src="http://mblogthumb1.phinf.naver.net/20160420_291/donga-bacchus_14611160044242ryl6_GIF/002.gif?type=w2">
							</a><br> <br>사용기한 : ${member.quitedate}</td>
						</tr>
						<tr>
							<td><span style="float: right; margin: 10px;"><button
										id="imagedel" class="close" type="button"
										style="color: black;">&times;</button></span><a id="itemdetail"
								href="#itdetail" data-toggle="modal"><img
									src="http://mblogthumb1.phinf.naver.net/20160420_291/donga-bacchus_14611160044242ryl6_GIF/002.gif?type=w2">
							</a><br> <br>사용기한 : ${member.quitedate}</td>
							<td><span style="float: right; margin: 10px;"><button
										id="imagedel" class="close" type="button"
										style="color: black;">&times;</button></span><a id="itemdetail"
								href="#itdetail" data-toggle="modal"><img
									src="http://mblogthumb1.phinf.naver.net/20160420_291/donga-bacchus_14611160044242ryl6_GIF/002.gif?type=w2">
							</a><br> <br>사용기한 : ${member.quitedate}</td>
							<td><span style="float: right; margin: 10px;"><button
										id="imagedel" class="close" type="button"
										style="color: black;">&times;</button></span><a id="itemdetail"
								href="#itdetail" data-toggle="modal"><img
									src="http://mblogthumb1.phinf.naver.net/20160420_291/donga-bacchus_14611160044242ryl6_GIF/002.gif?type=w2">
							</a><br> <br>사용기한 : ${member.quitedate}</td>
							<td><span style="float: right; margin: 10px;"><button
										id="imagedel" class="close" type="button"
										style="color: black;">&times;</button></span><a id="itemdetail"
								href="#itdetail" data-toggle="modal"><img
									src="http://mblogthumb1.phinf.naver.net/20160420_291/donga-bacchus_14611160044242ryl6_GIF/002.gif?type=w2">
							</a><br> <br>사용기한 : ${member.quitedate}</td>
						</tr>
					</table>
				</div>
				<div id="myitemfooter" class="modal-footer">
					<button type="button" class="cancelbtn" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 아이템 상세보기 -->
	<div class="modal modal-center fade" id="itdetail" tabindex="-1"
		role="dialog" aria-labelledby="my80sizeCenterModalLabel">
		<div class="modal-dialog modal-80size modal-center" role="document">
			<div class="modal-content modal-80size" style="width: 630px;">
				<div class="modal-header">
					<h4 class="modal-title" id="myModalLabel">아이템 상세보기</h4>
				</div>
				<div class="modal-body">

					<div id="selectimage">
						<!-- 선택이미지 보여주기 -->
						<img
							src="http://mblogthumb1.phinf.naver.net/20160420_291/donga-bacchus_14611160044242ryl6_GIF/002.gif?type=w2">
					</div>
					<div id="information">
						<p>
							&nbsp; 이름 : <br> <br> &nbsp; 사용기한 :

						</p>
					</div>

				</div>
				<div class="modal-footer">
					<button type="button" class="cancelbtn" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</body>

<!--스크롤 배너 -->

<div id="floating" >
<a id="flotImg" href="cashcharge.jsp" style="text-decoration: none; ">
<img id="banner" src="https://image.freepik.com/free-vector/bills-and-coins-in-isometric-design_23-2147604444.jpg" border="0" width = "200px" height="130px" >
<div id="test" style="display: none; width:200px;height: 130px; font-size: 30px; text-align: center;"><br>결제하러 가기~</div>
</a>
</div>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<%@ include file="/footer.jsp"%>
</html>
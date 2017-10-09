<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <title>About Hmm</title>
      <meta charset="utf-8">
        <link href="resources/css/about.css" rel="stylesheet" type="text/css">
          <meta name="viewport" content="width=device-width, initial-scale=1">
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
 <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet" type="text/css">
 <link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet" type="text/css">
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
 <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
            <body>
              <%@ include file="/header.jsp"%>

              <div class="the_container">
                <h1>Hmm 팀을 소개합니다.</h1>
                <img id="the_team" src="resources/img/about_hmm.jpg"/>
              </div>
              <div class="the_container">
                <h2>Hmm에 쏟아지는 사회 곳곳에서의 찬사!</h2>
                <div id="myCarousel" class="carousel slide text-center" data-ride="carousel">
                  <!-- Indicators -->
                  <ol class="carousel-indicators">
                    <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                    <li data-target="#myCarousel" data-slide-to="1"></li>
                    <li data-target="#myCarousel" data-slide-to="2"></li>
                    <li data-target="#myCarousel" data-slide-to="3"></li>
                    <li data-target="#myCarousel" data-slide-to="4"></li>
                  </ol>

                  <!-- Wrapper for slides -->
                  <div class="carousel-inner" role="listbox">
                    <div class="item active">
                      <h4>"Hmm 최고의 IT 커뮤니티입니다. 자신있게 추천합니다."<br>
                          <span style="font-style:normal;">빌 게이츠, 前 마이크로소프트 사장, 전라남도 전주시 덕진구</span>
                        </h4>
                      </div>
                      <div class="item">
                        <h4>"이것은 혁명이다... 이전까지 이런 커뮤니티는 존재하지 않았다."<br>
                            <span style="font-style:normal;">김효숙, 이재훈 어머니, 청솔 부동산 대표</span>
                          </h4>
                        </div>
                        <div class="item">
                          <h4>"신이시여, 왜 다음카카오를 만드시고 Hmm을 다시 만드셨습니까?"<br>
                              <span style="font-style:normal;">스티브 잡스, 前 애플뮤직 대표, 무직</span>
                            </h4>
                          </div>
                          <div class="item">
                            <h4>"아, 배고프다. 피자 먹고 싶어."<br>
                                <span style="font-style:normal;">이기승, 웹개발 취업 희망자, 상록시티 주민</span>
                              </h4>
                            </div>
                            <div class="item">
                              <h4>"대한민국 대표 유산균 청인 딱좋아! 장 건강에 딱 좋아! 쾌변에 딱 좋아!"<br>
                                  <span style="font-style:normal;">박세준, 힐링 바이오 대표, 변비 환자</span>
                                </h4>
                              </div>
                        </div>

                        <!-- Left and right controls -->
                        <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
                          <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                          <span class="sr-only">Previous</span>
                        </a>
                        <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
                          <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                          <span class="sr-only">Next</span>
                        </a>
                      </div>
                    </div>

                    <div class="the_container"></div>
                    <div class="the_container"></div>
                    <div class="the_container"></div>
                    <div class="the_container"></div>

                  </body>
                  <%@ include file="/footer.jsp"%>

                </html>

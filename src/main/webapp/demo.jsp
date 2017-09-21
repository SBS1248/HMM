<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="UTF-8">
<meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no, width=device-width">
<meta name="csrf-token" content="xdoV866hjeuyniYpyjZiItMIJIGCcN5Rf0Scu2YQ" />
<title>결제 연동을 위한 정보</title>
<meta name="description" content="개발자를 위한 무료 결제연동 서비스">
    <meta name="keywords" content="python inicis, node.js inicis, ruby inicis, python LGU+, node.js
                                   LGU+, ruby LGU+, python 나이스페이, node.js 나이스페이, ruby 나이스페이,
                                   python pg연동, node.js pg연동, ruby pg연동, python 결제개발,
                                   node.js 결제개발, ruby 결제개발, python 결제연동, node.js 결제연동,
                                   ruby 결제연동, python KCP, node.js KCP, ruby KCP, PAYCO, PHP 결제연동,
                                   JAVA 결제연동, ASP 결제연동, PHP PG연동, JAVA PG연동, ASP PG연동, PG연동,
                                   PG사, PG결제, PG변경, KG이니시스, LGU+, 나이스페이, 페이게이트, KCP, JTNet, tPay,
                                   카카오페이, kakaopay, 네이버페이, 페이코, 전자결제, 결제연동, 결제개발, 결제서비스, 인터넷결제, 온라인결제, 카드결제,
                                   가상계좌, 실시간계좌이체, 휴대폰소액결제, 해외결제, 간편결제, 인앱결제,
                                   워드프레스 우커머스, 워드프레스 결제, 우커머스, 우커머스 쇼핑몰, 우커머스 결제,
                                   우커머스 플러그인, 워드프레스 플러그인, 무료 결제 플러그인, 결제 API, Paypal,
                                   Stripe, 카카오페이, 결제분석, 결제이상감지, 결제오류분석">
    <meta name="author" content="SIOT">
 <!-- jquery -->
    <script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.4.js"></script>
<script type="text/javascript" src="/assets/js/common/moment.min.js"></script>
<script type="text/javascript" src="http://iamport.kr/assets/js/controllers/demo.js?d=20170815"></script>
<link href="http://iamport.kr/assets/css/demo.css?d=20170112" rel="stylesheet"> 
</head>
<body>
<div ng-controller="demoCtrl">
    <section style="background-color: #18bc9c">
        <div class="container" style="padding: 50px 0 50px 0;">
            <h1>I'mport; 결제 모듈 DEMO</h1>
            <div id="demo" class="col-md-8 col-md-offset-1 col-xs-11">
                <form name="frm_payment" id="frm_payment" class="form-horizontal">
                    <div class="form-group" style="margin-bottom: 0px;">
                        <label for="pg_provider" class="col-md-4 col-xs-4">지원 PG사</label>
                        <select id="pg_provider" ng-model="pg" class="col-md-8 col-xs-8" ng-options="pg as pg.name for pg in pgProviders track by pg.id">
                        </select>
                    </div>
                    <div class="form-group">
                        <p id="pay_method_help" ng-bind="getHelpText(pg.id)" class="col-md-8 col-md-offset-4 col-xs-11 col-xs-offset-1">
                        </p>
                    </div>
                    <div class="form-group" style="margin-bottom: 0px;">
                        <label for="pay_method" class="col-md-4 col-xs-4">결제수단</label>
                        <select id="pay_method" ng-model="payMethod" ng-options="m as m.name for m in pg.payMethod track by m.value" class="col-md-8 col-xs-8">
                        </select>
                    </div>
                    <div class="form-group">
                        <div class="checkbox col-md-4 col-md-offset-3" style="padding: 0px;">
                            <label>
                                <input type="checkbox" name="use_escrow" ng-model="use_escrow">
                                <span id="escrow-label"> 에스크로결제적용</span>
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="merchant_uid" class="col-md-4 col-xs-4">주문번호</label>
                        <input type="text" name="merchant_uid" id="merchant_uid" ng-model="merchant_uid" class="col-md-8 col-xs-8"/>
                    </div>
                    <div class="form-group">
                        <label for="name" class="col-md-4 col-xs-4">결제명</label>
                        <input type="text" name="name" id="name"  ng-model="name" class="col-md-8 col-xs-8"/>
                    </div>
                    <div class="form-group">
                        <label for="amount" class="col-md-4 col-xs-4">금액</label>
                        <input type="tel" name="amount" id="amount" ng-model="amount" class="col-md-8 col-xs-8"/>
                    </div>
                    <div class="form-group">
                        <label for="buyer_email" class="col-md-4 col-xs-4">이메일주소</label>
                        <input type="text" name="buyer_email" id="buyer_email"  ng-model="buyer_email" class="col-md-8 col-xs-8"/>
                    </div>
                    <div class="form-group">
                        <label for="buyer_name" class="col-md-4 col-xs-4">성함</label>
                        <input type="text" name="buyer_name" id="buyer_name"  ng-model="buyer_name" class="col-md-8 col-xs-8"/>
                    </div>
                    <div class="form-group">
                        <label for="buyer_tel" class="col-md-4 col-xs-4">전화번호</label>
                        <input type="tel" name="buyer_tel" id="buyer_tel" ng-model="buyer_tel" class="col-md-8 col-xs-8"/>
                    </div>
                    <div class="form-group">
                        <label for="buyer_addr" class="col-md-4 col-xs-4">주소</label>
                        <input type="text" name="buyer_addr" id="buyer_addr"  ng-model="buyer_addr" class="col-md-8 col-xs-8"/>
                    </div>
                    <div class="form-group">
                        <label for="buyer_postcode" class="col-md-4 col-xs-4">우편번호</label>
                        <input type="text" name="buyer_postcode" id="buyer_postcode" ng-model="buyer_postcode" class="col-md-8 col-xs-8"/>
                    </div>
                    <div class="form-group">
                        <label for="vbank_due" class="col-md-4 col-xs-4">가상계좌 입금일자<br>(YYYYMMDD)</label>
                        <input type="text" name="vbank_due" id="vbank_due"  ng-model="vbank_due" class="col-md-8 col-xs-8"/>
                    </div>

                    <div class="form-group">
                    <label for="in_app" class="col-md-4 col-xs-4"></label>
                    <label for="in_app" class="col-md-8 col-xs-8" style="text-align:left">
                        <input type="checkbox" name="in_app" ng-model="in_app">
                        <span> 앱내 webView를 통한 결제인 경우만 체크</span>
                    </label>
                </div>
                </form>
                <pre id="responser" ng-show="is_response" ng-bind="response"></pre>
                <a class="btn btn-primary" ng-click="payRequest()">결제하기</a>
            </div>
        </div>
    </section>
</div>
</body>
</html>
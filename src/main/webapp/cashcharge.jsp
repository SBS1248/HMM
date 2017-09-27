<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="resources/css/cashcharge.css">
<link rel="stylesheet" type="text/css"
	href="resources/css/chargebutton.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<title>캐쉬 결제 창</title>
	<!-- 아임포트 결제스크립트 -->
	<script src="https://service.iamport.kr/js/iamport.payment-1.1.2.js"
		type="text/javascript"></script>
	<script type="text/javascript">
		$(function() {
			IMP.init('imp86108516'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
			document.getElementById("cashbuy").onclick = function() {
				pay_test()
			};
		});
		function pay_test() {
			IMP.request_pay(
							{
								pg : 'uplus', //ActiveX 결제창은 inicis를 사용
								pay_method : 'card', //card(신용카드), trans(실시간계좌이체), vbank(가상계좌), phone(휴대폰소액결제)
								merchant_uid : 'merchant_'
										+ new Date().getTime(), //상점에서 관리하시는 고유 주문번호를 전달
								name : '주문명:결제테스트'/*  '주문명: $("input[type=radio]:checked").name' */,
								amount : dPrice,
								buyer_email : 'asdf@asdf.com',
								buyer_name : 'test',
								buyer_tel : '010-1111-5555', //누락되면 이니시스 결제창에서 오류
								buyer_addr : '서울특별시 강남구',
								buyer_postcode : '123-456'
							}, function(rsp) {
								if (rsp.success) {
									var msg = '결제가 완료되었습니다.';
									msg += '고유ID : ' + rsp.imp_uid;
									msg += '상점 거래ID : ' + rsp.merchant_uid;
									msg += '결제 금액 : ' + rsp.paid_amount;
									msg += '카드 승인번호 : ' + rsp.apply_num;
								} else {
									var msg = '결제에 실패하였습니다.';
									msg += '에러내용 : ' + rsp.error_msg;
								}
								alert(msg);
							});
		};
	</script>
<%@ include file="/header.jsp"%>
</head>
<body>
	<div class="wrap">
		<div class="WolfharuRadioCheckbox">
			<form name="" action="">
				<fieldset>
					<legend>결제 방식을 선택하여 주십시오.</legend>
					<p class="ti">결제 방식</p>
					<div class="para">
						<p>
							<input type="radio" name="cash" id="d1" value="1000"
								checked="checked"> <label for="onecash">1000원(100따루)</label>
						</p>
						<p>
							<input type="radio" name="cash" id="d2" value="5000"> <label
								for="twocash">5000원(500따루)</label>
						</p>
						<p>
							<input type="radio" name="cash" id="d3" value="10000"> <label
								for="threecash">10000원(10000따루 + 150따루)</label>
						</p>
						<p>
							<input type="radio" name="cash" id="d4" value="14000"> <label
								for="fourcash">14000원(15000따루 + 300따루)</label>
						</p>
					</div>
				</fieldset>
			</form>
		</div>
	</div>

	<div id="cashbuy" class="button_base b05_3d_roll"
		style="position: absolute; left: 40%; top: 65%;">
		<div>결제하기</div>
		<div>결제하기</div>
	</div>

	<div class="button_base b05_3d_roll"
		style="position: absolute; left: 55%; top: 65%;"
		onclick="location.href='cashshop.jsp'">
		<div>돌아가기</div>
		<div>돌아가기</div>
	</div>
</body>
<%@ include file="/footer.jsp"%>
</html>
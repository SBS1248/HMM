<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="resources/css/cashcharge.css">
<link rel="stylesheet" type="text/css" href="resources/css/chargebutton.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<title>캐쉬 결제 창</title>
<style type="text/css">

</style>
<%@ include file="/header.jsp"%>
</head>
<body>
<div class= "wrap">
<div class="WolfharuRadioCheckbox">
		<form name="" action="">
			<fieldset>
				<legend>결제 방식을 선택하여 주십시오.</legend>
				<p class="ti">결제 방식</p>
				<div class="para">
					<p>
						<input type="radio" name="cash" id="onecash" value="1000" checked="checked">
						<label for="onecash">1000원(100캐시)</label>
					</p>
					<p>
						<input type="radio" name="cash" id="twocash" value="5000">
						<label for="twocash">5000원(500캐시)</label>
					</p>
					<p>
						<input type="radio" name="cash" id="threecash" value="10000">
						<label for="threecash">10000원(10000캐시 + 150캐시)</label>
					</p>
					<p>
						<input type="radio" name="cash" id="fourcash" value="14000">
						<label for="fourcash">14000원(15000캐시 + 300캐시)</label>
					</p>
				</div>
			</fieldset>
		</form>
	</div>
</div><br><br>

 <!-- 아임포트 결제스크립트 -->
 <script src="https://service.iamport.kr/js/iamport.payment-1.1.2.js" type="text/javascript"></script>
 <script type="text/javascript">

$(function(){
	<%-- var price = <%=price%>;
	numberWithCommas(price); --%>
	IMP.init('imp86108516'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
});
function pay_test(){
	 IMP.request_pay({
		    pg : 'uplus', //ActiveX 결제창은 inicis를 사용
		    pay_method : 'card', //card(신용카드), trans(실시간계좌이체), vbank(가상계좌), phone(휴대폰소액결제)
		    merchant_uid : 'merchant_' + new Date().getTime(), //상점에서 관리하시는 고유 주문번호를 전달
		    name : '주문명:결제테스트'/*  '주문명: $("input[type=radio]:checked").name' */,
		    amount : '100',
		 	 buyer_email : 'iamport@siot.do',
		    buyer_name : '구매자이름'/*  '${member.id}' */,
		    buyer_tel : '010-1234-5678', //누락되면 이니시스 결제창에서 오류
		    buyer_addr : '서울특별시 강남구 삼성동',
		    buyer_postcode : '123-456'
		}, function(rsp) {
		    if ( rsp.success ) {
		    	//[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
		    	$.ajax({
		    		url: "/payments/complete", //cross-domain error가 발생하지 않도록 주의해주세요
		    		type: 'POST',
		    		dataType: 'json',
		    		data: {
		    		 	<%-- item : 'design',
						code : '<%=%>',
						quan : <%=%>, --%>
						imp_uid : rsp.imp_uid,
						pay_method : rsp.pay_method,
						price : rsp.paid_amount,
						status : rsp.status,
						title : rsp.name,
						pg_tid : rsp.pg_tid,
						/* buyer_name : rsp.buyer_name,
						paid_at : rsp.paid_at, */
						receipt_url : rsp.receipt_url
					//기타 필요한 데이터가 있으면 추가 전달
		    		}
		    	}).done(function(data) {
		    		//[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
		    		if ( everythings_fine ) {
		    			var msg = '결제가 완료되었습니다.';
		    			msg += '\n고유ID : ' + rsp.imp_uid;
		    			msg += '\n상점 거래ID : ' + rsp.merchant_uid;
		    			msg += '\n결제 금액 : ' + rsp.paid_amount;
		    			msg += '카드 승인번호 : ' + rsp.apply_num;
		    			
		    			alert(msg);
		    		} else {
		    			alert("결제가 정상적으로 이루어지지 않았습니다.\n결제 내역을 확인해 주세요.");
		    			//[3] 아직 제대로 결제가 되지 않았습니다.
		    			//[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
		    		}
		    	});
		    } else {
		        var msg = '결제에 실패하였습니다.';
		        msg += '에러내용 : ' + rsp.error_msg;
		        
		        alert(msg);
		    }
		});
};
$(function(){
document.getElementById("cashbuy").onclick = function(){pay_test()};
});
</script>
 
    <div id="cashbuy" class="button_base b05_3d_roll"  style="position: absolute; left : 40%; top:65%;">
        <div>결제하기</div>
        <div>결제하기</div>
    </div>
    
    <div class="button_base b05_3d_roll" style="position: absolute; left : 55%; top:65%;" onclick="location.href='cashshop.jsp'">
        <div>돌아가기</div>
        <div>돌아가기</div>
    </div>
   
    
</body>
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
<%@ include file="/footer.jsp"%>
</html>
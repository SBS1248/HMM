<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link href="resources/css/login.css" rel="stylesheet" type="text/css">
	<link
		href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css"
		rel="stylesheet">
	<script
		src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
	<script
		src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>
	<link
		href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css"
		rel="stylesheet">
	<script
		src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>
<script src="https://apis.google.com/js/platform.js" async defer></script>
<meta name="google-signin-client_id"
	content="419809006981-bkqqk1p2e3bhevtice98fcc9efo5fhkp.apps.googleusercontent.com">

<!-- 로그인 모달 -->
<div class="container">

	<div id="loginModal" class="modal">

		<div class="container">
			<div class="modal-content animate">
				<div class="modal-header">
					<h4 class="modal-title">로그인</h4>
				</div>
				<div class="modal-body">
					<input type="text" name="id" placeholder="아이디를 입력해 주세요" required>
					<input type="password" name="password" placeholder="비밀번호를 입력해 주세요"
						required onkeydown='javascript:onEnterSubmit()'>
					<button type="button" id="loginbtn" onclick="onSubmit()">로그인</button>
					<br>
					<hr>
					<p>구글 계정으로 로그인하기:</p>
					<div class="g-signin2" data-width="100%" data-onsuccess="onSignIn"></div>
				</div>
				<span class="psw" style="float: left;">&nbsp; 혹시 <a href="#"
					style="text-decoration: none;" onclick="popupSearch()">아이디/비밀번호</a>를
					잊으셨나요?
				</span>
				<div class="modal-footer">
					<button type="button" id="cancelbtn" data-dismiss="modal">창
						닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 로그인 모달 -->

<script type="text/javascript">
	count = 0;
	function onEnterSubmit() {
		var keyCode = window.event.keyCode;
		if (keyCode == 13) {
			onSubmit();
		}
	}

	function onSubmit() {

		var id = $('input[name=id]').val();
		var pwd = $('input[name=password]').val();

		if (id == '' || pwd == '') {
			alert("아이디/패스워드를 입력해 주세요!!");
			return;
		}

		var member = {
			"id" : $('input[name=id]').val(),
			"password" : $('input[name=password]').val()
		}

		$.ajax({
			type : "POST",
			url : "login.do",
			data : member,
			dataType : "text",
			success : function(rData, textStatus, xhr) {
				var chkRst = rData;
				if (chkRst == "true") {
					window.location.reload();
				} else {
					count = count + 1;
					if (count == 4) {
						popupSearch();
						count = 0;
						return;
					}
					alert("아이디/패스워드를 확인해 주세요!!");
					$('input[name=id]').val('');
					$('input[name=password]').val('');

				}
			},
			error : function() {
				alert("로그인 실패!!");
			}
		});

	}
	// Get the modal
	var modal = document.getElementById('loginModal');

	// When the user clicks anywhere outside of the modal, close it
	window.onclick = function(event) {
		if (event.target == modal) {
			modal.style.display = "none";
		}
	}

	function onSignIn(googleUser) {
		var profile = googleUser.getBasicProfile();
		console.log('ID: ' + profile.getId()); // Do not send to your backend! Use an ID token instead.
		console.log('Name: ' + profile.getName());
		console.log('Image URL: ' + profile.getImageUrl());
		console.log('Email: ' + profile.getEmail()); // This is null if the 'email' scope is not present.
		var email = profile.getEmail();
		var id = email.substring(0, email.lastIndexOf('@'));

		var member = {
			"id" : id,
			"photo" : profile.getImageUrl(),
			"email" : profile.getEmail(),
			"password" : "googleLogin",
			"job" : "etc"
		};

		$.ajax({
			type : "POST",
			url : "google.do",
			data : member,
			dataType : "text",
			success : function(rData, textStatus, xhr) {
				var chkRst = rData;
				if (chkRst == "true") {
					var auth2 = gapi.auth2.getAuthInstance();
					auth2.signOut().then(function() {
						console.log('User signed out.');
					});
					window.location.reload();
				} else {
					$('input[name=id]').val('');
					$('input[name=password]').val('');
				}
			},
			error : function() {
				alert("로그인 실패!!");
			}
		});

	}

	function popupSearch() {
		var popUrl = "resources/search/Search.jsp";
		var popOption = "width=400, height=auto, resizable=yes, scrollbars=no, status=no;"; //팝업창 옵션(optoin)
		window.open(popUrl, "", popOption);
	}
</script>

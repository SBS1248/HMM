<%@page import="com.kh.hmm.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<!-- 회원수정 모달 -->
<c:set var="job" value="${member.job }" scope="session" />
<c:set var="photo" value="${member.photo }" scope="session" />
<c:set var="quitDate" value="${member.quitdate}" scope="session" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="resources/css/updateMember.css" rel="stylesheet"
	type="text/css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script type="text/javascript">
	fileExt = 0;
	$(function() {
		var quitDate = '${quitDate}';

		if (quitDate != '')
			alert(quitDate + "일에 회원 탈퇴될 예정 입니다!!");

		var job = "${job}";
		$('#updateJob option').each(function() {
			if ($(this).val() == job)
				$(this).attr('selected', 'selected');
		});

		$("#imgUpload").on('change', function() {
			fileExt = this.value;
			readURL(this);
		});

	});
	function readURL(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();

			reader.onload = function(e) {
				$('#profileImg').attr('src', e.target.result);
			}

			reader.readAsDataURL(input.files[0]);
		}
	}
	b

	function validationDate() {
		var x = document.updateForm.password.value;
		var y = document.updateForm.passwordConfirm.value;
		var cfm = confirm("수정 하시겠습니까?");
		if (cfm) {
			if (x == y)
				$('#updateForm').submit();
			else
				alert("비밀번호를 한번 더 확인해주세요!!");
		} else {
			return;
		}

	}

	function validationFile() {
		var file = fileExt.substring(fileExt.lastIndexOf('.') + 1);
		if (file.toUpperCase() == "JPG" || file.toUpperCase() == "PNG"
				|| file.toUpperCase() == "GIF") {
			$('#pictureUpload').submit();
		} else {
			alert("jpg, png, gif 파일만 업로드 가능합니다!!");
			return;
		}
	}

	function deleteMember() {
		var cfm = confirm("회원 탈퇴 하시겠습니까?");
		if (cfm) {
			location.href = "deleteMember.do";
		} else {
			return;
		}
	}
</script>

<title>회원 정보 수정</title>
</head>


<body>
	<%@ include file="/header.jsp"%>

	<div class="container">

		<div class="profile_board">
			<!-- Modal content-->
			<div class="profile">

				<div class="profile-heading">${member.id}님의프로필</div>
				<div class="profile-body">
					<form id="pictureUpload" name="pictureUpload"
						action="uploadFile.do" method="POST" enctype="multipart/form-data">
						<c:choose>
							<c:when test="${null eq photo}">
								<img id="profileImg" src="resources/img/defaultImg.jpg"
									alt="profileImg" />
							</c:when>
							<c:when test="${null ne photo}">
								<img id="profileImg" src="${photo}" alt="profileImg" />
							</c:when>
						</c:choose>
						<br> <br> <input type='file' id="imgUpload" name="photo"
							id="photo" /> <br>

						<button type="button" id="file_upload_btn"
							onclick="validationFile()">프로필 사진 업로드</button>
					</form>
					<form id="updateForm" name="updateForm" action="update.do"
						method="POST">
						<input id="input_id" type="text" name="id" value="${member.id}"
							readonly> <input type="password" name="password"
							placeholder="비밀번호" value="${member.password}" required
							id="password"><br> <input type="password"
							id="passwordConfirm" name="passwordConfirm" placeholder="비밀번호 확인"
							value="${member.password}" required id="passwordConfirm"><br>
						<input type="email" name="email" placeholder="이메일"
							value="${member.email}" required /><br> <select name="job"
							id="updateJob">
							<option value="student">학생</option>
							<option value="business">회사원</option>
							<option value="jobless">무직</option>
							<option value="etc">기타</option>
						</select> <br>
						<button id="profile_update_btn" type="button"
							onclick="validationDate()">수정하기</button>
						<button id="profile_delete_btn" type="button"
							onclick="deleteMember()">회원 탈퇴</button>
					</form>
				</div>

				<div class="profile-footer">
					<label>메달 갯수 : ${member.medal}</label> <br> <label>경험치
						: ${member.exp}</label> <br> <label>남은 캐시 : ${member.chash}</label> <br>
					<label>남은 따루 : ${member.ddaru}</label> <br> <label>가입일
						: ${member.enrolldate}</label>

				</div>
			</div>
		</div>


	</div>
</body>
</html>

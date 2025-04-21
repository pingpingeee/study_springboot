<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${pageContext.request.contextPath}/js/jquery.js"></script>
<script type="text/javascript">
	function fn_submit() {
		alert("011");
		var formData = $("#frm").serialize();
		alert("02");

		//비동기 전송방식의 jquery 함수
		$.ajax({
			type : "post",
			data : formData,
			url : "registerOk",
			success : function(data) {
				alert("저장완료");
				location.href="login";
			},
			error : function() {
				alert("오류발생");
			}
		});
	}
</script>
</head>
<body>
	<table border="1" align="center">
<!-- 		<form method="post" action="registerOk"> -->
		<form id="frm">
			<tr height="50">
				<td colspan="2">
					<h1>회원 가입 신청</h1>
				</td>
			</tr>
			<tr height="30">
				<td width="80">
					User ID
				</td>
				<td>
					<input type="text" size="20" name="mem_uid">
				</td>
			</tr>
			<tr height="30">
				<td width="80">
					암호
				</td>
				<td>
					<input type="text" size="20" name="mem_pwd">
				</td>
			</tr>
			<tr height="30">
				<td width="80">
					이름
				</td>
				<td>
					<input type="text" size="20" name="mem_name">
				</td>
			</tr>
			<tr height="30">
				<td colspan="2">
<!-- 					<input type="submit" value="등록"> -->
					<input type="button" value="등록" onclick="fn_submit()">
				</td>
			</tr>
		</form>
	</table>
</body>
</html>
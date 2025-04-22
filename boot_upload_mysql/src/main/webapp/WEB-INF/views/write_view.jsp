<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script src="${pageContext.request.contextPath}/js/jquery.js"></script>
		<script type="text/javascript">
			function fn_submit() {
				var formData = $("#frm").serialize();

				$.ajax({
					type: "post"
					, data: formData
					, url: "write"
					, success: function (data) {
						alert("저장완료")
						location.href = "list";
					}
					, error: function () {
						alert("오류발생")
					}
				});
			}
		</script>
	</head>

	<body>
		<table width="500" border="1">
			<form id="frm">
				<tr>
					<td>이름</td>
					<td>
						<input type="text" name="boardName" size="50">
					</td>
				</tr>
				<tr>
					<td>제목</td>
					<td>
						<input type="text" name="boardTitle" size="50">
					</td>
				</tr>
				<tr>
					<td>내용</td>
					<td>
						<textarea rows="10" name="boardContent"></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="button" onclick="fn_submit()" value="입력">
						&nbsp;&nbsp;
						<a href="list">목록</a>
					</td>
				</tr>
			</form>
		</table>

		File Attach
		<div class="uploadDiv">
			<input type="file" name="uploadFile" multiple>
		</div>
		<div class="uploadResult">
			<ul>

			</ul>
		</div>
	</body>

	</html>
	<script>
		$(document).ready(function (e) {
			// 확장자가 exe|sh|alz 업로드 금지하기 위한 정규식
			var regex = new RegExp("(.*?)\.(exe|sh|alz)");
			// 파일크기 (5MB 미만) 조건
			var maxSize = 5242880; // 5MB

			function checkExtension(fileName, fileSize) {
				if (fileSize >= maxSize) {
					alert("파일 사이즈 초과");
					return false;
				}
				if (regex.test(fileName)) {
					alert("해당 종류의 파일은 업로드 할 수 없습니다.");
					return false;
				}
				return true;
			}

			$("input[type='file']").change(function (e) {
				var formData = new FormData();
				var inputFile = $("input[name='uploadFile']");
				// files : 파일정보
				var files = inputFile[0].files;

				for (var i = 0; i < files.length; i++) {
					console.log("@#files=> " + files[i].name);

					// 파일 크기와 종류 중에서 거짓이면 리턴
					<!--					if (checkExtension(files[i].name, files[i].size)) {-->
					if (!checkExtension(files[i].name, files[i].size)) {
						return false;
					}

					formData.append("uploadFile", files[i]);
				}

				$.ajax({
					type: "post",
					data: formData,
					url: "uploadAjaxAction",
					// processData : 기본은 key/value를 Query String으로 전송하는게 true
					// (파일업로드는 false)
					processData: false,

					// contentType : 기본값 : "application / x-www-form-urlencoded; charset = UTF-8"
					// 첨부파일은 false : multipart/form-data로 전송됨
					contentType: false,
					success: function (result) {
						alert("Uploaded");
						console.log(result);
						// 파일 정보들을 함수로 보냄
						showUploadResult(result); // 업로드 결과 처리 함수
					}
				}); // end of ajax
				function showUploadResult(uploadResultArr) {
					if (!uploadResultArr || uploadResultArr.length == 0) {
						return;
					}
					var uploadUL = $(".uploadResult ul");
					var str = "";

					$(uploadResultArr).each(function (i, obj) {
						// image type
						if (obj.image) {
							console.log("@#obj.uploadPath =>" + obj.uploadPath);
							console.log("@#obj.uuid =>" + obj.uuid);
							console.log("@#obj.fileName =>" + obj.fileName);

							var fileCallPath = obj.uploadPath + obj.uuid + "_" + obj.fileName;
							str += "<li><div>"
							str += "<span>" + obj.fileName + "</span>";
							str += "<img src='/display?fileName=" + fileCallPath + "'>";
							str += "</li>"
						} else {
							// var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
							var fileCallPath = obj.uploadPath + obj.uuid + "_" + obj.fileName;
							str += "<li><div>"
							str += "<span>" + obj.fileName + "</span>";
							str += "<img src='./resources/img/attach.png'>";
							str += "</li>"
						}
					}); // end of each
				}
			}) // end of change
		}); // end of ready
	</script>
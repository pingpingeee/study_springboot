<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<html>

		<head>
			<meta charset="UTF-8">
			<title>Insert title here</title>
		</head>

		<body>
			<table width="500" border="1">
				<tr>
					<td>번호</td>
					<td>이름</td>
					<td>제목</td>
					<td>날짜</td>
					<td>히트</td>
				</tr>
				<!-- 		조회결과 -->
				<!-- 		list : 모델객체에서 보낸 이름 -->
				<c:forEach var="dto" items="${list}">
					<tr>
						<td>${dto.boardNo}</td>
						<td>${dto.boardName}</td>
						<td>
							<%-- ${dto.boardTitle} --%>
								<!-- 			content_view : 컨트롤러단 호출 -->
								<a href="content_view?boardNo=${dto.boardNo}">${dto.boardTitle}</a>
						</td>
						<td>${dto.boardDate}</td>
						<td>${dto.boardHit}</td>
					</tr>
				</c:forEach>
				<tr>
					<td colspan="5">
						<!-- write_view : 컨트롤러단 호출 -->
						<a href="write_view">글작성</a>
					</td>
				</tr>
			</table>
			<h3>${pageMaker}</h3>
			<div class="div_page">
				<ul>
					<c:if test="${pageMaker.prev}">
						<!-- <li>[Previous]</li> -->
						<li class="paginate_button">
							<a href="${pageMaker.startPage - 1}">
								[Previous]
							</a>
						</li>
					</c:if>

					<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
						<!-- <li>[${num}]</li> -->
						<li class="paginate_button" ${pageMaker.criteriaDTO.pageNum==num ? "style='color: red'" :""}>
							<a href="${num}">
								[${num}]
							</a>
						</li>
					</c:forEach>

					<c:if test="${pageMaker.next}">
						<!-- <li>[Next]</li> -->
						<li class="paginate_button">
							<a href="${pageMaker.endPage+1}">
								[Next]
							</a>
						</li>
					</c:if>
				</ul>
			</div>
		</body>
		<style>
			.div_page ul {
				display: flex;
				list-style: none;
			}
		</style>

		</html>
		<script src="${pageContext.request.contextPath}/js/jquery.js"></script>
		<script>
			// 페이지번호 처리
			$(".paginate_button a").on("click", function(e){
				e.preventDefault();
				console.log("click했음");
				console.log("@# href => " + $(this).attr("href"));
			}); // end of paginate_button click
		</script>
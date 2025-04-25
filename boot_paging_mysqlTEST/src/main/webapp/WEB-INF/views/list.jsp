<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시판</title>
    <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pagination.css">
</head>
<body>
    <!-- 게시판 내용 -->
    
    <!-- 페이징 태그 사용 -->
    <custom:pagination pageMaker="${pageMaker}" formId="actionForm" />
    
    <!-- 페이징 처리를 위한 폼 -->
    <form id="actionForm" action="list" method="get">
        <input type="hidden" name="pageNum" value="${pageMaker.criteriaDTO.pageNum}">
        <input type="hidden" name="amount" value="${pageMaker.criteriaDTO.amount}">
    </form>
    
    <script>
        var actionForm = $("#actionForm");

        // 페이지번호 처리
        $(".paginate_button a").on("click", function (e) {
            e.preventDefault();
            console.log("click했음");
            console.log("@# href => " + $(this).attr("href"));

            actionForm.find("input[name='pageNum']").val($(this).attr("href"));
            
            // 버그처리(게시글 클릭 후 뒤로가기 누른 후 다른 페이지 클릭 할 때 content_view2가 작동되는 것을 해결)
            actionForm.attr("action", "list").submit();
        });

        // 게시글 처리
        $(".move_link").on("click", function (e) {
            e.preventDefault();
            console.log("move_link click");
            console.log("@# click => " + $(this).attr("href"));

            var targetBno = $(this).attr("href");

            // 버그처리(게시글 클릭 후 뒤로가기 누른 후 다른 게시글 클릭 할 때 &boardNo=번호 게속 누적되는 거 방지)
            var bno = actionForm.find("input[name='boardNo']").val();
            if(bno!=""){
                actionForm.find("input[name='boardNo']").remove();
            }

            // "content_view?boardNo=${dto.boardNo}"를 actionForm로 처리
            actionForm.append("<input type='hidden' name='boardNo' value='" + targetBno + "'>");
            // 컨트롤러에 content_view로 찾아감
            actionForm.attr("action", "content_view").submit();
        });
    </script>
</body>
</html>
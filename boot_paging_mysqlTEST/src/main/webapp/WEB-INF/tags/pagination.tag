<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="pageMaker" required="true" type="com.boot.dto.PageDTO" %>
<%@ attribute name="formId" required="true" %>
<%@ attribute name="cssClass" required="false" %>

<div class="${empty cssClass ? 'pagination-container' : cssClass}">
    <ul class="pagination">
        <c:if test="${pageMaker.prev}">
            <li class="paginate_button">
                <a href="${pageMaker.startPage - 1}" title="이전">
                    [Previous]
                </a>
            </li>
        </c:if>

        <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
            <li class="paginate_button" ${pageMaker.criteriaDTO.pageNum==num ? "style='color: red'" :""}>
                <a href="${num}">
                    [${num}]
                </a>
            </li>
        </c:forEach>

        <c:if test="${pageMaker.next}">
            <li class="paginate_button">
                <a href="${pageMaker.endPage+1}" title="다음">
                    [Next]
                </a>
            </li>
        </c:if>
    </ul>
</div>
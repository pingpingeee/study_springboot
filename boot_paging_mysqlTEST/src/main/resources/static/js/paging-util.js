// /resources/js/paging-util.js
/**
 * 페이징 처리를 위한 유틸리티 함수
 */
const PagingUtil = {
    /**
     * 페이징 처리 초기화
     * @param {string} formId - 폼 ID
     * @param {string} linkClass - 게시글 링크 클래스
     * @param {string} listUrl - 목록 URL
     * @param {string} viewUrl - 상세보기 URL
     */
    init: function(formId, linkClass, listUrl, viewUrl) {
        const actionForm = $("#" + formId);
        
        // 페이지번호 처리
        $(".paginate_button a").on("click", function (e) {
            e.preventDefault();
            console.log("페이지 클릭: " + $(this).attr("href"));
            
            actionForm.find("input[name='pageNum']").val($(this).attr("href"));
            actionForm.attr("action", listUrl).submit();
        });
        
        // 게시글 처리
        $("." + linkClass).on("click", function (e) {
            e.preventDefault();
            console.log("게시글 클릭: " + $(this).attr("href"));
            
            const targetBno = $(this).attr("href");
            
            // 버그처리(게시글 클릭 후 뒤로가기 누른 후 다른 게시글 클릭 할 때 &boardNo=번호 게속 누적되는 거 방지)
            const bno = actionForm.find("input[name='boardNo']").val();
            if(bno !== "") {
                actionForm.find("input[name='boardNo']").remove();
            }
            
            actionForm.append("<input type='hidden' name='boardNo' value='" + targetBno + "'>");
            actionForm.attr("action", viewUrl).submit();
        });
    }
};
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시판</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&family=Playfair+Display:wght@500;700&display=swap" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <style>
        :root {
            --primary: #2e7d32;
            --primary-dark: #1b5e20;
            --primary-light: #c8e6c9;
            --accent: #d4af37;
            --accent-light: #f9f3d9;
            --accent-dark: #b08c1e;
            --secondary: #78909c;
            --success: #43a047;
            --danger: #e53935;
            --warning: #ffb300;
            --info: #039be5;
            --dark: #263238;
            --light: #fafafa;
            --border: #e0e0e0;
            --text-primary: #37474f;
            --text-secondary: #607d8b;
            --text-light: #90a4ae;
            --shadow-sm: 0 2px 4px rgba(0, 0, 0, 0.04);
            --shadow: 0 4px 6px rgba(0, 0, 0, 0.06);
            --shadow-md: 0 6px 10px rgba(0, 0, 0, 0.08);
            --shadow-lg: 0 15px 20px rgba(0, 0, 0, 0.05);
            --radius-sm: 0.125rem;
            --radius: 0.25rem;
            --radius-md: 0.375rem;
            --radius-lg: 0.5rem;
            --radius-xl: 0.75rem;
            --radius-2xl: 1rem;
            --radius-full: 9999px;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Noto Sans KR', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
            background-color: #f5f5f5;
            color: var(--text-primary);
            line-height: 1.5;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
        }

        .container {
            max-width: 1200px;
            margin: 2.5rem auto;
            padding: 0 1.5rem;
        }

        .board-container {
            background-color: white;
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-lg);
            overflow: hidden;
            position: relative;
        }

        .board-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(to right, var(--primary), var(--accent));
        }

        .board-header {
            padding: 2rem;
            border-bottom: 1px solid var(--border);
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: white;
        }

        .board-title {
            font-family: 'Playfair Display', serif;
            font-size: 1.75rem;
            font-weight: 700;
            color: var(--dark);
            margin: 0;
            position: relative;
            padding-left: 1rem;
        }

        .board-title::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0.25rem;
            bottom: 0.25rem;
            width: 4px;
            background-color: var(--primary);
            border-radius: var(--radius);
        }

        .board-actions {
            display: flex;
            gap: 0.75rem;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 0.625rem 1.25rem;
            font-size: 0.875rem;
            font-weight: 500;
            border-radius: var(--radius-md);
            transition: all 0.3s ease;
            cursor: pointer;
            border: none;
            outline: none;
            text-decoration: none;
            position: relative;
            overflow: hidden;
        }

        .btn::after {
            content: '';
            position: absolute;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            pointer-events: none;
            background-image: radial-gradient(circle, #fff 10%, transparent 10.01%);
            background-repeat: no-repeat;
            background-position: 50%;
            transform: scale(10, 10);
            opacity: 0;
            transition: transform .5s, opacity 1s;
        }

        .btn:active::after {
            transform: scale(0, 0);
            opacity: .3;
            transition: 0s;
        }

        .btn-primary {
            background-color: var(--primary);
            color: white;
            box-shadow: 0 2px 4px rgba(46, 125, 50, 0.2);
        }

        .btn-primary:hover {
            background-color: var(--primary-dark);
            box-shadow: 0 4px 8px rgba(46, 125, 50, 0.3);
            transform: translateY(-1px);
        }

        .btn-primary:active {
            transform: translateY(0);
        }

        .btn-outline {
            background-color: transparent;
            color: var(--secondary);
            border: 1px solid var(--border);
            box-shadow: var(--shadow-sm);
        }

        .btn-outline:hover {
            background-color: var(--light);
            border-color: var(--secondary);
            box-shadow: var(--shadow);
            transform: translateY(-1px);
        }

        .btn-outline:active {
            transform: translateY(0);
        }

        .btn-icon {
            margin-right: 0.5rem;
            font-size: 0.875rem;
        }

        .board-content {
            padding: 1.5rem 2rem;
        }

        .board-info {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
            color: var(--text-secondary);
            font-size: 0.875rem;
        }

        .board-count {
            display: flex;
            align-items: center;
        }

        .board-count-number {
            font-weight: 700;
            color: var(--primary);
            margin: 0 0.25rem;
        }

        .board-table-container {
            overflow-x: auto;
            margin-bottom: 1.5rem;
            border-radius: var(--radius-md);
            box-shadow: var(--shadow-sm);
        }

        .board-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            font-size: 0.9375rem;
        }

        .board-table th {
            background-color: #f9f9f9;
            color: var(--text-secondary);
            font-weight: 500;
            text-align: left;
            padding: 1rem;
            border-bottom: 1px solid var(--border);
            position: relative;
        }

        .board-table th:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            height: 1px;
            background: linear-gradient(to right, var(--primary-light), transparent);
        }

        .board-table td {
            padding: 1.125rem 1rem;
            border-bottom: 1px solid var(--border);
            vertical-align: middle;
        }

        .board-table tr:last-child td {
            border-bottom: none;
        }

        .board-table tr {
            transition: all 0.2s ease;
        }

        .board-table tbody tr:hover {
            background-color: var(--accent-light);
            transform: translateY(-1px);
            box-shadow: var(--shadow-sm);
        }

        .board-table th:first-child,
        .board-table td:first-child {
            padding-left: 1.5rem;
        }

        .board-table th:last-child,
        .board-table td:last-child {
            padding-right: 1.5rem;
            text-align: right;
        }

        .board-no {
            font-weight: 500;
            color: var(--text-secondary);
            width: 70px;
        }

        .board-name {
            width: 120px;
            color: var(--text-primary);
        }

        .board-title-cell {
            font-weight: 500;
        }

        .board-date {
            width: 120px;
            color: var(--text-secondary);
            font-size: 0.875rem;
        }

        .board-hit {
            width: 80px;
            color: var(--text-secondary);
            text-align: center;
        }

        .move_link {
            color: var(--text-primary);
            text-decoration: none;
            transition: all 0.2s ease;
            position: relative;
            display: inline-block;
            padding-right: 1.5rem;
        }

        .move_link:hover {
            color: var(--primary);
        }

        .move_link::after {
            content: '\f054';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            position: absolute;
            right: 0;
            top: 50%;
            transform: translateY(-50%);
            font-size: 0.75rem;
            color: var(--accent);
            transition: transform 0.3s ease, color 0.2s ease;
        }

        .move_link:hover::after {
            transform: translateY(-50%) translateX(3px);
            color: var(--primary);
        }

        .pagination-container {
            display: flex;
            justify-content: center;
            padding: 1.75rem 0;
            border-top: 1px solid var(--border);
        }

        .pagination {
            display: flex;
            list-style: none;
            gap: 0.375rem;
        }

        .paginate_button a {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 2.5rem;
            height: 2.5rem;
            border-radius: var(--radius-full);
            color: var(--text-secondary);
            text-decoration: none;
            transition: all 0.3s ease;
            font-size: 0.875rem;
            font-weight: 500;
            border: 1px solid transparent;
        }

        .paginate_button a:hover {
            background-color: var(--primary-light);
            color: var(--primary);
            border-color: var(--primary-light);
            transform: translateY(-2px);
            box-shadow: 0 3px 5px rgba(0, 0, 0, 0.05);
        }

        .paginate_button[style*="color: red"] a {
            background-color: var(--primary);
            color: white;
            border-color: var(--primary);
            box-shadow: 0 3px 5px rgba(46, 125, 50, 0.2);
        }

        .board-footer {
            padding: 1.5rem 2rem;
            border-top: 1px solid var(--border);
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #f9f9f9;
            background-image: linear-gradient(to right, rgba(46, 125, 50, 0.03), rgba(212, 175, 55, 0.03));
        }

        .board-search {
            display: flex;
            gap: 0.5rem;
            width: 100%;
            max-width: 600px;
            margin: 0 auto;
        }

        .search-select {
            padding: 0.625rem 1rem;
            border: 1px solid var(--border);
            border-radius: var(--radius-md);
            background-color: white;
            color: var(--text-primary);
            font-size: 0.875rem;
            transition: all 0.2s ease;
            box-shadow: var(--shadow-sm);
            -webkit-appearance: none;
            -moz-appearance: none;
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' viewBox='0 0 24 24' fill='none' stroke='%2390a4ae' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpolyline points='6 9 12 15 18 9'%3E%3C/polyline%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 0.75rem center;
            background-size: 1rem;
            padding-right: 2.5rem;
        }

        .search-select:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(46, 125, 50, 0.1);
            outline: none;
        }

        .search-input {
            padding: 0.625rem 1rem;
            border: 1px solid var(--border);
            border-radius: var(--radius-md);
            background-color: white;
            color: var(--text-primary);
            font-size: 0.875rem;
            flex: 1;
            min-width: 0;
            transition: all 0.2s ease;
            box-shadow: var(--shadow-sm);
        }

        .search-input:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(46, 125, 50, 0.1);
            outline: none;
        }

        .search-btn {
            padding: 0.625rem 1.25rem;
            background-color: var(--accent);
            color: white;
            border: none;
            border-radius: var(--radius-md);
            font-size: 0.875rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 2px 4px rgba(212, 175, 55, 0.2);
        }

        .search-btn:hover {
            background-color: var(--accent-dark);
            box-shadow: 0 4px 8px rgba(212, 175, 55, 0.3);
            transform: translateY(-1px);
        }

        .search-btn:active {
            transform: translateY(0);
        }

        /* 반응형 디자인 */
        @media (max-width: 768px) {
            .container {
                margin: 1rem auto;
                padding: 0 1rem;
            }

            .board-header {
                padding: 1.5rem;
                flex-direction: column;
                align-items: flex-start;
                gap: 1rem;
            }

            .board-actions {
                width: 100%;
            }

            .btn {
                flex: 1;
                justify-content: center;
            }

            .board-content {
                padding: 1rem;
            }

            .board-table th:nth-child(2),
            .board-table td:nth-child(2),
            .board-table th:nth-child(4),
            .board-table td:nth-child(4) {
                display: none;
            }

            .board-no {
                width: 50px;
            }

            .board-hit {
                width: 60px;
            }

            .board-footer {
                flex-direction: column;
                gap: 1rem;
                padding: 1.5rem 1rem;
            }

            .board-search {
                width: 100%;
            }

            .search-input {
                flex: 1;
                min-width: 0;
            }
        }

        /* 애니메이션 */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes slideInRight {
            from { opacity: 0; transform: translateX(20px); }
            to { opacity: 1; transform: translateX(0); }
        }

        @keyframes pulse {
            0% { box-shadow: 0 0 0 0 rgba(46, 125, 50, 0.4); }
            70% { box-shadow: 0 0 0 10px rgba(46, 125, 50, 0); }
            100% { box-shadow: 0 0 0 0 rgba(46, 125, 50, 0); }
        }

        .board-container {
            animation: fadeIn 0.5s ease-out;
        }

        .board-title {
            animation: slideInRight 0.5s ease-out;
        }

        .board-table tbody tr {
            animation: fadeIn 0.4s ease-out;
            animation-fill-mode: both;
        }

        .board-table tbody tr:nth-child(1) { animation-delay: 0.05s; }
        .board-table tbody tr:nth-child(2) { animation-delay: 0.1s; }
        .board-table tbody tr:nth-child(3) { animation-delay: 0.15s; }
        .board-table tbody tr:nth-child(4) { animation-delay: 0.2s; }
        .board-table tbody tr:nth-child(5) { animation-delay: 0.25s; }
        .board-table tbody tr:nth-child(6) { animation-delay: 0.3s; }
        .board-table tbody tr:nth-child(7) { animation-delay: 0.35s; }
        .board-table tbody tr:nth-child(8) { animation-delay: 0.4s; }
        .board-table tbody tr:nth-child(9) { animation-delay: 0.45s; }
        .board-table tbody tr:nth-child(10) { animation-delay: 0.5s; }

        .btn-primary {
            animation: pulse 2s infinite;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="board-container">
            <div class="board-header">
                <h1 class="board-title">커뮤니티 게시판</h1>
                <div class="board-actions">
                    <a href="write_view" class="btn btn-primary">
                        <i class="fas fa-pen btn-icon"></i>글작성
                    </a>
                    <button class="btn btn-outline">
                        <i class="fas fa-sync-alt btn-icon"></i>새로고침
                    </button>
                </div>
            </div>
            
            <div class="board-content">
                <div class="board-info">
                    <div class="board-count">
                        <i class="fas fa-list-ul"></i>
                        <span>총 <span class="board-count-number">${list.size()}</span>개의 게시글</span>
                    </div>
                    <div class="board-view">
                        <i class="fas fa-eye"></i>
                        <span>페이지당 표시: 10개</span>
                    </div>
                </div>
                
                <div class="board-table-container">
                    <table class="board-table">
                        <thead>
                            <tr>
                                <th class="board-no">번호</th>
                                <th class="board-name">이름</th>
                                <th>제목</th>
                                <th class="board-date">날짜</th>
                                <th class="board-hit">조회</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="dto" items="${list}">
                                <tr>
                                    <td class="board-no">${dto.boardNo}</td>
                                    <td class="board-name">${dto.boardName}</td>
                                    <td class="board-title-cell">
                                        <a class="move_link" href="${dto.boardNo}">${dto.boardTitle}</a>
                                    </td>
                                    <td class="board-date">${dto.boardDate}</td>
                                    <td class="board-hit">${dto.boardHit}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
            
            <div class="pagination-container">
                <ul class="pagination">
                    <c:if test="${pageMaker.prev}">
                        <li class="paginate_button">
                            <a href="${pageMaker.startPage - 1}" title="이전">
                                <i class="fas fa-chevron-left"></i>
                            </a>
                        </li>
                    </c:if>

                    <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                        <li class="paginate_button" ${pageMaker.criteriaDTO.pageNum==num ? "style='color: red'" :""}>
                            <a href="${num}">
                                ${num}
                            </a>
                        </li>
                    </c:forEach>

                    <c:if test="${pageMaker.next}">
                        <li class="paginate_button">
                            <a href="${pageMaker.endPage+1}" title="다음">
                                <i class="fas fa-chevron-right"></i>
                            </a>
                        </li>
                    </c:if>
                </ul>
            </div>
            
            <div class="board-footer">
                <div class="board-search">
                    <select class="search-select">
                        <option value="title">제목</option>
                        <option value="content">내용</option>
                        <option value="writer">작성자</option>
                        <option value="titlecontent">제목+내용</option>
                    </select>
                    <input type="text" class="search-input" placeholder="검색어를 입력하세요">
                    <button class="search-btn">
                        <i class="fas fa-search"></i> 검색
                    </button>
                </div>
            </div>
        </div>
    </div>
    
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
        
        // 새로고침 버튼
        $(".btn-outline").on("click", function() {
            location.reload();
        });
    </script>
</body>
</html>
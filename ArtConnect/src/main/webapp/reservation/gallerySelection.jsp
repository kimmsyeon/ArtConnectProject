<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE HTML>
<html>

<head>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <meta charset="utf-8">
    <title>ArtConnect</title>
    <link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon">

    <!-- Bootstrap CSS -->
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <!-- Custom CSS -->
    <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet" type="text/css">
    <!-- Font Awesome -->
    <link href="${pageContext.request.contextPath}/resources/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <!-- Responsive CSS -->
    <link href="${pageContext.request.contextPath}/resources/css/responsive.css" rel="stylesheet" type="text/css">
<style type="text/css">

footer {
    bottom: 0;
    width: 100%;
    border-top: 1px solid #ddd;
}

th,td {
	vertical-align: middle;
	text-align: center;
	padding: 10px;
}
	
.navy {
	position: fixed;
	top: 10px;
	right: 10px;
}

.thumbnails-pan {
	display: flex;
	justify-content: center;
	align-items: center;
	flex-wrap: wrap;
}

#gallery-container {
	min-width: 900px;
	max-width: 1400px;
	margin: 0 auto;
	height: auto;
    border: 1px solid #333333; 
    border-radius: 10px;
    padding: 30px;
    background-color: white;
    box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.1);
    margin-bottom: 300px;
    align-content: center;
}

#logo-image {
	position: absolute;
	top: 0;
	left: 0;
	margin: 20px;
}

</style>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
	<script type="text/javascript">
	$(function() {
		// 초기 데이터 로딩
		loadGallery("listGallery");

		// 검색 버튼 클릭 시
		$('#searchButton').click(function() {
			var galleryName = $('#galleryNameInput').val();
			if (galleryName.trim() === "") {
				// 검색창이 공란이면 초기 데이터 로딩
				loadGallery("listGallery");
			} else {
				loadGallery("searchGallery/" + encodeURIComponent(galleryName));
			}
		});
		
		// Enter 키 눌렀을 때
		$('#galleryNameInput').keypress(function(e) {
			if (e.which === 13) {
				var galleryName = $('#galleryNameInput').val();
				if (galleryName.trim() === "") {
					// 검색창이 공란이면 초기 데이터 로딩
					loadGallery("listGallery");
				} else {
					loadGallery("searchGallery/" + encodeURIComponent(galleryName));
				}
			}
		});
	});

	function loadGallery(url) {
		$.ajax({
			url : url,
			method : 'GET',
			success : function(response) {
				$('#galleryDisplay').html(response);
			},
			error : function(xhr, status, error) {
				console.error("AJAX Error: " + status + ", " + error);
			}
		});
	}
</script>
</head>

<body>
	<div class="login" style="display: block; text-align: right; margin-top: 75px; margin-right: 20px;">
		<% String memberID = (String) session.getAttribute("memberID");
		String memberName = (String) session.getAttribute("memberName");
		if (memberID == null || memberID.equals("")) { %>
			<a href="${pageContext.request.contextPath}/member/login">
				<button class="btn btn-danger" onclick="login()">로그인</button>
			</a>
		<% } else { %>
			<!-- 로그아웃 버튼 -->
			<%= memberName %>님 환영합니다.<br>
			<a href="${pageContext.request.contextPath}/member/Logout.jsp?redirectPage=../reservation/gallerySelection.jsp">
				<button class="btn btn-info">로그아웃</button>
			</a>
		<% } %>
	</div>
    <header role="header">
    <!-- nav -->
    <nav role="header-nav" class="navy">
	<ul>
	<li><a href="${pageContext.request.contextPath}/gallery/list" title="Work">전시관 조회 및 검색</a></li>

	<li><a href="${pageContext.request.contextPath}/reservation/gallerySelection.jsp" title="About">예약</a></li>

	<li><a href="${pageContext.request.contextPath}/review/boardList" title="Blog">커뮤니티</a></li>

	<li><a href="${pageContext.request.contextPath}/mypage/updateOne?memberID=${memberID}" title="Contact">마이 페이지</a></li>
					
	<li><a href="${pageContext.request.contextPath}/notice/noticeList" title="Contact">공지사항</a></li>
					
	<li><a href="${pageContext.request.contextPath}/notice/qnaList" title="Contact">QnA</a></li>
    </ul>
	</nav>
    </header>
    <!-- Main Content -->
    <main role="main-inner-wrapper container">
    	<!-- Logo -->
                <div id="logo-image" style="display: inline-block;"><a href="${pageContext.request.contextPath}/gallery/main.jsp" style="max-width: 300px;">
                <img src="${pageContext.request.contextPath}/resources/img/art.png" title="ArtConnect"
                        alt="ArtConnect" style="width: 450px; height: auto;"/></a></div>
        <div id="search-container" style="text-align: center; margin-top: 20px;">
            <!-- Search bar for gallery ID -->
            <input type="text" id="galleryNameInput" placeholder="미술관 이름을 입력하세요."
                class="form-control input-lg" style="width: 300px; display: inline-block;">
            <button id="searchButton" class="btn btn-primary btn-lg">검색</button>
        </div>
        <br><br>
		<div id="gallery-container">
			<!-- Display area for galleries -->
        	<div id="galleryDisplay" class="thumbnails-pan" style="font-size: 20px;">
        	<!-- Initial gallery display will be loaded here -->
        	</div>
		</div>
        <hr>
    </main>

    <!-- Footer -->
    <footer role="footer">
       	<nav role="footer-nav">
            <ul>
               	<li><a href="index.html" title="Work">Work</a></li>
                <li><a href="about.html" title="About">About</a></li>
                <li><a href="blog.html" title="Blog">Blog</a></li>
                <li><a href="contact.html" title="Contact">Contact</a></li>
            </ul>
        </nav>
        <!-- nav -->
        <ul role="social-icons">
         	<li><a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a></li>
            <li><a href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a></li>
            <li><a href="#"><i class="fa fa-linkedin" aria-hidden="true"></i></a></li>
            <li><a href="#"><i class="fa fa-flickr" aria-hidden="true"></i></a></li>
        </ul>
        <p class="copy-right">Shared by <i class="fa fa-love"></i><a href="https://bootstrapthemes.co">BootstrapThemes</a></p>
    </footer>
    <script src="${pageContext.request.contextPath}/resources/js/jquery.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/resources/js/nav.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/resources/js/custom.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/resources/js/html5shiv.js" type="text/javascript"></script>
</body>
</html>

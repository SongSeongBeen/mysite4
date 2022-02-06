<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		
		<link href="${pageContext.request.contextPath }/assets/css/mysite.css" rel="stylesheet" type="text/css">
		<link href="${pageContext.request.contextPath }/assets/css/gallery.css" rel="stylesheet" type="text/css">
		<link href="${pageContext.request.contextPath }/assets/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css">
		
		<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/jquery-1.12.4.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath }/assets/bootstrap/js/bootstrap.js"></script>
		
	</head>
	
	
	<body>
		<div id="wrap">
	
			<c:import url="/WEB-INF/views/include/header.jsp"></c:import>
			<!-- //header -->
			<!-- //nav -->
	
			<c:import url="/WEB-INF/views/include/asideBoard.jsp"></c:import>
			<!-- //aside -->
	
	
			<div id="content">
	
				<div id="content-head">
					<h3>갤러리</h3>
					<div id="location">
						<ul>
							<li>홈</li>
							<li>갤러리</li>
							<li class="last">갤러리</li>
						</ul>
					</div>
					<div class="clear"></div>
				</div>
				<!-- //content-head -->

				<div id="gallery">
					<div id="list">
				
						<c:if test="${!(empty authUser)}">
							<button id="btnImgUpload">이미지올리기</button>
							<div class="clear"></div>
						</c:if>
				
						<ul id="viewArea">
							
							<!-- 이미지반복영역 -->
							<c:forEach items="${galleryList}" var="galleryVo">
								<li>
									<div class="view" >  
										<img class="imgItem" src="${pageContext.request.contextPath}/upload/${galleryVo.saveName}" data-no="${galleryVo.no}">
										<div class="imgWriter">작성자: <strong>${galleryVo.name}</strong></div>
									</div>
								</li>
							</c:forEach>
							<!-- 이미지반복영역 -->
							
							
						</ul>
					</div>
					<!-- //list -->
				</div>
				<!-- //board -->
			</div>
			<!-- //content  -->
			<div class="clear"></div>
	
			<c:import url="/WEB-INF/views/include/footer.jsp"></c:import>
			<!-- //footer -->
	
		</div>
		<!-- //wrap -->
	
		
			
		<!-- 이미지등록 팝업(모달)창 -->
		<div class="modal fade" id="addModal">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
						<h4 class="modal-title">이미지등록</h4>
					</div>
				
					<form method="post" action="${pageContext.request.contextPath}/gallery/upload" enctype="multipart/form-data">
						<div class="modal-body">
							<div class="form-group">
								<label class="form-text">글작성</label>
								<input id="addModalContent" type="text" name="content" value="" >
							</div>
							<div class="form-group">
								<label class="form-text">이미지선택</label>
								<input id="file" type="file" name="file" value="" >
							</div>
						</div>
						<div class="modal-footer">
							<button type="submit" class="btn" id="btnUpload">등록</button>
						</div>
						<input type="text" name="userNo" value="${authUser.no}">
					</form>
					
					
				</div><!-- /.modal-content -->
			</div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
		
	
	
		<!-- 이미지보기 팝업(모달)창 -->
		<div class="modal fade" id="viewModal">
			<div class="modal-dialog" >
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
						
						<h4 class="modal-title">이미지보기</h4>
						
					</div>
			
						<div class="modal-body">
							<div class="formgroup" >
								<img id="viewModelImg" src =""> 
								
									<!-- ajax로 처리 : 이미지출력 위치-->
							</div>
							
							<div class="formgroup">
								<p id="viewModelContent"> </p>
							</div>
							
						</div>
						<form method="" action="">
							<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
							<c:if test="${!(empty authUser)}">
							<button type="button" class="btn btn-danger" id="btnDel">삭제</button>
							</c:if>
						</div>
						</form>
							<input id="modalNo" type="text" name="no" value="${galleryVo.no}">
				</div><!-- /.modal-content -->
				
			</div><!-- /.modal-dialog -->
		</div><!-- /.modal -->	
	
	
	</body>
	
	<script type="text/javascript">
	//업로드 클릭
	$("#btnImgUpload").on("click", function() {
			console.log("클릭");
			$("#ModalContent").val("");
			$("#addModal").modal("show");
	});
	
	//사진보기 클릭
	$(".imgItem").on("click", function(){
		console.log("사진클릭");
		var $this = $(this);
		var no = $this.data("no");
	
		//요청
		$.ajax({
				//요청할때
				url : "${pageContext.request.contextPath}/gallery/read",// 주소.    
				type : "get",//get, post(어차피 차이 없음)
				//contentType : "application/json",
				
				//파라미터로 보낼때 객체로 보내야 한다
				data : {no: no},
			
				//응답받을때
				//dataType : "json",
				success : function(galleryVo) {//json --> js로 변환되서 result에 담김
					
					console.log(galleryVo);
				
						$("#viewModal").modal("show");
						$("#viewModelImg").attr("src", "${pageContext.request.contextPath}/upload/"+galleryVo.saveName);
						$("#viewModelContent").html(galleryVo.content);
						
				},
				error : function(XHR, status, error) {
					console.error(status + " : " + error);
				}
		});
	
	});
	
	$("#btnDel").on("click", function(){
		console.log("삭제");
		
		var $this = $(this);
		var no = $this.data("no");

		$.ajax({
				//요청할때
				url : "${pageContext.request.contextPath}/gallery/remove",// 주소.    
				type : "post",//get, post(어차피 차이 없음)
				//contentType : "application/json",
				
				//파라미터로 보낼때 객체로 보내야 한다
				data : {no : no},
			
				//응답받을때
				//dataType : "json",
				success : function(result) {//json --> js로 변환되서 result에 담김
					
						$("#viewModal").modal("hide");
						$("#li"+no).remove();
					
				},
				error : function(XHR, status, error) {
					console.error(status + " : " + error);
				}
		});
		
	});
	</script>




</html>


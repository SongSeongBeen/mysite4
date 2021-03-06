<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>

<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link href="${pageContext.request.contextPath}/assets/css/mysite.css" rel="stylesheet" type="text/css">
		<link href="${pageContext.request.contextPath}/assets/css/user.css" rel="stylesheet" type="text/css">
		
		<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/jquery-1.12.4.js"></script>
	</head>
	
	<body>
		<div id="wrap">
	
			<!-- header + nav -->
			<c:import url="/WEB-INF/views/include/header.jsp"></c:import>
			<!-- header + nav -->
	
			<!-- //aside -->
			<div id="container" class="clearfix">
			
				<!-- //aside -->
				<c:import url="/WEB-INF/views/include/aside.jsp"></c:import>
				<!-- //aside -->
				
			
				<div id="content">
				
					<!-- //content-head -->
					<div id="content-head">
						<h3>회원가입</h3>
						<div id="location">
							<ul>
								<li>홈</li>
								<li>회원</li>
								<li class="last">회원가입</li>
							</ul>
						</div>
						<div class="clear"></div>
					</div>
					<!-- //content-head -->
		
					<div id="user">
						<div id="joinForm">
							<form action="${pageContext.request.contextPath}/user/join" method="get">
								<!-- 아이디 -->
								<div class="form-group">
									<label class="form-text" for="input-uid">아이디</label> 
									<input type="text" id="input-uid" name="id" value="" placeholder="아이디를 입력하세요">
									<button type="button" id="btn-check">중복체크</button>
								</div>
		
								<!-- 비밀번호 -->
								<div class="form-group">
									<label class="form-text" for="input-pass">패스워드</label> 
									<input type="password" id="input-pass" name="password" value="" placeholder="비밀번호를 입력하세요"	>
								</div>
		
								<!-- 이메일 -->
								<div class="form-group">
									<label class="form-text" for="input-name">이름</label> 
									<input type="text" id="input-name" name="name" value="" placeholder="이름을 입력하세요">
								</div>
		
								<!-- //나이 -->
								<div class="form-group">
									<span class="form-text">성별</span> 
									
									<label for="rdo-male">남</label> 
									<input type="radio" id="rdo-male" name="gender" value="male" > 
									
									<label for="rdo-female">여</label> 
									<input type="radio" id="rdo-female" name="gender" value="female	" > 
		
								</div>
		
								<!-- 약관동의 -->
								<div class="form-group">
									<span class="form-text">약관동의</span> 
									
									<input type="checkbox" id="chk-agree" value="" name="agree">
									<label for="chk-agree">서비스 약관에 동의합니다.</label> 
								</div>
								
								<!-- 버튼영역 -->
								<div class="button-area">
									<button type="submit" id="btn-submit">회원가입</button>
								</div>
								
							</form>
						</div>
						<!-- //joinForm -->
					</div>
					<!-- //user -->
				</div>
				<!-- //content  -->
			</div>
			<!-- //container  -->
			
			<c:import url="/WEB-INF/views/include/footer.jsp"></c:import>
			<!-- //footer -->
	
		</div>
		<!-- //wrap -->
	
	</body>
	
	<script type="text/javascript">
//회원가입버튼
	$("#btn-submit").on("click", function(){
		
			console.log("회원가입버튼 클릭");	
			
			if($("#intpu-uid") == null){
				alert("아이디를 입력해 주세요.");
				return false;
			} 
			if($("#intpu-pass") == ''){
				alert("비밀번호를 입력해 주세요.");
				return false;
			} 
			if($("#input-name") == ''){
				alert("이름을 입력해 주세요.");
				return false;
			}
			if($("#intpu-uid") == false && 
			   $("#intpu-pass") == false && 
			   $("#input-name") == false && 
			   $("#chk-agree") == false && 
			   $("#rdo-male") == false ||
			   $("#rdo-female") == false
			){
				alert("입력하지 않은 정보가 있습니다.");
				return false;
			}
		
	
	});
	
//아이디 중복체크		
	$("#btn-check").on("click", function(){
			console.log("중복체크 클릭");
	
			//요청
			$.ajax({
					//요청할때
					url : "${pageContext.request.contextPath}/user/idCheck",// 주소.    
					type : "get",//get, post(어차피 차이 없음)
					//contentType : "application/json",
					
					//파라미터로 보낼때 객체로 보내야 한다
					data : {id : $("#input-uid").val()},
				
					//응답받을때
					//dataType : "json",
					success : function(result) {//json --> js로 변환되서 result에 담김
						
						console.log(result);
					
							if(result == 'success'){
								console.log(result);
								alert("사용가능한 아이뒤 입니다.");
								console.log("사용가능");
							}else{
								alert("이미 사용중인 아이뒤 입니다.");
								console.log("중복");
							}
					},
					error : function(XHR, status, error) {
						console.error(status + " : " + error);
					}
			});
	
	});


	</script>
	
	
</html>
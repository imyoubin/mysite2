<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>

<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <title>MySite</title>
    	<!-- css -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/mysite.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/user.css">
    	<!-- js -->
    	<script src="${pageContext.request.contextPath}/assets/js/jquery/jquery-3.7.1.js"></script>    
    </head>

    <body>
       <div class="wrap">
           <header class="clearfix">
                <h1><a href="">MySite</a></h1>
              
              	<!-- 로그인 되었을때(세션에 값이 있을때) -->
              	<c:if test="${sessionScope.authUser != null}">
					<ul class="clearfix">
						<li><span class="user-welcome"> ${sessionScope.authUser.name}님 안녕하세요^^</span></li>
						<li>
							<a class="btn btn-white btn-sm" href="">로그아웃</a>
						</li>
						<li>
						    <a class="btn btn-white btn-sm" href="">정보수정</a>
						</li>
			   	 	</ul>
              	</c:if>
                
	
 				<!-- 로그인 되지 않을때(세션에 값없을때) -->
              	<c:if test="${sessionScope.authUser == null}">
              		<ul class="clearfix">
						<li>
						    <a class="btn btn-white btn-sm" href="">로그인</a>
						</li>
						<li>
						    <a class="btn btn-white btn-sm" href="">회원가입</a>
						</li>
				 	</ul>
              	</c:if>
				
            </header>
                 
            <nav>
                <ul class="clearfix">
                    <li><a href="">입사지원서</a></li>
                    <li><a href="">게시판</a></li>
                    <li><a href="">갤러리</a></li>
                    <li><a href="">방명록</a></li>
                </ul>
            </nav>

            <div class="content2 clearfix">
                <aside>
                    <h2>유저</h2>
                    <ul>
                        <li><a href="">회원정보</a></li>
                        <li><a href="">로그인</a></li>
                        <li><a href="">회원가입</a></li>
                    </ul>
                </aside>


                <main>
                    <div class="main-head clearfix">
                        <h3>회원정보</h3>
                        <ol class="clearfix">
                            <li>홈</li>
                            <li>유저</li>
                            <li>회원가입</li>
                        </ol>
                    </div>

                    <div id="user-joinform">
                        <form class="form-box" action="http://localhost:8888/user/join" method="get">
                            <div class="info-row">
                                <label class="info-title" for="txt-idcheck">아이디</label>
                                <input id="txt-idcheck" type="text" name="id" value="">
                                <button id="btnCheck" class="btn btn-gray btn-input"  type="button">중복체크</button>
                           		<p id="checkMsg"></p>
                            </div>
                            <div class="info-row">
                                <label class="info-title" for="txt-pwd">패스워드</label>
                                <input id="txt-pwd" type="password" name="password" value="">
                            </div>
                            <div class="info-row">
                                <label class="info-title" for="txt-name">이름</label>
                                <input id="txt-name" type="text" name="name" value="">
                            </div>
                            <div class="info-row">
                                <span class="info-title">성별</span>
                                <label>남</label>
                                <input type="radio" name="gender" value="male">
                                
                                <label>여</label>
                                <input type="radio" name="gender" value="female">
                            </div>
                            <div class="info-row">
                                <span class="info-title">약관동의</span>
                                <input type="checkbox" name="" value="">
                                <lable>서비스 약관에 동의합니다.</lable>
                            </div>
                            <div class="btn-group">
                                <button class="btn btn-blue btn-lg" type="submit">회원가입</button>
                            </div>
                        </form>
                        
                    </div>

                    
                </main>
            </div>
            
            <footer>
                <p>
                    Copyright ⓒ 2025 황일영. All right reserved  
                </p>
            </footer>

        </div>

<!-- -------------------------------------------------------- -->
<script>
//돔트리완료되었을대
$(document).ready(function(){
	console.log('돔트리 완성');
	
	//아이디체크 버튼을 클릭했을 때
	$('#btnCheck').on('click', function(){
		console.log('아이디체크 버튼 클릭');
		
		//입력한 id
		let id = $('#txt-idcheck').val();
		console.log(id);
		
		console.log('서버랑 통신');
		/* 서버랑 통신(주소치고엔터) --> !!!데이터만 받을거야!!!!*/
		$.ajax({
			url : "${pageContext.request.contextPath}/user/idcheck",		
			type : "post",
			//contentType : "application/json",
			data : {id: id},
			
			dataType : "json",
			success : function(result){
				/*성공시 처리해야될 코드 작성*/
				console.log(result);
				console.log(result.isUse);
				
				//상황에 맞는 메세지 출력--->저위에 있는 html 사이에 html출력해줘야한다
				if(result.isUse == true){
					$('#checkMsg').html('사용할 수 있는 아이디 입니다.')
					$('#checkMsg').css('color', '#0000ff');	
					$('#checkMsg').css('font-weight', 'bold');
				}else {
					$('#checkMsg').html('<strong>이미 사용중인 아이디 입니다.</strong>');
					$('#checkMsg').css('color', '#ff0000');	
					$('#checkMsg').css('font-weight', 'bold');
				}
				
			},
			error : function(XHR, status, error) {
				console.error(status + " : " + error);
			}
		});

		
	});
	
});




</script>
     
    </body>
</html>
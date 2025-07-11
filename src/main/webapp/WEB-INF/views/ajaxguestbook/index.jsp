<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <title>MySite</title>
        <!-- css -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/mysite.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/guestbook.css">
        <!-- js -->
        <script src="${pageContext.request.contextPath}/assets/js/jquery/jquery-3.7.1.js"></script>
    </head>


	<body>
		<div class="wrap">
    		<!-- 해더 + 네비 ------------------------------------>
            <c:import url="/WEB-INF/views/include/header.jsp"></c:import>
            <!-- 해더 + 네비 ------------------------------------>
		
            <div class="content2 clearfix">
                <aside>
                    <h2>방명록</h2>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/guestbook">일반방명록</a></li>
                        <li><a href="">ajax방명록</a></li>
                    </ul>
                </aside>

				<main>
					
				    <div class="main-head clearfix">
                        <h3>일반방명록</h3>
                        <ol class="clearfix">
                            <li>홈</li>
                            <li>방명록</li>
                            <li>일반방명록</li>
                        </ol>
                    </div>

					<div id="guestbook-addlist">
						<form id="formAdd" class="form-box" action="" method="get">
							<table>
								<colgroup>
									<col style="width: 70px;">
									<col style="width: 340px;">
									<col style="width: 70px;">
									<col style="width: 340px;">
								</colgroup>
								<tbody>
									<tr>
										<th>
											<label for="txt-name">이름</label>
										</th>
										<td>
											<input id="txt-name" type="text" name="name" value="">
										</td>
										<th>
											<label for="txt-password">패스워드</label>
										</th>
										<td>
											<input id="txt-password"type="password" name="password" value="">
										</td>
									</tr>
									<tr>
										<td colspan="4">
											<textarea id="text-content" name="content"></textarea>
										</td>
									</tr>
									<tr>
										<td colspan="4" class="btn-box">
											<button class="btn btn-blue btn-lg" type="submit">등록</button>
										</td>
									</tr>
								</tbody>
								
							</table>
						</form>	
						
						<button id="btnList" class="btn btn-blue btn-md" type="button">전체데이터 요청</button>
						
						
						<div id="gbListArea">
							<!-- 리스트가 출력되는자리 -->
						</div>
						
					</div>
			    
                </main>
            </div>
            
			<!-- footer -->
			<c:import url="/WEB-INF/views/include/footer.jsp"></c:import>
			<!-- //footer -->

        </div>
        
<!-- ------------------------------------------------------------ -->
<script>
$(document).ready(function(){
	console.log('돔트리완성');
	
	//리스트데이타요청해서 화면에 리스트 그리는 함수
	fetchList(); 
	
	/*
	//버튼클릭할때
	$('#btnList').on('click', function(){
		console.log('버튼클릭');
		
		fetchList();  //리스트데이타요청해서 그리는 함수

	});
	*/
	
	//등록버튼을 클릭했을때
	$('#formAdd').on('submit', function(event){
		console.log('등록버튼클릭');
		event.preventDefault();
		
		//value값 수집
		
		
		
		
	});
		
	
	
	
	
});


//리스트데이타요청해서 그리는 함수
function fetchList(){
	$.ajax({
		url : "${pageContext.request.contextPath}/api/guestbook/list",
		type : "post",
		//contentType : "application/json",
		//data : {name: ”홍길동"},
		
		dataType : "json",
		success : function(guestbookList){
			/*성공시 처리해야될 코드 작성*/
			//console.log(guestbookList);
			
			//화면에 그린다
			for(let i=0; i<guestbookList.length; i++){
				render(guestbookList[i]);
			}
			 
		},
		error : function(XHR, status, error) {
			console.error(status + " : " + error);
		}
	});
}


//guestbookVO 1개를 화면에 그린다
function render(guestbookVO){
	console.log(guestbookVO);
	
	let str = '';
	str += '<table class="guestbook-item">' ;
	str += '	<colgroup>' ;
	str += '		<col style="width: 10%;">' ;
	str += '		<col style="width: 40%;">' ;
	str += '		<col style="width: 40%;">' ;
	str += '	</colgroup>' ;
	str += '	<tbody>' ;
	str += '		<tr>' ;
	str += '			<td>' + guestbookVO.no+ '</td>' ;
	str += '			<td>' + guestbookVO.name +'</td>' ;
	str += '			<td>' + guestbookVO.regDate +'</td>' ;
	str += '			<td class="txt-center">' ;
	str += '				<a class="btn btn-gray btn-sm" href="">삭제</a>' ;
	str += '			</td>' ;
	str += '		</tr>' ;
	str += '		<tr>' ;
	str += '			<td colspan=4>' + guestbookVO.content +'</td>' ;
	str += '		</tr>' ;
	str += '	</tbody>' ;
	str += '</table>' ;

	
	$('#gbListArea').append(str);
	
	
}



</script>
     
    </body>
</html>
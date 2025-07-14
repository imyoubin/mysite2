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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/modal.css">
        <!-- js -->
        <script src="${pageContext.request.contextPath}/assets/js/jquery/jquery-3.7.1.js"></script>
    </head>


	<body>
		<div class="wrap">
    		<!-- 해더 + 네비 ------------------------------------>
            <c:import url="/WEB-INF/views/include/header.jsp"></c:import>
            <!-- 해더 + 네비 ------------------------------------>
		
            <div class="content2 clearfix">
            	<!-- 방명록 aside -->
 				<c:import url="/WEB-INF/views/include/asideGuestbook.jsp"></c:import>
				<!-- /방명록 aside -->
				<main>
					
				    <div class="main-head clearfix">
                        <h3>ajax방명록</h3>
                        <ol class="clearfix">
                            <li>홈</li>
                            <li>방명록</li>
                            <li>ajax방명록</li>
                        </ol>
                    </div>

					<div id="guestbook-addlist">
						<form id="formAdd" class="form-box" action="" method="">
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
						
						<!-- <button id="btnList" class="btn btn-blue btn-md" type="button">전체데이터 요청</button> -->
						
						
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
<!-- 모달창 -->
<div class="modal-bg">

	<div class="modal-content">
		<p>비밀번호 입력해 주세요</p>
	
		<form id="modalForm" action="" method="">
			<div>
				<input type="password" name="password" value="">
				<input type="text" name="no" value="">
			</div>
			<button type="submit" class="btn-del btn btn-blue btn-md">삭제</button>
			<button class="btn-close btn btn-gray btn-md">닫기</button>
		</form>
		
	</div>

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
		let name = $('#txt-name').val();
		let pw = $('#txt-password').val();
		let content = $('#text-content').val();
		
		//vo묶기
		let guestbookVO = {
			name: name,
			password: pw,
			content: content
		};
		console.log(guestbookVO);
		
		//서버에 저장 요청
		$.ajax({
			
			url : '${pageContext.request.contextPath }/api/guestbooks',		
			type : 'post',
			//contentType : "application/json",
			data : guestbookVO,
			
			dataType : 'json',
			success : function(jsonResult){
				/*성공시 처리해야될 코드 작성*/
				console.log(jsonResult);
				console.log(jsonResult.result);
				console.log(jsonResult.apiData);
				
				if(jsonResult.result == 'success'){
					
					/* 화면에 그리기 */
					render(jsonResult.apiData, 'up');
					
					/* 입력폼 비우기 */
					$('#txt-name').val('');
					$('#txt-password').val('');
					$('#text-content').val('')
				}else {
					console.log("등록 실패");
				}
				
			
			},
			error : function(XHR, status, error) {
				console.error(status + " : " + error);
			}
		});
		
		
	});
		
	
	/* 삭제(모달창 띄우기)버튼을 클릭했을때 -->삭제모달창 */ 
	$('#gbListArea').on('click', '.btn-modal',  function(){
		console.log('모달창 떠라');
		
		$('.modal-bg').addClass('active');
		
		//내가 가지고 있는 no값을  /  모달창의 no값 넣는input박스에 넣어둔다
		let $this = $(this);
		let no = $this.data('no');
		console.log(no);

		//번호 추가
		$('#modalForm [name="no"]').val(no);
		
		//패스워드는 비운다
		$('#modalForm [name="password"]').val('');
		
	});
	
	
	//모달창의 닫기버튼을 클릭했을때
	$('.btn-close').on('click', function(){
		console.log('모달차의 닫기버튼 클릭');
		
		$('.modal-bg').removeClass('active');
		
	});
	
	
	//모달창의 삭제 버튼을 클릭했을때(진짜삭제)
	$('#modalForm').on('submit', function(event){
		console.log('진짜삭제클릭');
		event.preventDefault();
		
		//데이터 수집
		let pw = $('#modalForm input[name="password"]').val();
		let no = $('#modalForm input[name="no"]').val();
		
		let guestbookVO = {
			password: pw
		};
		
		//전송
		$.ajax({
			
			url : '${pageContext.request.contextPath}/api/guestbooks/'+no,		
			type : 'delete',
			//contentType : 'application/json',
			data : guestbookVO,

			dataType : 'json',
			success : function(jsonResult){
			    /*성공시 처리해야될 코드 작성*/
			    console.log(jsonResult);
			    console.log(jsonResult.result);
			    
			    if(jsonResult.result == 'success'){
			    	//리스트에서 선택한거 화면에서 지우기
				    $('#t'+no).remove();   //아이디를 매칭시킨다
				    $('.modal-bg').removeClass('active');
			    }else {
			    	//모달창 닫기
				    $('.modal-bg').removeClass('active');	
			    }
			    
			},
			error : function(XHR, status, error) {
				console.error(status + ' : ' + error);
			}
		});

		
		

	});            
	
});


//리스트데이타요청해서 그리는 함수
function fetchList(){
	$.ajax({
		url : "${pageContext.request.contextPath}/api/guestbooks",
		/*rl : "https://raw.githubusercontent.com/clz2025-red/api/refs/heads/main/guestbook",*/
		type : "get",
		//contentType : "application/json",
		//data : {name: ”홍길동"},
		
		dataType : "json",
		success : function(jsonResult){
			/*성공시 처리해야될 코드 작성*/
			console.log(jsonResult);
			console.log(jsonResult.result);
			console.log(jsonResult.apiData);
			
			if(jsonResult.result == 'success'){
				//화면에 그린다
				for(let i=0; i<jsonResult.apiData.length; i++){
					render(jsonResult.apiData[i], 'down');
				}
			}else {
				console.log('알수없는 오류')
			}
			 
		},
		error : function(XHR, status, error) {
			console.error(status + " : " + error);
		}
	});
}


//guestbookVO 1개를 화면에 그린다
function render(guestbookVO, updown){
	console.log(guestbookVO);
	
	let str = '';
	str += '<table id="t'+guestbookVO.no+'" class="guestbook-item">' ;
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
	str += '				<button class="btn-modal btn btn-gray btn-sm" data-no="' +guestbookVO.no+ '">삭제</button>' ;
	str += '			</td>' ;
	str += '		</tr>' ;
	str += '		<tr>' ;
	str += '			<td colspan=4>' + guestbookVO.content +'</td>' ;
	str += '		</tr>' ;
	str += '	</tbody>' ;
	str += '</table>' ;

	if(updown == 'up'){
		$('#gbListArea').prepend(str);	
	
	}else if(updown == 'down'){
		$('#gbListArea').append(str);
	
	}else {
		console.log('방향체크')
	}
	
}



</script>
     
    </body>
</html>
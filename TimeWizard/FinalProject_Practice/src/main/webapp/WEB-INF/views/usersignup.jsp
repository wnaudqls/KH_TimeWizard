<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%
	response.setContentType("text/html; charset=UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<!--<script type="text/javascript">
	
/* function idChkForm(){
	id = $("#user_id").val();
	
	$.ajax({
	    url: 'idcheck.do',
	    type: 'POST',
	    dataType: 'text', //서버로부터 내가 받는 데이터의 타입
	    contentType : 'text/plain; charset=utf-8;',//내가 서버로 보내는 데이터의 타입
	    data: id ,

	    success: function(data){
	         if(data == 0){
	         console.log("아이디 없음");
	         alert("사용하실 수 있는 아이디입니다.");
	         }else{
	         	console.log("아이디 있음");
	         	alert("중복된 아이디가 존재합니다.");
	         }
	    },
	    error: function (){        
	                      
	    }
	  });


}

	
	function insertId(){
	
			alert(" 중복체크를 먼저 하셔야합니다.");
		
	} */
	
	 
	 
</script> -->

<style type="text/css">


.naver {
	width: 60px;
	hight: 60px;
}

.google {
	width: 60px;
	hight: 60px;
}

.kakao {
	width: 60px;
	hight: 60px;
}

#logo {
	display: flex;
}

:root {
  /*색상*/
  --color-white: #ffffff;
  --color-black: #212121;
  --color-gray: #f4f4f4;
  --color-dark-gray: #dddddd;

  /*글씨 크기 */
  --font-large: 36px;
  --font-regular: 16px;
  --font-small: 12px;

  /*font weight*/
  --weight-bold: 700;
  --weight-regular: 500;
  --weight-thin: 300;

  /*Size*/
  --size-border-radius: 13px;
}

/*universal tags*/

body {
  margin: 0;
  font-family: 'Roboto', sans-serif;
  cursor: default;
  color: var(--color-black);
}

a {
  margin: 0;
  text-decoration: none;
  color: var(--color-black);
}
ul,
li {
  list-style: none;
  padding-left: 0;
}

input {
  
  cursor: pointer;
  font-size: var(--font-regular);
  margin: 10px 6px;
  font-weight: var(--weight-bold);
  padding: 4px 6px;
  border: 1.5px solid var(--color-dark-gray);
  border-radius: 4px;
  position: relative;
}

.input {
  display: flex;
  flex-direction: row;
  padding-top: 15px;
}

.input > input {
  background-color: var(--color-dark-gray);
  cursor: pointer;
  font-size: var(--font-regular);
  color: var(--color-white);
  margin: 10px 6px;
  font-weight: var(--weight-bold);
  padding: 4px 6px;
  border: 1.5px solid var(--color-dark-black);
  border-radius: 4px;
  position: relative;
}


.regist_form {
  display: flex;
  flex-direction: column;
  align-items: center;
}
h1 {
  padding: 25px 0;
  margin: 0;
}

.email > p,
.pw > p,
.name > p {
  margin: 10px 0;
}


#font{
	font-family: gulim
}

#minibean_regist	 {
  position: fixed;
  top: 8%;
  left: 35%;
  width: 400px;
  height: 800px;
  background-color: #FFEBF0;
  border-radius: 13px 13px 13px 13px;
  box-shadow: 10px 4px 30px rgba(0, 0, 0, 0.29);
}

input:hover {
  background-color: var(--color-dark-gray);
  color: var(--color-white);
  transition: all ease 0.3s 0s;
}


</style>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">

var idPass;
var idRegex = /^[a-zA-Z0-9]{4,12}$/;
$(document).ready(function(){
	//아이디 중복체크
	$('input[name=user_id]').blur(function(){
		var idCheck=$('input[name=user_id]').val();
		if(idRegex.test(idCheck)){
			$.ajax({
			
				url:'idcheck.do?user_id='+idCheck,
				type:'get',
				
				success:function(data){
					var color;
					var ans;
					if(data>0){
						ans='이미있는 아이디입니다.';
						color='red';
                        idPass=false;
					}else{
						ans='회원가입 가능한 아이디입니다.';
						color='blue';
						idPass=true;
					}
					//#은 id
					$('#temp').text(ans);
					$('#temp').css('color',color);
				}
			})	
		}
	});
})

</script>



</head>
<body>

	<form action="signupres.do" method="post">
		
		<div id="minibean_regist">
			<h1 align ="center">Create Account</h1>
			<div class="logo" align="center">
				<a href="#"><img alt="naver_logo.png" src="resources/img/naver_logo.png" class="naver"></a> 
				<a href="#"><img alt="google_logo.png" src="resources/img/google_logo.png"class="google"></a> 
				<a href="#"><img alt="kakao_logo.png" src="resources/img/kakao_logo.png" class="kakao"></a>
				
			</div>
	
			<div class="regist_form">
					<div class="regist_id">		
						<p>ID</p>
							<p id="temp"/>
							<input class="temp" type="text" name="user_id" required="required" placeholder="ID" class="form-control id" id="idcheck" autofocus/> 		
					</div>				

				<div class="regist_pw">
					<p>PW</p>
						<input class= "" type="password" name="user_pw" required="required" placeholder="패스워드 입력" />
				</div>
				<div class="regist_pw_check">
					<p>PW</p>
					<input class="" type="password" name="check_pw" required="required" placeholder="패스워드 재입력" />
				</div>	
				<div class="">
					<p>NAME</p>
					<input class="" type="text" name="user_name" required="required" placeholder="이름" />
				</div>
				<div>
					<p>Email</p>
					<input class="" type="text" name="user_email" required="required" placeholder="이메일형식으로 입력하세요" />
				</div>
					<button type="submit" class="form-control btn btn-primary signupbtn" disabled="disabled">회원가입</button>
					<input type="button" value="취소" onclick="location.href='index.jsp'">
			</div>
		</div>
	</form>


</body>
</html>
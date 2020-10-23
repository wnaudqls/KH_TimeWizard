<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Template</title>
   
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

	
<!-- registform3 관련 -->
<script type="text/javascript" src="resources/js/registform.js"></script>
<link rel="stylesheet" href="resources/css/registform.css">
<link rel="stylesheet" href="resources/css/Template.css">
    
</head>
<body>
 <%
 	//카카오 관련
	 String id = (String)request.getAttribute("id");
	 String email = (String)request.getAttribute("email");
	 String name = (String)request.getAttribute("name");
 %>  
   

   <!-- 내용 -->
   <section class="secssion">
   	
	<h3>회원가입 form</h3>
	
	<form action="Registercontroller.do" method="post">
		<input type="hidden" name="command" value="insert"/>
		<table class="table table-sm" >
		<col width="100">
		<col width="500">
			<tr>
				<th class="text-center">이름</th>
				<td scope="col">
					<input type="text" required="required" autofocus="autofocus" width="500px" name="name">
				</td>
			</tr>
			<tr>
				<th class="text-center">성별</th>
           		 <td>
          		 		<input type="radio" name="gender" value="M" required="required"/> 남 
            			<input class="ml-4" type="radio" name="gender" value="F" required="required"/> 여 
        	    </td>
			</tr>
			<tr>
				<th class="text-center">아이디</th>
				<td>
					<input type="text" required="required" name="id"  maxlength="20">
					<input class="btn btn-secondary btn-sm" type="button" value="아이디 중복 확인"  onclick="idCheck();">
				</td>
			</tr>
			<tr>
				<th class="text-center">비밀번호</th>
				<td>
					<input type="password" id="password1" required="required" min="4" maxlength="12" name="pw">
				</td>
			</tr>
			<tr>
				<th class="text-center">비밀번호 확인</th>
				<td><input type="password" id="password2" placeholder="비밀번호확인" required="required" min="4" maxlength="12"></td>
			</tr>
			<tr>
				<th class="text-center">이메일</th>
				<td>
					<input type="email"  id="email" value="<%=request.getParameter("email") %>" maxlength="50" autocomplete="off" name="email" class="" placeholder="이메일을 입력해주세요" required="required"> 
					<button class="btn btn-secondary btn-sm" id="echeck" onclick="emailCheck();">이메일중복</button>
				</td>
			</tr>
			<tr >
				<th class="text-center">주소</th>
				<td>
					<input type="text" id="sample6_postcode" class="addr1" name="addr1" placeholder="우편번호" readonly="readonly">
					<input class="btn btn-secondary btn-sm" type="button" onclick="sample6_execDaumPostcode()"    value="우편번호 찾기" ><br>
					<input type="text" id="sample6_address"  class="addr1" name="addr2" placeholder="주소" readonly="readonly"><br>
					<input type="text" id="sample6_detailAddress"  class="addr1" name="addr3" placeholder="상세주소" required="required">
				</td>
			</tr>
		<tr>
			<td colspan="2" align="right">
				<input class="btn btn-secondary btn-sm" type="submit" id="btnSend"  value="회원가입하기" />
				<input class="btn btn-secondary btn-sm" type="button" value="취소" onclick="location.href='login.jsp'"/>
			</td>
		</tr>
		</table>
	</form>

   </section>
   
    
</body>
</html>
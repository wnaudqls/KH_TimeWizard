<%@page import="com.minibean.timewizard.model.dto.UserInfoDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE>
<html>
<head>
<meta charset="UTF-8">
<title>mypage</title>

<link href="https://fonts.googleapis.com/css2?family=Source+Code+Pro&family=Source+Sans+Pro:wght@200;400&family=Staatliches&display=swap" rel="stylesheet">
<link href="resources/css/mypage.css" rel="stylesheet">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="resources/js/mypage.js" defer></script>
<link href="/timewizard/css/actionpage.css" rel="stylesheet">
<script src="https://kit.fontawesome.com/3049a69bf8.js" crossorigin="anonymous"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script type="text/javascript">

const elImage = document.querySelector("#reviewImageFileOpenInput");
elImage.addEventListener("change", (evt) => {
  const image = evt.target.files[0];
  if(!validImageType(image)) { 
    console.warn("invalide image file type");
    return;
  }
});

function valideImageType(image) {
  const result = ([ 'image/jpeg',
                    'image/png',
                    'image/jpg' ].indexOf(image.type) > -1);
  return result;
}

//결제 pay
let user_no = ${login.user_no};
let user_name = ${login.user_name};
let membership;

function pay(e){
	var IMP = window.IMP;
	IMP.init('imp26998959');
	let name = $(e).attr("name");
	let price = $(e).val();
	IMP.request_pay({
	    pg : 'inicis', // version 1.1.0부터 지원.
	    pay_method : 'card',
	    merchant_uid : "timewizard-" + new Date().getTime(),
	    name : name, //상품이름
	    amount : price, //판매 가격
	    buyer_email : '${login.user_email}',
	    buyer_name : '${login.user_name}',
	}, function(rsp) {
	    if ( rsp.success ) {
	    	
	    	location.href="/timewizard/pay?user_no="+${login.user_no}+"&pay_name="+rsp.name+"&price="+rsp.paid_amount;
	        var msg = '결제가 완료되었습니다.';
	        msg += '고유ID : ' + rsp.imp_uid;
 	        msg += '상품이름 : '+ rsp.name;
	        msg += '상점 거래ID : ' + rsp.merchant_uid;
	        msg += '결제 금액 : ' + rsp.paid_amount;
	        msg += '카드 승인번호 : ' + rsp.apply_num;
	    } else {
	        var msg = '결제에 실패하였습니다.';
	        msg += '에러내용 : ' + rsp.error_msg;
	    }
	    alert(msg);
	});
}
	
</script>
</head>

<body>

	<div class="mypagebox">

		<div class="mypagemenu" align="center">
			<div class="preview">
				<img id="frame" />
				${fileObj.file_title }
			</div>
			<form:form method="post" enctype="multipart/form-data" modelAttribute="uploadFile" action="upload">
<<<<<<< HEAD
				<label><input type="file" class="mypagebtn" accept="image/*" id="image" name="file_title" /></label>
				<label><input type="submit" class="mypagebtn" value="send" /></label>
				<p style="color: red; font-weight: bold;"><form:errors path="file_title" /></p>
			</form:form>
			
			<table>
				<tr>
					<td>ID</td>
					<td><input type="text" name="" size=20 readonly value="${login.user_id }"></td>
				</tr>
				<tr>
					<td>NAME</td>
					<td><input type="text" name="" size=20 readonly value="${login.user_name }"></td>
				</tr>
				<tr>
					<td>EMAIL</td>
					<td><input type="email" name="" size=20 value="${login.user_email }"></td>
				</tr>
				<tr>
					<td colspan="2" align="right">
						<input type="submit" class="mypagebtn" value="수정" onclick="" /><br/>
						<a href="userpwchange?user_no=${login.user_no }" class="btndesign">암호변경</a>
						<a href="userdeletepage?user_no=${login.user_no }" class="btndesign">탈퇴</a>
					</td>
				</tr>
			</table>
=======
				<div class="userchange">
					<label><input type="file" accept="image/*" id="image" name="file_title" /></label>
					<label><input type="submit" value="send" /></label>
					<p style="color: red; font-weight: bold;"><form:errors path="file_title" /></p>
				</div>
			</form:form>
			
			<form action="userInfoChange">
				<input type="hidden" name="user_no" value="${dto.user_no}">
				<div class="userchange">
					<table>
						<tr>
							<td>ID</td>
							<td><input type="text" name="user_id" size=20 readonly value="${login.user_id }"></td>
						</tr>
						<tr>
							<td>NAME</td>
							<td><input type="text" name="user_name" size=20 value="${login.user_name }"></td>
						</tr>
						<tr>
							<td>EMAIL</td>
							<td><input type="email" name="user_email" size=20 value="${login.user_email }"></td>
						</tr>
						<tr>
							<td colspan="2" align="right">
								<input type="submit" class="submitbox" value="수정" /><br/>
								<a href="userpwchange?user_no=${login.user_no }" class="btndesign">암호변경</a>
								<a href="userdeletepage?user_no=${login.user_no }" class="btndesign">탈퇴</a>
							</td>
						</tr>
					</table>
				</div>
			</form>
>>>>>>> main
		</div>
	
		<div class="mypagemenu" align="center">
			<table>
			<!-- 구현할때 사용하면 될듯!
				<c:choose>
					<c:when test="">
						<tr>
							<th>저장할 수 있는 timelapse가 없습니다.</th>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach items="" >
							<tr>
								<td>날짜 및 시간</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
				-->
				<tr>
					<td>날짜 및 시간</td>
					<td><a class="save"><i class="fas fa-save"></i></a></td>
				</tr>
				<tr>
					<td>날짜 및 시간</td>
					<td><a class="save"><i class="fas fa-save"></i></a></td>
				</tr>
			</table>
		</div>
		
		<div class="mypagemenu" align="center">
			<form>
			<input type="hidden" name="user_no" value="${login.user_no }">
			<table>
			<c:choose>
			<c:when test="${dto.membership eq 'N' }">  
				<tr>
					<td><b>스트리밍 이용</b></td>
					<td colspan="3" align="center"><input type="button" class="payname mypagebtn" name="membership" value="9900" onclick="pay(this);"></td>
				</tr>
			</c:when>
			<c:otherwise>
				<tr>
					<td><b>스트리밍 이용</b></td>
					<td colspan="3" align="center"><input type="button" class="mypagebtn" name="membership" value="9900" onclick="pay(this);" disabled></td>
				</tr>
			</c:otherwise>
			</c:choose>
				<tr>
					<td align="center"><b>timelapse</b></td>
					<td align="center">1</td>
					<td align="center">5</td>
					<td align="center">10</td>
				</tr>			
					<tr>
						<td align="center" id="lastcount">( ${dto.timelapse } )</td>	
						<td><input type="button" class="payname mypagebtn" name="timelapse" value="1000" onclick="pay(this);"></td>
						<td><input type="button" class="payname mypagebtn" name="timelapse" value="5000" onclick="pay(this);"></td>
						<td><input type="button" class="payname mypagebtn" name="timelapse" value="9000" onclick="pay(this);"></td>
					</tr>	
			</table>
			</form>
		</div>
		<div class="home"><a href="main"><i class="fab fa-tumblr-square"></i></a></div>
	</div>

</body>
</html>
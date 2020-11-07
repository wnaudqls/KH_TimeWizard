<%@page import="com.minibean.timewizard.model.dto.ChatDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css"
	href="resources/css/grouplist.css">
<script src="https://kit.fontawesome.com/3049a69bf8.js"
	crossorigin="anonymous"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>
	<nav class="fixedtop">
		<div class="logo">
			<a class="titlelogo" href="main"><img alt=""
				src="resources/img/027-star 2.png"></a> <a class="titlename"
				href="main"><img alt="" src="resources/img/TIME WIZARD.png"></a>
		</div>

		<div class="menu">
			<div id="searchArea">
				<input type="text" id="search" placeholder="아이디 또는 방이름을 입력하세요" />
				<button id="searchBtn">
					<a><i class="fas fa-search"></i></a>
				</button>
			</div>
			<div class="createroom">
				<input type="button" value="만들기"
					onclick="location.href='groupnewroom'">
			</div>
		</div>
	</nav>
	<section class="contentsection">
		<div class="fixedmain">
			<c:choose>
				<c:when test="${empty list }">
					<tr>
						<td>아무것도 없습니다.</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="dto" items="${list }">
						<div class="grouproom">
							<div class="grouptitle">
								<span class="group1">방이름</span> <span class="group2">${dto.group_title }</span>
							</div>
							<div class="groupmain">
								<span class="group1">아이디</span> <span class="groupid">${dto.user_id }</span>
							</div>
							<div align="right">
								<input type="button" value="접속하기"
									onclick="location.href='joinroom/${dto.group_title }'">
							</div>
						</div>
						<div style="width: 1rem"></div>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</div>
	</section>
	<jsp:include page="friendlist.jsp"></jsp:include>
	<jsp:include page="footer.jsp"></jsp:include> 

</body>

<!-- <script type="text/javascript">

자동갱신 ajax 코드
var loop;
$(document).ready(function () {
	roomlist();

});

function roomlist(){
	$.ajax({
	    type: "post",
	    url: "/timewizard/ajaxgrouplist",
	    data: "",
	    dataType: "json",
	    contentType: "application/json",
	    success: function(data){
	    	var list = data.flist;
	    	console.log(list);
	    	$(".fixedmain").empty();
	     	for(i in list){
	    	
  				if(list[i].group_public == "공개"){
  					var name = list[i].group_title;
  					$(".fixedmain").append(
  				"<div class='grouproom'>"
  					+"<div class='grouptitle'>"
  							+"<span class='group1'>방이름</span>"
  							+"<span class='group2'>"+name+"</span>"
  							+"</div>"
  				+"<div class='groupmain'>"
							+"<span class='group1'>아이디</span>"
							+"<span class='groupid'>"+list[i].user_id+"</span>"
							+"</div>"
				+"<div class='groupmain'>"
							+"<span class='group1'>인원수</span>"
							+"<span class='groupid'>"+list[i].group_client+"/"+list[i].group_su+"</span>"
				+"</div>"
				+"<div align='right'>"
					+"<input type='button' value='접속하기' onclick='location.href="+"\"joinroom/"+name+"\"'/>"
					+"</div>"
				+"</div>"
				+"<div style='width: 1rem'>"
				+"</div>"
  					
  					
  					);
   				}
	    	}
	    
	    },
		error: function(data){
			$(".fixedmain").append("<p>연결이 끊겼습니다.</p>");
		}
	    	
	});
	loop = setTimeout("roomlist()", 3000);
}
</script> -->
</html>
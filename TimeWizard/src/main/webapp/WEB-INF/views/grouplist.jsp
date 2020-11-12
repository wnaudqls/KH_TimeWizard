111<%@page import="com.minibean.timewizard.model.dto.ChatDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css"
	href="resources/css/grouplist.css">
<link
	href="https://fonts.googleapis.com/css2?family=Source+Code+Pro&family=Source+Sans+Pro:wght@200;400&family=Staatliches&display=swap"
	rel="stylesheet">
<script src="https://kit.fontawesome.com/3049a69bf8.js"
	crossorigin="anonymous"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>

<!-- 	<nav class="fixedtop">
		<div class="logo">
			<a class="titlelogo" href="main"><img alt=""
				src="resources/image/027-star 2.png"></a> <a class="titlename"
				href="main"><img alt="" src="resources/image/TIME WIZARD.png"></a>
		</div>

		<div class="menu">
			<div id="searchArea">
				<input type="text" id="search" placeholder="아이디 또는 방이름을 입력하세요" class="group_title"/>
				<button id="searchBtn" onclick="searchRoom();">
					<a><i class="fas fa-search"></i></a>
				</button>
				<button id="searchBtn" onclick="reset();">
					초기화
				</button>
			</div>
			<div class="createroom">
				<input type="button" value="만들기"
					onclick="location.href='groupnewroom'">
			</div>
		</div>
	</nav> -->
	
	<section class="contentsection">
	<div class="menu">
			<div id="searchArea">
				<input type="text" id="search" placeholder="아이디 또는 방이름을 입력하세요" onkeyup="enterkey();" />
				<button id="searchBtn" onclick="searchRoom();">
					<a><i class="fas fa-search"></i></a>
				</button>
				<button id="searchBtn" onclick="reset();">
					<a><i class="fas fa-sync"></i></a>
				</button>
			</div>
			<div class="createroom">
				<input type="button" value="만들기"
					onclick="location.href='groupnewroom'">
			</div>
		</div>
		<div class="contentmain">
			<c:choose>
				<c:when test="${empty list }">
					<tr>
						<td>아무것도 없습니다.</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="dto" items="${list }">
						<div class="grouproom">
							<div class="groupimg">
								img
							</div>
							<div class="grouptitle">
								<span class="group2">${dto.group_title }</span>
							</div>
							<div class="groupmain">
								<span class="groupid">${dto.user_id }</span>
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

<script type="text/javascript">

var reflesh;
var loop;
$(document).ready(function () {
	
	roomlist();

});


function reset(){
	if(reflesh == "가능"){
	var gtitle = document.getElementById("search");
	gtitle.value = "";
	roomlist();
	}
}

function searchRoom(){
	
	var gtitle = document.getElementById("search").value;
	console.log(gtitle);
	var paramdata = {
			"group_title": gtitle
	}
	if(gtitle == '' || gtitle.trim() == ''){
		alert("방 이름이나 사용자의 이름을 적어주세요.");
		
	}else{
	$.ajax({
	    type: "post",
	    url: "/timewizard/ajaxgroupselectlist",
	    data: JSON.stringify(paramdata),
	    dataType: "json",
	    contentType: "application/json",
	    success: function(data){
	    	var list = data.selectlist;
	    	$(".contentmain").empty();
	    	
	    	
	    	if(list == '' || list == 'undefined' || list == null){
	    		$(".contentmain").append("찾으시는 방이 존재하지 않습니다.");
	    	}else{
	     	for(i in list){
	    	
  				if(list[i].group_public == "공개"){
  					var name = list[i].group_title;
  					$(".contentmain").append(
  				"<div class='grouproom'>"
					+"<div class='groupimg'>"
					+"img"
					+"</div>"
  					+"<div class='grouptitle'>"
  							+"<span class='group2'>"+name+"</span>"
  							+"</div>"
  				+"<div class='groupmain'>"
							+"<span class='groupid'>"+list[i].user_id+"</span>"
							+"</div>"
				+"<div class='groupmain'>"
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
	    	}
	    
	    },
		error: function(data){
			$(".fixedmain").empty();
			$(".fixedmain").append("<p>연결이 끊겼습니다.</p>");
		}
	    	
	});
	reflesh = "가능";
	console.log("reflesh: "+reflesh);
	clearTimeout(loop);
	}
}
function roomlist(){
	$.ajax({
	    type: "post",
	    url: "/timewizard/ajaxgrouplist",
	    data: "",
	    dataType: "json",
	    contentType: "application/json",
	    success: function(data){
	    	var list = data.flist;
	    	$(".contentmain").empty();
	    	if(list == ''){
    			$(".contentmain").append('<p>방이 없습니다.</p>');
    		}else{
	     	for(i in list){
	    	
  				if(list[i].group_public == "공개"){
  					var name = list[i].group_title;
  					$(".contentmain").append(
  							"<div class='grouproom'>"
  							+"<div class='groupimg'>"
  							+"img"
  							+"</div>"
  		  					+"<div class='grouptitle'>"
  		  							+"<span class='group2'>"+name+"</span>"
  		  							+"</div>"
  		  				+"<div class='groupmain'>"
  									+"<span class='groupid'>"+list[i].user_id+"</span>"
  									+"</div>"
  						+"<div class='groupmain'>"
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
	    	}
	    
	    },
		error: function(data){
			$(".contentmain").empty();
			$(".contentmain").append("<p>연결이 끊겼습니다.</p>");
		}
	    	
	});
	reflesh = "불가능";
	loop = setTimeout("roomlist()", 3000);
	
}

function enterkey(){
	if (window.event.keyCode == 13) {
		searchRoom();
	}
	
}

</script>
</html>
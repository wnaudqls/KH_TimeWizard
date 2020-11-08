<%@page import="com.minibean.timewizard.model.dto.UserInfoDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://unpkg.com/frappe-charts@1.2.4/dist/frappe-charts.min.iife.js"></script>
</head>
<body>
<!-- maincontroller에서 받은 ㄱ값들 -->
<%	
	UserInfoDto linked = (UserInfoDto) session.getAttribute("linked");
	UserInfoDto login = (UserInfoDto)session.getAttribute("login");
%>
	<div id="chart" style="width: 1600px;"></div>
	
	<script>
	//하루 날마다 보여줌
	//날짜, 전체, 완료 보여주기
	//한거랑+안한거=전체리스트
	// [USER_TODO]
	// - TODO_DATE 에서 시간빼고 날짜만
	// - TODO_COMPLETE 각 갯수  : Y는 완료, N는 완료X
	//** 각 유저에 맞게, 날짜에 맞게 가져오기
	//** labels에는 날짜(TODO_DATE)
	//** datasets에는 완료한 갯수, 완료안한 갯수
	//** TODO_NO != TODO_DATE
	

	//let dayy; //날짜 TODO_DATE
	//let CompleteListCount;  //완료한 LIST 갯수
	//let notCompleteListCount;  //완료 못한 LIST 갯수
	
	//날짜--------------------------
	function getDate(date){
		var year =date.getFullYear();
		var month = (1 + date.getMonth());          //M
	    month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
	    var day = date.getDate();                   //d
	    day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
	    return  month + '월' + day+'일'; 
	}
	function getweek(){
		for(var i=0; i<7; i++){
			
		}
	}
	var setting = new Date();
	setting.setDate(setting.getDate()-2); //2일전(=6일뜸)
	setting = getDate(setting);
	console.log("setting : "+setting)
	//날짜------------------------
	
	var user_no = ${login.user_no};
	//var tododate;
	var todocomple;
	var userVal = {
			"user_no": user_no
	}
	var week = new Array();

	// 날짜 가져오기
	// 해당 유저, 해당 날짜 가져오기
	$(document).ready(function(){
		chart();
		daylist();
	});
	function daylist(){
		$.ajax({
			type: "post",
			url: "/timewizard/weekly",
			dataType: "json",
			data: JSON.stringify(userVal),
			contentType: "application/json",
			success: function(data){
				var lst = data.list;
				for(i in lst){
					tododate = lst[i].todo_date;
					console.log("tododate : "+tododate[i])
					todocomple = lst[i].todo_title;
					console.log("todocomple : "+todocomple[i])
				}
			},
			error: function(data){
				alert("weekly 통신실패 ㅠㅠㅠ!!!");
			}
		});
	}
	//차트 부분
	function chart(){
		const data = {
			    labels: week,
			    datasets: [
			        {
			            name: "Complete List", type: "bar",
			            chartType: 'bar',
			            values: [6, 5, 6, 8, 1, 12, 11]},
			            
			        {   name: "not Complete List", type: "bar",
			            chartType: 'bar',
			            values: [2, 1, 3, 5, 2, 10, 2]
			        },
			     ]
			}
	
			const chart = new frappe.Chart("#chart", {  // or a DOM element,
			                                            // new Chart() in case of ES6 module with above usage
			    title: "당신의 한 주",
			    data: data,
			    type: 'axis-mixed', // or 'bar', 'line', 'scatter', 'pie', 'percentage', 'axis-mixed'
			    height: 300,
			    colors: ['#eb2ac4', '#28eb38'],
			    barOptions: {
			    	  stacked: 1    // default 0, i.e. adjacent
			    	}
			})
	}

	</script>
	
</body>
</html>
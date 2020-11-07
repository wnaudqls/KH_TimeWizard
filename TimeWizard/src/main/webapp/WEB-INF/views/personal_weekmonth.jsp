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
	<div id="chart" style="width: 1600px;"></div>
	<script>
	//하루 날마다 보여줌
	//날짜, 전체, 완료 보여주기
	//한거랑+안한거=전체리스트
	// [USER_TODO]
	// - TODO_DATE 에서 시간빼고 날짜만
	// - TODO_COMPLETE 각 갯수  : Y는 완료, N는 완료X
	//** 각 유저에 맞게, 날짜에 맞게 가져오기
	//** labels에는 날짜
	//** datasets에는 완료한 갯수, 완료안한 갯수
	//** TODO_NO != TODO_DATE
	

	var labels; //날짜
	var CompleteListCount;  //완료한 LIST 갯수
	var notCompleteListCount;  //완료 못한 LIST 갯수
	
	
	const data = {
		    labels: ["12am-3am", "3am-6pm", "6am-9am", "9am-12am",
		        "12pm-3pm", "3pm-6pm", "6pm-9pm"],
		        
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
		    title: "여기 제목을 뭐로 할까욤",
		    data: data,
		    type: 'axis-mixed', // or 'bar', 'line', 'scatter', 'pie', 'percentage', 'axis-mixed'
		    height: 300,
		    colors: ['#eb2ac4', '#28eb38'],
		    barOptions: {
		    	  stacked: 1    // default 0, i.e. adjacent
		    	}
		})
	</script>
</body>
</html>
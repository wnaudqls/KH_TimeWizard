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
	const data = {
		    labels: ["12am-3am", "3am-6pm", "6am-9am", "9am-12am",
		        "12pm-3pm", "3pm-6pm", "6pm-9pm"
		    ],
		    datasets: [
		        {
		            name: "My All List", type: "bar",
		            values: [10, 5, 7, 12, 2, 3, 15],
		            chartType: 'bar'
		        },
		        {
		            name: "Complete List", type: "bar",
		            values: [6, 5, 6, 3, 1, 2, 11],
		            chartType: 'bar'
		        }
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
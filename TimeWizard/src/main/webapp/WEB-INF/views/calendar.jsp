<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.1.0/main.min.css">
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.1.0/main.min.js"></script>
<!-- <link href='fullcalendar/main.css' rel='stylesheet' />
 <script src='fullcalendar/main.js'></script> -->
 <style type="text/css">

body {
	margin: 40px 10px;
	padding: 0;
	font-family: "Lucida Grande", Helvetica, Arial, Verdana, sans-serif;
	font-size: 14px;
}
</style>
   
<script type="text/javascript">

 		 document.addEventListener('DOMContentLoaded', function() {
	    var calendarEl = document.getElementById('calendar');

	    var calendar = new FullCalendar.Calendar(calendarEl, {
	      initialView: 'dayGridMonth',
	      initialDate: '2020-10-07',
	      headerToolbar: {
	        left: 'prev,next today',
	        center: 'title',
	        right: 'dayGridMonth,timeGridWeek,timeGridDay '
	      },
	      events: [
	        {
	          title: 'Q클래스 수료',
	          start: '2020-11-17'
	        },
	        {
	          title: '네이버 면접',
	          start: '2020-11-20',
	          
	        },
	        {
	          groupId: '999',
	          title: '결혼식',
	          start: '2020-11-22T16:00:00'
	        },
	        {
	          groupId: '999',
	          title: '결혼식',
	          start: '2020-11-22T16:00:00'
	        },
	        {
	          title: '예비군 동미참 훈련',
	          start: '2020-11-23',
	          end: '2020-11-25'
	        },
	        {
	          title: '유럽 여행',
	          start: '2020-11-26T10:30:00',
	          end: '2020-11-27T12:30:00'
	        },
	        {
	          title: '점심 약속',
	          start: '2020-11-28T12:00:00'
	        },
	        {
	          title: 'Meeting',
	          start: '2020-11-29T10:30:00'
	        },
	        {
	          title: 'Birthday Party',
	          start: '2020-11-29T07:00:00'
	        },
	        {
	          title: 'Click for Google',
	          url: 'http://google.com/',
	          start: '2020-11-30'
	        }
	      ]
	    });

	    calendar.render();
	  });

</script> 
    
    
</head>
<body> 

	  <div id='calendar'>달력 출력</div>
	  

</body>

</html>
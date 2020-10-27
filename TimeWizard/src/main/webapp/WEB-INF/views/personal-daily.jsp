<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
div {
border: 1px;
}
.todo__item {
	display:flex;
}
.todo__insert {
	text-align:center;
}
</style>
<script src="https://kit.fontawesome.com/3049a69bf8.js" crossorigin="anonymous"></script>
</head>
<body>
<%
	Calendar cal = Calendar.getInstance();
	int today_year = cal.get(Calendar.YEAR);
	int today_month = cal.get(Calendar.MONTH) + 1;
	int today_day = cal.get(Calendar.DATE);
	String today = "" + today_year + (today_month<10 ? "0"+today_month : today_month) + (today_day<10 ? "0" + today_day : today_day);
	int year = cal.get(Calendar.YEAR);
	int month = cal.get(Calendar.MONTH) + 1;
	int day = cal.get(Calendar.DATE);
%>

	<h5>tab is here</h5>
	<h4>personal page</h4>
	<h5>list area</h5>
	<div class="daily__part">
		<div class="list">
			<div class="date__area">
				<div class="date__status">
					<a>◀◀</a> <!-- fontawesome에서 괜찮은 화살표 버튼 찾아두기... -->
					<a>◁</a>
					<span class="month"><%=month %>월 </span>
					<span class="mday"><%=day %> 일</span>
					<a>▷</a>
					<a>▶▶</a>
				</div>
				<div class="date__input"><!-- 빨리 찾기 기능...? -->
					<input type="date" id="date" value="${today }" />
				</div>
			</div>
			<div id="todo__list">date's todo-list
			</div>
		</div>
		<br />
		<div class="heatmap__area">
			<h5>heatmap area</h5>
		</div>
	</div>
	<br />
	<h5>TEST :: </h5>
	컬러value값 체크<input type="color" id="colorinput" />
	<button onclick="sayColorValue()">value</button>
	<input type="text" id="whatcolor" /><button onclick="changeColor()">change
	<div class="heatmap"></div>
	<div class="modal__area"></div>
	
	<script type="text/javascript">
	window.addEventListener('DOMContentLoaded', () => {
		dailylist(<%=today%>);
	});
	function sayColorValue(){
		let color = document.getElementById("colorinput").value;
		let space = document.getElementById("whatcolor");
		space.value = color;
	}
	function changeColor(){
		let text = document.getElementById("whatcolor").value;
		let color = document.getElementById("colorinput");
		color.value = text;
	}
	function dailylist(date){
		const xhr = new XMLHttpRequest();
		xhr.open("POST", "daily/list/"+date);
		xhr.send();
		xhr.onreadystatechange = () => {
			if (xhr.readyState == 4 && xhr.status == 200){
				let items = "";
				const list_div = document.getElementById("todo__list");
				list_div.innerHTML = "";
				if (xhr.responseText != null ||xhr.responseText != ""){
					items = JSON.parse(xhr.responseText);
					console.log(items);
					const items_div = document.createElement("div");
					let i = 0;
					for (i = 0; i < items.length; i++) {
						let item_div = document.createElement("div");
						item_div.setAttribute("class","todo__item")
						
						let check_cell = document.createElement("div");
						check_cell.setAttribute("class","cell check__cell");
						let check_cell_span = document.createElement("span");
						check_cell_span.setAttribute("class", "number");
						check_cell_span.textContent = i + 1;
						check_cell.appendChild(check_cell_span);
						/* rownum? checkbox? what? */
						
						let category_cell = document.createElement("div");
						category_cell.setAttribute("class","cell category__cell");
						let category_title = document.createElement("button");
						/* category_title.setAttribute("class","category"); */
						category_title.textContent = (items[i].todo_category == null ? '기본' : items[i].todo_category);
						category_cell.appendChild(category_title);
						/* onclick event */
						
						let title_cell = document.createElement("div");
						title_cell.setAttribute("class","cell title__cell");
						let title = document.createElement("p");
						title.textContent = items[i].todo_title;
						title_cell.appendChild(title);
						
						let stopwatch_cell = document.createElement("div");
						stopwatch_cell.setAttribute("class","cell stopwatch__cell");
						let stopwatch = document.createElement("button");
						stopwatch.setAttribute("class","stopwatch_"+i);
						/* onclick event : */
						/* hover color change */
						let css = '.stopwatch_'+i+':hover { background-color: '+items[i].todo_color+';}'
								+'.stopwatch_'+i+':hover .fas { color: white; }';
						let style = document.createElement("style");						
						if (style.styleSheet){
							style.styleSheet.cssText = css;
						} else {
							style.appendChild(document.createTextNode(css));
						}
						document.getElementsByTagName('head')[0].appendChild(style);
						let caret_right = document.createElement("i");
						caret_right.setAttribute("class","fas fa-caret-right");
						stopwatch.appendChild(caret_right);
						stopwatch_cell.appendChild(stopwatch);
						
						item_div.appendChild(check_cell);
						item_div.appendChild(category_cell);
						item_div.appendChild(title_cell);
						item_div.appendChild(stopwatch_cell);
						items_div.appendChild(item_div);
					} /* for - array items */
					list_div.appendChild(items_div);
				}/* response not null */
				let insert_div = document.createElement("div");
				insert_div.setAttribute("class","todo__insert");
				/* onclick event : modal show and form open -> ajax */
				let plus = document.createElement("i")
				plus.setAttribute("class","fas fa-plus");
				insert_div.appendChild(plus);
				list_div.appendChild(insert_div);
			} else {
				/* 로딩중 화면 */
			}
		}
	}
	<!-- 할일 목록을 클릭하면 불러옴 -->
	<!-- 등록 -->
	<!-- 수정 -->
	<!-- 삭제 confirm 띄우고서 삭제실행 -->
	</script>
</body>
</html>
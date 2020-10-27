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
		<div class="modal__area"></div>
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
				const listDiv = document.getElementById("todo__list");
				listDiv.innerHTML = "";
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
						/* >>onclick event<< */
						
						let title_cell = document.createElement("div");
						title_cell.setAttribute("class","cell title__cell");
						title_cell.setAttribute("onclick","showDetailModal("+items[i].todo_no+");")
						let title = document.createElement("p");
						title.textContent = items[i].todo_title;
						title_cell.appendChild(title);
						
						let stopwatch_cell = document.createElement("div");
						stopwatch_cell.setAttribute("class","cell stopwatch__cell");
						let stopwatch = document.createElement("button");
						stopwatch.setAttribute("class","stopwatch_"+i+" stopwatch");
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
					listDiv.appendChild(items_div);
				}/* response not null */
				let insert_div = document.createElement("div");
				insert_div.setAttribute("class","todo__insert");
				/* onclick event : modal show and form open -> ajax */
				insert_div.setAttribute("onclick","showInsertModal("+date+");");
				let plus = document.createElement("i")
				plus.setAttribute("class","fas fa-plus");
				insert_div.appendChild(plus);
				listDiv.appendChild(insert_div);
			} else {
				/* 로딩중 화면 */
			}
		}
	}
	/* item 클릭시 detail modal */
	function showDetailModal(todo_no){
		const xhr = new XMLHttpRequest();
		xhr.open("POST", "daily/detail/"+todo_no);
		xhr.send();
		xhr.onreadystatechange = () => {
			if (xhr.readyState == 4 && xhr.status == 200){
				let item = "";
				const modal_div = document.getElementById("modal__area");
				modal_div.innerHTML = "";
				if (xhr.responseText != null ||xhr.responseText != ""){
					/* response not null */
					item = JSON.parse(xhr.responseText);
					console.log(item);
					/* 추가 modal 에서 내용만 채우기 */
					
				} else {
					/* response null */
				}
				/* success */
			}else{
				/* fail or loading */
			}
			
		}/* onreadystatechange */
	}
	
	/* 추가 modal */
	function showInsertModal(date){
		/* 
		 * modal area에 들어가야 하는 것들 (insert)
		 * title
		 * color
		 * content
		 * category : 따로 테이블을 만드나...? switch-case로 처리하기에는 다소 난감
		 * hashtag : 스페이스바 누르면 블록 만들어지게 구성. 이렇게 만들어도 근데 잘 검색이 될까
		 * todo_date : 이건 상단 date__area에 자동으로 맞춰지게끔
		 */
		let modalArea = document.getElementsByClassName("modal__area")[0];
		modalArea.innerHTML = "";
		let overlay_div = document.createElement("div");
		overlay_div.setAttribute("class","modal__overlay");
		
		let insert_div = document.createElement("div");
		insert_div.setAttribute("class","modal__insert");
		
		let close_button = document.createElement("button");
		/* onclick event close */
		close_button.setAttribute("onclick","closeModal();");
		let times = document.createElement("i");
		times.setAttribute("class", "fas fa-times");
		close_button.appendChild(times);
		
		let title_input = document.createElement("input");
		title_input.setAttribute("type","text");
		title_input.setAttribute("placeholder","todo 이름");
		title_input.setAttribute("name","todo_title");
		
		/* 색상이 다음 행에서 전개되는 경우 */
		let color_div = document.createElement("div");
		color_div.setAttribute("class","todo__div");
		let color_namespan = document.createElement("span");
		color_namespan.setAttribute("class","todo__subname");
		color_namespan.textContent = "todo 색상";
		let color_input = document.createElement("input");
		color_input.setAttribute("type","color");
		color_input.setAttribute("name","todo_color");
		color_div.appendChild(color_namespan);
		color_div.appendChild(color_input);
		
		let content_textarea = document.createElement("textarea");
		content_textarea.setAttribute("class","todo__textarea");
		content_textarea.setAttribute("name","todo_content");
		content_textarea.setAttribute("placeholder","todo 상세 설명");
		
		let category_div = document.createElement("div");
		category_div.setAttribute("class","todo__div");
		let category_namespan = document.createElement("span");
		category_namespan.setAttribute("class","todo__subname");
		category_namespan.textContent = "todo 속성";
		let category_button = document.createElement("button");
		/* category_button.setAttribute("class",""); */
		category_button.setAttribute("name","todo_category");
		category_button.textContent = "없음";
		category_button.setAttribute("value", category_button.textContent);
		/* onclick -> popup event */
		category_div.appendChild(category_namespan);
		category_div.appendChild(category_button);
		
		let hashtag_div = document.createElement("div");
		hashtag_div.setAttribute("class","todo__div");
		let hashtag_namespan = document.createElement("span");
		hashtag_namespan.setAttribute("class","todo__subname");
		hashtag_namespan.textContent = "해시태그";
		let hashtag_editablediv = document.createElement("div");
		hashtag_editablediv.setAttribute("class","todo__editable");
		hashtag_editablediv.setAttribute("contenteditable","true");
		/* focust, keyup event, (spacebar or ,) event, close event */
		hashtag_div.appendChild(hashtag_namespan);
		hashtag_div.appendChild(hashtag_editablediv);
		
		let date_div = document.createElement("div");
		date_div.setAttribute("class","todo__div");
		let date_namespan = document.createElement("span");
		date_namespan.setAttribute("class","todo__subname");
		date_namespan.textContent = "날짜";
		let date_button = document.createElement("button");
		/* date_button.setAttribute("class",""); */
		date_button.textContent = date.toString().substring(0,4)+"-"+date.toString().substring(4,6)+"-"+date.toString().substring(6,8);
		/* onclick event -> input type=calendar open */
		date_div.appendChild(date_namespan);
		date_div.appendChild(date_button);
		
		let submit_button = document.createElement("button");
		submit_button.setAttribute("class","todo__save");
		submit_button.textContent = "저장";
		/* onclick event : submit */
		
		insert_div.appendChild(close_button);
		insert_div.appendChild(title_input);
		insert_div.appendChild(color_div);
		insert_div.appendChild(content_textarea);
		insert_div.appendChild(category_div);
		insert_div.appendChild(hashtag_div);
		insert_div.appendChild(date_div);
		insert_div.appendChild(submit_button);
		overlay_div.appendChild(insert_div);
		modalArea.appendChild(overlay_div);
	}
	
	/* 수정 modal (-> detail에서 교체? 아니면 마우스오버시 수정버튼이라도 뜨게??) */
	function showUpdateModal(){
		
	}
	
	/* modal창 닫기 이벤트 */
	function closeModal(){
		let modalArea = document.getElementsByClassName("modal__area")[0];
		modalArea.innerHTML = "";
	}
	/* 삭제 let check = confirm('삭제하시겠습니까?') */
	function showDeleteConfirm(){
		let check = confirm('삭제하시겠습니까?')
		/* confirm 말고 modal? */
		if (check){
			
		} else {
			return false;
		}
	}
	/* stopwatch/timer popup event */
	</script>
</body>
</html>
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
	const listDiv = document.getElementById("todo__list");
	listDiv.innerHTML = "";
	const xhr = new XMLHttpRequest();
	xhr.open("POST", "daily/list/"+date);
	xhr.send();
	xhr.onreadystatechange = () => {
		if (xhr.readyState == 4 && xhr.status == 200){
			let items = "";
			if (xhr.responseText != null ||xhr.responseText != ""){
				items = JSON.parse(xhr.responseText);
				console.log(items);
				const items_div = document.createElement("div");
				let i = 0;
				for (i = 0; i < items.length; i++) {
					let item_div = document.createElement("div");
					item_div.setAttribute("class","todo__item")
					
					let number_cell = document.createElement("div");
					number_cell.setAttribute("class","cell number__cell");
					let number_cell_span = document.createElement("span");
					number_cell_span.setAttribute("class", "number");
					number_cell_span.textContent = i + 1;
					number_cell.appendChild(number_cell_span);
					
					let category_cell = document.createElement("div");
					category_cell.setAttribute("class","cell category__cell");
					let category_title = document.createElement("button");
					category_title.setAttribute("class","todo__block");
					category_title.setAttribute("type","button");
					category_title.textContent = (items[i].todo_category == null ? '기본' : items[i].todo_category);
					category_cell.appendChild(category_title);
					/* >>onclick event<< category별로 popup 띄워서 워드클라우드 함 재밌겠다 */
					
					let title_cell = document.createElement("div");
					title_cell.setAttribute("class","cell title__cell");
					title_cell.setAttribute("onclick","showDetailModal("+items[i].todo_no+");")
					let title = document.createElement("p");
					title.textContent = items[i].todo_title;
					title_cell.appendChild(title);
					
					let stopwatch_cell = document.createElement("div");
					stopwatch_cell.setAttribute("class","cell stopwatch__cell");
					let stopwatch = document.createElement("button");
					stopwatch.setAttribute("type","button");
					stopwatch.setAttribute("class","stopwatch_"+i+" stopwatch");
					/* onclick event : stopwatch/timer popup */
					
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
					
					item_div.appendChild(number_cell);
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
/* item 클릭시 detail modal + 수정하기 버튼 누르면 수정 되는걸로... */
function showDetailModal(todo_no){
	const xhr = new XMLHttpRequest();
	xhr.open("POST", "daily/detail/"+todo_no);
	xhr.send();
	xhr.onreadystatechange = () => {
		if (xhr.readyState == 4 && xhr.status == 200){
			let item = "";
			const modal_div = document.getElementsByClassName("modal__area")[0];
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
	let modalArea = document.getElementsByClassName("modal__area")[0];
	modalArea.innerHTML = "";
	
	let overlay_div = document.createElement("div");
	overlay_div.setAttribute("class","modal__overlay");
	
	let insert_div = document.createElement("div");
	insert_div.setAttribute("class","modal__insert");
	
	let form = document.createElement("form");
	form.setAttribute("action","");
	form.setAttribute("method","post");
	form.setAttribute("id","insert__form");
	
	let close_button = document.createElement("button");
	close_button.setAttribute("type","button");
	/* onclick event close */
	close_button.setAttribute("onclick","closeModal();");
	let times = document.createElement("i");
	times.setAttribute("class", "fas fa-times");
	close_button.appendChild(times);
	
	let title_input = document.createElement("input");
	title_input.setAttribute("type","text");
	title_input.setAttribute("placeholder","todo 이름");
	title_input.setAttribute("name","todo_title");
	title_input.setAttribute("id","todo_title");
	
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
	category_button.setAttribute("type","button");
	category_button.setAttribute("class","todo__block");
	category_button.setAttribute("name","todo_category");
	category_button.textContent = "기본";
	category_button.setAttribute("value", category_button.textContent);
	/* onclick -> popup event : 카테고리 나열해서 선택 - 적용 > modal close, value 적용 */
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
	hashtag_editablediv.setAttribute("name","todo_hashtag")
	/* focust, keyup event, (spacebar or ,) event, close event */
	hashtag_div.appendChild(hashtag_namespan);
	hashtag_div.appendChild(hashtag_editablediv);
	
	let date_div = document.createElement("div");
	date_div.setAttribute("class","todo__div");
	let date_namespan = document.createElement("span");
	date_namespan.setAttribute("class","todo__subname");
	date_namespan.textContent = "날짜";
	let date_input = document.createElement("input");
	date_input.setAttribute("type","date");
	date_input.setAttribute("name","todo_date")
	date_input.setAttribute("value",date.toString().substring(0,4)+"-"+date.toString().substring(4,6)+"-"+date.toString().substring(6,8));
	date_div.appendChild(date_namespan);
	date_div.appendChild(date_input);
	
	/* 상세설정 : 소요 시간 작성 저장하기 */
	let time_div = document.createElement("div");
	time_div.setAttribute("class","todo__div");
	let time_namespan = document.createElement("span");
	time_namespan.setAttribute("class","todo__subname");
	time_namespan.textContent = "완료 여부";
	let time_checkbox = document.createElement("input");
	time_checkbox.setAttribute("type","checkbox");
	time_checkbox.setAttribute("name","todo_complete");
	time_checkbox.setAttribute("value","N");
	let starttime = document.createElement("input");
	starttime.setAttribute("type","time");
	starttime.setAttribute("name","start_time");
	starttime.setAttribute("disabled",true);
	let between_span = document.createElement("span");
	between_span.setAttribute("class","tilde");
	between_span.textContent = "~";
	let endtime = document.createElement("input");
	endtime.setAttribute("type","time");
	endtime.setAttribute("name","end_time");
	endtime.setAttribute("disabled",true);
	time_div.appendChild(time_namespan);
	time_div.appendChild(time_checkbox);
	time_div.appendChild(starttime);
	time_div.appendChild(between_span);
	time_div.appendChild(endtime);
	
	let submit_button = document.createElement("button");
	submit_button.setAttribute("class","todo__save");
	submit_button.setAttribute("type","button");
	submit_button.disabled = true;
	submit_button.textContent = "저장";
	/* onclick event : submit */
	submit_button.setAttribute("onclick","submitModal();");
	
	form.appendChild(close_button);
	form.appendChild(title_input);
	form.appendChild(color_div);
	form.appendChild(content_textarea);
	form.appendChild(time_div);
	form.appendChild(category_div);
	form.appendChild(hashtag_div);
	form.appendChild(date_div);
	form.appendChild(submit_button);
	insert_div.appendChild(form);
	
	overlay_div.appendChild(insert_div);
	modalArea.appendChild(overlay_div);
	
	let input_title = document.getElementById("todo_title");
	let button_submit = document.getElementsByClassName("todo__save")[0];
	todo_title.addEventListener("keyup",()=>{
		if(todo_title.value == null || todo_title.value == ""){
			button_submit.disabled = true;
		} else {
			button_submit.disabled = false;
		}
	});
	
	let input_complete = document.getElementsByName("todo_complete")[0];
	let input_starttime = document.getElementsByName("start_time")[0];
	let input_endtime = document.getElementsByName("end_time")[0];
	input_complete.addEventListener("click",()=>{
		if(input_complete.checked == true){
			input_starttime.disabled = false;
			input_endtime.disabled = false;
			input_complete.value = "Y";
		}else {
			input_starttime.disabled = true;
			input_endtime.disabled = true;
			input_complete.value = "N";
		}
	});
}

function submitModal(){
	let input_complete = document.getElementsByName("todo_complete")[0];
	let input_starttime = document.getElementsByName("start_time")[0].value;
	let input_endtime = document.getElementsByName("end_time")[0].value;
	let temp = input_starttime.split(":");
	let starttime_minutes= temp[0] * 60 + temp[1];
	temp = input_endtime.split(":");
	let endtime_minutes = temp[0] * 60 + temp[1];
	console.log(starttime_minutes + ":"+endtime_minutes);
	if(input_complete.checked == true && (input_starttime == "" || input_endtime == "" ||(endtime_minutes - starttime_minutes < 0))){ 
		/* 이부분 어떻게 하는 게 맞지...? 
			complete = Y && starttime != null && endtime != null && endtime - startime > 0 -> ajax
			complete = N -> ajax
		 */
		alert("내용을 바르게 입력해주세요");
		return false;
	} else {
		const xhr = new XMLHttpRequest();
		xhr.open("POST", "daily/insert");
		xhr.setRequestHeader("Content-type","application/json");
		const data = {
				todo_title: document.getElementsByName("todo_title")[0].value,
				todo_color: document.getElementsByName("todo_color")[0].value,
				todo_content: document.getElementsByName("todo_content")[0].value,
				todo_category: document.getElementsByName("todo_category")[0].value,
				todo_complete: document.getElementsByName("todo_complete")[0].value,
				todo_hashtag: document.getElementsByName("todo_hashtag")[0].textContent,
				todo_date: Date.parse(document.getElementsByName("todo_date")[0].value)
		};
		console.log(data);
		xhr.send(JSON.stringify(data));
		xhr.onreadystatechange = () => {
			if (xhr.readyState == 4 && xhr.status == 200){
				dailylist(pagedate);
			}
		}
		closeModal();
	}
}

/* modal창 닫기 이벤트 */
function closeModal(){
	let modalArea = document.getElementsByClassName("modal__area")[0];
	modalArea.innerHTML = "";
}
/* 삭제 let check = confirm('삭제하시겠습니까?') */
/* stopwatch/timer popup event */
function showDeleteConfirm(){
	let check = confirm('삭제하시겠습니까?')
	/* confirm 말고 modal? */
	if (check){
		
	} else {
		return false;
	}
}
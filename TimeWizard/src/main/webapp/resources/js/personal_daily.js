class Calendar{
	constructor(){
		this.date = new Date();
		this.year = this.date.getFullYear();
		this.month = this.date.getMonth(); // 0 ~ 11
		this.day = this.date.getDate();
	}
	
/*
 * Uncaught SyntaxError: A class may only have one constructor
 * 	constructor(year, month, day){ // month: 0~11
 * 		this.date = new Date(year, month, day);
 * 		this.year = this.date.getFullYear();
 * 		this.month = this.date.getMonth();
 * 		this.day = this.date.getDate();
 * 	}
 */
	setDate(year, month, day) { this.date = new Date(year, month, day);
								this.year = this.date.getFullYear();
								this.month = this.date.getMonth();
								this.day = this.date.getDate();
								}
	getYear() { return this.date.getFullYear();};
	setYear(year) { this.date.setFullYear(year); this.year = year;};
	plusYear() { this.date.setFullYear(this.year + 1); this.year = this.date.getFullYear();};
	minusYear() { this.date.setFullYear(this.year -1); this.year = this.date.getFullYear();};
	getMonth() { this.month = this.date.getMonth(); return this.month;};
	setMonth(month) { this.date.setMonth(month); this.month = month;};
	plusMonth() { this.date.setMonth(this.month + 1); this.month = this.date.getMonth();};
	minusMonth() { this.date.setMonth(this.month - 1); this.month = this.date.getMonth();};
	getDay() { this.day = this.date.getDate(); return this.day;};
	setDay(day) { this.date.setDate(day); this.day = day;};
	plusDay() { this.date.setDate(this.day + 1); this.day = this.date.getDate();};
	minusDay() { this.date.setDate(this.day - 1); this.day = this.date.getDate();}
	toString() { return "" + this.year + (this.month+1 < 10 ? "0" + this.month+1: this.month+1) + (this.day < 10 ? "0" + this.day : this.day);};
}

let pageDate = new Calendar();

let category_array = [
	{key:"기본",value:"block__basic"},
	{key:"공부",value:"block__study"},
	{key:"건강",value:"block__health"},
	{key:"생활",value:"block__life"},
	{key:"휴식",value:"block__relax"},
	{key:"관계",value:"block__relation"},
	{key:"기타",value:"block__etc"}
];
let selectedCategory = "";

window.addEventListener('DOMContentLoaded', () => {
	showDailyList(pageDate.toString());
});

function showDailyList(date){
	let month = date.substring(4,6);
	let day = date.substring(6,8);
	let month_div = document.querySelector("div.date__month");
	month_div.textContent = month + "월";
	let day_div = document.querySelector("div.date__day");
	day_div.textContent = day + "일";
	const list_div = document.getElementById("todo__list");
	list_div.innerHTML = "";
	const xhr = new XMLHttpRequest();
	xhr.open("POST", "/timewizard/daily/list/"+date);
	xhr.send();
	xhr.onreadystatechange = () => {
		if (xhr.readyState == 4 && xhr.status == 200){
			let items = "";
			if (xhr.responseText != null ||xhr.responseText != ""){
				items = JSON.parse(xhr.responseText);
				const items_div = document.createElement("div");
				items_div.setAttribute("class","todo__items");
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
					category_title.setAttribute("class", selectCategoryClass(items[i].todo_category));
					category_title.setAttribute("type","button");
					category_title.textContent = (items[i].todo_category == null ? '기본' : items[i].todo_category);
					category_cell.appendChild(category_title);
					/* TODO >>onclick event<< category별로 popup 띄워서 워드클라우드 함 재밌겠다 */
					
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
					if (linkedUserNo == loginUserNo) {
						stopwatch.setAttribute("onclick", "showPopupStopwatch("+items[i].todo_no+");");
					}
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
				list_div.appendChild(items_div);
			}/* response not null */
			/* TODO c:when?으로 session의 user_no와 user_distinct check */
			if (linkedUserNo == loginUserNo) {
				let insert_div = document.createElement("div");
				insert_div.setAttribute("class","todo__insert");
				insert_div.setAttribute("onclick","showInsertModal("+date+");");
				let plus = document.createElement("i")
				plus.setAttribute("class","fas fa-plus");
				insert_div.appendChild(plus);
				list_div.appendChild(insert_div);
			}
			
		} else {
			/* 로딩중 화면 */
		}
	}
}

function selectCategoryClass(itemcategory){
	for (j in category_array){
		if (itemcategory == category_array[j].key || itemcategory == category_array[j].value){
			return "todo__block " + category_array[j].value + "";
		} else if (itemcategory == '예시'){
			return "todo__block block__example";
		}
	}
}

/* 추가 modal */
function showInsertModal(date){
	closeFirstModal();
	closeSecondModal();
	let modalArea = document.getElementsByClassName("modal__area")[0];
	selectedCategory = "";
	
	let overlay_div = document.createElement("div");
	overlay_div.setAttribute("class","modal__overlay");
	overlay_div.setAttribute("onclick","closeFirstModal();");
	
	let insert_div = document.createElement("div");
	insert_div.setAttribute("class","modal__insert");
	
	let form = document.createElement("form");
	form.setAttribute("action","");
	form.setAttribute("method","post");
	form.setAttribute("id","insert__form");
	
	let close_button = document.createElement("button");
	close_button.setAttribute("type","button");
	close_button.setAttribute("class","button__times");
	close_button.setAttribute("onclick","closeFirstModal(); closeSecondModal();");
	let times = document.createElement("i");
	times.setAttribute("class", "fas fa-times");
	close_button.appendChild(times);
	
	let title_input = document.createElement("input");
	title_input.setAttribute("type","text");
	title_input.setAttribute("placeholder","todo 이름");
	title_input.setAttribute("name","todo_title");
	title_input.setAttribute("id","todo_title");
	
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
	category_namespan.textContent = "카테고리";
	let category_button = document.createElement("button");
	category_button.setAttribute("type","button");
	category_button.textContent = "기본";
	category_button.setAttribute("name","todo_category");
	category_button.setAttribute("class",selectCategoryClass(category_button.textContent));
	category_button.setAttribute("value", category_button.textContent);
	category_button.setAttribute("onclick","showCategoryModal();")
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
	starttime.setAttribute("name","todo_starttime");
	starttime.setAttribute("disabled",true);
	let between_span = document.createElement("span");
	between_span.setAttribute("class","tilde");
	between_span.textContent = "~";
	let endtime = document.createElement("input");
	endtime.setAttribute("type","time");
	endtime.setAttribute("name","todo_endtime");
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
	submit_button.setAttribute("onclick","submitInsertModal();");
	
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
	
	modalArea.appendChild(overlay_div);
	modalArea.appendChild(insert_div);
	
	let input_title = document.getElementById("todo_title");
	let button_submit = document.getElementsByClassName("todo__save")[0];
	input_title.addEventListener("keyup",()=>{
		if(input_title.value == null || input_title.value == ""){
			button_submit.disabled = true;
		} else {
			button_submit.disabled = false;
		}
	});
	
	let input_complete = document.getElementsByName("todo_complete")[0];
	let input_starttime = document.getElementsByName("todo_starttime")[0];
	let input_endtime = document.getElementsByName("todo_endtime")[0];
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

function showCategoryModal(){
	let modalArea = document.getElementsByClassName("modal__area")[1];
	modalArea.innerHTML = "";
	
	let overlay_div = document.createElement("div");
	overlay_div.setAttribute("class","modal__overlay");
	overlay_div.setAttribute("onclick","closeSecondModal();");
	
	let category_div = document.createElement("div");
	category_div.setAttribute("class","modal__category");
	
	let information_p = document.createElement("p");
	information_p.textContent = "카테고리를 선택해주세요";
	
	let categories_div = document.createElement("div");
	categories_div.setAttribute("class","categories__div");

	let i = 0;
	for (i = 0; i <category_array.length; i++){
		let category_block = document.createElement("button");
		category_block.setAttribute("type","button");
		category_block.setAttribute("class","todo__block notselected");
		category_block.textContent = category_array[i].key;
		category_block.setAttribute("value",category_block.textContent);
		category_block.setAttribute("onclick","selectedOrNot(this);");
		categories_div.appendChild(category_block);
	}
	
	let buttons_div = document.createElement("div");
	buttons_div.setAttribute("class","buttons__cell")
		
	let accept_button = document.createElement("button");
	accept_button.setAttribute("type","button");
	accept_button.setAttribute("class","button__accept");
	accept_button.textContent = "저장";
	accept_button.setAttribute("onclick","submitCategory();");
	
	buttons_div.appendChild(accept_button);
	
	category_div.appendChild(information_p);
	category_div.appendChild(categories_div);
	category_div.appendChild(buttons_div);
	
	modalArea.appendChild(overlay_div);
	modalArea.appendChild(category_div);
}

function selectedOrNot(element){
	let siblings = t => [...t.parentElement.children].filter(e => e != t);
	element.setAttribute("class", selectCategoryClass(element.value));
	let i = 0;
	selectedCategory = element;
	for (i = 0; i< siblings(element).length; i++){
		 siblings(element)[i].setAttribute("class","todo__block notselected");
	}
}

function submitCategory(){
	let firstModal = document.getElementsByClassName("modal__area")[0];
	let firstModalCategory = firstModal.querySelector("[name=todo_category]")
	if (selectedCategory != null || selectedCategory != ""){
		firstModalCategory.setAttribute("class", selectedCategory.classList[0] + " " + selectedCategory.classList[1]);
		firstModalCategory.textContent = selectedCategory.value;
		firstModalCategory.value = selectedCategory.value;
		closeSecondModal();
	} else {
		alert("카테고리를 선택해주세요");
		return false;
	}
}

function submitInsertModal(){
	let tags = document.querySelectorAll("span.tag");
	let i = 0;
	let input_hashtag = "";
	for (i = 0; i<tags.length; i++){
		input_hashtag += tags[i].textContent;
		input_hashtag += " ";
	}
	let input_complete = document.getElementsByName("todo_complete")[0];
	let input_starttime = document.getElementsByName("todo_starttime")[0].value;
	let input_endtime = document.getElementsByName("todo_endtime")[0].value;
	let temp = input_starttime.split(":");
	let starttime_minutes= temp[0] * 60 + temp[1];
	temp = input_endtime.split(":");
	let endtime_minutes = temp[0] * 60 + temp[1];
	if(input_complete.checked == true && (input_starttime == "" || input_endtime == "" ||(endtime_minutes - starttime_minutes < 0))){ 
		alert("내용을 입력해주세요");
		return false;
	} else {
		let input_date = document.getElementsByName("todo_date")[0].value;
		const xhr = new XMLHttpRequest();
		xhr.open("POST", "/timewizard/daily/insert");
		xhr.setRequestHeader("Content-type","application/json");
		const data = {
				todo_title: document.getElementsByName("todo_title")[0].value,
				todo_color: document.getElementsByName("todo_color")[0].value,
				todo_content: document.getElementsByName("todo_content")[0].value,
				todo_category: document.getElementsByName("todo_category")[0].value,
				todo_complete: document.getElementsByName("todo_complete")[0].value,
				todo_starttime: setTimeForJSON(input_date, input_starttime),
				todo_endtime: setTimeForJSON(input_date, input_endtime),
				todo_hashtag: input_hashtag,
				todo_date: input_date
		};
		xhr.send(JSON.stringify(data));
		xhr.onreadystatechange = () => {
			if (xhr.readyState == 4 && xhr.status == 200){
				showDailyList(pagedate);
			}
		}
		closeFirstModal();
		closeSecondModal();
	}
}


function getDateForValue(days){
	let theday  = new Date(days);
	let year = Number(theday.getYear()) + 1900;
	let month = Number(theday.getMonth()) + 1;
	let date = Number(theday.getDate());
	return year + "-" + month + "-" + date;
}

function setTimeForJSON(days, times){
	if (times == "" || times == null || times == undefined){
		return "";
	} else {
		return days + " " + times;
	}
}

function getTimeForValue(daytime){
	let theday = new Date(daytime);
	let hour = theday.getHours();
	let minutes = theday.getMinutes();
	return hour + ":" + minutes;
}


function closeFirstModal(){
	let modalArea = document.getElementsByClassName("modal__area")[0];
	modalArea.innerHTML = "";
}
function closeSecondModal(){
	let modalArea = document.getElementsByClassName("modal__area")[1];
	modalArea.innerHTML = "";
}
function showDeleteConfirm(todo_no){
	closeSecondModal();
	let modalArea = document.getElementsByClassName("modal__area")[1];
	
	let overlay_div = document.createElement("div");
	overlay_div.setAttribute("class","modal__overlay");
	overlay_div.setAttribute("onclick","closeFirstModal();")
	
	let delete_div = document.createElement("div");
	delete_div.setAttribute("class","modal__delete");
	
	let message_p = document.createElement("p");
	message_p.textContent = "정말 삭제하시겠습니까?\n(삭제한 todo는 복구할 수 없습니다.)";
	
	let buttons_div = document.createElement("div");
	buttons_div.setAttribute("class","buttons__cell")
		
	let delete_button = document.createElement("button");
	delete_button.setAttribute("type","button");
	delete_button.setAttribute("class","button__delete");
	delete_button.textContent = "삭제"
	delete_button.setAttribute("onclick","submitDeleteModal("+todo_no+");");
	
	let cancel_button = document.createElement("button");
	cancel_button.setAttribute("type","button");
	cancel_button.setAttribute("class","button__cancel");
	cancel_button.textContent = "취소"
	cancel_button.setAttribute("onclick","closeSecondModal();");
	
	buttons_div.appendChild(delete_button);
	buttons_div.appendChild(cancel_button);
	delete_div.appendChild(message_p);
	delete_div.appendChild(buttons_div);
	modalArea.appendChild(overlay_div);
	modalArea.appendChild(delete_div);
	
}

function submitDeleteModal(todo_no){
	const xhr = new XMLHttpRequest();
	xhr.open("POST", "/timewizard/daily/delete/"+todo_no);
	xhr.setRequestHeader("Content-type","application/json");
	xhr.send();
	xhr.onreadystatechange = () => {
		if (xhr.readyState == 4 && xhr.status == 200){
			showDailyList(pagedate);
		}
	}
	closeFirstModal();
}

function showDetailModal(todo_no){
	const xhr = new XMLHttpRequest();
	xhr.open("POST", "/timewizard/daily/detail/"+todo_no);
	xhr.send();
	xhr.onreadystatechange = () => {
		if (xhr.readyState == 4 && xhr.status == 200){
			let item = "";
			closeFirstModal();
			closeSecondModal();
			const modalArea = document.getElementsByClassName("modal__area")[0];
			if (xhr.responseText != null ||xhr.responseText != ""){
				item = JSON.parse(xhr.responseText);
				
				let overlay_div = document.createElement("div");
				overlay_div.setAttribute("class","modal__overlay");
				overlay_div.setAttribute("onclick","closeFistModal();");
				
				let detail_div = document.createElement("div");
				detail_div.setAttribute("class","modal__detail");
				
				
				let form = document.createElement("form");
				form.setAttribute("action","");
				form.setAttribute("method","post");
				form.setAttribute("id","update__form");
				
				
				let close_button = document.createElement("button");
				close_button.setAttribute("type","button");
				close_button.setAttribute("class","button__times");
				close_button.setAttribute("onclick","closeFirstModal(); closeSecondModal();");
				let times = document.createElement("i");
				times.setAttribute("class", "fas fa-times");
				close_button.appendChild(times);
				form.appendChild(close_button);
				
				
				if (linkedUserNo == loginUserNo) {
					let delete_button = document.createElement("button");
					delete_button.setAttribute("type","button");
					delete_button.setAttribute("class","button__delete");
					delete_button.textContent = "삭제하기";
					delete_button.setAttribute("onclick","showDeleteConfirm("+ item.todo_no +");");
					form.appendChild(delete_button);
				}
				
				
				let title_input = document.createElement("input");
				title_input.setAttribute("type","text");
				title_input.setAttribute("placeholder","todo 이름");
				title_input.setAttribute("name","todo_title");
				title_input.setAttribute("id","todo_title");
				title_input.setAttribute("value",item.todo_title);
				form.appendChild(title_input);
				
				
				let color_div = document.createElement("div");
				color_div.setAttribute("class","todo__div");
				let color_namespan = document.createElement("span");
				color_namespan.setAttribute("class","todo__subname");
				color_namespan.textContent = "todo 색상";
				let color_input = document.createElement("input");
				color_input.setAttribute("type","color");
				color_input.setAttribute("name","todo_color");
				color_input.setAttribute("value",item.todo_color);
				color_div.appendChild(color_namespan);
				color_div.appendChild(color_input);
				form.appendChild(color_div);
				
				
				let content_textarea = document.createElement("textarea");
				content_textarea.setAttribute("class","todo__textarea");
				content_textarea.setAttribute("name","todo_content");
				content_textarea.setAttribute("placeholder","todo 상세 설명");
				content_textarea.textContent = item.todo_content;
				form.appendChild(content_textarea);
				
				
				let category_div = document.createElement("div");
				category_div.setAttribute("class","todo__div");
				let category_namespan = document.createElement("span");
				category_namespan.setAttribute("class","todo__subname");
				category_namespan.textContent = "카테고리";
				let category_button = document.createElement("button");
				category_button.setAttribute("type","button");
				category_button.textContent = item.todo_category;
				category_button.setAttribute("name","todo_category");
				category_button.setAttribute("class",selectCategoryClass(category_button.textContent));
				category_button.setAttribute("value", category_button.textContent);
				category_button.setAttribute("onclick","showCategoryModal();")
				category_div.appendChild(category_namespan);
				category_div.appendChild(category_button);
				form.appendChild(category_div);
				
				
				let hashtag_div = document.createElement("div");
				hashtag_div.setAttribute("class","todo__div");
				let hashtag_namespan = document.createElement("span");
				hashtag_namespan.setAttribute("class","todo__subname");
				hashtag_namespan.textContent = "해시태그";
				let hashtag_editablediv = document.createElement("div");
				hashtag_editablediv.setAttribute("class","todo__editable");
				hashtag_editablediv.setAttribute("contenteditable","true");
				hashtag_editablediv.setAttribute("name","todo_hashtag")
				
				if (item.todo_hashtag != null && item.todo_hashtag != ''){
					let splitedtexts = item.todo_hashtag.split("^");
					let i = 0;
					let numbers = [];
					for (i=0; i<splitedtexts.length-1; i++){
						numbers[i] = document.createElement("span");
						numbers[i].setAttribute("class","tag label label-info new");
						let removebutton = document.createElement("span");
						removebutton.setAttribute("class","delHashtag");
						removebutton.setAttribute("data-role","remove"); // what is data-role?
						removebutton.setAttribute("aria-hidden","true"); //what is aria-hidden?
						numbers[i].textContent = splitedtexts[i];
						numbers[i].appendChild(removebutton);
						hashtag_editablediv.appendChild(numbers[i]);
						hashtag_editablediv.appendChild(document.createTextNode(" "));
					}
				}
				hashtag_div.appendChild(hashtag_namespan);
				hashtag_div.appendChild(hashtag_editablediv);
				form.appendChild(hashtag_div);

				
				let time_div = document.createElement("div");
				time_div.setAttribute("class","todo__div");
				let time_namespan = document.createElement("span");
				time_namespan.setAttribute("class","todo__subname");
				time_namespan.textContent = "완료 여부";
				let time_checkbox = document.createElement("input");
				time_checkbox.setAttribute("type","checkbox");
				time_checkbox.setAttribute("name","todo_complete");
				time_checkbox.checked = (item.todo_complete == 'Y')?true:false;
				time_checkbox.setAttribute("value",item.todo_complete);
				
				let starttime = document.createElement("input");
				starttime.setAttribute("type","time");
				starttime.setAttribute("name","todo_starttime");
				starttime.disabled = (item.todo_complete == 'Y')?false:true;
				starttime.setAttribute("value", (item.todo_starttime == "" || item.todo_starttime == undefined) ? "" : item.todo_starttime.split(" ")[1]);
				let between_span = document.createElement("span");
				between_span.setAttribute("class","tilde");
				between_span.textContent = "~";
				let endtime = document.createElement("input");
				endtime.setAttribute("type","time");
				endtime.setAttribute("name","todo_endtime");
				endtime.disabled = (item.todo_complete == 'Y')?false:true;
				endtime.setAttribute("value", (item.todo_endtime == "" || item.todo_endtime == undefined) ? "" : item.todo_endtime.split(" ")[1]);
				time_div.appendChild(time_namespan);
				time_div.appendChild(time_checkbox);
				time_div.appendChild(starttime);
				time_div.appendChild(between_span);
				time_div.appendChild(endtime);
				form.appendChild(time_div);
				
				
				let date_div = document.createElement("div");
				date_div.setAttribute("class","todo__div");
				let date_namespan = document.createElement("span");
				date_namespan.setAttribute("class","todo__subname");
				date_namespan.textContent = "날짜";
				let date_input = document.createElement("input");
				date_input.setAttribute("type","date");
				date_input.setAttribute("name","todo_date")
				date_input.setAttribute("value", item.todo_date);
				date_div.appendChild(date_namespan);
				date_div.appendChild(date_input);
				form.appendChild(date_div);
				
				
				if (linkedUserNo == loginUserNo) {
					let submit_button = document.createElement("button");
					submit_button.setAttribute("class","todo__save");
					submit_button.setAttribute("type","button");
					submit_button.textContent = "저장";
					submit_button.setAttribute("onclick","submitUpdateModal("+item.todo_no+");");
					form.appendChild(submit_button);
				}
				
				
				detail_div.appendChild(form);
				modalArea.appendChild(overlay_div);
				modalArea.appendChild(detail_div);
				
				let input_title = document.getElementById("todo_title");
				let button_submit = document.getElementsByClassName("todo__save")[0];
				input_title.addEventListener("keyup",()=>{
					if(input_title.value == null || input_title.value == ""){
						button_submit.disabled = true;
					} else {
						button_submit.disabled = false;
					}
				});
				
				let input_complete = document.getElementsByName("todo_complete")[0];
				let input_starttime = document.getElementsByName("todo_starttime")[0];
				let input_endtime = document.getElementsByName("todo_endtime")[0];
				input_complete.addEventListener("click",()=>{
					if(input_complete.checked == true){
						input_starttime.disabled = false;
						input_endtime.disabled = false;
						input_complete.value = "Y";
					}else {
						input_starttime.disabled = true;
						input_endtime.disabled = true;
						input_starttime.value = "";
						input_endtime.value = "";
						input_complete.value = "N";
					}
				});
				
			} else {
				/* response null */
			}
			/* success */
		}else{
			/* fail or loading */
		}
	}/* onreadystatechange */
}

function submitUpdateModal(todo_no){
	let tags = document.querySelectorAll("span.tag");
	let i = 0;
	let input_hashtag = "";
	for (i = 0; i<tags.length; i++){
		input_hashtag += tags[i].textContent;
		input_hashtag += " ";
	}
	let input_complete = document.getElementsByName("todo_complete")[0];
	let input_starttime = document.getElementsByName("todo_starttime")[0].value;
	let input_endtime = document.getElementsByName("todo_endtime")[0].value;
	let temp = input_starttime.split(":");
	let starttime_minutes= temp[0] * 60 + temp[1];
	temp = input_endtime.split(":");
	let endtime_minutes = temp[0] * 60 + temp[1];
	if(input_complete.checked == true && (input_starttime == "" || input_endtime == "" ||(endtime_minutes - starttime_minutes < 0))){ 
		alert("내용을 입력해주세요");
		return false;
	} else {
		let input_date = document.getElementsByName("todo_date")[0].value;
		const xhr = new XMLHttpRequest();
		xhr.open("POST", "/timewizard/daily/update");
		xhr.setRequestHeader("Content-type","application/json");
		const data = {
				todo_no: todo_no,
				todo_title: document.getElementsByName("todo_title")[0].value,
				todo_color: document.getElementsByName("todo_color")[0].value,
				todo_content: document.getElementsByName("todo_content")[0].value,
				todo_category: document.getElementsByName("todo_category")[0].value,
				todo_complete: document.getElementsByName("todo_complete")[0].value,
				todo_starttime: setTimeForJSON(input_date, input_starttime),
				todo_endtime: setTimeForJSON(input_date, input_endtime),
				todo_hashtag: input_hashtag,
				todo_date: input_date
		};
		xhr.send(JSON.stringify(data));
		xhr.onreadystatechange = () => {
			if (xhr.readyState == 4 && xhr.status == 200){
				showDailyList(pagedate);
			}
		}
		closeFirstModal();
	}
}

/* stopwatch/timer popup event */
function showPopupStopwatch(todo_no){
	window.open('/timewizard/stopwatch', 'window_'+todo_no,'width=300, height=190, left=0, top=100, status=no, resizable=no');
}
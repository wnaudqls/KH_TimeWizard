/* 프로필 이미지 미리보기 */
var image = document.getElementById('image');
var frame = document.getElementById('frame');
image.addEventListener('change', function(e) {
	console.log(e);
	var file = e.target.files[0];
	frame.src = URL.createObjectURL(file);
});


/* 프로필 이미지 업로드 */
function uploadProfile(){
	let fileInput = document.querySelector("[name=file]");
	let file = fileInput.files[0];
	let formData = new FormData();
	formData.append("file",file);
	const xhr = new XMLHttpRequest();
	xhr.open("POST","/timewizard/file/upload");
	xhr.send(formData);
	xhr.onreadystatechange = () => {
		if (xhr.readyState == 4 && xhr.status == 200){
			if (JSON.parse(xhr.responseText).result == true){
				selectOne(user_no);
			}
		}
	}
}

function selectOne(user_no){
	let title = document.querySelector(".title");
	title.innerHTML = "";
	const xhr = new XMLHttpRequest();
	xhr.open("POST","/timewizard/file/one/"+user_no);
	xhr.send();
	xhr.onreadystatechange = () => {
		if (xhr.readyState == 4 && xhr.status == 200){
			console.log(xhr.responseText);
			if (xhr.responseText != null && xhr.responseText != ""){
				let file = JSON.parse(xhr.responseText);
				
				let files_div = document.createElement("div");
				files_div.setAttribute("class","files");
				
				let file_div = document.createElement("div");
				file_div.setAttribute("class","file");
					
				let number_cell = document.createElement("div");
				number_cell.setAttribute("class","cell number__cell");
				let number_cell_span = document.createElement("span");
				number_cell_span.setAttribute("class", "number");
				number_cell_span.textContent = 1;
				number_cell.appendChild(number_cell_span);
				
				let title_cell = document.createElement("div");
				title_cell.setAttribute("class","cell title__cell");
				let title = document.createElement("p");
				title.textContent = file.file_name;
				title_cell.appendChild(title);
				
				let download_cell = document.createElement("div");
				download_cell.setAttribute("class","cell download__cell");
				
				let form = document.createElement("form");
				form.setAttribute("action","/timewizard/file/download/"+file.file_no);
				form.setAttribute("method","POST");
				let submit = document.createElement("input");
				submit.setAttribute("type","submit");
				submit.setAttribute("value","download");
				form.appendChild(submit);
				download_cell.appendChild(form);
				
				file_div.appendChild(number_cell);
				file_div.appendChild(title_cell);
				file_div.appendChild(download_cell);
				files_div.appendChild(file_div)
				title.appendChild(files_div);
				
			} else if (xhr.responseText == "" || xhr.responseText == null){
					title.textContent = "저장된 파일이 없습니다.";
			}
		}
	}
}
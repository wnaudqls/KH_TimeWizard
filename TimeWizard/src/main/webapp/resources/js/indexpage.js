window.onload = function() {
	const p5box = document.querySelectorAll('.p5box');
	const contentbox = document.querySelectorAll('.contentbox');
	const hoverbox = document.querySelectorAll('.hoverbox');
	const hovertext = document.querySelectorAll('.hovertext');

	for(let i=0 ; i<p5box.length ; i++) {
		p5box[i].addEventListener("mouseover", function() {
			contentbox[i].style = 'margin-top:25vh';
			hoverbox[i].style = 'height:20vh';
			hovertext[i].style = 'height:10vh';
		});

		p5box[i].addEventListener("mouseout", function() {
			contentbox[i].style = 'margin-top:35vh';
			hoverbox[i].style = 'height:10vh';
			hovertext[i].style = 'height:0vh';
		});
	}
} 
var image = document.getElementById('image');
var frame = document.getElementById('frame');
image.addEventListener('change', function(e) {
	console.log(e);
	var file = e.target.files[0];
	frame.src = URL.createObjectURL(file);
});

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link href="https://fonts.googleapis.com/css2?family=Source+Code+Pro&family=Source+Sans+Pro:wght@200;400&family=Staatliches&display=swap" rel="stylesheet">
<link href="resources/css/actionpage.css" rel="stylesheet">
<script src="resources/js/actionpage.js" defer></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://kit.fontawesome.com/3049a69bf8.js" crossorigin="anonymous"></script>

</head>

<style>

:root {
    --text-color: #f0f4f5;
    --background-color: #263343;
    --accent-color: #d49466;
}

body {
    margin: 0;
    font-family: 'Staatliches';
}

a {
    text-decoration: none;
    color: var(--text-color);
}

.navbar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    background-color: var(--background-color);
    padding: 8px 12px;
}

.nav_logo {
    font-size: 24px;
    color: var(--text-color);
}

.nav_logo i {
    color: var(--accent-color);
}

.nav_menu {
    display: flex;
    list-style: none;
    padding-left: 0;
}

.nav_menu li {
    padding: 8px 12px;
}

.nav_menu li:hover {
    background-color: var(--accent-color);
    border-radius: 4px;
}

.nav_icon {
    list-style: none;
    color: var(--text-color);
    display: flex;
    padding-left: 0;	
}

.nav_icon li {
    padding: 8px 12px;
    font-size: 24px;
}

.nav_icon li i{
    cursor: pointer;
}

.nav_toggle {
    display: none;
    position: absolute;
    right: 25px;
    font-size: 24px;
    color: var(--accent-color);
}

@media screen and (max-width: 1140px) {
    .navbar {
        flex-direction: column;
        align-items: flex-start;
        padding: 8px 24px;
    }
    
    .nav_logo {
        font-size: 40px;
    }
    
    .nav_menu {
        display: none;
        flex-direction: column;
        align-items: center;
        width: 100%;
        font-size: 50px;
    }
    
    .nav_menu li {
        width: 100%;
        text-align: center;
    }
    
    .nav_icon {
        display: none;
        width: 100%;
        justify-content: center;
        font-size: 40px;
    }
    
    .nav_toggle {
        display: block;
        font-size: 40px;
    }
    
    .nav_menu.active,
    .nav_icon.active {
        display: flex;
    }
}

</style>
<body>
	
	<nav class="navbar">
		<div class="nav_logo">
			<i class="fas fa-magic"></i>
			<a href="">TiWi</a>
		</div>
		<ul class="nav_menu">
			<li><a href="">Home</a></li>
			<li><a href="">Garrely</a></li>
			<li><a href="">Notice</a></li>
			<li><a href="">FAQ</a></li>
			<li><a href="">Mypage</a></li>
		</ul>
		<ul class="nav_icon">
			<li><i class="fab fa-twitter-square"></i></li>
			<li><i class="fab fa-facebook-square"></i></li>
		</ul>
		
		<a href="#" class="nav_toggle">
			<i class="fas fa-bars"></i>
		</a>
	</nav>

</body>
<script>

const toggleBtn = document.querySelector('.nav_toggle');
const menu = document.querySelector('.nav_menu');
const icon = document.querySelector('.nav_icon');

toggleBtn.addEventListener('click', () => {
	menu.classList.toggle('active');
	icon.classList.toggle('active');
})


</script>
</html>















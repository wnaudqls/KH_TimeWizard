<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html lang="ko">
<head>
<script type="text/javascript"
    src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
 
</head>
<body>
  <div class="padd">
    <h6>네이버 로그인 성공 화면</h6>
    <hr />
    <div id="resultCode" style="text-align:center"></div>
    <div id="message" style="text-align:center"></div>
    <div id="image" style="text-align:center"><img src=""></img</div>
    <div id="id" style="text-align:center"></div>
    <div id="name" style="text-align:center"></div>
    <div id="email" style="text-align:center"></div>
    <a href="http://nid.naver.com/nidlogin.logout">로그아웃</a>
  </div>

  <script>
    $(document).ready(function(){
      var obj = JSON.parse('${result}');

      $("#resultCode").text("결과코드 : " + obj.resultcode);
      $("#message").text("결과메시지 : " + obj.message);
      $("#id").text("아이디 : " + obj.response.id);
      $("#name").text("이름 : " + obj.response.name);
      $("#email").text("이메일 : " + obj.response.email);
      $("#image").children("img").attr("src", obj.response.profile_image);
    });
  </script>
 
</body>
</html>

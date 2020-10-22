<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">

	$(function () {
		$("#loginchk").hide();
	});
	
	function loginPrc() {
		var memberid = $("#memberid").val().trim();
		var memberpw = $("#memberpw").val().trim();
		// 객체리터럴
		var loginVal = {
				"memberid": memberid,
				"memberpw": memberpw
		}
		if (memberid == null || memberid == "" || memberpw == null || memberpw == "") {
			alert("ID와 PW를 모두 작성해주세요")
		} else {
			$.ajax({
				type: "post",
				url: "ajaxlogin.do",
				data: JSON.stringify(loginVal),
				contentType: "application/json",
				dataType: "json",
				success: function (msg) {
					if(msg.check == true) {
						location.href='list.do';
					} else {
						$("#loginchk").show();
						$("#loginchk").html("ID 혹은 PW가 잘못 입력되었습니다").css("color", "red")
					}
				},
				error: function () {
					alert("통신실패");
				}
			})
		}
	}

</script>

</head>
<body>

	<h1>Login</h1>
	
	<table border="1">
		<tr>
			<th>ID</th>
			<td><input type="text" id="memberid" /></td>
		</tr>
		<tr>
			<th>PW</th>
			<td><input type="text" id="memberpw" /></td>
		</tr>
		<tr>
			<td colspan="2" align="right">
				<input type="button" value="login" onclick="loginPrc();" />
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center" id="loginchk"></td>
		</tr>
	</table>

</body>
</html>
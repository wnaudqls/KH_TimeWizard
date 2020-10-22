<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 중복 확인</title>
<script type="text/javascript">
	onload = function() {
		var id = opener.document.getElementsByName("user_id")[0].value;
		document.getElementsByName("nick")[0].value = id;
	}
	function confirmId(bool) {
		if (bool == "true") {
		}
		self.close();
	}
</script>
</head>
<body>

	<table border="1">
		<tr>
			<td>
				<input type="text" name="nick"/>
			</td>
		</tr>
		<tr>
			<td>${user_id}.equals("true")?" 사용 가능 닉네임 입니다.":"중복된 닉네임 존재!" </td>
		</tr>
		<tr>
			<td>
				<input type="button" value="확인" onclick="confirmId('${user_id}')" />
				<!-- quotation problem -->
			</td>
		</tr>
	</table>

</body>
</html>
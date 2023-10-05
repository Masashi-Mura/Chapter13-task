<%@ page contentType="text/html; charset=UTF-8"%>
<%
//セッションの有効期限設定180秒
session.setMaxInactiveInterval(180);

String logout = (String) request.getParameter("logout");
String javaMessage = null;

//セッションの管理
//logoutがtrueでセッション削除
if (logout != null && logout.equals("true")) {
	session.invalidate();
} else {
	//パラメータにメッセージがあればセッションに保存
	//パラメータにメッセージが無ければ、セッションからメッセージを読み込み
	javaMessage = (String) request.getParameter("htmlMessage");
	if (javaMessage != null) {
		session.setAttribute("htmlMessage", javaMessage);
	} else {
		javaMessage = (String) session.getAttribute("htmlMessage");
	}
}
if (javaMessage == null)
	javaMessage = "";
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>registerMessage</title>
<style>
ul {
	list-style: none;
}
</style>
</head>
<body>
	<form method="GET" action="/jsp/registerMessage.jsp">
		<ul>
			<li>
				<label for="htmlMessage">メッセージ</label>
			    <input type="text" name="htmlMessage" value="<%=javaMessage%>" />
		    </li>
			<li><input type="submit" value="登録" /> </li>
				<!-- セッション削除 --> 
			<li><a href="/jsp/registerMessage.jsp?logout=true">ログアウト</a></li>
		</ul>
	</form>
</body>

</html>
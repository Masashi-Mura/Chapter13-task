<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.ZoneId" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:setLocale value="ja_JP" />
<%!private static Map<String, String> eventMap = new HashMap<>();
	static {
		eventMap.put("20231009", "スポーツの日");
		eventMap.put("20231103", "文化の日");
		eventMap.put("20231123", "勤労感謝の日");
		eventMap.put("20231031", "ハロウィン");
		eventMap.put("20231224", "クリスマスイブ");
		eventMap.put("20231225", "クリスマス");
		eventMap.put("20231231", "大晦日");
		eventMap.put("20240101", "お正月");
		eventMap.put("20240108", "成人の日");
		eventMap.put("20240211", "建国記念日");
		//eventMap.put("20231003", "動作確認用");
	}
%>
<%
//リクエストパラメーターから日付を取り出す
String year = (String)request.getParameter("year");
String month = (String)request.getParameter("month");
String day = (String)request.getParameter("day");
//日付の設定を行う
LocalDate localDate = null;
if (year == null || month == null || day == null) {
	//本日の日付を設定する
	localDate = LocalDate.now();
	year = String.valueOf(localDate.getYear());
	month = String.valueOf(localDate.getMonthValue());
	day = String.valueOf(localDate.getDayOfMonth());
} else {
	//送信された日付をもとに、LocalDateのインスタンスを生成する
	localDate = LocalDate.of(Integer.parseInt(year), Integer.parseInt(month), Integer.parseInt(day));
}
String[] dates = { year, month, day };

//画面で利用するための日付、イベント情報を保存
session.setAttribute("dates", dates);
session.setAttribute("date", Date.from(localDate.atStartOfDay(ZoneId.systemDefault()).toInstant()));

DateTimeFormatter dtm = DateTimeFormatter.ofPattern("yyyyMMdd");
String event = (String)eventMap.get(localDate.format(dtm));
session.setAttribute("event", event);
%>

<!DOCTYPE HTML>
<html>
<head>
<meta charset="UTF-8">
<title>calendar</title>
<style>
ul {
	list-style: none;
}
</style>
</head>
<body>
	<form method="POST" action="/jsp/calendar.jsp">
		<ul>
			<li><input type="text" name="year" value="${param['year']}" id="year"/>
				<label for="year">年</label>
				<input type="text" name="month" value="${param['month']}" id="month"/>
				<label for="month">月</label>
				<input type="text" name="day" value="${param['day']}" id="day"/>
				<label for="day">日</label>
			</li>
			<li><input type ="submit" value="送信"/>
			<li><c:out value="${fn:join(dates,'/')}"/>(<fmt:formatDate value="${date}" pattern="E"/>)</li>
			<li><c:out value="${event}"/></li>
		</ul>
	</form>
</body>
</html>

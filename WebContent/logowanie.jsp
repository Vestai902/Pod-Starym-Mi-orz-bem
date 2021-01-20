<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Logowanie</title>
  <link rel="stylesheet" href="log.css">
</head>
<body>
<div id="topbar"><div id="logo">Pod Starym<br>Miłorzębem</div></div>
  <div id="logowanie">
	<%if((String)session.getAttribute("usname")!=null){response.sendRedirect("index.jsp");return;} %>
	
	<div id="pod">Logowanie</div>
	
    <form method="post" action="log">
	
       <input type="text" name="nazwa_uzytkownika" placeholder="Nazwa użytkownika:"/>

       <input type="password" name="haslo" placeholder="Hasło:"/>

	   <div class="s1">
	   <a href="url">Zapomniałeś hasła?</a>
	   </div>
	   
	   <p>${err}</p>
       <button type="submit" class="btn" name="login_user">Zaloguj</button>
    </form>
	<br>
	<a href="rejestracja.jsp">Nie masz jeszcze konta? Przejdź do Rejestracji.</a>
  </div>
  <script>
	document.getElementById("logo").addEventListener("click", toM);

	function toM() {
	window.location.href="index.jsp";
	}
	</script>
</body>
</html>
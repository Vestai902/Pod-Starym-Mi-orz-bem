<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Pod Starym Miłorzębem</title>
  <link rel="stylesheet" href="dodPrac.css">
</head>
<body>
	<div id="topbar"><div id="logo">Pod Starym<br>Miłorzębem</div>
	<div id="wyszukaj"><form method="get" action="wyszukiwanie.jsp"><input name="search" type="text" id="te" placeholder="Czego szukasz?"><button name="bt1" class="bt" >&#x2315;</button>	

	</form></div>
	<div id="user">
	
		<%
		String user=(String)session.getAttribute("usname");
		if(user!=null){
		%>
		<div class="w1">
		<a href="koszyk.jsp">
		<div class="cartt"></div></a>
		</div>
		<div class="w1">
		<div class="dropd">
		<div onclick="myFunction()" class="drop">
		<%=user %>
		</div>
		<div id="mDropd" class="dropd-cont">
		<a href="histo.jsp">Zamówienia</a>
		<a href="add.jsp">Dodaj</a>
		
		<a href="logout?n=1">Wyloguj</a>
		</div>
		</div>
		</div>
		<script>

		function myFunction() {
		document.getElementById("mDropd").classList.toggle("show");
			}

		
			
			document.getElementsByClassName(".drop").addEventListener("click", xx);
			document.getElementsByClassName(".xd2").addEventListener("click", xx);
			function xx(){
			
				var dropdowns = document.getElementsByClassName("dropd-cont");
				var i;
				for (i = 0; i < dropdowns.length; i++) {
				var openDropdown = dropdowns[i];
				if (openDropdown.classList.contains('show')) {
					openDropdown.classList.remove('show');
						}
					}
			}
		</script>	
		
		<%}else{%>
		<div id="rej">Zarejestruj</div>
		<div id="log">Zaloguj</div>
		<script>
		document.getElementById("rej").addEventListener("click", zRej);

		function zRej() {
		window.location.href="rejestracja.jsp";
		}

		document.getElementById("log").addEventListener("click", zLog);

		function zLog() {
		window.location.href="logowanie.jsp";
		}
		</script>
		<%} %>
		
		
	</div></div>
  <div id="dodawanie">
	
	<div id="pod">Dodaj nazwę nowej kategorii</div>
	
    <form method="post" action="addCt">
	
       <input type="text" name="nazwa_kategorii" placeholder="Nazwa kategorii:"/>


       <button type="submit" class="btn" name="add_p">Dodaj</button>
    </form>
	<br>
	<h2 style="color:red;">${prdod}</h2>
  </div>
  <script>
	document.getElementById("logo").addEventListener("click", toM);

	function toM() {
	window.location.href="index.jsp";
	}
	</script>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <link rel="stylesheet" href="dane.css">

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
		<div class="cartt"></div>
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
<div id="cont">

  <div id="dane">
	<h1>Dane do wysyłki:</h1>
    <form method="post" action="dn">
       <input type="text" name="imie" placeholder="Imie: "required>
       <input type="text" name="nazwisko" placeholder="Nazwisko: "required>
	   <input type="text" name="miejscowosc" placeholder="Miejscowosc: "required>
	   <input type="text" name="ulica" placeholder="Ulica z numerem domu: "required>
	   <input type="text" name="kod_po" pattern="[0-9]{2}\-[0-9]{3}" title="Kod pocztowy wymagany w następującym formacie NP: 12-345" placeholder="Kod pocztowy: " required>
       <input type="email" name="email" placeholder="Email: "required>
       <input type="tel" name="telefon" placeholder="Telefon: " pattern="[0-9]{9}" title="Potrzebne jest 9 cyfr" required>

	   <div class="s1">
	   <input type="checkbox" name="reg" id="reg" required>
	   <label for="reg">Oświadczam, że znam i akceptuję postanowienia <a href="regulamin.jsp" >Regulaminu Pod Starym Miłorzębem.</a></label>
	   </div><div class="s1">
	   <input type="checkbox" name="pozw" id="pozw" required>
	   <label for="pozw">  Wyrażam zgodę na przetwarzanie moich danych osobowych w celach marketingowych i otrzymywanie informacji handlowych od Pod Starym Miłorzębem z wykorzystaniem telekomunikacyjnych urządzeń końcowych (m.in. telefon) oraz środków komunikacji elektronicznej (m.in. SMS, e-mail). 
       </label>
	   </div>
       <button type="submit" class="btn" name="nt">Przejdź dalej</button>
    </form>
	<br>
  </div>
</div>
<script>
	document.getElementById("logo").addEventListener("click", toM);

	function toM() {
	window.location.href="index.jsp";
	}
	</script>
</body>

</html>
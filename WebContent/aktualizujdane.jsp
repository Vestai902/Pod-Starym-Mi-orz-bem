<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Pod Starym Miłorzębem</title>
  <link rel="stylesheet" href="zmianadanych.css">
</head>
<body>
	<div id="topbar"><div id="logo">Pod Starym<br>Miłorzębem</div>
	<div id="wyszukaj"><form method="get" action="wyszukiwanie.jsp"><input name="search" type="text" id="te" placeholder="Czego szukasz?"><button name="bt1" class="bt" >&#x2315;</button>	

	</form></div>
	<div id="user">
	
		<%
		Integer rank=(Integer)session.getAttribute("rank");
		String user=(String)session.getAttribute("usname");
		if(rank==null||rank!=2){response.sendRedirect("index.jsp");}
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
		<%if(rank==2){ %>
		<a href="historiazamowien.jsp">Zamówienia</a>
		<a href="aktualizujdane.jsp">Zmiana danych osobowych</a>
		
		<a href="logout?n=1">Wyloguj</a>
		<%}else if(rank==4||rank==3){ %>
		<a href="add.jsp">Dodaj nowy produkt</a>
		<a href="dodajkategorie.jsp">Dodaj kategorie</a>
		<a href="itemmgmt.jsp">Zarządzaj produktami</a>
		<a href="zamowieniazr.jsp">Zamówienia użytkownicy zarejestrowani</a>
		<a href="zamowienianzr.jsp">Zamówienia użytkownicy niezarejestrowani</a>
		<a href="zgloszenia.jsp">Zgłoszone komentarze</a>
		 <% if(rank==3){%>
		 <a href="dodajpracownika.jsp">Dodaj pracownika</a>
		<a href="zmienhaslo.jsp">Zmień hasło użytkownika</a>
		<a href="ban.jsp">Zbanuj/Odbanuj użytkownika</a>
		 <%} %>
		<a href="logout?n=1">Wyloguj</a>
		
		<%} %>
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
	
	<h1 style="color:white;margin-left:150px;">Zmień dane:</h1>
  <div id="dodawanie">
	
	<div id="pod">Zmień hasło</div>
	
    <form method="post" action="updUserD">

       <input type="password" name="haslo1"  pattern=".{8,}" title="8 lub więcej znaków" placeholder="Nowe hasło: " required/>
  
       <input type="password" name="haslo2"  pattern=".{8,}" title="8 lub więcej znaków" placeholder="Powtórz nowe hasło:" required/>

<p>${hasloerr}</p>

       <button type="submit" class="btn" name="z_haslo">Zmień</button>
    </form>
	<br>
	<h2 style="color:red;">${prdod1}</h2>
  </div>
  
   <div id="dodawanie">
	
	<div id="pod">Zmień dane kontaktowe</div>
	
    <form method="post" action="updUserD">
    
    	<input type="text" name="imie" placeholder="Imie: "required>
       <input type="text" name="nazwisko" placeholder="Nazwisko: "required>
	   <input type="text" name="miejscowosc" placeholder="Miejscowosc: "required>
	   <input type="text" name="ulica" placeholder="Ulica z numerem domu: "required>
	   <input type="text" name="kod_po" pattern="[0-9]{2}\-[0-9]{3}" title="Kod pocztowy wymagany w następującym formacie NP: 12-345" placeholder="Kod pocztowy: "required>


       <button type="submit" class="btn" name="z_dane">Zmień</button>
    </form>
	<br>
	<h2 style="color:red;">${prdod2}</h2>
  </div>
  
   <div id="dodawanie">
	
	<div id="pod">Zmień adres E-mail</div>
	
    <form method="post" action="updUserD">
    
           <input type="email" name="email" placeholder="Email: "required>


       <button type="submit" class="btn" name="z_email">Zmień</button>
    </form>
	<br>
	<h2 style="color:red;">${prdod3}</h2>
  </div>
  
   <div id="dodawanie">
	
	<div id="pod">Zmień nr telefonu</div>
	
    <form method="post" action="updUserD">
    
    	<input type="tel" name="telefon" placeholder="Telefon: " pattern="[0-9]{9}" title="Potrzebne jest 9 cyfr" required>

<p>${hasloerr}</p>

       <button type="submit" class="btn" name="z_tele">Zmień</button>
    </form>
	<br>
	<h2 style="color:red;">${prdod4}</h2>
  </div>
  
  <script>
	document.getElementById("logo").addEventListener("click", toM);

	function toM() {
	window.location.href="index.jsp";
	}
	</script>
</body>
</html>

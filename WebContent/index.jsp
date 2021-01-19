<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ page import="java.util.ArrayList,java.io.IOException,javax.imageio.ImageIO,java.sql.*,java.io.*,java.sql.Connection,java.sql.DriverManager"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Pod Starym Miłorzębem</title>
  <link rel="stylesheet" href="gl.css">
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
	<div class="pnl">
	<div class="kat">
		<div class="dropd1">
		<div onclick="myFunction1()" class="drop1">
		Kategorie
		</div>
		<div id="mDropd1" class="dropd-cont1">
		
			<%
	String url = "jdbc:postgresql://localhost:5432/shop";
    String userr = "postgres";
    String password = "admin";
    Connection conn = null;
    int id=0;
    String name="";
    int price=0;
    		
    try{	
		conn = DriverManager.getConnection(url, userr, password);
	}catch(Exception exp){
		System.out.println("err");
		response.sendRedirect("index.jsp");
		}
    if (conn != null) {
    	String SQL = "SELECT * FROM categories";
	
		try{
			
		
	            Statement stmt = conn.createStatement();
	            ResultSet rs = stmt.executeQuery(SQL); 
	            while (rs.next()) {
	            	id=rs.getInt("category_id");
	            	name=rs.getString("name");
	            	
	            	%>
		<a href="wyszukiwanie.jsp?kat=<%=id%>"><%=name%></a>
		
		<%}
	        	}catch(Exception e){
	        		System.out.println(e);
	        	}
	        	
				}else{
	        		response.sendRedirect("index.jsp");
				}
		
		%>
		
		</div>
		</div>
		</div>
		<a href="porady.jsp"><div class="porad">Porady do parzenia herbaty</div></a>
		<a href="kontakt.jsp"><div class="kontakt">Kontakt</div></a>
		
	</div>
		
		
		
	<div id="cont">
	
	<div class="inf">Sklep Pod Starym Miłorzębem powstał w Zielonej Górze w 1999 roku. Od ponad 15 lat dostarczamy najwyższej jakości herbaty.
	 Przez lata pracy ciągle zmieniamy się wsłuchując w głosy Klientów. Początkowo zajmowaliśmy się wyłącznie herbatą, głównie sypką, sprzedawaną na wagę.
	  Z czasem uczyliśmy się, zdobywaliśmy wiedzę i doświadczenie, którym chętnie się dzielimy czym zyskaliśmy uznanie wielu Klientów prywatnych jak i instytucjonalnych. 
	  Z biegiem lat wymagania i oczekiwania względem nas były coraz wyższe....
	   Dzisiaj nasz sklep to blisko 300 różnych herbat z zakątków całego świata, z Azji, Afryki, Ameryki, z wielu egzotycznych miejsc, których klimat można poczuć delektując się
	    smakiem wyselekcjonowanych najwyższej jakości herbat</div>
	
	</div>

	<script>
	document.getElementById("logo").addEventListener("click", toM);

	function toM() {
	window.location.href="index.jsp";
	}
	
	
	function myFunction1() {
		document.getElementById("mDropd1").classList.toggle("show1");
			}

		
			
			document.getElementsByClassName(".drop1").addEventListener("click", xx1);
			function xx1(){
			
				var dropdowns = document.getElementsByClassName("dropd-cont1");
				var i;
				for (i = 0; i < dropdowns.length; i++) {
				var openDropdown = dropdowns[i];
				if (openDropdown.classList.contains('show1')) {
					openDropdown.classList.remove('show1');
						}
					}
			}
	</script>
</body>

</html>

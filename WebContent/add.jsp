<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Dodawanie</title>
  <link rel="stylesheet" href="dodawanie.css">
</head>
<body>
<%
		String user=(String)session.getAttribute("usname");
if(user==null){
	response.sendRedirect("index.jsp");
}
	%>

<div id="topbar"><div id="logo">Pod Starym<br>Miłorzębem</div>
	<div id="wyszukaj"><form method="get" action="wyszukiwanie.jsp"><input name="search" type="text" id="te" placeholder="Czego szukasz?"><button name="bt1" class="bt" >&#x2315;</button>	

	</form></div>
	<div id="user">
	
		<%
		
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
  <div id="pod">Dodawanie Produktu</div>
<form method="POST" action="upload" enctype="multipart/form-data" >
	<input type="text" name="nazwa" placeholder="Nazwa produktu:" required/>
	<input type="text" name="opis" placeholder="Opis produktu:" required/>
	<%@ page import="java.io.*,java.sql.Connection,java.sql.DriverManager,javax.servlet.*,java.sql.*,java.io.IOException" %>
	Kategoria:
	<select name="kat" required>
	<option value="">Wybierz kategorie</option>
	<%
	String url = "jdbc:postgresql://localhost:5432/shop";
    String us = "postgres";
    String password = "admin";
    Connection conn = null;
	String a1,a2;
	
	try{
		
		conn = DriverManager.getConnection(url, us, password);
	}catch(Exception exp){
		System.out.println("err");
		}

        if (conn != null) {
        	String SQL = "SELECT * FROM categories";
    		try{
    	            Statement stmt = conn.createStatement();
    	            ResultSet rs = stmt.executeQuery(SQL); 
    	            while (rs.next()) {
    	            	a2=rs.getString("name");
    	            	a1=rs.getString("category_id");
    	            	%>
    	            	<option value="<%= a1 %>"> <%= a2 %> </option>
    	           <% 
    	            }
    		}catch(Exception exp){
    			System.out.println("g1");
    			}
        } %>
    	</select><br/>
	<label for="ilosc">Ilość produktu (0-1000):</label>
	<input type="number" id="ilosc" name="ilosc" min="0" max="1000" required><br/>
       <label for="cena">Cena produktu:</label>
	<input type="number" id="cena" name="cena" required><br/>
            Zdjęcia:
            <input type="file" name="file0" id="file" accept=".png,.jpg" required/>
            <div id="f"></div>
        <div id="d">Dodaj kolejne zdjęcie</div>
            <input type="submit" value="Dodaj Produkt" name="upload" id="upload" required/>
        </form>
	</div>
  <script>
  let i=1;
	document.getElementById("logo").addEventListener("click", toM);

	function toM() {
	window.location.href="index.jsp";
	}
	
	document.getElementById("d").addEventListener("click", add);

	function add() {
		document.getElementById("f").innerHTML+='<input type="file" name="file'+i+'" id="file" required/>';
		i+=1;
	}
	</script>
</body>
</html>
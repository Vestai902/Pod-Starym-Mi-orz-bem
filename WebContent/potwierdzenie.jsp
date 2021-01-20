<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ page import="java.util.ArrayList,java.io.IOException,javax.imageio.ImageIO,java.sql.*,java.io.*,java.sql.Connection,java.sql.DriverManager"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Pod Starym Miłorzębem</title>
  <link rel="stylesheet" href="koszyk.css">
</head>
<body>

	<div id="topbar"><div id="logo">Pod Starym<br>Miłorzębem</div>
	<div id="wyszukaj"><form method="get" action="wyszukiwanie.jsp"><input name="search" type="text" id="te" placeholder="Czego szukasz?"><button name="bt1" class="bt" >&#x2315;</button>	

	</form></div>
	<div id="user">
	
		<%
		Integer rank=(Integer)session.getAttribute("rank");
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
		<%}
		if((String)session.getAttribute("fName")==null){response.sendRedirect("index.jsp");return;}
		
		%>
		
		
	</div></div>
	<div id="cont">
	<h1>Dane do dostawy:</h1>
	<h4>Imię: <%=(String)session.getAttribute("fName")%> Nazwisko: <%=(String)session.getAttribute("lName")%> Miejscowość: <%=(String)session.getAttribute("street")%> <%=(String)session.getAttribute("zip")%> <%=(String)session.getAttribute("city")%></h4>

	
	<h1>Podsumowanie</h1>

<div class="shopping-cart">

  <div class="col-lab">
    <div class="product-title1">Produkt</div>
    <div class="product-price">Cena</div>
    <div class="product-quantity">Ilość</div>
    <div class="product-line-price">Suma</div>
  </div>



 
<div class="product">
      <div class="product-title"><%=(String)session.getAttribute("p_name")%></div>
    <div class="product-price"><%=(String)session.getAttribute("price")%>zł</div>
    <div class="product-quantity">

    <%=(String)session.getAttribute("quantity")%>szt.

    </div>
    
    <div class="product-line-price"><%=Integer.parseInt((String)session.getAttribute("price"))*Integer.parseInt((String)session.getAttribute("quantity"))%>zł</div>
  </div>
  
 	 	<div class="deliv">
 	<h2>Wybrana opcja dostawy:</h2>
 		<%
 		
 		String url = "jdbc:postgresql://localhost:5432/shop";
 	    String userr = "postgres";
 	    String password = "admin";
 	    Connection conn = null;    		
 	    try{	
 			conn = DriverManager.getConnection(url, userr, password);
 		}catch(Exception exp){
 			System.out.println("err");
 			response.sendRedirect("index.jsp");
 			}
String delivery_id = request.getParameter("slct"); 
if(delivery_id==null){response.sendRedirect("index.jsp");return;}
    int id=0;
    String name="";
    int price=0;
    int total=Integer.parseInt((String)session.getAttribute("price"))*Integer.parseInt((String)session.getAttribute("quantity"));

    	String SQL = "SELECT * FROM delivery WHERE delivery_id="+delivery_id;
	
		try{
			
		
	            Statement stmt = conn.createStatement();
	            ResultSet rs = stmt.executeQuery(SQL); 
	          
	            while (rs.next()) {
	            	id=rs.getInt("delivery_id");
	            	name=rs.getString("name");
	            	price=rs.getInt("price");
	            	
	            	if(total>60){
	            	%>
	            	  
	            	  <h3><%=name%> - 0zł (darmowa dostawa)</h3>
	            	<% 
	            	}else{
	            	total+=price;
	            	%>
	            		<h3><%=name%> - <%=price%>zł</h3>
	            	<%}
	            	
	            	
	            	
	            	
					}
	            
	        
	            
	            
				}catch(Exception e){
		System.out.println(e);
	}

    
    session.setAttribute("total",total);
    session.setAttribute("delivery",delivery_id);
     %>
     
	</div>
      <div class="total-pr">
      <h2>Cena końcowa zamówienia:</br><%=total%>zł</h2>
      <form action="ord" method="post">
      <button type="submit" class="checkout">Zapłać</button>
      </form>
      </div>

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
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.ArrayList,java.io.IOException,javax.imageio.ImageIO,java.sql.*,java.io.*,java.sql.Connection,java.sql.DriverManager"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Pod Starym Miłorzębem</title>
  <link rel="stylesheet" href="itemmgmt.css">
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
	<div id="cont">
	<div class="menu">
	<form action="itemmgmt.jsp" method="get">
	<h1>Pokaż wszystkie:</h1>
	<button type="submit" name="t" value="1" class="btt">Pokaż</button>
	<h1>Aktywne Produkty:</h1>
	<button type="submit" name="t" value="2" class="btt">Pokaż</button>
	<h1>Usunięte Produkty:</h1>
	<button type="submit" name="t" value="3" class="btt">Pokaż</button>
	<h1>Szukaj po nazwie:</h1>
	<input class="sro" name="s_name" placeholder="Podaj nazwę produktu" type="text"/><button type="submit" name="t" value="4" class="btt">Szukaj</button>
	</form>
	</div>
	<div class="case">
	<% 
	String SQL="";
	String tt="";
	String type=request.getParameter("t");
	String sname=request.getParameter("s_name");
	if(type==null||type.equals("1")){
		tt="Wszystkie produkty:";
		SQL="SELECT * FROM products";
	}else if(type.equals("2")){
		tt="Aktywne:";
		SQL="SELECT * FROM products WHERE show=true";
	}else if(type.equals("3")){
		tt="Usnięte:";
		SQL="SELECT * FROM products WHERE show=false";
	}else if(type.equals("4")){
		tt="Po nazwie:";
		SQL="SELECT * FROM products WHERE product_name LIKE '%"+sname+"%'";
	}
	%>
	<h1 style="color:white;"><%=tt%></h1>
	<div class="pr">
	<div class="p_name"><b>Nazwa produktu</b></div>
	<div class="il_p"><b>Ilość na magazynie</b></div>
	
	<div class="dod_il">
	<b>Dodawanie ilości produktu</b>
	</div>
      
      <div class="del">
     <b>Usuń/Przywróć produkt</b>
      </div>
	</div>
	
		<%
	String url = "jdbc:postgresql://localhost:5432/shop";
    String userr = "postgres";
    String password = "admin";
    Connection conn = null;
    int id=0;
    String name="";
    int qtn=0;
    boolean stat;	
    try{	
		conn = DriverManager.getConnection(url, userr, password);
	}catch(Exception exp){
		System.out.println("err");
		response.sendRedirect("index.jsp");
		}
    if (conn != null) {
    	
	
		try{
			
		
	            Statement stmt = conn.createStatement();
	            ResultSet rs = stmt.executeQuery(SQL); 
	            while (rs.next()) {
	            	id=rs.getInt("product_id");
	            	name=rs.getString("product_name");
	            	qtn=rs.getInt("quantity");
	            	stat=rs.getBoolean("show");
	            	%>
   <div class="pr">
	<div class="p_name"><%=name%></div>
	<div class="il_p"><%=qtn%>szt.</div>
	
	<div class="dod_il">
	<form method="post" action="addQt">
      <input name="qtn" type="number" value="1" min="1" max="10000">
      <button name="zm" value="<%=id%>" class="btt1">
        Dodaj
      </button>
      </form></div>
      
      <div class="del">
      <form method="post" action="state">
      <%if(stat==true){%>
      <button name="dlt" value="<%=id%>" class="btt2">
        Usuń
      </button>
      <%}else if(stat==false){ %>
      <button name="act" value="<%=id%>" class="btt3">
        Przywróć
      </button>
      <%} %>
      </form>
      </div>
	</div>
	            	<% 
	            	
					}
	            
	        
	            
	            
				}catch(Exception e){
		System.out.println(e);
	}
	}else{
		response.sendRedirect("index.jsp");
	}

     %>
	

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

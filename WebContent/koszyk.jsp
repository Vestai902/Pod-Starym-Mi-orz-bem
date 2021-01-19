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
		String user=(String)session.getAttribute("usname");
		Integer userid=(Integer)session.getAttribute("userid");
		if(userid==null){
			response.sendRedirect("index.jsp");
			return;
		}
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
	<%ArrayList<String[]> cart1 = (ArrayList<String[]>)session.getAttribute("cart");
	
	if(cart1.size()==0){ %>
	
	<h1>Koszyk jest pusty</h1>
<%}else{%>
	<h1>Koszyk</h1>

<div class="shopping-cart">

  <div class="col-lab">
    <div class="product-title1">Produkt</div>
    <div class="product-price">Cena</div>
    <div class="product-quantity">Ilość</div>
    <div class="product-removal1">Usuń</div>
    <div class="product-line-price">Suma</div>
  </div>



 
 	<%
 	int sum=0;
 	int total=0;
 	
 	for(int i=0; i<cart1.size();i++){
 		String[] ct=cart1.get(i);
 		sum=Integer.parseInt(ct[2])*Integer.parseInt(ct[4]);
 		total+=sum;
 	%>
 	 <div class="product">
      <div class="product-title"><%=ct[1]%></div>
    <div class="product-price"><%=ct[2]%>zł</div>
    <div class="product-quantity">
    <form method="post" action="changeQt">
      <input name="qtn" type="number" value="<%=ct[4]%>" min="1" max="<%=ct[3]%>">
      <button name="zm" value="<%=i%>" class="change-quantility">
        Zmień
      </button>
      </form>
    </div>
    <div class="product-removal">
    <form method="post" action="removeItem">
      <button name="del" value="<%=i%>" class="remove-product">
        Remove
      </button>
      </form>
    </div>
    <div class="product-line-price"><%=sum%>zł</div>
  </div>
  
	<%
 	}
 	session.setAttribute("total",total);
 	%>
 <form action="podsumowanie.jsp" method="post">
 	 	<div class="deliv">
 	<h2>Wybierz opcje dostawe:</h2>

 	<div class="select">
  	<select name="slct" id="slct">
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
    	String SQL = "SELECT * FROM delivery";
	
		try{
			
		
	            Statement stmt = conn.createStatement();
	            ResultSet rs = stmt.executeQuery(SQL); 
	            while (rs.next()) {
	            	id=rs.getInt("delivery_id");
	            	name=rs.getString("name");
	            	price=rs.getInt("price");
	            	
	            	%>
	            	 <option value="<%=id%>"><%=name%> - <%=price%>zł</option>
	            	<% 
	            	
					}
	            
	        
	            
	            
				}catch(Exception e){
		System.out.println(e);
	}
	}else{
		response.sendRedirect("index.jsp");
	}

     %>
     
  	</select>
  	 	
	</div>
	(Przy zamówieniu powyżej 60zł dostawa jest darmowa)
	</div>
      <div class="total-pr">
      <h2>Cena końcowa produktów:</br><%=total%>zł</h2>
      
      <button type="submit" class="checkout">Przejdź dalej</button>
     
      </div>
 </form>
 <%} %>
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
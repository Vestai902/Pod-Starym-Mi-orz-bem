<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.ArrayList,java.io.IOException,javax.imageio.ImageIO,java.sql.*,java.io.*,java.sql.Connection,java.sql.DriverManager"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Pod Starym Miłorzębem</title>
  <link rel="stylesheet" href="historiaz.css">
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
	<div class="case">
	
	<h1 style="color:white;">Historia zamówień:</h1>
	
			<%
	String url = "jdbc:postgresql://localhost:5432/shop";
    String userr = "postgres";
    String password = "admin";
    Connection conn = null;
	int nr=0;
	String p_name="";
	int il=0;
	int cen=0;
	String deliv="";
	int tot=0;
	String state="";	
    String SQL="SELECT order_id FROM orders WHERE user_id="+session.getAttribute("userid");
	String SQL1="";
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
	            	
	               
	                nr=rs.getInt("order_id");
	              
	                
	                %>
<div class="pr">
<div class="nr_ord"><b>Numer zamówienia: <%=nr%></b></div>
	<div class="p_name">Nazwa produktu</div><div class="p_qt">Ilość</div><div class="p_pr">Cena szt.</div>
	            	<%
	            	SQL1="SELECT a.quantity,b.order_id, c.price, c.product_name, b.order_status,b.total_value, d.name FROM order_items AS a JOIN orders AS b ON a.order_id = b.order_id JOIN products AS c ON a.product_id = c.product_id JOIN delivery AS d ON b.delivery_type=d.delivery_id WHERE b.order_id="+nr;
	            	ResultSet rs1 = stmt.executeQuery(SQL1); 
		            while (rs1.next()) {
		            	p_name=rs1.getString("product_name");
		            	il=rs1.getInt("quantity");
		            	cen=rs1.getInt("price");
		            	deliv=rs1.getString("name");
		            	tot=rs1.getInt("total_value");
		            	state=rs1.getString("order_status");
		            
	            	%>

	<div class="p_name"><%=p_name%></div><div class="p_qt"><%=il%></div><div class="p_pr"><%=cen%>zł</div>

	
	
	
<% 
		            }
		            
		            
		            %>
<div class="deli">Dostawa: <%=deliv%></div><div class="tot">Wartość zamówienia: <%=tot%>zł</div>
	<div class="status">Stan zamówienia: <%=state%></div>
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

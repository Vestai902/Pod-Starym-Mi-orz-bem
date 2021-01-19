<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.ArrayList,java.io.IOException,javax.imageio.ImageIO,java.sql.*,java.io.*,java.sql.Connection,java.sql.DriverManager"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Pod Starym Miłorzębem</title>
  <link rel="stylesheet" href="zamowieniazr.css">
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
		<%} 
		
		String url = "jdbc:postgresql://localhost:5432/shop";
	    String userr = "postgres";
	    String password = "admin";
	    Connection conn = null;
		String tt="";
		String stt="";
		String type=request.getParameter("t");
		String nrm=request.getParameter("nr");
		String SQL="";
		String SQL1="";
		
		 try{	
				conn = DriverManager.getConnection(url, userr, password);
			}catch(Exception exp){
				System.out.println("err");
				response.sendRedirect("index.jsp");
				}
		
		if(type==null||type.equals("1")){
			tt="Zamówienia do realizacji:";
			SQL="SELECT a.ord_id, a.email, a.f_name, a.l_name, a.city, a.street, a.zip_code, a.phone_number, c.name, b.product_name, b.price, a.order_date, c.name, a.total_value, a.quantity, a.order_status FROM unregisteredorders AS a JOIN products AS b ON a.product_id = b.product_id JOIN delivery AS c ON a.delivery_type = c.delivery_id WHERE a.order_status='W trakcie realizacji'";

		}else if(type.equals("2")){
			tt="Anulowane zamówienia:";
			SQL="SELECT a.ord_id, a.email, a.f_name, a.l_name, a.city, a.street, a.zip_code, a.phone_number, c.name, b.product_name, b.price, a.order_date, c.name, a.total_value, a.quantity, a.order_status FROM unregisteredorders AS a JOIN products AS b ON a.product_id = b.product_id JOIN delivery AS c ON a.delivery_type = c.delivery_id WHERE a.order_status='Anulowano'";

		}else if(type.equals("3")){
			tt="Zrealizowanie zamówienia:";
			SQL="SELECT a.ord_id, a.email, a.f_name, a.l_name, a.city, a.street, a.zip_code, a.phone_number, c.name, b.product_name, b.price, a.order_date, c.name, a.total_value, a.quantity, a.order_status FROM unregisteredorders AS a JOIN products AS b ON a.product_id = b.product_id JOIN delivery AS c ON a.delivery_type = c.delivery_id WHERE a.order_status='Zrealizowano'";
		}else if(type.equals("4")){
			tt="Zareklamowane zamówienia:";
			SQL="SELECT a.ord_id, a.email, a.f_name, a.l_name, a.city, a.street, a.zip_code, a.phone_number, c.name, b.product_name, b.price, a.order_date, c.name, a.total_value, a.quantity, a.order_status FROM unregisteredorders AS a JOIN products AS b ON a.product_id = b.product_id JOIN delivery AS c ON a.delivery_type = c.delivery_id WHERE a.order_status='Reklamacja'";
		}
		else if(type.equals("5")){
			tt="Wyszukane zamówienia:";
			SQL="SELECT a.ord_id, a.email, a.f_name, a.l_name, a.city, a.street, a.zip_code, a.phone_number, c.name, b.product_name, b.price, a.order_date, c.name, a.total_value, a.quantity, a.order_status FROM unregisteredorders AS a JOIN products AS b ON a.product_id = b.product_id JOIN delivery AS c ON a.delivery_type = c.delivery_id WHERE a.phone_number="+nrm;
		}
		
		
		
	
		
		%>
		
		
	</div></div>
	<div id="cont">
	<div class="menu">
	<form action="zamowienianzr.jsp" method="get">
	<h1>Zamówienia do realizacji</h1>
	<button type="submit" name="t" value="1" class="btt">Pokaż</button>
	
	<h1>Anulowane zamówienia:</h1>
	<button type="submit" name="t" value="2" class="btt">Pokaż</button>
	
	<h1>Zrealizowane zamówienia:</h1>
	<button type="submit" name="t" value="3" class="btt">Pokaż</button>
	
	<h1>Zareklamowane zamówienia:</h1>
	<button type="submit" name="t" value="4" class="btt">Pokaż</button>
	
	<h1>Szukaj po numerze telefonu:</h1>
	<input class="sro" name="nr" placeholder="Podaj nr telefonu" type="number"/><button type="submit" name="t" value="5" class="btt">Szukaj</button>
	
	</form>
	
	
	</div>

	<div class="case">
	<h1 style="color:white;">Zamówienia użytkowników niezarejestrowanych</h1>
	
	<h1 style="color:white;"><%=tt%></h1>
	
			<%

	int nr=0;
	String p_name="";
	int il=0;
	int cen=0;
	String deliv="";
	int tot=0;
	String state="";	

	
	String email=""; 
	String f_name="";
	String l_name="";
	String city="";
	String street="";
	String zip_code="";
	int phone_number=0;
	int ord_id=0;
	
   
    if (conn != null) {
    	
	
		try{
			
		
	            Statement stmt = conn.createStatement();
	            ResultSet rs = stmt.executeQuery(SQL); 
	            while (rs.next()) {
	            	
	               
	                nr=rs.getInt("ord_id");
	            	p_name=rs.getString("product_name");
	            	il=rs.getInt("quantity");
	            	cen=rs.getInt("price");
	            	deliv=rs.getString("name");
	            	tot=rs.getInt("total_value");
	            	state=rs.getString("order_status");
	            	email=rs.getString("email");
	            	f_name=rs.getString("f_name");
	            	l_name=rs.getString("l_name");
	            	city=rs.getString("city");
	            	street=rs.getString("street");
	            	zip_code=rs.getString("zip_code");
	            	phone_number=rs.getInt("phone_number");
	                
	                %>
<div class="pr">
<div class="nr_ord"><b>Numer zamówienia: <%=nr%></b></div>
	<div class="p_name">Nazwa produktu</div><div class="p_qt">Ilość</div><div class="p_pr">Cena szt.</div>
	           			
	<div class="p_name"><%=p_name%></div><div class="p_qt"><%=il%></div><div class="p_pr"><%=cen%>zł</div>
	        
	      
<div class="deli">Dostawa: <%=deliv%></div><div class="tot">Wartość zamówienia: <%=tot%>zł</div>
	<div class="data">
<h3>Dane kontaktowe:</h3>
<b>Imię: </b><%=f_name%> &nbsp;&nbsp;&nbsp;
<b>Nazwisko: </b><%=l_name%>  &nbsp;&nbsp;&nbsp;
<b>Ulica z numerem domu: </b><%=street%>  &nbsp;&nbsp;&nbsp;
<b>Miasto: </b><%=city%>  &nbsp;&nbsp;&nbsp;
<b>Kod pocztowy: </b><%=zip_code%>  &nbsp;&nbsp;&nbsp;
<b>Numer telefonu: </b><%=phone_number%>  &nbsp;&nbsp;&nbsp;
<b>Email: </b><%=email%></div>	
	
	<div class="status">Stan zamówienia: <%=state%></div>
	<form action="updUR" method="post">
	<div class="set">Zmień stan zamówienia:
	<select name="slct" id="slct"> 
	<option value="Zrealizowano">Zrealizowano</option>
	<option value="Anulowano">Anulowano</option>
	<option value="Reklamacja">Reklamacja</option>	
	</select>
	<button value="<%=nr%>" name="ord_id" type="submit">Aktualizuj</button>
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

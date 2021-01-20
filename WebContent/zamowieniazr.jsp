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
		Integer rank=(Integer)session.getAttribute("rank");
		String user=(String)session.getAttribute("usname");
		if(rank==null||rank==2){response.sendRedirect("index.jsp");}
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
		
		String url = "jdbc:postgresql://localhost:5432/shop";
	    String userr = "postgres";
	    String password = "admin";
	    Connection conn = null;
		String tt="";
		String stt="";
		String type=request.getParameter("t");
		String uname=request.getParameter("u_name");
		String nrz=request.getParameter("o_name");
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
			SQL="SELECT order_id FROM orders WHERE order_status='W trakcie realizacji'";

		}else if(type.equals("2")){
			tt="Anulowane zamówienia:";
			SQL="SELECT order_id FROM orders WHERE order_status='Anulowano'";
		}else if(type.equals("3")){
			tt="Zrealizowanie zamówienia:";
			SQL="SELECT order_id FROM orders WHERE order_status='Zrealizowano'";
		}else if(type.equals("4")){
			tt="Zareklamowane zamówienia:";
			SQL="SELECT order_id FROM orders WHERE order_status='Reklamacja'";
		}else if(type.equals("5")){
			tt="Zamówienia użytkownika "+uname+":";
			Statement ST = conn.createStatement();
            ResultSet se= ST.executeQuery("SELECT user_id FROM accounts WHERE username='"+uname+"'");
            int uid=0;
            while (se.next()) {
            	uid=se.getInt("user_id");
            }
            SQL="SELECT order_id FROM orders WHERE user_id="+uid;
		}else if(type.equals("6")){
			tt="Zamówienie o numerze "+nrz+":";
			SQL="SELECT order_id FROM orders WHERE order_id="+nrz;
		}
		
		
		
		
	
		
		%>
		
		
	</div></div>
	<div id="cont">
	<div class="menu">
	<form action="zamowieniazr.jsp" method="get">
	
	<h1>Zamówienia do realizacji:</h1>
	<button type="submit" name="t" value="1" class="btt">Pokaż</button>
	
	<h1>Anulowane zamówienia:</h1>
	<button type="submit" name="t" value="2" class="btt">Pokaż</button>
	
	<h1>Zrealizowane zamówienia:</h1>
	<button type="submit" name="t" value="3" class="btt">Pokaż</button>
	
	<h1>Zareklamowane zamówienia:</h1>
	<button type="submit" name="t" value="4" class="btt">Pokaż</button>
	
	<h1>Szukaj po nazwie użytkownika:</h1>
	<input class="sro" name="u_name" placeholder="Podaj nazwę użytkownika" type="text"/><button type="submit" name="t" value="5" class="btt">Szukaj</button>
	
	<h1>Szukaj po id oferty:</h1>
	<input class="sro" name="o_name" placeholder="Podaj id zamówienia" type="text"/><button type="submit" name="t" value="6" class="btt">Szukaj</button>
	</form>
	
	
	</div>

	<div class="case">
		<h1 style="color:white;">Zamówienia użytkowników zarejestrowanych</h1>
	<h1 style="color:white;"><%=tt%></h1>
	
			<%

	int nr=0;
	String p_name="";
	int il=0;
	int cen=0;
	String deliv="";
	int tot=0;
	String state="";	

	String username="";
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
	            	
	               
	                nr=rs.getInt("order_id");
	              
	                
	                %>
<div class="pr">
<div class="nr_ord"><b>Numer zamówienia: <%=nr%></b></div>
	<div class="p_name">Nazwa produktu</div><div class="p_qt">Ilość</div><div class="p_pr">Cena szt.</div>
	            	<%


					SQL1="SELECT a.quantity,b.order_id, c.price, c.product_name, b.order_status,b.total_value, d.name, e.username, e.email, e.f_name, e.l_name, e.city, e.street, e.zip_code, e.phone_number FROM order_items AS a JOIN orders AS b ON a.order_id = b.order_id JOIN products AS c ON a.product_id = c.product_id JOIN delivery AS d ON b.delivery_type=d.delivery_id JOIN accounts AS e ON b.user_id=e.user_id WHERE b.order_id="+nr;	
	            	ResultSet rs1 = stmt.executeQuery(SQL1); 
		            while (rs1.next()) {
		            	p_name=rs1.getString("product_name");
		            	il=rs1.getInt("quantity");
		            	cen=rs1.getInt("price");
		            	deliv=rs1.getString("name");
		            	tot=rs1.getInt("total_value");
		            	state=rs1.getString("order_status");
		            	username=rs1.getString("username");
		            	email=rs1.getString("email");
		            	f_name=rs1.getString("f_name");
		            	l_name=rs1.getString("l_name");
		            	city=rs1.getString("city");
		            	street=rs1.getString("street");
		            	zip_code=rs1.getString("zip_code");
		            	phone_number=rs1.getInt("phone_number");
		            	ord_id=rs1.getInt("order_id");
		            
	            	%>
	<div class="p_name"><%=p_name%></div><div class="p_qt"><%=il%></div><div class="p_pr"><%=cen%>zł</div>

	
	
	
<% 
		            }
		            
		            
		            %>
	      
<div class="deli">Dostawa: <%=deliv%></div><div class="tot">Wartość zamówienia: <%=tot%>zł</div>
	<div class="data">
<h3>Dane kontaktowe użytkownika <%=username%>:</h3>
<b>Imię: </b><%=f_name%> &nbsp;&nbsp;&nbsp;
<b>Nazwisko: </b><%=l_name%>  &nbsp;&nbsp;&nbsp;
<b>Ulica z numerem domu: </b><%=street%>  &nbsp;&nbsp;&nbsp;
<b>Miasto: </b><%=city%>  &nbsp;&nbsp;&nbsp;
<b>Kod pocztowy: </b><%=zip_code%>  &nbsp;&nbsp;&nbsp;
<b>Numer telefonu: </b><%=phone_number%>  &nbsp;&nbsp;&nbsp;
<b>Email: </b><%=email%></div>	
	
	<div class="status">Stan zamówienia: <%=state%></div>
	<form action="upd" method="post">
	<div class="set">Zmień stan zamówienia:
	<select name="slct" id="slct"> 
	<option value="Zrealizowano">Zrealizowano</option>
	<option value="Anulowano">Anulowano</option>
	<option value="Reklamacja">Reklamacja</option>	
	</select>
	<button value="<%=ord_id%>" name="ord_id" type="submit">Aktualizuj</button>
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

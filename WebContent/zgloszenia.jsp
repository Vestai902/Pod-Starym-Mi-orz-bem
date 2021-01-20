<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.ArrayList,java.io.IOException,javax.imageio.ImageIO,java.sql.*,java.io.*,java.sql.Connection,java.sql.DriverManager"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Pod Starym Miłorzębem</title>
  <link rel="stylesheet" href="zgloszenia.css">
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
		<%} %>
		
		
	</div></div>
	<div id="cont">
	<div class="menu">
	<form action="zgloszenia.jsp" method="get">
	<h1>Pokaż zgłoszenia:</h1>
	<button type="submit" name="t" value="1" class="btt">Pokaż</button>
	</form>
	<form action="usunietecom.jsp">
	<h1>Pokaż usunięte komentarze:</h1>
	<button type="submit" name="t" class="btt">Pokaż</button>
	</form>
	
	</div>
	<div class="case">
	<% 
	String SQL="";
	String SQL1="";
	String tt="";
	String type=request.getParameter("t");
	String sname=request.getParameter("s_name");
	if(type==null||type.equals("1")){
		tt="Zgłoszone komentarze:";
		SQL="SELECT b.username, c.user_id, c.review_id, c.description FROM report AS a JOIN accounts AS b ON a.rep_user = b.user_id JOIN reviews AS c ON a.rep_rev = c.review_id";
		SQL1="SELECT username FROM accounts WHERE user_id=";
	}
	%>
	<h1 style="color:white;"><%=tt%></h1>
	
			<%
	String url = "jdbc:postgresql://localhost:5432/shop";
    String userr = "postgres";
    String password = "admin";
    Connection conn = null;
    String zg_user="";
    String zgl_user="";
    int zgl_userid=0;
    int rev_id=0;
    String dscr="";	
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
	            	
	                zg_user=rs.getString("username");
	                
	                zgl_userid=rs.getInt("user_id");
	                rev_id=rs.getInt("review_id");
	                dscr=rs.getString("description");
	                
	                SQL1="SELECT username FROM accounts WHERE user_id="+zgl_userid;
	            	ResultSet rs1 = stmt.executeQuery(SQL1); 
		            while (rs1.next()) {
		            	zgl_user=rs1.getString("username"); 
		            }
	            	
	            	
	            	
	            	%>
	<div class="pr">
	<div class="z_name"><b>Zgłaszający: <%=zg_user%></b></div>
	<div class="a_name"><b>Autor komentarza: <%=zgl_user%></b></div>
	
	<div class="rev_content">
	<h5>Treść komentarza:</h5>
	<%=dscr %>
	</div>
      
    
      <div class="lf">
      <form action="com" method="post">
     <b>Zostaw komentarz:</b>  <button name="b1" class="btt1" value="<%=rev_id%>">Zostaw</button>
      </div>
      <div class="dl">
     <b>Usuń komentarz:</b>  <button name="b2" class="btt2" value="<%=rev_id%>">Usuń</button>
      </div>
      </form>
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

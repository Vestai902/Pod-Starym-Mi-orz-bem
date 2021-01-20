<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.awt.image.BufferedImage,java.io.File,java.io.FilenameFilter,java.io.IOException,javax.imageio.ImageIO,java.sql.*,java.io.*,java.sql.Connection,java.sql.DriverManager" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Pod Starym Miłorzębem</title>
  <link rel="stylesheet" href="sr.css">
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
		<%} %>
		
		
	</div></div>
	<div id="cont">
	<div class="sort">
	Sortuj:
	<select id="url" onchange="urlHandler(this.value)">
	<option selected disabled>Sortuj wg.</option>
	<%if(request.getParameter("search")!=null){%>
	<option value="wyszukiwanie.jsp?search=<%=request.getParameter("search")%>&bt1=&or=1">Po cenie rosnąco</option>
	<option value="wyszukiwanie.jsp?search=<%=request.getParameter("search")%>&bt1=&or=0">Po cenie malejąco</option>
	<%}else{%>
	<option value="wyszukiwanie.jsp?kat=<%=request.getParameter("kat")%>&bt1=&or=1">Po cenie rosnąco</option>
	<option value="wyszukiwanie.jsp?kat=<%=request.getParameter("kat")%>&bt1=&or=0">Po cenie malejąco</option>
	<%}%>
	</select>
	
	</div>
	<%
	String url = "jdbc:postgresql://localhost:5432/shop";
    String userr = "postgres";
    String password = "admin";
    Connection conn = null;
    String search = request.getParameter("search");
    String or = request.getParameter("or");
    String kat = request.getParameter("kat");
    String pictures="";
	String pName="";
	String price="";
	String description="";
	String p_id="";
	int rt=0;
	int sum=0;
    if(search!=null||kat!=null){
    try{
		
		conn = DriverManager.getConnection(url, userr, password);
	}catch(Exception exp){
		System.out.println("err");
		response.sendRedirect("index.jsp");
		}
    if (conn != null) {
    	String SQL="";
    	
    	if(or!=null){
    		if(or.equals("1")){
    			if(kat!=null){
    				 SQL = "SELECT * FROM products WHERE category_id="+kat+" AND show='true' ORDER BY price ASC";
    			}else{
    				 SQL = "SELECT * FROM products WHERE product_name LIKE '%"+search+"%' AND show='true' ORDER BY price ASC";
    			}
    			
    		}else if(or.equals("0")){
    			if(kat!=null){
   				 	SQL = "SELECT * FROM products WHERE category_id="+kat+" AND show='true' ORDER BY price DESC";
   				}else{
   				 	SQL = "SELECT * FROM products WHERE product_name LIKE '%"+search+"%' AND show='true' ORDER BY price DESC";
   				}
    		}
    	}else{
    		if(kat!=null){
  				 SQL = "SELECT * FROM products WHERE category_id="+kat+" AND show='true'";
    		}else{
    			SQL = "SELECT * FROM products WHERE product_name LIKE '%"+search+"%' AND show='true'";
    		}
    	}
		int c=0;
		
	
		try{
			
		
	            Statement stmt = conn.createStatement();
	            ResultSet rs = stmt.executeQuery(SQL); 
	            while (rs.next()) {
	            	p_id=rs.getString("product_id");
	            	pictures=rs.getString("pictures");
	    			pName=rs.getString("product_name");
	    			price=rs.getString("price");
	    			description=rs.getString("description");
	    			String SQL1 = "SELECT CAST(SUM(rating) AS INTEGER)/CAST (count(rating) AS INTEGER) AS rev FROM reviews WHERE product_id="+p_id+"AND show='true'";
	 	            Statement st = conn.createStatement();
	 	            ResultSet r = stmt.executeQuery(SQL1); 
	 	            while (r.next()) {
	 	            sum=r.getInt("rev");
	 	            }
	
					if(!pictures.equals("")){
		
					 File aDirectory = new File(pictures);

   					 String[] filesInDir = aDirectory.list();
    				String[] parts = pictures.split("\\\\");
   					 for ( int i=0; i<1; i++ )
    				{
   						 %>
   						 <div class="item">
		<div class="pict"><img width="300px" height="250px" src="img\<%=parts[parts.length-1]%>\<%=filesInDir[i]%>" /></div>
		<div class="ds">
		<div class="title"><%=pName%></div>
		<div class="dscr"><%=description%></div>
		<div class="grd"><div style="float:left;padding-top:5px;">Ocena:</div> 
			<%
	            for(int q=0; q<sum;q++){
					%><div class ="f"></div><%
					}
					int d=5;
					d=d-sum;
					for(int q=0; q<d;q++){
					%><div class ="b"></div><%
					}
					%></div>
		<div class="prc">Cena: <%=price%> zł</div>
		<div class="btnn">
			<a class="mB" href="show.jsp?o=<%=p_id%>">Zobacz</a>
			
		</div>
		</div>
		</div>
   						 <% 
    				}
    				}}
				}catch(Exception e){
		System.out.println("god");
	}
	}else{
		response.sendRedirect("index.jsp");
	}}
    
     %>
     
	

	</div>


	<script>
	document.getElementById("logo").addEventListener("click", toM);

	function toM() {
	window.location.href="index.jsp";
	}
	
	function urlHandler(value) {     
		window.location.href=value;
	}
	</script>
</body>

</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.awt.image.BufferedImage,java.io.File,java.io.FilenameFilter,java.io.IOException,javax.imageio.ImageIO,java.sql.*,java.io.*,java.sql.Connection,java.sql.DriverManager" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <meta charset="UTF-8">
  <title>Pod Starym Miłorzębem</title>
  <link rel="stylesheet" href="show.css">
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

	<div id="showof">
	
	<div class="slider">
	<div class="w3-content w3-display-container">
		<%
	String url = "jdbc:postgresql://localhost:5432/shop";
    String userr = "postgres";
    String password = "admin";
    Connection conn = null;
    String s = request.getParameter("o");
    String pictures="";
	String pName="";
	String price="";
	String description="";
	String quant="";
	int sum=0;
    if(s!=null){
    try{
		
		conn = DriverManager.getConnection(url, userr, password);
	}catch(Exception exp){
		System.out.println("err");
		response.sendRedirect("index.jsp");
		}
    if (conn != null) {
    	String SQL = "SELECT * FROM products WHERE product_id="+s+" AND show='true'";
    	
		int c=0;
		
	
		try{
			
		
	            Statement stmt = conn.createStatement();
	            ResultSet rs = stmt.executeQuery(SQL); 
	            while (rs.next()) {
	            	pictures=rs.getString("pictures");
	    			pName=rs.getString("product_name");
	    			price=rs.getString("price");
	    			description=rs.getString("description");
	    			quant=rs.getString("quantity");
	
					if(!pictures.equals("")){
		
					 File aDirectory = new File(pictures);

   					 String[] filesInDir = aDirectory.list();
    				String[] parts = pictures.split("\\\\");
   					 for ( int i=0; i<filesInDir.length; i++ )
    				{
   						 %>
   				<img height="300" class="mySlides" src="img\<%=parts[parts.length-1]%>\<%=filesInDir[i]%>" style="width:100%">
   						 <% 
    				}
    				}}
	            
	            String SQL1 = "SELECT CAST(SUM(rating) AS INTEGER)/CAST (count(rating) AS INTEGER) AS rev FROM reviews WHERE product_id="+s+"AND show='true'";
	            Statement st = conn.createStatement();
	            ResultSet r = stmt.executeQuery(SQL1); 
	            while (r.next()) {
	            sum=r.getInt("rev");
	            }
	            
	            
				}catch(Exception e){
		System.out.println(e);
	}
	}else{
		response.sendRedirect("index.jsp");
	}}
    
     %>

	<button class="w3-button w3-black w3-display-left" onclick="plusDivs(-1)">&#10094;</button>
	<button class="w3-button w3-black w3-display-right" onclick="plusDivs(1)">&#10095;</button>
	</div>

    </div>
	<div class="right">
	<div class="title"><%=pName%></div>
	
	
	<div class="price">Cena: <%=price%>zł</div>
	Ocena: 
	<%
	            for(int i=0; i<sum;i++){
					%><div class="f"></div><%
					}
					int d=5;
					d=d-sum;
					for(int i=0; i<d;i++){
					%><div class="b"></div><%
					}
					
Integer id=(Integer)session.getAttribute("userid");
if(Integer.parseInt(quant)<=0){%>
	<form method="post" action="addItem">
	 <div class="qt">
		Liczba sztuk:
		<div class="quantity"><input name="quantity" type="number" min="1" max="<%=quant%>" value="1"></div> &nbsp z <%=quant%> sztuk	
		</div> 
		<button name="addToCart" class="buy" style="Background-color:grey;" >Brak na magazynie</button>
	</form>	
<%}else{
if(id!=null){ %>
<form method="post" action="addItem">
 <div class="qt">
	Liczba sztuk:
	<div class="quantity"><input name="quantity" type="number" min="1" max="<%=quant%>" value="1"></div> &nbsp z <%=quant%> sztuk	
	</div> 
	<button type="submit" name="addToCart" class="buy" value="<%=s%>">Dodaj do koszyka</button>
</form>
<%}else{ %>
<form method="post" action="item">
 <div class="qt">
	Liczba sztuk:
	<div class="quantity"><input name="quantity" type="number" min="1" max="<%=quant%>" value="1"></div> &nbsp z <%=quant%> sztuk	
	</div> 
	<button type="submit" name="addToCart" class="buy" value="<%=s%>">Kup Teraz</button>
</form>
<%}} %>
	</div>
	</div>
	<div class="description"  style="padding-left:20px;padding-bottom:20px;padding-right:20px;">
	<h1>Opis:</h1>
	<%=description%>
	</div>
	<div class="description"  style="padding-left:20px;padding-bottom:20px;padding-right:20px;">
	<h1>Komentarze:</h1>
	
	<%if(user!=null){ %>
	<div id="add_com">
	<form method="post" action="addCom"><h2>Dodaj komentarz:</h2>
	<h4>Ocena:
	<fieldset class="rating">
    <input type="radio" id="star5" name="rating" value="5" /><label class = "full" for="star5" title="5"></label>
    <input type="radio" id="star4" name="rating" value="4" /><label class = "full" for="star4" title="4"></label>
    <input type="radio" id="star3" name="rating" value="3" /><label class = "full" for="star3" title="3"></label>
    <input type="radio" id="star2" name="rating" value="2" /><label class = "full" for="star2" title="2"></label>
    <input type="radio" id="star1" name="rating" value="1" /><label class = "full" for="star1" title="1"></label>
</fieldset>
</h4>
	<h4>Treść:</h4>
	<textarea id="tresc" rows="4" cols="50" name="tresc" required></textarea>
	<button class="dodaj" type="submit" class="btn" name="komentarz" value="<%=s%>">Dodaj</button>
	</form>
	</div>  
	<%} %>
	
	 
	<%if (conn != null) {
		String usrn="",desc="";
		int g=0;
		
    	String SQL = "SELECT accounts.username,products.product_name,reviews.review_id,reviews.description,reviews.rating from reviews reviews INNER JOIN accounts ON reviews.user_id=accounts.user_id INNER JOIN products ON reviews.product_id=products.product_id WHERE products.product_id="+s+" AND reviews.show='true'";
		try{
	            Statement stmt = conn.createStatement();
	            ResultSet rs = stmt.executeQuery(SQL); 
	            while (rs.next()){
	            	usrn=rs.getString("username");
	    			desc=rs.getString("description");
	    			g=rs.getInt("rating");
	    			int rid=rs.getInt("review_id");
					%>
					
					<div class="com"><div class="t"><div class="usn"><%=usrn%></div><div class="rate">
					<%
					for(int i=0; i<g;i++){
					%><div class ="f"></div><%
					}
					int a=5;
					a=a-g;
					for(int i=0; i<a;i++){
					%><div class ="b"></div><%
					}
					%>
					<div class="us">
					
					<% 
			    	String SQL1 = "SELECT CAST(count(report_id) AS INTEGER) AS repi FROM report WHERE rep_rev="+rid+"";

					Statement stm = conn.createStatement();
	           		ResultSet rs1 = stmt.executeQuery(SQL1); 
	           		int to=-1;
	            	while (rs1.next()){
	            	to=rs1.getInt("repi");
	            	}
	            	
	            	if(to==0&&session.getAttribute("userid")!=null){
	            	%>
					
					<form action="report" method="post">
					<input type="hidden" name="field" value="<%=s%>"/>
					<button name="rep" value="<%=rid%>" class="btt">Zgłoś</button></form>
					<%}
	            	%>
					
					
					</div></div>
					<div class="ct"><%=desc%></div>
					</div>
						</div>
					<%
   					
    				
    				}
				}catch(Exception e){
		System.out.println(e);
	}}
	%>
	

	</div>
	
		<script>
		var slideIndex = 1;
		showDivs(slideIndex);

		function plusDivs(n) {
		showDivs(slideIndex += n);
		}

		function showDivs(n) {
		let i;
		let x = document.getElementsByClassName("mySlides");
		if (n > x.length) {slideIndex = 1}
		if (n < 1) {slideIndex = x.length}
		for (i = 0; i < x.length; i++) {
		x[i].style.display = "none";  
		}
		x[slideIndex-1].style.display = "block";  
		}
		
		
		
		jQuery('<div class="quantity-nav"><div class="quantity-button quantity-up">+</div><div class="quantity-button quantity-down">-</div></div>').insertAfter('.quantity input');

		jQuery('.quantity').each(function () {

		    var spinner = jQuery(this),

		        input = spinner.find('input[type="number"]'),

		        btnUp = spinner.find('.quantity-up'),

		        btnDown = spinner.find('.quantity-down'),

		        min = input.attr('min'),

		        max = input.attr('max');

		    btnUp.click(function () {

		        var oldValue = parseFloat(input.val());

		        if (oldValue >= max) {

		            var newVal = oldValue;

		        } else {

		            var newVal = oldValue + 1;

		        }

		        spinner.find("input").val(newVal);

		        spinner.find("input").trigger("change");

		    });

		    btnDown.click(function () {

		        var oldValue = parseFloat(input.val());

		        if (oldValue <= min) {

		            var newVal = oldValue;

		        } else {

		            var newVal = oldValue - 1;

		        }

		        spinner.find("input").val(newVal);

		        spinner.find("input").trigger("change");

		    });

		});
		
		
		document.getElementById("logo").addEventListener("click", toM);

		function toM() {
		window.location.href="index.jsp";
		}
		
		</script>
</body>
</html>
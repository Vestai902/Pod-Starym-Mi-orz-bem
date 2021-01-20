<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ page import="java.util.ArrayList,java.io.IOException,javax.imageio.ImageIO,java.sql.*,java.io.*,java.sql.Connection,java.sql.DriverManager"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Pod Starym Miłorzębem</title>
  <link rel="stylesheet" href="gl.css">
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
	<div class="pnl">
	<div class="kat">
		<div class="dropd1">
		<div onclick="myFunction1()" class="drop1">
		Kategorie
		</div>
		<div id="mDropd1" class="dropd-cont1">
		
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
    	String SQL = "SELECT * FROM categories";
	
		try{
			
		
	            Statement stmt = conn.createStatement();
	            ResultSet rs = stmt.executeQuery(SQL); 
	            while (rs.next()) {
	            	id=rs.getInt("category_id");
	            	name=rs.getString("name");
	            	
	            	%>
		<a href="wyszukiwanie.jsp?kat=<%=id%>"><%=name%></a>
		
		<%}
	        	}catch(Exception e){
	        		System.out.println(e);
	        	}
	        	
				}else{
	        		response.sendRedirect("index.jsp");
				}
		
		%>
		
		</div>
		</div>
		</div>
		<a href="porady.jsp"><div class="porad">Porady do parzenia herbaty</div></a>
		<a href="kontakt.jsp"><div class="kontakt">Kontakt</div></a>
		
	</div>
		
		
		
	<div id="cont">
	
	<div  class="inf" style="margin-top:30px;"><h1>Porady:</h1><h2>Wybieraj najlepsze marki</h2>
Stosujcie Państwo tylko najlepsze marki herbaty. Ponieważ należy ona do stosunkowo niedrogich napojów, warto inwestować w wysokojakościowe mieszanki. Do kalkulacji należy przyjąć następujące dane: na 1 filiżankę przypada 2,0 do 2,5 g herbaty (wyjątek – owoce 5 g). Z opakowania o pojemności 250 g otrzyma się minimum 100 porcji.

Zakładając idealne warunki magazynowania herbaty, tzn. w suchych, szczelnych pojemnikach, które zapewniają ochronę produktu przed wilgocią i obcymi zapachami – można uznać, że termin przydatności do spożycia jest nieograniczony. Jednak herbaty aromatyzowane należy konsumować jak najszybciej, ze względu na fakt, że zawarte w nich delikatne olejki są bardzo ulotne.

<h2>Woda jest istotna</h2>
Świeżą, zimną wodę zagotować. Herbaty czarne, ziołowe i owocowe należy parzyć, zalewając je koniecznie wrzącą wodą. Dla herbat zielonych zaleca się stosowanie wody o temperaturze ok. 80 C, wtedy herbata nie nabierze lekko gorzkawego posmaku. Jeśli jakość wody przemysłowej jest niska, należy użyć wody „odstanej”, bądź niegazowanej wody mineralnej. Twardą lub mocno chlorowana wodę powinno się doprowadzić do wrzenia i gotować jeszcze 2-3 minuty bez przykrycia.

Zasadniczo: im woda bardziej miękka, tym lepiej.

<h2>W jakim naczyniu parzyć?</h2>
Dzbanek do serwowania herbaty ogrzać wstępnie gorącą wodą. Herbata utrzymuje wtedy temperaturę, w której jest najlepsza do spożycia przez co najmniej ½ godziny.

Należy raczej unikać stosowania termosów, czy podgrzewaczy do dzbanków, gdyż napój traci w ten sposób swój aromat. Tylko niektóre gatunki mocnych herbat, jak np. mieszanki fryzyjskie, czy Assam dobrze tolerują punktowe podgrzewanie (świeczką umieszczoną w podgrzewaczu do dzbanków).

<h2>Dozowanie</h2>
Do dozowania należy używać klasycznych miarek do herbaty, wsypując ja bezpośrednio do dzbanka lub też odpowiedniego sitka/filtra. Dla gatunków o bardzo dużych liściach – lekko czubatą miarkę na filiżankę (ok. 2,5 g), a dla odmian o liściach drobnych – płaską miarkę na filiżankę (ok. 2,0 g). Im większe naczynie, tym szybciej można liczyć się z dużą wydajnością herbaty. Dozowanie ziół i mieszanek owocowych – mocno wypełnioną miarkę (z dużym czubem) na filiżankę.

<h2>Czas parzenia</h2>
Właściwy czas parzenia znacząco wpływa na działanie i smak herbaty. Po 2 – 3 minutach działa ona pobudzająco na centralny układ nerwowy i charakteryzuje się lekko aromatycznym, nie za ostrym smakiem. Po 4 – 5 minutach – wpływa kojąco na żołądek i jelita, a jej smak jest bardziej wyrazisty, lecz nieco cierpki. Zioła i mieszanki owocowe powinny naciągać około 8 – 10 minut, aby móc się delektować ich pełnym smakiem i korzystać z ich łagodzącego oddziaływania.

<h2>Dodatki</h2>
Jako dodatki do herbaty poleca się neutralny w smaku biały cukier, bądź kandyz, jak również świeże (nie kondensowane) mleko. Delikatne gatunki herbaty należy pić jedynie z odrobiną cukru; korzenne – z mlekiem i/lub cukrem, a mocne – ze śmietanką i brązowym cukrem/kandyzem. Zieloną herbatę tradycyjnie spożywa się bez dodatków.

Z cytryny, jako dodatku do herbaty należy raczej zrezygnować, gdyż zupełnie niszczy ona aromat herbaty.

Najlepiej podawać herbatę w klasycznych szklankach, które doskonale prezentują świetlistą barwę napoju.

Nigdy nie wolno zapominać o spodeczku do odłożenia sitka, czy zużytej saszetki.</div>
	
	</div>

	<script>
	document.getElementById("logo").addEventListener("click", toM);

	function toM() {
	window.location.href="index.jsp";
	}
	
	
	function myFunction1() {
		document.getElementById("mDropd1").classList.toggle("show1");
			}

		
			
			document.getElementsByClassName(".drop1").addEventListener("click", xx1);
			function xx1(){
			
				var dropdowns = document.getElementsByClassName("dropd-cont1");
				var i;
				for (i = 0; i < dropdowns.length; i++) {
				var openDropdown = dropdowns[i];
				if (openDropdown.classList.contains('show1')) {
					openDropdown.classList.remove('show1');
						}
					}
			}
	</script>
</body>

</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <link rel="stylesheet" href="re.css">
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
</head>
<body>
<div id="topbar"><div id="logo">Pod Starym<br>Miłorzębem</div></div>
<div id="cont">
<%if((String)session.getAttribute("usname")!=null){response.sendRedirect("index.jsp");return;} %>
  <div id="rejestracja">
	<h1>Rejestracja</h1>
    <form method="post" action="rej">
	   <input type="text" name="nazwa_uzytkownika" placeholder="Nazwa użytkownika: "required>
       <input type="text" name="imie" placeholder="Imie: "required>
       <input type="text" name="nazwisko" placeholder="Nazwisko: "required>
	   <input type="text" name="miejscowosc" placeholder="Miejscowosc: "required>
	   <input type="text" name="ulica" placeholder="Ulica z numerem domu: "required>
	   <input type="text" name="kod_po" pattern="[0-9]{2}\-[0-9]{3}" title="Kod pocztowy wymagany w następującym formacie NP: 12-345" placeholder="Kod pocztowy: "required>
       <input type="email" name="email" placeholder="Email: "required>
       <input type="tel" name="telefon" placeholder="Telefon: " pattern="[0-9]{9}" title="Potrzebne jest 9 cyfr" required>
       <input type="password" name="haslo1" pattern=".{8,}" title="8 lub więcej znaków" placeholder="Hasło: "required>
	   <input type="password" name="haslo2" pattern=".{8,}" title="8 lub więcej znaków" placeholder="Powtórz hasło: "required>
	   <div class="s1">
	   <input type="checkbox" name="reg" id="reg" required>
	   <label for="reg">Oświadczam, że znam i akceptuję postanowienia <a href="regulamin.jsp" >Regulaminu Pod Starym Miłorzębem.</a></label>
	   </div><div class="s1">
	   <input type="checkbox" name="pozw" id="pozw" required>
	   <label for="pozw">  Wyrażam zgodę na przetwarzanie moich danych osobowych w celach marketingowych i otrzymywanie informacji handlowych od Pod Starym Miłorzębem z wykorzystaniem telekomunikacyjnych urządzeń końcowych (m.in. telefon) oraz środków komunikacji elektronicznej (m.in. SMS, e-mail). 
       </label>
	   </div>
	   
	   <p>${hasloerr}</p>
<p>${nazwaerr}</p>
	   
       <button type="submit" class="btn" name="reg_user">Zarejestruj</button>
    </form>
	<br>
	<a href="logowanie.jsp">Masz już konto? Przejdź do logowania.</a>
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
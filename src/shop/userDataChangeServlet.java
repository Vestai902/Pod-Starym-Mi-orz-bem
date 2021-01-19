package shop;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class userDataChangeServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String url = "jdbc:postgresql://localhost:5432/shop";
	    String user = "postgres";
	    String password = "admin";
	    Connection conn = null;
	    String usern = request.getParameter("nazwa_uzytkownika");

		String pass1= request.getParameter("haslo1");
		String pass2= request.getParameter("haslo2");
		String email= request.getParameter("email");
		String fName= request.getParameter("imie");
		String lName= request.getParameter("nazwisko");
		String city= request.getParameter("miejscowosc");
		String street= request.getParameter("ulica");
		String zip= request.getParameter("kod_po");
		String phone= request.getParameter("telefon");
		String p1= request.getParameter("z_haslo");
		String p2= request.getParameter("z_dane");
		String p3= request.getParameter("z_email");
		String p4= request.getParameter("z_tele");
		String SQL="";
		
			try{
			
			conn = DriverManager.getConnection(url, user, password);
		}catch(Exception exp){
			System.out.println("err");
			}
		
		HttpSession session = request.getSession();
		
     try {
    	 Statement stmt  = conn.createStatement();
		
		if(p1!=null) {
			
		        if(!pass2.equals(pass1)){
		    			
		    			request.setAttribute("hasloerr","Has³a siê nie zgadzaj¹");
		    			request.getRequestDispatcher("aktualizujdane.jsp").forward(request,response);
		    			return;	
		    		}

	            TrippleDes td=new TrippleDes();
				String t=td.encrypt(pass1);
    	
				SQL="UPDATE accounts SET password='"+t+"' WHERE user_id="+session.getAttribute("userid");

				request.setAttribute("prdod1","Zmieniono has³o");
    			
		        	
		 }else if(p2!=null){
			 
			 SQL="UPDATE accounts SET f_name='"+fName+"', l_name='"+lName+"', city='"+city+"', street='"+street+"', zip_code='"+zip+"' WHERE user_id="+session.getAttribute("userid");
			 
		 }else if(p3!=null){
			 
			 SQL="UPDATE accounts SET email='"+email+"' WHERE user_id="+session.getAttribute("userid");
			 request.setAttribute("prdod3","Zmieniono email");
		 }else if(p4!=null){
			 SQL="UPDATE accounts SET phone_number="+phone+" WHERE user_id="+session.getAttribute("userid");
			 request.setAttribute("prdod4","Zmieniono numer telefonu");
		 }
		        
		

            
        		try{
        			
        			stmt.execute(SQL);
        			request.getRequestDispatcher("aktualizujdane.jsp").forward(request,response);
        		}catch(Exception exp){
        			System.out.println("err");
        			}
        	 
     }catch(Exception e) {
    	 
     }     
        		 
            
	
}
	}

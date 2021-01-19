package shop;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class rejServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String url = "jdbc:postgresql://localhost:5432/shop";
	    String user = "postgres";
	    String password = "admin";
	    Connection conn = null;
	    String usern = request.getParameter("nazwa_uzytkownika");
		String pass= request.getParameter("haslo1");
		String pass1= request.getParameter("haslo2");
		String email= request.getParameter("email");
		String fName= request.getParameter("imie");
		String lName= request.getParameter("nazwisko");
		String city= request.getParameter("miejscowosc");
		String street= request.getParameter("ulica");
		String zip= request.getParameter("kod_po");
		String phone= request.getParameter("telefon");
		String us= request.getParameter("reg_user");
		
		

		if(!pass.equals(pass1)){
			
			request.setAttribute("hasloerr","Has³a siê nie zgadzaj¹");
			request.getRequestDispatcher("rejestracja.jsp").forward(request,response);
			return;	
		}
		
		try{
			
			conn = DriverManager.getConnection(url, user, password);
		}catch(Exception exp){
			System.out.println("err");
			}
		
            if (us!=null) {
            
        		try{
        			
        			
        			int sum=0;
        			String SQL1 = "SELECT CAST (count(username) AS INTEGER) AS il FROM accounts WHERE username='"+usern+"'";
        			Statement stmt  = conn.createStatement();
    	            ResultSet r = stmt.executeQuery(SQL1); 
    	            while (r.next()) {
    	            sum=r.getInt("il");
    	            }
    	            
    	            if(sum!=0){
    	            	request.setAttribute("nazwaerr","Nazwa u¿ytkownika jest zjêta");
    	    			request.getRequestDispatcher("rejestracja.jsp").forward(request,response);
    	    			return;	
    	            }
    	            
    	            
    	            TrippleDes td=new TrippleDes();
    				String t=td.encrypt(pass);
        		

        			stmt.executeUpdate("INSERT INTO accounts (username, password, email, f_name, l_name, city, street, zip_code, phone_number, account_type) VALUES ('"+usern+"', '"+t+"','"+email+"','"+fName+"','"+lName+"','"+city+"','"+street+"','"+zip+"',"+phone+",2)");
        	            response.sendRedirect("logowanie.jsp");
        		}catch(Exception exp){
        			System.out.println("err");
        			}
        	 
        	         
        		  }else {
                System.out.println("Failed to make connection!");
                response.sendRedirect("rejestracja.jsp");
            }
            
	
}
	}

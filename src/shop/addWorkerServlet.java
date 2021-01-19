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

public class addWorkerServlet  extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String url = "jdbc:postgresql://localhost:5432/shop";
	    String user = "postgres";
	    String password = "admin";
	    Connection conn = null;
	    String usern = request.getParameter("nazwa_uzytkownika");
		String pass= request.getParameter("haslo1");
		String pass1= request.getParameter("haslo");
		String us= request.getParameter("add_p");
		
		if(!pass.equals(pass1)){
			
			request.setAttribute("hasloerr","Has³a siê nie zgadzaj¹");
			request.getRequestDispatcher("dodajpracownika.jsp").forward(request,response);
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
    	            	request.setAttribute("nazwaerr","Nazwa u¿ytkownika jest zajêta");
    	    			request.getRequestDispatcher("dodajpracownika.jsp").forward(request,response);
    	    			return;	
    	            }
    	            
    	            TrippleDes td=new TrippleDes();
    				String t=td.encrypt(pass);
        	
        			stmt.execute("INSERT INTO accounts (username, password, f_name, l_name, city, street, zip_code, phone_number, account_type) VALUES ('"+usern+"', '"+t+"','-','-','-','-','-',000000000,4)");
        	            
        			
        			request.setAttribute("prdod","Pracownik "+usern+" zosta³ dodany");
        			request.getRequestDispatcher("dodajpracownika.jsp").forward(request,response);
        			return;
        			
        		}catch(Exception exp){
        			System.out.println("err");
        			 response.sendRedirect("index.jsp");
        			}
        	 
        	         
        		  }else {
                System.out.println("Failed to make connection!");
                response.sendRedirect("index.jsp");
            }
            
	
}
	}
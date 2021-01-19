package shop;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;

import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class addCtServlet  extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String url = "jdbc:postgresql://localhost:5432/shop";
	    String user = "postgres";
	    String password = "admin";
	    Connection conn = null;
	    String katn = request.getParameter("nazwa_kategorii");


		String us= request.getParameter("add_p");
		
		
		
		try{
			
			conn = DriverManager.getConnection(url, user, password);
		}catch(Exception exp){
			System.out.println("err");
			response.sendRedirect("index.jsp");
			}
		
		
		
		
		
            if (us!=null) {

            	
            	
        		try{
        			
        			
        			Statement stmt  = conn.createStatement();
    	          
    	            
    	           
        	
        			stmt.execute("INSERT INTO categories(name) VALUES ('"+katn+"')");
        	            
        			
        			
        			request.setAttribute("prdod","Kategoria "+katn+" zosta³a dodana");
        			request.getRequestDispatcher("dodajkategorie.jsp").forward(request,response);
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
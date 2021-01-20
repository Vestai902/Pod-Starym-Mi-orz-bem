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

public class banServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String url = "jdbc:postgresql://localhost:5432/shop";
	    String user = "postgres";
	    String password = "admin";
	    Connection conn = null;
	    String usern = request.getParameter("nazwa_uzytkownika");
	    String usern1 = request.getParameter("nazwa_uzytkownika1");
	    String a = request.getParameter("ban_u");
	    String b = request.getParameter("uban_u");
	    String SQL="";
		try{
			
			conn = DriverManager.getConnection(url, user, password);
		}catch(Exception exp){
			System.out.println("err");
			
			}
		
		if(a!=null) {
			SQL="UPDATE accounts SET ban='true' WHERE username='"+usern+"'" ;
			 request.setAttribute("set1","Zbanowano u¿ytkownika "+usern);
		}else if(b!=null) {
			SQL="UPDATE accounts SET ban='false' WHERE username='"+usern+"'" ;
			 request.setAttribute("set2","Odbanowano u¿ytkownika "+usern);
		}
            	
        		try{
        			
        		  Statement stmt  = conn.createStatement();
    	           
        		  	stmt.execute(SQL);
        			
        			
        			request.getRequestDispatcher("ban.jsp").forward(request,response);
        			return;
        			
        		}catch(Exception exp){
        			System.out.println("err");
        			 response.sendRedirect("index.jsp");
        			}
        	 
        	         
        		  }
            
	

	}
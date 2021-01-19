package shop;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class stateOfItemServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String url = "jdbc:postgresql://localhost:5432/shop";
	    String user = "postgres";
	    String password = "admin";
	    Connection conn = null;
	    String SQL="";
	    String dlt = request.getParameter("dlt");
		String act = request.getParameter("act");
		try{
			conn = DriverManager.getConnection(url, user, password);
		}catch(Exception exp){
			System.out.println("err1");
			}

            if (conn != null) {
            	
            	if(dlt!=null) {
            		SQL = "UPDATE products SET show=false WHERE product_id="+dlt;
            	}else if(act!=null){
            		SQL = "UPDATE products SET show=true WHERE product_id="+act;
            	}
            	
            	
        		try{
        	           Statement stmt = conn.createStatement();
        	           stmt.execute(SQL); 
        	           response.sendRedirect("itemmgmt.jsp");
           				
        		}catch(Exception exp){
        			System.out.println("err2");
        			response.sendRedirect("index.jsp");
        			return;
        			}

        			
        		  }else {
                System.out.println("Failed to make connection!");
                response.sendRedirect("index.jsp");
                return;
            }
          
	
}
	}

package shop;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class updateStatusURServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String url = "jdbc:postgresql://localhost:5432/shop";
	    String user = "postgres";
	    String password = "admin";
	    Connection conn = null;
	    String SQL="";
	    String sl = request.getParameter("slct");
		String id = request.getParameter("ord_id");
		try{
			conn = DriverManager.getConnection(url, user, password);
		}catch(Exception exp){
			System.out.println("err1");
			}

            if (conn != null) {
            	
            	
            		SQL = "UPDATE unregisteredorders SET order_status='"+sl+"' WHERE ord_id="+id;
            	
            	
        		try{
        	           Statement stmt = conn.createStatement();
        	           stmt.execute(SQL); 
        	           response.sendRedirect("zamowienianzr.jsp");
           				
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
	


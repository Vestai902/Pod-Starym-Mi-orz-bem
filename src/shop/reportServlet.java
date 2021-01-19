package shop;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class reportServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String url = "jdbc:postgresql://localhost:5432/shop";
	    String user = "postgres";
	    String password = "admin";
	    Connection conn = null;
	    String SQL="";
	    String rid = request.getParameter("rep");
	    String p = request.getParameter("field");
		try{
			conn = DriverManager.getConnection(url, user, password);
		}catch(Exception exp){
			System.out.println("err1");
			}

            if (conn != null) {
            	HttpSession session=request.getSession();
            	
            		SQL = "INSERT INTO report (rep_user, rep_rev) VALUES ("+session.getAttribute("userid")+", "+rid+");";
            	
            	
                	
            	
            	
            	
        		try{
        	           Statement stmt = conn.createStatement();
        	           stmt.execute(SQL); 
        	           response.sendRedirect("show.jsp?o="+p);
           				
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

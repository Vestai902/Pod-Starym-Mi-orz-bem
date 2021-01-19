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

public class itemServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = "jdbc:postgresql://localhost:5432/shop";
	    String user = "postgres";
	    String password = "admin";
	    Connection conn = null;
		String p_id= request.getParameter("addToCart");
		String quantity= request.getParameter("quantity");
		HttpSession session=request.getSession();
        		try{
        		
        			
        			session.setAttribute("unreg","unreg");
	        		session.setAttribute("quantity",quantity);
	        		session.setAttribute("p_id",p_id);
	        		
        	 
        	         
        		  }catch(Exception e) {
                response.sendRedirect("index.jsp");
            }
        		try{
        			conn = DriverManager.getConnection(url, user, password);
        		}catch(Exception exp){
        			System.out.println("err1");
        			}

                    if (conn != null) {
                    	String SQL = "SELECT * FROM products WHERE product_id="+p_id;
                		try{
                	            Statement stmt = conn.createStatement();
                	            ResultSet rs = stmt.executeQuery(SQL); 
                	            while (rs.next()) {
                	            	session.setAttribute("p_name",rs.getString("product_name"));
                	            	session.setAttribute("price",rs.getString("price"));
                	            	session.setAttribute("qt",rs.getString("quantity"));
                	            }

                		}catch(Exception exp){
                			System.out.println("err2");
                			response.sendRedirect("index.jsp");
                			}
                		response.sendRedirect("dane.jsp");
           
                		  }else {
                        System.out.println("Failed to make connection!");
                        response.sendRedirect("index.jsp");
                    }
                    }}      
	

	

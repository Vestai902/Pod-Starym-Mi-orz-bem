package shop;

import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.ArrayList;

import javax.servlet.*;
import java.sql.*;
import javax.servlet.http.*;

public class addToCartServlet  extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String url = "jdbc:postgresql://localhost:5432/shop";
	    String user = "postgres";
	    String password = "admin";
	    Connection conn = null;
	    String qt = request.getParameter("quantity");
		String pid = request.getParameter("addToCart");
		String item[]=new String[5];
		try{
			conn = DriverManager.getConnection(url, user, password);
		}catch(Exception exp){
			System.out.println("err1");
			}

            if (conn != null) {
            	String SQL = "SELECT * FROM products WHERE product_id="+pid;
            	HttpSession session = request.getSession();
            	ArrayList<String[]> cart = (ArrayList<String[]>)session.getAttribute("cart");
        		try{
        	            Statement stmt = conn.createStatement();
        	            ResultSet rs = stmt.executeQuery(SQL); 
        	            while (rs.next()) {
        	            	item[0]=rs.getString("product_id");
        	            	item[1]=rs.getString("product_name");
        	            	item[2]=rs.getString("price");
        	            	item[3]=rs.getString("quantity");
        	            	item[4]=qt;
        	           }
        	            cart.add(item);
        		}catch(Exception exp){
        			System.out.println("err2");
        			response.sendRedirect("index.jsp");
        			}

        			response.sendRedirect("koszyk.jsp");
   
        		  }else {
                System.out.println("Failed to make connection!");
                response.sendRedirect("index.jsp");
            }
          
	
}
	}

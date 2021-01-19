package shop;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class unOrderServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String url = "jdbc:postgresql://localhost:5432/shop";
	    String user = "postgres";
	    String password = "admin";
	    Connection conn = null;
		HttpSession session=request.getSession();
		String stt="";
		String stt2="";
    	
		try{
			conn = DriverManager.getConnection(url, user, password);
		}catch(Exception exp){
			System.out.println("err");
			}

            if (conn != null) {
            		
        		try{
        	            Statement stmt = conn.createStatement();
        	            
        	            
        	            conn.setAutoCommit(false);
        	            
        	            stt="INSERT INTO public.unregisteredorders( email, f_name, l_name, city, street, zip_code, phone_number, product_id, delivery_type, total_value, quantity, order_status) VALUES ('"+session.getAttribute("email")+"','"+session.getAttribute("fName")+"','"+session.getAttribute("lName")+"','"+session.getAttribute("city")+"','"+session.getAttribute("street")+"','"+session.getAttribute("zip")+"',"+session.getAttribute("phone")+","+session.getAttribute("p_id")+","+session.getAttribute("delivery")+","+session.getAttribute("total")+","+session.getAttribute("quantity")+",'W trakcie realizacji')";
        	            stmt.execute(stt);
        	     
        	        	stt2="UPDATE products SET quantity=((SELECT quantity FROM products WHERE product_id="+session.getAttribute("p_id")+")-"+session.getAttribute("quantity")+") WHERE product_id="+session.getAttribute("p_id")+";";
        	        	stmt.execute(stt2);
        	        
        	            
        	            
        	            
        	            conn.commit();

        	            conn.setAutoCommit(true);
        	          
        	            
        		}catch(Exception exp){
        			try {
        			 conn.rollback();
        			 
        			}catch(Exception e) {
        				System.out.println("rollback");
        			}
        			System.out.println("baseerr");
        			}
        	         
        				
        					session.invalidate();  
        	        		response.sendRedirect("index.jsp");
        	            }else {
        	            	response.sendRedirect("index.jsp");
        	            }
        	         
        		 
            
	
}
	}

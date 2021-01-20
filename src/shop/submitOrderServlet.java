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

public class submitOrderServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String url = "jdbc:postgresql://localhost:5432/shop";
	    String user = "postgres";
	    String password = "admin";
	    Connection conn = null;
		HttpSession session=request.getSession();
		String stt="";
		String stt2="";
	    stt="WITH ins1 AS (INSERT INTO orders(user_id, delivery_type, total_value, order_status) VALUES ("+session.getAttribute("userid")+","+session.getAttribute("delivery")+","+session.getAttribute("total")+",'W trakcie realizacji')RETURNING order_id AS ord_id), new_data(product_id, quantity) AS ( values ";
    	ArrayList<String[]> cart1 = (ArrayList<String[]>)session.getAttribute("cart");
     	for(int i=0; i<cart1.size()-1;i++){
     		String[] ct=cart1.get(i);
    	stt+="("+Integer.parseInt(ct[0])+","+Integer.parseInt(ct[4])+"),";
     	}
     	String[] ct=cart1.get(cart1.size()-1);
    	stt+="("+Integer.parseInt(ct[0])+","+Integer.parseInt(ct[4])+")) INSERT INTO order_items(order_id, product_id, quantity) SELECT ord_id, nd.product_id, nd.quantity FROM new_data as nd, ins1; ";

    	
    	
    	
    	
    	
		try{
			
			conn = DriverManager.getConnection(url, user, password);
		}catch(Exception exp){
			System.out.println("err");
			}

            if (conn != null) {
            		
        		try{
        	            Statement stmt = conn.createStatement();
        	            
        	            
        	            conn.setAutoCommit(false);
        	            
        	            
        	            stmt.execute(stt);
        	            for(int i=0; i<cart1.size();i++){
        	         		ct=cart1.get(i);
        	        	stt2="UPDATE products SET quantity=((SELECT quantity FROM products WHERE product_id="+Integer.parseInt(ct[0])+")-"+Integer.parseInt(ct[4])+") WHERE product_id="+Integer.parseInt(ct[0])+";";
        	        	stmt.execute(stt2);
        	            }
        	            
        	            
        	            
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
        	         
        				ArrayList<String[]> cart = new ArrayList<String[]>();
        	        		session.setAttribute("cart",cart);
        	        		session.setAttribute("total",null);
        	        		session.setAttribute("delivery",null);
        	        		response.sendRedirect("end.jsp");
        	            }else {
        	            	response.sendRedirect("index.jsp");
        	            }
        	         
        		 
            
	
}
	}

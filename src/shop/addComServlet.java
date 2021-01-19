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

public class addComServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String url = "jdbc:postgresql://localhost:5432/shop";
	    String user = "postgres";
	    String password = "admin";
	    Connection conn = null;
	    String com = request.getParameter("komentarz");
	    int pid=Integer.parseInt(com);
		String descr= request.getParameter("tresc");
		String rating= request.getParameter("rating");
		HttpSession session=request.getSession();  
		String usern=(String)session.getAttribute("usname");
		int id=0;

		int gr=0;
		if(rating!=null) {
		if(rating.equals("5")) gr=5;
		else if(rating.equals("4")) gr=4;
		else if(rating.equals("3")) gr=3;
		else if(rating.equals("2")) gr=2;
		else if(rating.equals("1")) gr=1;
		}
		
		try{
			
			conn = DriverManager.getConnection(url, user, password);
		}catch(Exception exp){
			System.out.println("err");
			response.sendRedirect("show.jsp?o="+pid);
			}
	    if (conn != null) {
	    	String SQL = "SELECT user_id FROM accounts WHERE username='"+usern+"'";
			int c=0;
			try{
				
			
		            Statement stmt = conn.createStatement();
		            ResultSet rs = stmt.executeQuery(SQL); 
		            while (rs.next()) {
		            id=rs.getInt("user_id");
					}
					}catch(Exception e){
			System.out.println(e);
		}
		}else{
			response.sendRedirect("show.jsp?o="+pid);
		}
        		try{
        			Statement stmt  = conn.createStatement();
        			stmt.executeUpdate("INSERT INTO reviews(user_id, product_id, description, rating) VALUES ("+id+","+pid+",'"+descr+"',"+gr+")");
        	            response.sendRedirect("show.jsp?o="+pid);
        		}catch(Exception exp){
        			System.out.println("err");
        			}
     
        		  }
	}

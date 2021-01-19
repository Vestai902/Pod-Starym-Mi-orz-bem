package shop;
import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.ArrayList;

import javax.servlet.*;
import java.sql.*;
import javax.servlet.http.*;
public class logServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String url = "jdbc:postgresql://localhost:5432/shop";
	    String user = "postgres";
	    String password = "admin";
	    Connection conn = null;
	    String user1 = request.getParameter("nazwa_uzytkownika");
		String pwd = request.getParameter("haslo");
		int userid=0;
		int total=0;
		int rank=0;
		String t="";
		ArrayList<String[]> cart = new ArrayList<String[]>();
		HttpSession ses=request.getSession();
    	ses.invalidate();
		try{
			
			conn = DriverManager.getConnection(url, user, password);
		}catch(Exception exp){
			System.out.println("err");
			}
		
		try {
		 	TrippleDes td=new TrippleDes();
			t=td.encrypt(pwd);
		}catch(Exception e) {}

            if (conn != null) {
            	String SQL = "SELECT * FROM accounts WHERE username='"+user1+"' AND password='"+t+"'";
        		int c=0;
        		try{
        	            Statement stmt = conn.createStatement();
        	            ResultSet rs = stmt.executeQuery(SQL); 
        	            while (rs.next()) {
        	            if(rs.getString("username").equals(user1)){
        	            	userid=rs.getInt("user_id");
        	            	rank=rs.getInt("account_type");
        	            	
        	            	c=1;
        	            }}
        		}catch(Exception exp){
        			System.out.println("god");
        			}
        	            if(c==1) {
        	            	  
        	        		HttpSession session=request.getSession();
        	        		session.setAttribute("usname",user1);
        	        		session.setAttribute("cart",cart);
        	        		session.setAttribute("userid",userid);
        	        		session.setAttribute("total",total);
        	        		session.setAttribute("rank",rank);
        	        		response.sendRedirect("index.jsp");
        	            }else {
        	            	request.setAttribute("err","Niepoprawne dane logowania!");
        	    			request.getRequestDispatcher("logowanie.jsp").forward(request,response);
        	    			return;	
        	            }
        	         
        		  }else {
                System.out.println("Failed to make connection!");
                response.sendRedirect("logowanie.jsp");
            }
            
	
}
	}

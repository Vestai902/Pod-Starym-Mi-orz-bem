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

public class checkComServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String url = "jdbc:postgresql://localhost:5432/shop";
	    String user = "postgres";
	    String password = "admin";
	    Connection conn = null;
		HttpSession session=request.getSession();
		String stt="";
		String stt1="";
	    String a1= request.getParameter("b1");
		String a2 = request.getParameter("b2");
		try{
			conn = DriverManager.getConnection(url, user, password);
		}catch(Exception exp){
			System.out.println("err");
			}

		if(a1!=null) {
			stt="DELETE FROM report WHERE rep_rev="+a1;
		}else if(a2!=null) {
			stt="UPDATE reviews SET show=false WHERE review_id="+a2;
			stt1="DELETE FROM report WHERE rep_rev="+a2;
		}
		
            if (conn != null) {
            		
        		try{
        	            Statement stmt = conn.createStatement();
  
        	            stmt.execute(stt);
        	            
        	            if(!stt.equals("")){
        	            	stmt.execute(stt1);
        	            }
        	            
        		}catch(Exception exp){
        			
        			System.out.println("baseerr");
        			}
        	          
        	        		response.sendRedirect("zgloszenia.jsp");
        	        		return;
        	            }else {
        	            	response.sendRedirect("index.jsp");
        	            }
        	         
        		 
            
	
}
	}

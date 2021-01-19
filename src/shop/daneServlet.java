package shop;

import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class daneServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String email= request.getParameter("email");
		String fName= request.getParameter("imie");
		String lName= request.getParameter("nazwisko");
		String city= request.getParameter("miejscowosc");
		String street= request.getParameter("ulica");
		String zip= request.getParameter("kod_po");
		String phone= request.getParameter("telefon");
		         
        		try{
        		
        			HttpSession session=request.getSession();
	        		session.setAttribute("fName",fName);
	        		session.setAttribute("lName",lName);
	        		session.setAttribute("city",city);
	        		session.setAttribute("zip",zip);
	        		session.setAttribute("street",street);
	        		session.setAttribute("email",email);
	        		session.setAttribute("phone",phone);
	        		response.sendRedirect("dostawa.jsp");
        	 
        	         
        		  }catch(Exception e) {
                response.sendRedirect("index.jsp");
            }
            
	
}
	}

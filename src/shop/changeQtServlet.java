package shop;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class changeQtServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	    String zm = request.getParameter("zm");
	    String qtn = request.getParameter("qtn");
	
            	HttpSession session = request.getSession();
            	ArrayList<String[]> cart = (ArrayList<String[]>)session.getAttribute("cart");
        		(cart.get(Integer.parseInt(zm)))[4]=qtn;
        	   
                response.sendRedirect("koszyk.jsp");
            }
          
	
}
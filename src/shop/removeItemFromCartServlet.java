package shop;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class removeItemFromCartServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	    String dl = request.getParameter("del");
	
            	HttpSession session = request.getSession();
            	ArrayList<String[]> cart = (ArrayList<String[]>)session.getAttribute("cart");
        		cart.remove(Integer.parseInt(dl));
        	   
                response.sendRedirect("koszyk.jsp");
            }
          
	
}
	
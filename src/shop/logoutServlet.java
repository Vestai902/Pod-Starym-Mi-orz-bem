package shop;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class logoutServlet extends HttpServlet{

	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		String a=request.getParameter("n");
		if(a.equals("1")) {
		HttpSession session=request.getSession();  
        session.invalidate();  
	    response.sendRedirect("index.jsp");
	    return; 
		}
	}
}
package shop;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.io.FileOutputStream;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig
public class uploadServlet extends HttpServlet{
	
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request,
	        HttpServletResponse response)
	        throws ServletException, IOException {
	    response.setContentType("text/html;charset=UTF-8");
	    String url = "jdbc:postgresql://localhost:5432/shop";
	    String user = "postgres";
	    String password = "admin";
	    Connection conn = null;
	    String name = request.getParameter("nazwa");
	    String desc = request.getParameter("opis");
	    String cat = request.getParameter("kat");
	    String qn = request.getParameter("ilosc");
	    String pr = request.getParameter("cena");
	    String s = request.getParameter("upload");
	   
	    String path = "C:\\Users\\Admin\\eclipse-workspace\\shop\\WebContent\\img\\";
	    
try{	
			conn = DriverManager.getConnection(url, user, password);
		}catch(Exception exp){
			System.out.println("err");
			}
if (s!=null) {
	try{
		Random r=new Random();
		String a="at"+r.nextInt(50000000)+1000000;
		path+=a;
		File theDir = new File(path);
		if (!theDir.exists()){
		    theDir.mkdirs();
		}
		//PreparedStatement st = conn.prepareStatement(SQL);
		Statement stmt  = conn.createStatement();
		
		stmt.executeUpdate("INSERT INTO public.products(product_name, description, pictures, category_id, show, quantity, price) VALUES ('"+name+"', '"+desc+"','"+path+"','"+cat+"',true,"+qn+","+pr+")");
            response.sendRedirect("index.jsp");
	}catch(Exception exp){
		System.out.println("err");
		}
 
         
	  }else {
    System.out.println("Failed to make connection!");
    response.sendRedirect("index.jsp");
}

	    
	    Part filePart;
	    List<Part> list = new ArrayList<Part>();
	    int c=0;
	    while(true) {
	    	filePart=request.getPart("file"+c);
	    	if(filePart!=null) {
	    		list.add(filePart);
	    	}else break;
	    	c++;
	    }
	    for(int j=0;j<list.size();j++) {
	    String nam=Paths.get(list.get(j).getSubmittedFileName()).getFileName().toString();
	    OutputStream out = null;
	    InputStream filecontent = null;
	    final PrintWriter writer = response.getWriter();

	    try {
	        out = new FileOutputStream(new File(path + File.separator
	                + nam));
	        filecontent = list.get(j).getInputStream();

	        int read = 0;
	        final byte[] bytes = new byte[1024];

	        while ((read = filecontent.read(bytes)) != -1) {
	            out.write(bytes, 0, read);
	        }
	        //writer.println("New file " + nam + " created at " + path);
	       
	    } catch (FileNotFoundException fne) {
	        writer.println("<br/> ERROR: " + fne.getMessage());

	      
	    } finally {
	        if (out != null) {
	            out.close();
	        }
	        if (filecontent != null) {
	            filecontent.close();
	        }
	        if (writer != null) {
	            writer.close();
	        }
	    }
	    }
	}


}

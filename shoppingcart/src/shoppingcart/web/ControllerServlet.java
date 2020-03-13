package shoppingcart.web;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import shoppingcart.db.User;
import shoppingcart.util.Utilities;

/**
 * Servlet implementation class ControllerServlet
 * 
 * Inheritance - Controller servlet inherits HttpServlet
 * 
 */
public class ControllerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 * 
	 * overide doGet Method of parent Class HttpServlet (Polymorphism)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 * 
	 * overide doPost Method of parent Class HttpServlet (Polymorphism)
	 * 
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}
	//
	private void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Entered processRequest");
		
		String action = Utilities.checkString(request.getParameter("action"));	
		
		System.out.println("Action: "+action);
		
		String returnPage = "";
		Helper helper = new Helper();
		
		if(action.equals("login")){
			int status = helper.login(request);
			if(status == 0){
				returnPage = "/pages/home.jsp";
			}else{
				returnPage = "/pages/login.jsp";
			}
		}else if(action.equals("loginp")){	
			returnPage = "/pages/login.jsp";
		}else if(action.equals("signupp")){
			helper.getStateList(request);
			returnPage = "/pages/adduser.jsp";		
		}else if(action.equals("edituserp")){
			helper.getUser(request);	
			helper.getStateList(request);
			returnPage = "/pages/edituser.jsp";			
		}else if(action.equals("edituser")){
			helper.editUser(request);	
			returnPage = "/pages/home.jsp";
		}else if(action.equals("adduser")){
			helper.addUser(request);
			returnPage = "/pages/home.jsp";
		}else if(action.equals("logout")){
			helper.logOut(request);
			returnPage = "/pages/home.jsp";
		}else if(action.equals("home")){
			returnPage = "/pages/home.jsp";			
		}else if(action.equals("products")){
			helper.getProducts(request);
			returnPage = "/pages/products.jsp";	
		}else if(action.equals("viewcart")){
			if(checkUserSession(request) != null){
				helper.getCartItemList(request);
				returnPage = "/pages/cart.jsp";
			}else {
				returnPage = "/pages/login.jsp";
			}			
		}else if(action.equals("addtocart")){
			if(checkUserSession(request) != null){
				helper.addCartItem(request);
				helper.getCartItemList(request);
				returnPage = "/pages/cart.jsp";
			}else {
				returnPage = "/pages/login.jsp";
			}
		}else if(action.equals("editcart")){
			if(checkUserSession(request) != null){
				helper.editCartItem(request);
				helper.getCartItemList(request);
				returnPage = "/pages/cart.jsp";
			}else {
				returnPage = "/pages/login.jsp";
			}	
		}else if(action.equals("removeitem")){
			if(checkUserSession(request) != null){
				helper.deleteCartItem(request);
				helper.getCartItemList(request);
				returnPage = "/pages/cart.jsp";
			}else {
				returnPage = "/pages/login.jsp";
			}
		}else if(action.equals("orderp")){
			if(checkUserSession(request) != null){
				helper.getUser(request);	
				helper.getStateList(request);
				helper.getCartItemList(request);
				returnPage = "/pages/order.jsp";
			}else {
				returnPage = "/pages/login.jsp";
			}
		}else if(action.equals("placeorder")){
			if(checkUserSession(request) != null){
				helper.placeOrder(request);
				returnPage = "/pages/orderconfirmation.jsp";
			}else {
				returnPage = "/pages/login.jsp";
			}		
		}else if(action.equals("orderreportp")){
			if(checkUserSession(request) != null){
				returnPage = "/pages/orderreport.jsp";
			}else {
				returnPage = "/pages/login.jsp";
			}
		}else if(action.equals("orderreport")){
			if(checkUserSession(request) != null){
				helper.getUserOrderList(request);
				returnPage = "/pages/orderreport.jsp";
			}else {
				returnPage = "/pages/login.jsp";
			}			
				
		}else{//
			PrintWriter out = response.getWriter();
			response.setContentType("text/html");
			out.println("<b>Unknown request format</b>");
			out.println("<br>");
			out.println("Please click <a href=\""+request.getContextPath()+"\">here</a> to go the home page.");
		}
		
		if(!"".equals(returnPage)) {
			RequestDispatcher dispatcher = request.getRequestDispatcher(returnPage);
				dispatcher.forward(request, response);

		}
		
	}
	
	private User checkUserSession(HttpServletRequest httpRequest){ 
		HttpSession session = httpRequest.getSession(true);
		User userSession = (User)session.getAttribute("appuser");	
		return userSession;
		
	}

}

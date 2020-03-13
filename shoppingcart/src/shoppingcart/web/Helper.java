package shoppingcart.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import shoppingcart.db.CartItem;
import shoppingcart.db.Item;
import shoppingcart.db.Order;
import shoppingcart.db.ProductType;
import shoppingcart.db.ShoppingCartDb;
import shoppingcart.db.State;
import shoppingcart.db.User;
import shoppingcart.util.Utilities;

public class Helper {
	
	public int login(HttpServletRequest request){
		int status = 0;
		
		String userName = Utilities.checkString(request.getParameter("username"));
		String password = Utilities.checkString(request.getParameter("password"));
		
		ShoppingCartDb db = new ShoppingCartDb();
		User user = db.getUser(userName);
		
		if(user != null){
			if(password.equals(user.getPassword())){
				status = 0;
				System.out.println("User password matches");
			}else{
				status =1;
				request.setAttribute("status", "Invalid user");
				System.out.println("User password does not match");
			}
		}else{
			status = 1;
			request.setAttribute("status", "Invalid user");
			System.out.println("User not found");
		}		

		if(status == 0) {
			HttpSession session = request.getSession(true); //Creating new session
			if(session != null) {
				session.setAttribute("appuser", user);
			}
		}	
		
		
		return status;
	}
	
	public void addUser(HttpServletRequest request){
		int status = 0;
		
		User user = new User();
		user.setUserName(Utilities.checkString(request.getParameter("username")));
		user.setPassword(Utilities.checkString(request.getParameter("password")));
		user.setEmail(Utilities.checkString(request.getParameter("email")));
		user.setFirstName(Utilities.checkString(request.getParameter("firstName")));
		user.setLastName(Utilities.checkString(request.getParameter("lastName")));
		user.setAddress1(Utilities.checkString(request.getParameter("address1")));
		user.setAddress2(Utilities.checkString(request.getParameter("address2")));
		user.setCity(Utilities.checkString(request.getParameter("city")));
		user.setStateId(Utilities.checkString(request.getParameter("stateId")));
		user.setCountry(Utilities.checkString(request.getParameter("country")));
		
		ShoppingCartDb db = new ShoppingCartDb();
		
		status = db.addUser(user);
		
		if(status == 0){
			request.setAttribute("status", "User added successfully");
		}else{
			request.setAttribute("status", "Error occurred while adding user");
		}
	}
	
	public void editUser(HttpServletRequest request){
		int status = 0;
		
		User user = new User();
		user.setUserId(Utilities.checkInt(request.getParameter("userId")));
		user.setEmail(Utilities.checkString(request.getParameter("email")));
		user.setFirstName(Utilities.checkString(request.getParameter("firstName")));
		user.setLastName(Utilities.checkString(request.getParameter("lastName")));
		user.setAddress1(Utilities.checkString(request.getParameter("address1")));
		user.setAddress2(Utilities.checkString(request.getParameter("address2")));
		user.setCity(Utilities.checkString(request.getParameter("city")));
		user.setStateId(Utilities.checkString(request.getParameter("stateId")));
		user.setCountry(Utilities.checkString(request.getParameter("country")));
		
		ShoppingCartDb db = new ShoppingCartDb();
		
		status = db.editUser(user);
		
		if(status == 0){
			request.setAttribute("status", "User updated successfully");
		}else{
			request.setAttribute("status", "Error occurred while updating user");
		}
	}
	
	public void getUser(HttpServletRequest request){
		User sessionUser = (User)request.getSession().getAttribute("appuser");
		
		ShoppingCartDb db = new ShoppingCartDb();
		User user = db.getUser(sessionUser.getUserName());
		
		request.setAttribute("user", user);
	}
	

	public void logOut(HttpServletRequest request) {

		HttpSession session = request.getSession();

		if(session != null) {
			//User user = (User)session.getAttribute("appuser");

			//System.out.println(user+" - logOut");

			session.removeAttribute("appuser");
			session.invalidate();

		}
	}
	
	public void getProducts(HttpServletRequest request){
		int productTypeId = Utilities.checkInt(request.getParameter("productTypeId"));
		String itemName = Utilities.checkString(request.getParameter("itemName"));
		
		ShoppingCartDb db = new ShoppingCartDb();
		
		List<ProductType> productTypeList = db.getProductTypeList();
		List<Item> itemList = db.getItemList(productTypeId, itemName);
		
		request.setAttribute("productTypeList", productTypeList);
		request.setAttribute("itemList", itemList);
		
	}
	
	public void getStateList(HttpServletRequest request){
		
		ShoppingCartDb db = new ShoppingCartDb();
		
		List<State> stateList = db.getStateList();
		
		request.setAttribute("stateList", stateList);
		
	}
	
	public void addCartItem(HttpServletRequest request){
		int status = 0;
		
		User sessionUser = (User)request.getSession().getAttribute("appuser");
		int itemId = Utilities.checkInt(request.getParameter("itemId"));
		int userId = sessionUser.getUserId();
		
		ShoppingCartDb db = new ShoppingCartDb();
		
		CartItem cartItem = null;
		//check if item is already in the cart / if yes just increase number
		cartItem = db.getCartItem(userId, itemId);
		if(cartItem == null){ // not in cart add new row.
			cartItem = new CartItem();
			cartItem.setItemId(itemId);
			cartItem.setItemQuantity(1); //Default is one
			cartItem.setUserId(userId);
			status = db.addCartItem(cartItem);
		}else{
			cartItem.setItemQuantity(cartItem.getItemQuantity()+1); //just increase quantity
			status = db.editCartItem(cartItem);
		}		
		
		if(status == 0){
			request.setAttribute("status", "Item added successfully");
		}else{
			request.setAttribute("status", "Error occurred while adding item to cart");
		}
	}
	
	public void editCartItem(HttpServletRequest request){
		int status = 0;
		
		User sessionUser = (User)request.getSession().getAttribute("appuser");
		
		CartItem cartItem = new CartItem();
		cartItem.setItemId(Utilities.checkInt(request.getParameter("itemId")));
		cartItem.setItemQuantity(Utilities.checkInt(request.getParameter("quantity"))); 
		cartItem.setUserId(sessionUser.getUserId());
		
		ShoppingCartDb db = new ShoppingCartDb();
		
		status = db.editCartItem(cartItem);
		
		if(status == 0){
			request.setAttribute("status", "Item updated successfully");
		}else{
			request.setAttribute("status", "Error occurred while trying to update item");
		}
	}
	
	public void deleteCartItem(HttpServletRequest request){
		int status = 0;
		
		User sessionUser = (User)request.getSession().getAttribute("appuser");
		
		CartItem cartItem = new CartItem();
		cartItem.setItemId(Utilities.checkInt(request.getParameter("itemId")));
		cartItem.setUserId(sessionUser.getUserId());
		
		ShoppingCartDb db = new ShoppingCartDb();
		
		status = db.deleteCartItem(cartItem);
		
		if(status == 0){
			request.setAttribute("status", "Item removed successfully");
		}else{
			request.setAttribute("status", "Error occurred while trying to delelete item");
		}
	}
	
	
	public void getCartItemList(HttpServletRequest request){
		User sessionUser = (User)request.getSession().getAttribute("appuser");
		
		ShoppingCartDb db = new ShoppingCartDb();
		
		List<CartItem> cartItemList = db.getCartItemList(sessionUser.getUserId());
		
		request.setAttribute("cartItemList", cartItemList);
		
	}
	
	public void placeOrder(HttpServletRequest request){
		int status = 0;
		
		User sessionUser = (User)request.getSession().getAttribute("appuser");
		
		Order order = new Order();
		order.setUserId(sessionUser.getUserId());
		order.setShipFirstName(Utilities.checkString(request.getParameter("shipFirstName")));
		order.setShipLastName(Utilities.checkString(request.getParameter("shipLastName")));
		order.setShipAddress1(Utilities.checkString(request.getParameter("shipAddress1")));
		order.setShipAddress2(Utilities.checkString(request.getParameter("shipAddress2")));
		order.setShipCity(Utilities.checkString(request.getParameter("shipCity")));
		order.setShipStateId(Utilities.checkString(request.getParameter("shipStateId")));
		order.setShipCountry(Utilities.checkString(request.getParameter("shipCountry")));
		order.setShipCharge(Utilities.checkDouble(request.getParameter("shipCharge")));
		order.setOrderAmount(Utilities.checkDouble(request.getParameter("totalPrice")));
		order.setOrderStatus("PROCESSING");
		
		ShoppingCartDb db = new ShoppingCartDb();
		
		status = db.addOrder(order);
		
		if(status == 0){
			request.setAttribute("orderId", order.getOrderId());
			List<CartItem> cartItemList = db.getCartItemList(sessionUser.getUserId());
			db.addOrderItem(cartItemList, order.getOrderId());
			db.substractItemQuantity(cartItemList);
			db.deleteAllCartItem(sessionUser.getUserId()); //clear cart after oder is placed
		}else{
			request.setAttribute("status", "Error occurred while trying to place order");
		}
	}
	
	public void getUserOrderList(HttpServletRequest request){
		String fromDateTime = Utilities.checkString(request.getParameter("fromDate"))+" 00:00:00";
		String toDateTime = Utilities.checkString(request.getParameter("toDate"))+" 23:59:59";
		
		User sessionUser = (User)request.getSession().getAttribute("appuser");
		
		ShoppingCartDb db = new ShoppingCartDb();
		
		List<Order> orderList = db.getUserOrderList(fromDateTime, toDateTime, sessionUser.getUserId());
		
		request.setAttribute("orderList", orderList);
		
	}	

}

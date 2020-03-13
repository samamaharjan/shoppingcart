package shoppingcart.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import shoppingcart.util.Utilities;

public class ShoppingCartDb {
	//addUser
	public int addUser(User user){
		int status = 0;
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			
			con = AppDatabaseConnection.getInstance().getConnection();	
			StringBuilder sqlQuery  = new StringBuilder();
			sqlQuery.append("insert into user (user_name, password, first_name, last_name, email, address1, ");
			sqlQuery.append("address2, city, state_id, country)  ");
			sqlQuery.append("values (?,?,?,?,?,?,?,?,?,?) ");
					
			ps = con.prepareStatement(sqlQuery.toString());	
			
			int i=1;
			ps.setString(i++, user.getUserName());
			ps.setString(i++, user.getPassword());
			ps.setString(i++, user.getFirstName());
			ps.setString(i++, user.getLastName());
			ps.setString(i++, user.getEmail());
			ps.setString(i++, user.getAddress1());
			ps.setString(i++, user.getAddress2());
			ps.setString(i++, user.getCity());
			if(user.getStateId() !="" && user.getStateId() != null){
				ps.setString(i++, user.getStateId());
			}else{
				ps.setNull(i++, Types.NULL);
			}
			
			ps.setString(i++, user.getCountry());
			
			System.out.println("Executing query: \n"+ps.toString());
			
			ps.executeUpdate();			
			
		} catch (SQLException sqle) {			
			System.err.println("Caught SQLException " + sqle.getMessage());		
			status = 1;
		} catch (Exception e) {			
			System.err.println("Caught Exception " + e);
			status = 1;
		} finally {	  
			try {
				if(ps != null) {
					ps.close();
				}
			} catch(SQLException se) {
			//do nothing
			}
			AppDatabaseConnection.getInstance().closeConnection(con);			
		}
		return status;
	}
	//editUser
	public int editUser(User user){
		int status = 0;
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			
			con = AppDatabaseConnection.getInstance().getConnection();	
			StringBuilder sqlQuery  = new StringBuilder();
			sqlQuery.append("update user set first_name=?, last_name=?, email=?, address1=?, ");
			sqlQuery.append("address2=?, city=?, state_id=?, country=? ");
			sqlQuery.append("where user_id = ? ");
					
			ps = con.prepareStatement(sqlQuery.toString());	
			
			int i=1;
			ps.setString(i++, user.getFirstName());
			ps.setString(i++, user.getLastName());
			ps.setString(i++, user.getEmail());
			ps.setString(i++, user.getAddress1());
			ps.setString(i++, user.getAddress2());
			ps.setString(i++, user.getCity());
			if(user.getStateId() !="" && user.getStateId() != null){
				ps.setString(i++, user.getStateId());
			}else{
				ps.setNull(i++, Types.NULL);
			}
			ps.setString(i++, user.getCountry());
			ps.setInt(i++, user.getUserId());
			
			System.out.println("Executing query: \n"+ps.toString());
			
			ps.executeUpdate();			
			
		} catch (SQLException sqle) {			
			System.err.println("Caught SQLException " + sqle.getMessage());			
			status = 1;
		} catch (Exception e) {			
			System.err.println("Caught Exception " + e);
			status = 1;
		} finally {	  
			try {
				if(ps != null) {
					ps.close();
				}
			} catch(SQLException se) {
			//do nothing
			}
			AppDatabaseConnection.getInstance().closeConnection(con);			
		}		
		return status;
	}
	//getUser by userName
	public User getUser(String userName) {
		User user = null;
		Connection con = null;
		PreparedStatement ps = null;	//secure and faster than statement
		ResultSet rs = null;	//hold DB return result. Get value through iteration. 
		
		try {
			
			con = AppDatabaseConnection.getInstance().getConnection();	
			StringBuilder sqlQuery  = new StringBuilder();
			sqlQuery.append("select user_id, user_name, password, first_name, last_name, email, address1, ");
			sqlQuery.append("address2, city, state_id, country ");
			sqlQuery.append("from user ");
			sqlQuery.append("where user_Name=?");
					
			ps = con.prepareStatement(sqlQuery.toString());	
			ps.setString(1, userName);
			
			System.out.println("Executing query: \n"+ps.toString());
						
			rs = ps.executeQuery();
			
			if(rs.next()){
				user = new User();
				user.setUserId(rs.getInt("user_id"));
				user.setUserName(rs.getString("user_name"));
				user.setPassword(rs.getString("password"));
				user.setFirstName(rs.getString("first_name"));
				user.setLastName(rs.getString("last_name"));
				user.setEmail(rs.getString("email"));
				user.setAddress1(rs.getString("address1"));
				user.setAddress2(rs.getString("address2"));
				user.setCity(rs.getString("city"));
				user.setStateId(rs.getString("state_id"));
				user.setCountry(rs.getString("country"));
				System.out.println(user.toString());
			}		
			
			
		} catch (SQLException sqle) {			
			System.err.println("Caught SQLException " + sqle.getMessage());
			
		} catch (Exception e) {			
			System.err.println("Caught Exception " + e);
		} finally {	  
			try {
				if(rs != null) {			
					rs.close();
				}
				if(ps != null) {
					ps.close();
				}
			} catch(SQLException se) {
			//do nothing
			}
			AppDatabaseConnection.getInstance().closeConnection(con);			
		}
		
		return user;
		
	}
	//productTypeList
	public List<ProductType> getProductTypeList(){
		
		List<ProductType> productTypeList = new ArrayList<ProductType>();
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			
			con = AppDatabaseConnection.getInstance().getConnection();	
			StringBuilder sqlQuery  = new StringBuilder();
			sqlQuery.append("select product_type_id, product_type_name ");
			sqlQuery.append("from product_type ");
			sqlQuery.append("order by product_type_name ");
								
			ps = con.prepareStatement(sqlQuery.toString());	
			System.out.println("Executing query: \n"+ps.toString());
			
			
			rs = ps.executeQuery();
			
			while(rs.next()){
				ProductType productType = new ProductType();
				productType.setProductTypeId(rs.getInt("product_type_id"));
				productType.setProductTypeName(rs.getString("product_type_name"));
				
				productTypeList.add(productType);
			}		
			
			
		} catch (SQLException sqle) {			
			System.err.println("Caught SQLException " + sqle.getMessage());			
		} catch (Exception e) {			
			System.err.println("Caught Exception " + e);
		} finally {	  
			try {
				if(rs != null) {			
					rs.close();
				}
				if(ps != null) {
					ps.close();
				}
			} catch(SQLException se) {
			//do nothing
			}
			AppDatabaseConnection.getInstance().closeConnection(con);			
		}
		return productTypeList;
	}
	//ItemList
	public List<Item> getItemList(int productTypeId, String itemName){
		
		List<Item> itemList = new ArrayList<Item>();
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			
			con = AppDatabaseConnection.getInstance().getConnection();	
			StringBuilder sqlQuery  = new StringBuilder();
			sqlQuery.append("select item_id, item_name, item_price, item_desc, product_type_id, item_quantity ");
			sqlQuery.append("from item ");
			
			StringBuilder whereClause = new StringBuilder();
			
			if(productTypeId > 0){
				whereClause.append("and product_type_id= " + productTypeId + " " );
			}
			if(itemName != null && !itemName.isEmpty()) { 
				whereClause.append("and item_name like '%"+itemName+"%' ");
			}
			if(whereClause.length() > 0){
				sqlQuery.append("where " + whereClause.toString().replaceFirst("and", ""));
			}
			sqlQuery.append("order by item_price desc  ");
								
			ps = con.prepareStatement(sqlQuery.toString());				
			//if(productTypeId > 0){
			//	ps.setInt(1, productTypeId);
			//}
			
			System.out.println("Executing query: \n"+ps.toString());
			
			rs = ps.executeQuery();
			
			while(rs.next()){
				Item item = new Item();
				item.setItemId(rs.getInt("item_id"));
				item.setItemName(rs.getString("item_name"));
				item.setItemPrice(rs.getDouble("item_price"));
				item.setItemDescription(rs.getString("item_desc"));				
				item.setProductTypeId(rs.getInt("product_type_id"));
				item.setItemQuantity(rs.getInt("item_quantity"));
				
				itemList.add(item);
			}		
			
			
		} catch (SQLException sqle) {			
			System.err.println("Caught SQLException " + sqle.getMessage());			
		} catch (Exception e) {			
			System.err.println("Caught Exception " + e);
		} finally {	  
			try {
				if(rs != null) {			
					rs.close();
				}
				if(ps != null) {
					ps.close();
				}
			} catch(SQLException se) {
			//do nothing
			}
			AppDatabaseConnection.getInstance().closeConnection(con);			
		}
		return itemList;
	}
	
	//StateList
	public List<State> getStateList(){
		
		List<State> stateList = new ArrayList<State>();
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			
			con = AppDatabaseConnection.getInstance().getConnection();	
			StringBuilder sqlQuery  = new StringBuilder();
			sqlQuery.append("select state_id, state_name ");
			sqlQuery.append("from state ");
			sqlQuery.append("order by state_name ");
								
			ps = con.prepareStatement(sqlQuery.toString());	
			System.out.println("Executing query: \n"+ps.toString());
			
			
			rs = ps.executeQuery();
			
			while(rs.next()){
				State state = new State();
				state.setStateId(rs.getString("state_id"));
				state.setStateName(rs.getString("state_name"));
				
				stateList.add(state);
			}		
			
			
		} catch (SQLException sqle) {			
			System.err.println("Caught SQLException " + sqle.getMessage());			
		} catch (Exception e) {			
			System.err.println("Caught Exception " + e);
		} finally {	  
			try {
				if(rs != null) {			
					rs.close();
				}
				if(ps != null) {
					ps.close();
				}
			} catch(SQLException se) {
			//do nothing
			}
			AppDatabaseConnection.getInstance().closeConnection(con);			
		}
		return stateList;
	}
	
	//addCartItem  *************************************************************************************
	public int addCartItem(CartItem cartItem){
		int status = 0;
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			
			con = AppDatabaseConnection.getInstance().getConnection();	
			StringBuilder sqlQuery  = new StringBuilder();
			sqlQuery.append("insert into cart (user_id, item_id, item_quantity) ");
			sqlQuery.append("values (?,?,?) ");
					
			ps = con.prepareStatement(sqlQuery.toString());	
			
			int i=1;
			ps.setInt(i++, cartItem.getUserId());
			ps.setInt(i++, cartItem.getItemId());
			ps.setInt(i++, cartItem.getItemQuantity());
			
			System.out.println("Executing query: \n"+ps.toString());
			
			ps.executeUpdate();			
			
		} catch (SQLException sqle) {			
			System.err.println("Caught SQLException " + sqle.getMessage());		
			status = 1;
		} catch (Exception e) {			
			System.err.println("Caught Exception " + e);
			status = 1;
		} finally {	  
			try {
				if(ps != null) {
					ps.close();
				}
			} catch(SQLException se) {
			//do nothing
			}
			AppDatabaseConnection.getInstance().closeConnection(con);			
		}
		return status;
	}
	
	//editCartItem
	public int editCartItem(CartItem cartItem){
		int status = 0;
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			
			con = AppDatabaseConnection.getInstance().getConnection();	
			StringBuilder sqlQuery  = new StringBuilder();
			sqlQuery.append("update cart set item_quantity = ? where user_id = ? and item_id=? ");
					
			ps = con.prepareStatement(sqlQuery.toString());	
			
			int i=1;
			ps.setInt(i++, cartItem.getItemQuantity());
			ps.setInt(i++, cartItem.getUserId());
			ps.setInt(i++, cartItem.getItemId());
			
			
			System.out.println("Executing query: \n"+ps.toString());
			
			ps.executeUpdate();			
			
		} catch (SQLException sqle) {			
			System.err.println("Caught SQLException " + sqle.getMessage());			
			status = 1;
		} catch (Exception e) {			
			System.err.println("Caught Exception " + e);
			status = 1;
		} finally {	  
			try {
				if(ps != null) {
					ps.close();
				}
			} catch(SQLException se) {
			//do nothing
			}
			AppDatabaseConnection.getInstance().closeConnection(con);			
		}		
		return status;
	}		
	//deleteCartItem
	public int deleteCartItem(CartItem cartItem){
		int status = 0;
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			
			con = AppDatabaseConnection.getInstance().getConnection();	
			StringBuilder sqlQuery  = new StringBuilder();
			sqlQuery.append("delete from cart where user_id = ? and item_id=? ");
					
			ps = con.prepareStatement(sqlQuery.toString());	
			
			int i=1;
			ps.setInt(i++, cartItem.getUserId());
			ps.setInt(i++, cartItem.getItemId());
			
			
			System.out.println("Executing query: \n"+ps.toString());
			
			ps.executeUpdate();			
			
		} catch (SQLException sqle) {			
			System.err.println("Caught SQLException " + sqle.getMessage());			
			status = 1;
		} catch (Exception e) {			
			System.err.println("Caught Exception " + e);
			status = 1;
		} finally {	  
			try {
				if(ps != null) {
					ps.close();
				}
			} catch(SQLException se) {
			//do nothing
			}
			AppDatabaseConnection.getInstance().closeConnection(con);			
		}		
		return status;
	}	
	
	public int deleteAllCartItem(int userId){
		int status = 0;
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			
			con = AppDatabaseConnection.getInstance().getConnection();	
			StringBuilder sqlQuery  = new StringBuilder();
			sqlQuery.append("delete from cart where user_id = ?  ");
					
			ps = con.prepareStatement(sqlQuery.toString());	
			
			int i=1;
			ps.setInt(i++, userId);
			
			
			System.out.println("Executing query: \n"+ps.toString());
			
			ps.executeUpdate();			
			
		} catch (SQLException sqle) {			
			System.err.println("Caught SQLException " + sqle.getMessage());			
			status = 1;
		} catch (Exception e) {			
			System.err.println("Caught Exception " + e);
			status = 1;
		} finally {	  
			try {
				if(ps != null) {
					ps.close();
				}
			} catch(SQLException se) {
			//do nothing
			}
			AppDatabaseConnection.getInstance().closeConnection(con);			
		}		
		return status;
	}	
	//getCartItem
	public CartItem getCartItem(int userId, int itemId) {
		CartItem cartItem = null;
		Connection con = null;
		PreparedStatement ps = null;	//secure and faster than statement
		ResultSet rs = null;	//hold DB return result. Get value through iteration. 
		
		try {
			
			con = AppDatabaseConnection.getInstance().getConnection();	
			StringBuilder sqlQuery  = new StringBuilder();
			sqlQuery.append("select a.user_id, a.item_id, b.item_name, a.item_quantity, (a.item_quantity*b.item_price) as price "); 
			sqlQuery.append("from cart a, item b ");
			sqlQuery.append("where a.item_id = b.item_id ");
			sqlQuery.append("and a.user_id=? ");
			sqlQuery.append("and a.item_id=? ");
					
			ps = con.prepareStatement(sqlQuery.toString());	
			ps.setInt(1, userId);
			ps.setInt(2, itemId);
			
			System.out.println("Executing query: \n"+ps.toString());
						
			rs = ps.executeQuery();
			
			if(rs.next()){
				cartItem = new CartItem();
				cartItem.setUserId(rs.getInt("user_id"));
				cartItem.setItemId(rs.getInt("item_id"));
				cartItem.setItemName(rs.getString("item_name"));
				cartItem.setItemQuantity(rs.getInt("item_quantity"));
				cartItem.setPrice(rs.getDouble("price"));
			}		
			
			
		} catch (SQLException sqle) {			
			System.err.println("Caught SQLException " + sqle.getMessage());
			
		} catch (Exception e) {			
			System.err.println("Caught Exception " + e);
		} finally {	  
			try {
				if(rs != null) {			
					rs.close();
				}
				if(ps != null) {
					ps.close();
				}
			} catch(SQLException se) {
			//do nothing
			}
			AppDatabaseConnection.getInstance().closeConnection(con);			
		}
		
		return cartItem;
		
	}
	
	//cartItemList
	public List<CartItem> getCartItemList(int userId){
		
		List<CartItem> cartItemList = new ArrayList<CartItem>();
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			
			con = AppDatabaseConnection.getInstance().getConnection();	
			StringBuilder sqlQuery  = new StringBuilder();
			sqlQuery.append("select a.user_id, a.item_id, b.item_name, a.item_quantity, (a.item_quantity*b.item_price) as price "); 
			sqlQuery.append("from cart a, item b ");
			sqlQuery.append("where a.item_id = b.item_id ");
			sqlQuery.append("and a.user_id=? ");
								
			ps = con.prepareStatement(sqlQuery.toString());	
			ps.setInt(1, userId);
			
			System.out.println("Executing query: \n"+ps.toString());
			
			
			rs = ps.executeQuery();
			
			while(rs.next()){
				CartItem cartItem = new CartItem();
				cartItem.setUserId(rs.getInt("user_id"));
				cartItem.setItemId(rs.getInt("item_id"));
				cartItem.setItemName(rs.getString("item_name"));
				cartItem.setItemQuantity(rs.getInt("item_quantity"));
				cartItem.setPrice(rs.getDouble("price"));
				cartItemList.add(cartItem);
			}		
			
			
		} catch (SQLException sqle) {			
			System.err.println("Caught SQLException " + sqle.getMessage());			
		} catch (Exception e) {			
			System.err.println("Caught Exception " + e);
		} finally {	  
			try {
				if(rs != null) {			
					rs.close();
				}
				if(ps != null) {
					ps.close();
				}
			} catch(SQLException se) {
			//do nothing
			}
			AppDatabaseConnection.getInstance().closeConnection(con);			
		}
		return cartItemList;
	}
	
	public int addOrder(Order order){
		int status = 0;
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			
			con = AppDatabaseConnection.getInstance().getConnection();	
			StringBuilder sqlQuery  = new StringBuilder();
			sqlQuery.append("INSERT INTO orders ");
			sqlQuery.append("(user_id, ship_first_name, ship_last_name, ship_address1, ship_address2, ship_city, ");
			sqlQuery.append("ship_state_id, ship_country, ship_charge, order_amout, order_status, order_date_time) ");
			sqlQuery.append("VALUES(?,?,?,?,?,?,?,?,?,?,?,now()) ");
					
			ps = con.prepareStatement(sqlQuery.toString(), PreparedStatement.RETURN_GENERATED_KEYS);	
			
			int i=1;
			ps.setInt(i++, order.getUserId());
			ps.setString(i++, order.getShipFirstName());
			ps.setString(i++, order.getShipLastName());
			ps.setString(i++, order.getShipAddress1());
			ps.setString(i++, order.getShipAddress2());
			ps.setString(i++, order.getShipCity());
			ps.setString(i++, order.getShipStateId());
			ps.setString(i++, order.getShipCountry());
			ps.setDouble(i++, order.getShipCharge());
			ps.setDouble(i++, order.getOrderAmount());
			ps.setString(i++, order.getOrderStatus());
			
			System.out.println("Executing query: \n"+ps.toString());
			
			ps.executeUpdate();			
			
			rs = ps.getGeneratedKeys();// get generated order id			
			int orderId = 0;
			
			while (rs.next()) {
				orderId = rs.getInt(1);			  		 
			}
			order.setOrderId(orderId);
			
		} catch (SQLException sqle) {			
			System.err.println("Caught SQLException " + sqle.getMessage());		
			status = 1;
		} catch (Exception e) {			
			System.err.println("Caught Exception " + e);
			status = 1;
		} finally {	  
			try {
				if(rs != null) {			
					rs.close();
				}				
				if(ps != null) {
					ps.close();
				}
			} catch(SQLException se) {
			//do nothing
			}
			AppDatabaseConnection.getInstance().closeConnection(con);			
		}
		return status;
	}
	
	//copy cart item to order_item table
	public int addOrderItem(List<CartItem> cartItemList, int orderId){
		int status = 0;
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			
			con = AppDatabaseConnection.getInstance().getConnection();	
			StringBuilder sqlQuery  = new StringBuilder();
			sqlQuery.append("insert into order_item (order_id, item_id, item_price, item_quantity) ");
			sqlQuery.append("values (?,?,?,?) ");
					
			ps = con.prepareStatement(sqlQuery.toString());	
			
			for(CartItem cartItem : cartItemList){
				int i=1;
				ps.setInt(i++, orderId);
				ps.setInt(i++, cartItem.getItemId());
				ps.setDouble(i++, cartItem.getPrice());	
				ps.setInt(i++, cartItem.getItemQuantity());			
				System.out.println("Executing query: \n"+ps.toString());			
				ps.executeUpdate();		
			}	
			
		} catch (SQLException sqle) {			
			System.err.println("Caught SQLException " + sqle.getMessage());		
			status = 1;
		} catch (Exception e) {			
			System.err.println("Caught Exception " + e);
			status = 1;
		} finally {	  
			try {
				if(ps != null) {
					ps.close();
				}
			} catch(SQLException se) {
			//do nothing
			}
			AppDatabaseConnection.getInstance().closeConnection(con);			
		}
		return status;
	}
	
	//substract item quantity after order
	public int substractItemQuantity(List<CartItem> cartItemList){
		int status = 0;
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			
			con = AppDatabaseConnection.getInstance().getConnection();	
			StringBuilder sqlQuery  = new StringBuilder();
			sqlQuery.append("update item set item_quantity = (item_quantity - ?) where item_id = ? ");
					
			ps = con.prepareStatement(sqlQuery.toString());	
			
			for(CartItem cartItem : cartItemList){
				int i=1;
				ps.setInt(i++, cartItem.getItemQuantity());	
				ps.setInt(i++, cartItem.getItemId());
						
				System.out.println("Executing query: \n"+ps.toString());			
				ps.executeUpdate();		
			}	
			
		} catch (SQLException sqle) {			
			System.err.println("Caught SQLException " + sqle.getMessage());		
			status = 1;
		} catch (Exception e) {			
			System.err.println("Caught Exception " + e);
			status = 1;
		} finally {	  
			try {
				if(ps != null) {
					ps.close();
				}
			} catch(SQLException se) {
			//do nothing
			}
			AppDatabaseConnection.getInstance().closeConnection(con);			
		}
		return status;
	}

	public List<Order> getUserOrderList(String fromDateTime, String toDateTime, int userId){
		
		List<Order> orderList = new ArrayList<Order>();
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			
			con = AppDatabaseConnection.getInstance().getConnection();	
			StringBuilder sqlQuery  = new StringBuilder();
			sqlQuery.append("select order_id, user_id, ship_first_name, ship_last_name, ship_address1, ship_address2, ship_city, ");
			sqlQuery.append("ship_state_id, ship_country, ship_charge, order_amout, order_status, order_date_time ");
			sqlQuery.append("from orders ");
			sqlQuery.append("where order_date_time between ? and ? ");
			sqlQuery.append("and user_id=? ");
			sqlQuery.append("order by order_date_time ");
			
								
			ps = con.prepareStatement(sqlQuery.toString());		
			ps.setTimestamp(1, Utilities.convertFormattedStringToSqlTimeStamp(
					Utilities.formatDateString(fromDateTime, "MM/dd/yyyy HH:mm:ss", "yyyy-MM-dd HH:mm:ss")));
			ps.setTimestamp(2, Utilities.convertFormattedStringToSqlTimeStamp(
					Utilities.formatDateString(toDateTime, "MM/dd/yyyy HH:mm:ss", "yyyy-MM-dd HH:mm:ss")));
			ps.setInt(3, userId);
			
			System.out.println("Executing query: \n"+ps.toString());
			
			rs = ps.executeQuery();
			
			while(rs.next()){
				Order order = new Order();
				order.setOrderId(rs.getInt("order_id"));
				order.setUserId(rs.getInt("user_id"));
				order.setShipFirstName(rs.getString("ship_first_name"));
				order.setShipLastName(rs.getString("ship_last_name"));
				order.setShipAddress1(rs.getString("ship_address1"));
				order.setShipAddress2(rs.getString("ship_address2"));
				order.setShipCity(rs.getString("ship_city"));
				order.setShipStateId(rs.getString("ship_state_id"));
				order.setShipCountry(rs.getString("ship_country"));
				order.setShipCharge(rs.getDouble("ship_charge"));
				order.setOrderAmount(rs.getDouble("order_amout"));
				order.setOrderStatus(rs.getString("order_status"));
				order.setOrderDateTime(Utilities.formatDateString(rs.getString("order_date_time"), "yyyy-MM-dd HH:mm:ss", "MM/dd/yyyy HH:mm:ss"));
				
				orderList.add(order);
			}		
			
			
		} catch (SQLException sqle) {			
			System.err.println("Caught SQLException " + sqle.getMessage());			
		} catch (Exception e) {			
			System.err.println("Caught Exception " + e);
		} finally {	  
			try {
				if(rs != null) {			
					rs.close();
				}
				if(ps != null) {
					ps.close();
				}
			} catch(SQLException se) {
			//do nothing
			}
			AppDatabaseConnection.getInstance().closeConnection(con);			
		}
		return orderList;
	}
}

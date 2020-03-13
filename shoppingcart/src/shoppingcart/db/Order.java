package shoppingcart.db;

public class Order {
	
	private int orderId;
	private int userId;
	private String shipFirstName;
	private String shipLastName;
	private String shipAddress1;
	private String shipAddress2;
	private String shipCity;
	private String shipStateId;
	private String shipCountry;
	
	private double shipCharge;
	private double orderAmount;
	private String orderStatus;
	private String orderDateTime;
	public int getOrderId() {
		return orderId;
	}
	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getShipFirstName() {
		return shipFirstName;
	}
	public void setShipFirstName(String shipFirstName) {
		this.shipFirstName = shipFirstName;
	}
	public String getShipLastName() {
		return shipLastName;
	}
	public void setShipLastName(String shipLastName) {
		this.shipLastName = shipLastName;
	}
	public String getShipAddress1() {
		return shipAddress1;
	}
	public void setShipAddress1(String shipAddress1) {
		this.shipAddress1 = shipAddress1;
	}
	public String getShipAddress2() {
		return shipAddress2;
	}
	public void setShipAddress2(String shipAddress2) {
		this.shipAddress2 = shipAddress2;
	}
	public String getShipCity() {
		return shipCity;
	}
	public void setShipCity(String shipCity) {
		this.shipCity = shipCity;
	}
	public String getShipStateId() {
		return shipStateId;
	}
	public void setShipStateId(String shipStateId) {
		this.shipStateId = shipStateId;
	}
	public String getShipCountry() {
		return shipCountry;
	}
	public void setShipCountry(String shipCountry) {
		this.shipCountry = shipCountry;
	}
	public double getShipCharge() {
		return shipCharge;
	}
	public void setShipCharge(double shipCharge) {
		this.shipCharge = shipCharge;
	}
	public double getOrderAmount() {
		return orderAmount;
	}
	public void setOrderAmount(double orderAmount) {
		this.orderAmount = orderAmount;
	}
	public String getOrderStatus() {
		return orderStatus;
	}
	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
	}
	public String getOrderDateTime() {
		return orderDateTime;
	}
	public void setOrderDateTime(String orderDateTime) {
		this.orderDateTime = orderDateTime;
	}

	
}

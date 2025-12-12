package Models;

public class orderModel {
	private String order_id;
	private String email;
	private String title;
	private String quantity;
	private String price;
	private String status;
	private String date;
	
	public orderModel() {}

	public orderModel(String order_id, String email, String title, String quantity, String price, String status,
			String date) {
		this.order_id = order_id;
		this.email = email;
		this.title = title;
		this.quantity = quantity;
		this.price = price;
		this.status = status;
		this.date = date;
	}
	
	
	
	

	public String getOrder_id() {
		return order_id;
	}

	public String getEmail() {
		return email;
	}

	public String getTitle() {
		return title;
	}

	public String getQuantity() {
		return quantity;
	}

	public String getPrice() {
		return price;
	}

	public String getStatus() {
		return status;
	}

	public String getDate() {
		return date;
	}
	
	
	
	

	public void setOrder_id(String order_id) {
		this.order_id = order_id;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public void setQuantity(String quantity) {
		this.quantity = quantity;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public void setDate(String date) {
		this.date = date;
	}
	
	
}

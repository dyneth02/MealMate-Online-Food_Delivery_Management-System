package Models;

public class guestUserModel {
	protected int user_id;
	protected String username;
	protected String password;
	protected String email;
	protected String phone_number;
	protected String address;
	
	public guestUserModel() {}
	
	public guestUserModel(String username, String password, String email, String phone_number) {
		this.username = username;
		this.password = password;
		this.email = email;
		this.phone_number = phone_number;
	}
	
	public guestUserModel(String username, String password, String email, String phone_number, String address) {
		this.username = username;
		this.password = password;
		this.email = email;
		this.phone_number = phone_number;
		this.address = address;
	}

	public int getUser_id() {
		return user_id;
	}

	public String getUsername() {
		return username;
	}

	public String getPassword() {
		return password;
	}

	public String getEmail() {
		return email;
	}

	public String getPhone_number() {
		return phone_number;
	}

	public String getAddress() {
		return address;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public void setPhone_number(String phone_number) {
		this.phone_number = phone_number;
	}

	public void setAddress(String address) {
		this.address = address;
	}
	
	
}

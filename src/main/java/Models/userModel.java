package Models;


public class userModel extends guestUserModel{
	
	public userModel() {}
	
	public userModel(String username, String password, String email, String phone_number, String address) {
		super.username = username;
		super.password = password;
		super.email = email;
		super.phone_number = phone_number;
		super.address = address;
	}
	
    // Getters
    public int getUserId() {
        return super.user_id;
    }

    public String getUsername() {
        return super.username;
    }

    public String getPassword() {
        return super.password;
    }

    public String getEmail() {
        return super.email;
    }

    public String getContact() {
        return super.phone_number;
    }

    public String getAddress() {
        return super.address;
    }

    // Setters
    public void setUserId(int user_id) {
        super.user_id = user_id;
    }

    public void setUsername(String username) {
        super.username = username;
    }

    public void setPassword(String password) {
        super.password = password;
    }

    public void setEmail(String email) {
        super.email = email;
    }

    public void setContact(String phone_number) {
        super.phone_number = phone_number;
    }

    public void setAddress(String address) {
        super.address = address;
    }
}



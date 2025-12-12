package Models;

public class deliveryPersonModel extends guestUserModel{
	
	public deliveryPersonModel() {}
	
	public deliveryPersonModel(String username, String password, String email, String phone_number) {
		super.username = username;
		super.password = password;
		super.email = email;
		super.phone_number = phone_number;
	}
	
	// Getters
    public int getId() {
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

    
    // Setters
    public void setId(int id) {
        super.user_id = id;
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

}

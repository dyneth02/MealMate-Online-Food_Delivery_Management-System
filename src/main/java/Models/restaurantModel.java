package Models;

public class restaurantModel {
	private String rest_id;
	private int rest_admin_id;
	private String rest_title;
	private String rest_admin_email;
	private String rest_phone;
	private String rest_url;
	private String o_hr;
	private String c_hr;
	private String o_days;
	private String rest_address;
	private String rest_image;
	private String reg_date;
	
	public restaurantModel() {}
	
	
	public restaurantModel(String rest_id, int rest_admin_id, String rest_title, String rest_admin_email,
			String rest_phone, String rest_url, String o_hr, String c_hr, String o_days, String rest_address,
			String rest_image, String reg_date) {
		this.rest_id = rest_id;
		this.rest_admin_id = rest_admin_id;
		this.rest_title = rest_title;
		this.rest_admin_email = rest_admin_email;
		this.rest_phone = rest_phone;
		this.rest_url = rest_url;
		this.o_hr = o_hr;
		this.c_hr = c_hr;
		this.o_days = o_days;
		this.rest_address = rest_address;
		this.rest_image = rest_image;
		this.reg_date = reg_date;
	}


	public String getRest_id() {
		return rest_id;
	}


	public int getRest_admin_id() {
		return rest_admin_id;
	}


	public String getRest_title() {
		return rest_title;
	}


	public String getRest_admin_email() {
		return rest_admin_email;
	}


	public String getRest_phone() {
		return rest_phone;
	}


	public String getRest_url() {
		return rest_url;
	}


	public String getO_hr() {
		return o_hr;
	}


	public String getC_hr() {
		return c_hr;
	}


	public String getO_days() {
		return o_days;
	}


	public String getRest_address() {
		return rest_address;
	}


	public String getRest_image() {
		return rest_image;
	}


	public String getReg_date() {
		return reg_date;
	}


	public void setRest_id(String rest_id) {
		this.rest_id = rest_id;
	}


	public void setRest_admin_id(int rest_admin_id) {
		this.rest_admin_id = rest_admin_id;
	}


	public void setRest_title(String rest_title) {
		this.rest_title = rest_title;
	}


	public void setRest_admin_email(String rest_admin_email) {
		this.rest_admin_email = rest_admin_email;
	}


	public void setRest_phone(String rest_phone) {
		this.rest_phone = rest_phone;
	}


	public void setRest_url(String rest_url) {
		this.rest_url = rest_url;
	}


	public void setO_hr(String o_hr) {
		this.o_hr = o_hr;
	}


	public void setC_hr(String c_hr) {
		this.c_hr = c_hr;
	}


	public void setO_days(String o_days) {
		this.o_days = o_days;
	}


	public void setRest_address(String rest_address) {
		this.rest_address = rest_address;
	}


	public void setRest_image(String rest_image) {
		this.rest_image = rest_image;
	}


	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	
	
	
	

}

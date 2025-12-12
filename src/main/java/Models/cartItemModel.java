package Models;

public class cartItemModel {
    private Integer did;
    private Integer rid;
    private String uemail;
    private String dtitle;
    private Double uprice;
    private Integer qty;
    private Double tprice;
    
    public cartItemModel(Integer did, Integer rid, String uemail, String dtitle, Double uprice, Integer qty,
			Double tprice) {
		super();
		this.did = did;
		this.rid = rid;
		this.uemail = uemail;
		this.dtitle = dtitle;
		this.uprice = uprice;
		this.qty = qty;
		this.tprice = tprice;
	}

    
	public Integer getDid() {
		return did;
	}

	public Integer getRid() {
		return rid;
	}

	public String getUemail() {
		return uemail;
	}

	public String getDtitle() {
		return dtitle;
	}

	public Double getUprice() {
		return uprice;
	}

	public Integer getQty() {
		return qty;
	}

	public Double getTprice() {
		return tprice;
	}





	public void setDid(Integer did) {
		this.did = did;
	}

	public void setRid(Integer rid) {
		this.rid = rid;
	}

	public void setUemail(String uemail) {
		this.uemail = uemail;
	}

	public void setDtitle(String dtitle) {
		this.dtitle = dtitle;
	}

	public void setUprice(Double uprice) {
		this.uprice = uprice;
	}

	public void setQty(Integer qty) {
		this.qty = qty;
	}

	public void setTprice(Double tprice) {
		this.tprice = tprice;
	}



	public void increaseQuantity(Integer amount) { 
    	this.qty += amount; 
	}
}


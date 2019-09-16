package bean;

public class Buy {

	private int bid;
	private int yid;
	private String yname;
	private String unit;
	private int num;
	private float price;
	public int getBid() {
		return bid;
	}
	public void setBid(int bid) {
		this.bid = bid;
	}
	public int getYid() {
		return yid;
	}
	public void setYid(int yid) {
		this.yid = yid;
	}
	public String getYname() {
		return yname;
	}
	public void setYname(String yname) {
		this.yname = yname;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public float getPrice() {
		return price;
	}
	public void setPrice(float price) {
		this.price = price;
	}
	@Override
	public String toString() {
		return "Buy [bid=" + bid + ", yid=" + yid + ", yname=" + yname + ", unit=" + unit + ", num=" + num + ", price="
				+ price + "]";
	}
	
}

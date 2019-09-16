package bean;

public class Chufangdetail {

	private int cdid;
	private int cid;
	private int yid;
	private String yname;
	private String unit;
	private int num;
	private float price;

	public int getCdid() {
		return cdid;
	}

	public void setCdid(int cdid) {
		this.cdid = cdid;
	}

	public int getCid() {
		return cid;
	}

	public void setCid(int cid) {
		this.cid = cid;
	}

	public int getYid() {
		return yid;
	}

	public void setYid(int yid) {
		this.yid = yid;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public String getYname() {
		return yname;
	}

	public void setYname(String yname) {
		this.yname = yname;
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
		return "Chufangdetail [cdid=" + cdid + ", cid=" + cid + ", yid=" + yid + ", yname=" + yname + ", unit=" + unit
				+ ", num=" + num + ", price=" + price + "]";
	}


}

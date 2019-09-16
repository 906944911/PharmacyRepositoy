package bean;

import java.sql.Date;

public class Yaopin {

	private int yid;
	private String yname ; 
	private String yunit ; 
	private int ynum ; 
	private float ystockprice ; 
	private float yprice ; 
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
	public String getYunit() {
		return yunit;
	}
	public void setYunit(String yunit) {
		this.yunit = yunit;
	}
	public int getYnum() {
		return ynum;
	}
	public void setYnum(int ynum) {
		this.ynum = ynum;
	}
	public float getYstockprice() {
		return ystockprice;
	}
	public void setYstockprice(float ystockprice) {
		this.ystockprice = ystockprice;
	}
	public float getYprice() {
		return yprice;
	}
	public void setYprice(float yprice) {
		this.yprice = yprice;
	}
	@Override
	public String toString() {
		return "Yaopin [yid=" + yid + ", yname=" + yname + ", yunit=" + yunit + ", ynum=" + ynum + ", ystockprice="
				+ ystockprice + ", yprice=" + yprice + "]";
	}
	
	
}

package bean;

import java.sql.Date;

public class Chufang {

	private int cid;
	private String sickname;
	private String doctorname;
	private String yaojishiname;
	private Date chufangdate;
	private Date peiyaodate;
	private String ispeiyao;
	public int getCid() {
		return cid;
	}
	public void setCid(int cid) {
		this.cid = cid;
	}
	public String getSickname() {
		return sickname;
	}
	public void setSickname(String sickname) {
		this.sickname = sickname;
	}
	public String getDoctorname() {
		return doctorname;
	}
	public void setDoctorname(String doctorname) {
		this.doctorname = doctorname;
	}
	public String getYaojishiname() {
		return yaojishiname;
	}
	public void setYaojishiname(String yaojishiname) {
		this.yaojishiname = yaojishiname;
	}
	public Date getChufangdate() {
		return chufangdate;
	}
	public void setChufangdate(Date chufangdate) {
		this.chufangdate = chufangdate;
	}
	public Date getPeiyaodate() {
		return peiyaodate;
	}
	public void setPeiyaodate(Date peiyaodate) {
		this.peiyaodate = peiyaodate;
	}
	public String getIspeiyao() {
		return ispeiyao;
	}
	public void setIspeiyao(String ispeiyao) {
		this.ispeiyao = ispeiyao;
	}
	@Override
	public String toString() {
		return "Chufang [cid=" + cid + ", sickname=" + sickname + ", doctorname=" + doctorname + ", yaojishiname="
				+ yaojishiname + ", chufangdate=" + chufangdate + ", peiyaodate=" + peiyaodate + ", ispeiyao="
				+ ispeiyao + "]";
	}
	
}

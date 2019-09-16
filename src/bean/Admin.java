package bean;

public class Admin {

	private int aid;
	private String aname;
	private String apwd;
	private String atelephone;
	private String atype;
	public int getAid() {
		return aid;
	}
	public void setAid(int aid) {
		this.aid = aid;
	}
	public String getAname() {
		return aname;
	}
	public void setAname(String aname) {
		this.aname = aname;
	}
	public String getApwd() {
		return apwd;
	}
	public void setApwd(String apwd) {
		this.apwd = apwd;
	}
	public String getAtelephone() {
		return atelephone;
	}
	public void setAtelephone(String atelephone) {
		this.atelephone = atelephone;
	}
	public String getAtype() {
		return atype;
	}
	public void setAtype(String atype) {
		this.atype = atype;
	}
	@Override
	public String toString() {
		return "Admin [aid=" + aid + ", aname=" + aname + ", apwd=" + apwd + ", atelephone=" + atelephone + ", atype="
				+ atype + "]";
	}
	
}

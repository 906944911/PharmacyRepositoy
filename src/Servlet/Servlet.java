package Servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import bean.Admin;
import bean.Buy;
import bean.Chufang;
import bean.Chufangdetail;
import bean.Yaopin;
import util.BeanUtils;
import util.DBHelper;

@WebServlet("/Servlet")
public class Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		String op = request.getParameter("op");

		if ("login".equals(op)) {
			Admin a = BeanUtils.toBean(request, new Admin());
			String sql = "select * from admin where aname=? and apwd=?";
			List<Admin> admin = DBHelper.find(sql, Admin.class, a.getAname(), a.getApwd());

			Map<String, Object> map = new HashMap<String, Object>();
			if (!admin.isEmpty()) {
				request.getSession().setAttribute("aid", admin.get(0).getAid());
				request.getSession().setAttribute("aname", admin.get(0).getAname());
				request.getSession().setAttribute("atype", admin.get(0).getAtype());
				request.getSession().setAttribute("atelephone", admin.get(0).getAtelephone());
				map.put("data", 1);
			} else {
				map.put("data", 0);
			}
			// 输出数据到页面
			writerPrinter(map, response);
		} else if ("zhuxiao".equals(op)) {
			// 注销，使session失效
			System.out.println("====注销======");
			request.getSession().invalidate();
			response.sendRedirect("login.jsp");

		} else if ("queryCommodity".equals(op)) {
			Yaopin y = BeanUtils.toBean(request, new Yaopin());

			String sql = "select * from yaopin where 1=1 ";
			List<Object> params = new ArrayList<Object>();
			// 验证是否为空，以免报错
			if (y != null) {
				// 判断商品名
				if (y.getYname() != null && y.getYname().trim().length() > 0) {
					sql += " and yname like  ?";
					params.add("%" + y.getYname() + "%");
				}
			}
			List<Yaopin> yao = DBHelper.find(sql, Yaopin.class, params);
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("rows", yao);
			writerPrinter(map, response);

		}else if("addYaopin".equals(op)){
			Yaopin c = BeanUtils.toBean(request, new Yaopin());
			Map<String, Object> map = new HashMap<String, Object>();
			c.setYstockprice(Float.parseFloat(request.getParameter("ystockprice")));
			c.setYprice(Float.parseFloat(request.getParameter("yprice")));
			String sql = "insert into yaopin(yname,yunit,ystockprice,yprice) values(?,?,?,?)";
			int result = DBHelper.doInsert(sql, c.getYname(),c.getYunit(),c.getYstockprice(),c.getYprice());
			if(result>0){
				map.put("code", 1);
				map.put("data", "新增药品成功");
			}else{
				map.put("code", 0);
				map.put("data", "新增药品失败，请与管理员联系");
			}
			writerPrinter(map, response);
		}else if("InventoryYaopin".equals(op)){
			Map<String, Object> map = new HashMap<String, Object>();
			int yid = Integer.parseInt(request.getParameter("yid"));
			int addnum = Integer.parseInt(request.getParameter("addnum"));
			String sql = "update yaopin set ynum=ynum+? where yid=?";
			int result = DBHelper.doUpdate(sql, addnum,yid);
			if(result>0){
				map.put("code", 1);
				map.put("data", "添加库存成功");
			}else{
				map.put("code", 0);
				map.put("data", "添加库存失败");
			}
			writerPrinter(map, response);
			
		} else if ("updateCommodity".equals(op)) {
			Yaopin c = BeanUtils.toBean(request, new Yaopin());
			Map<String, Object> map = new HashMap<String, Object>();
			int yid = Integer.parseInt(request.getParameter("yid"));
			float yprice = Float.parseFloat(request.getParameter("yprice"));
			c.setYid(yid);
			c.setYprice(yprice);

			String sql = "update yaopin set yname=?,yprice=?,yunit=? where yid=?";
			int result = DBHelper.doUpdate(sql, c.getYname(), c.getYprice(), c.getYunit(), c.getYid());
			if (result > 0) {
				map.put("data", 1);
			} else {
				map.put("data", 0);
			}
			writerPrinter(map, response);
		} else if ("addbuy".equals(op)) {
			Buy b = BeanUtils.toBean(request, new Buy());
			Map<String, Object> map = new HashMap<String, Object>();
			int num = Integer.parseInt(request.getParameter("num"));
			int yid = Integer.parseInt(request.getParameter("yid"));
			float price = Float.parseFloat(request.getParameter("price"));
			b.setNum(num);
			b.setPrice(price);
			String sql = "insert into buy(yid,yname,unit,num,price) values(?,?,?,?,?)";
			int result = DBHelper.doInsert(sql, yid, b.getYname(), b.getUnit(), b.getNum(), b.getPrice());
			if (result > 0) {
				map.put("data", 1);
			} else {
				map.put("data", 0);
			}
			writerPrinter(map, response);
		} else if ("addorder".equals(op)) {
			Map<String, Object> map = new HashMap<String, Object>();
			float mount = Float.parseFloat(request.getParameter("mount"));
			String sickname = request.getParameter("sickname");
			String doctorname = (String) request.getSession().getAttribute("aname");
			java.util.Date Date = new Date();
			java.sql.Date sqlDate = new java.sql.Date(Date.getTime());
			// 加入处方
			String sql1 = "insert into chufang(sickname,doctorname,chufangdate,mount) values(?,?,?,?)";
			int cid = DBHelper.doInsert(sql1, sickname, doctorname, sqlDate, mount);
			// 加入处方详情
			String sql2 = "select * from buy";
			List<Buy> buy = DBHelper.find(sql2, Buy.class);
			String sql3 = "insert into chufangdetail(cid,yid,yname,unit,num,price) values(?,?,?,?,?,?)";
			int cfid = 1;
			for (int i = 0; i < buy.size(); i++) {
				cfid = DBHelper.doInsert(sql3, cid, buy.get(i).getYid(), buy.get(i).getYname(), buy.get(i).getUnit(),
						buy.get(i).getNum(), buy.get(i).getPrice());
				if (cfid <= 0) {
					break;
				}
			}
			// 删除buy
			String sql4 = "delete from buy";
			DBHelper.doUpdate(sql4);
			if (cid > 0 && cfid > 0) {
				map.put("data", "开处方成功");
			} else {
				map.put("data", "开处方失败，请与管理员联系...");
			}
			writerPrinter(map, response);
		} else if ("querybuy".equals(op)) {
			Map<String, Object> map = new HashMap<String, Object>();
			String sql = "select * from buy";
			List<Buy> buy = DBHelper.find(sql, Buy.class);
			map.put("rows", buy);
			writerPrinter(map, response);
		} else if ("deleteBuy".equals(op)) {
			Map<String, Object> map = new HashMap<String, Object>();
			String sql = "delete from buy";
			int result = DBHelper.doUpdate(sql);
			if (result > 0) {
				map.put("code", 1);
			} else {
				map.put("code", 0);
			}
			writerPrinter(map, response);
		} else if ("accomplish".equals(op)) {
			Map<String, Object> map = new HashMap<String, Object>();
			int cid = Integer.parseInt(request.getParameter("cid"));
			String yaojishiname = (String) request.getSession().getAttribute("aname");
			java.util.Date Date = new Date();
			java.sql.Date sqlDate = new java.sql.Date(Date.getTime());
			String sql1 = "update chufang set yaojishiname=?,peiyaodate=?,ispeiyao='是'";
			int result = DBHelper.doUpdate(sql1, yaojishiname, sqlDate);
			if (result > 0) {
				String sql2 = "select * from chufangdetail where cid = ?";
				String sql3 = "update yaopin set ynum=ynum-? where yid=? ";
				List<Chufangdetail> chufangdetail = DBHelper.find(sql2, Chufangdetail.class, cid);
				for (int i = 0; i < chufangdetail.size(); i++) {
					DBHelper.doUpdate(sql3, chufangdetail.get(i).getNum(), chufangdetail.get(i).getYid());
				}
				map.put("code", 1);
			} else {
				map.put("code", 0);
			}
			writerPrinter(map, response);
		} else if ("queryDeal".equals(op)) {
			Map<String, Object> map = new HashMap<String, Object>();
			String sql = "select * from chufang";
			List<Chufang> list = DBHelper.find(sql, Chufang.class);
			map.put("rows", list);
			writerPrinter(map, response);
		} else if ("lookchufangdetail".equals(op)) {
			int cid = Integer.parseInt(request.getParameter("cid"));
			String sql = "select * from chufangdetail where cid = ?";
			List<Chufangdetail> chufangList = DBHelper.find(sql, Chufangdetail.class, cid);
			request.setAttribute("chufangList", chufangList);
			request.getRequestDispatcher("chufangdetail.jsp").forward(request, response);
		} else if ("queryAdmin".equals(op)) {
			String sql = "select * from admin where 1=1";
			Admin a = BeanUtils.toBean(request, new Admin());
			Map<String, Object> map = new HashMap<String, Object>();
			List<Object> params = new ArrayList<Object>();
			if (a != null) {
				// 判断商品名
				if (a.getAname() != null && a.getAname().trim().length() > 0) {
					sql += " and aname like  ?";
					params.add("%" + a.getAname() + "%");
				}
				if (a.getAtype() != null && a.getAtype().trim().length() > 0) {
					sql += " and atype like  ?";
					params.add("%" + a.getAtype() + "%");
				}
			}
			List<Admin> list = DBHelper.find(sql, Admin.class, params);
			map.put("rows", list);
			writerPrinter(map, response);
		} else if ("addAdmin".equals(op)) {
			Admin a = BeanUtils.toBean(request, new Admin());
			Map<String, Object> map = new HashMap<String, Object>();
			// 随机生成密码
			String newPwd = "";
			Random r = new Random();
			for (int i = 0; i < 3; i++) {
				newPwd += r.nextInt(10) + "";
			}
			String sql = "insert into admin(aname,apwd,atelephone,atype) values(?,?,?,?)";
			int result = DBHelper.doInsert(  sql, a.getAname(), newPwd, a.getAtelephone(), a.getAtype()  );
			if (result > 0) {
				map.put("code", 1);
				map.put("data", a.getAtype() + " 添加成功！姓名：" + a.getAname() + " 初始密码：" + newPwd);
			} else {
				map.put("code", 0);
				map.put("data", "员工添加失败，请与管理员联系...");
			}
			writerPrinter(map, response);
		} else if ("updateAdmin".equals(op)) {
			Admin a = BeanUtils.toBean(request, new Admin());
			Map<String, Object> map = new HashMap<String, Object>();
			int aid = Integer.parseInt(request.getParameter("aid"));
			String sql = "update admin set atype=? , atelephone=? where aid = ?";
			int result = DBHelper.doUpdate(sql, a.getAtype(),a.getAtelephone(),aid);
			if (result > 0) {
				map.put("code", 1);
				map.put("data", "修改成功");
			} else {
				map.put("code", 0);
				map.put("data", "修改失败，请与管理员联系...");
			}
			writerPrinter(map, response);
		}else if("deleteAdmin".equals(op)){
			Admin a = BeanUtils.toBean(request, new Admin());
			Map<String, Object> map = new HashMap<String, Object>();
			int aid = Integer.parseInt(request.getParameter("aid"));
			String sql = "delete from admin where aid = ?";
			int result = DBHelper.doUpdate(sql, aid);
			if (result > 0) {
				map.put("code", 1);
				map.put("data", "删除成功");
			} else {
				map.put("code", 0);
				map.put("data", "删除失败，请与管理员联系...");
			}
			writerPrinter(map, response);
		}else if ("resetPwd".equals(op)) {
			int aid = Integer.parseInt(request.getParameter("aid"));
			Map<String, Object> map = new HashMap<String, Object>();
			String newPwd = "";
			Random r = new Random();
			for (int i = 0; i < 3; i++) {
				newPwd += r.nextInt(10) + "";
			}
			String sql ="update admin set apwd = ? where aid =?";
			int result = DBHelper.doUpdate(sql,newPwd,aid);
			if(result>0){
				map.put("code", 1);
				map.put("data", "新密码：" + newPwd);
			}else{
				map.put("code", 0);
				map.put("data", "修改密码成功");
			}
			writerPrinter(map, response);
		}
	}

	public void writerPrinter(Map<String, Object> map, HttpServletResponse response) {
		Gson gson = new Gson();
		String s = gson.toJson(map);
		// 输出到页面
		try {
			response.getWriter().println(s);
		} catch (IOException e) {
			System.out.println("===========返回json格式数据错误==================");
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}

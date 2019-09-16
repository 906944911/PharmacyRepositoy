package util;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Collection;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.PageContext;

import com.jspsmart.upload.File;
import com.jspsmart.upload.Files;
import com.jspsmart.upload.Request;
import com.jspsmart.upload.SmartUpload;
import com.jspsmart.upload.SmartUploadException;

public class UploadUtil {
	//定义文件上传路径
	private String PATH = "images";
	//定义允许上传的文件
	private String ALLOWED = "jpg,png,gif,txt";
	//定义不允许上传的文件
	private String DENDED = "exe,bat,js";
	//定义单个文件的大小
	private int SINGLESIZE = 5*1024*1024;
	//定义总大小
	private int TOTALMAXSIZE = 20*1024*1024;
	public UploadUtil(String pATH, String aLLOWED, String dENDED, int sINGLESIZE, int tOTALMAXSIZE) {
		super();
		PATH = pATH;
		ALLOWED = aLLOWED;
		DENDED = dENDED;
		SINGLESIZE = sINGLESIZE;
		TOTALMAXSIZE = tOTALMAXSIZE;
	}
	public UploadUtil() {
		super();
	}
	
	//文件上传的封装    pageContext是属于jsp内置对象的，在网页里面可以直接得到，但是，在java代码里面，是得不到的
	public Map<String,String> uploadFiles(ServletConfig servletconfig,
			HttpServletRequest httpservletrequest,
			HttpServletResponse httpservletresponse) throws ServletException, IOException, SQLException, SmartUploadException{
		SmartUpload su = new SmartUpload();
		Map<String,String> params = new HashMap<String,String>();
		//初始化
		su.initialize(servletconfig, httpservletrequest, httpservletresponse);
		//设置参数
		su.setAllowedFilesList(ALLOWED);
		su.setDeniedFilesList(DENDED);
		su.setCharset("utf-8");
		su.setMaxFileSize(SINGLESIZE);
		su.setTotalMaxFileSize(TOTALMAXSIZE);
		//开始上传
		su.upload();
		//开始处理我们需要的值
		Request request = su.getRequest();
		Enumeration et = request.getParameterNames();
		String str = "";
		//循环取出值
		while(et.hasMoreElements()){
			//先得到键
			str = (String) et.nextElement();
			//通过键得到值
			params.put(str, request.getParameter(str));
		}
		//开始上传文件
		if(su.getFiles()!=null && su.getFiles().getCount()>0){
			//得到上传的文件
			Files fs = su.getFiles();
			//得到文件的所有信息
			Collection<File> col = fs.getCollection();
			int i = 1;
			for(File f : col){
				if(!f.isMissing()){    //判断文件在上传过程中是否丢失
					String fname = PATH + "/" + new Date().getTime() + new Random().nextInt(10000) + "." + f.getFileExt();
					System.out.println(fname);
					f.saveAs(fname);
					//Map  如果分键相同，值会被覆盖      为了防止键相同
					params.put("picPath"+i, fname);
					i++;
				}
			}
		}
		
		return params;
	}
}

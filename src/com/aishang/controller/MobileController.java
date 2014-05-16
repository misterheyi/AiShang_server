package com.aishang.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.aishang.db.DTOMain;
import com.aishang.db.bean.AdPicture;
import com.aishang.db.bean.AdVideo;
import com.aishang.db.bean.HairStyle;
import com.aishang.db.bean.Users;
import com.aishang.db.bean.Version;
import com.aishang.db.dao.AdPictureDAO;
import com.aishang.db.dao.AdVideoDAO;
import com.aishang.db.dao.HairStyleDAO;
import com.aishang.db.dao.UsersDAO;
import com.aishang.db.dao.VersionDAO;
import com.aishang.db.dto.AdVideoDTO;
import com.aishang.db.dto.HairStyleDTO;
import com.aishang.db.dto.LoginDTO;
import com.aishang.db.dto.PriceListDTO;
import com.aishang.db.dto.ScrollPictureDTO;
import com.aishang.manager.AdPictureManager;
import com.aishang.manager.AdVideoManager;
import com.aishang.vo.AdPictureVO;
import com.aishang.vo.AdVideoVO;
import com.alibaba.fastjson.JSON;

/**
 * 移动端的控制类
 * 
 * @author gavin
 * 
 */
public class MobileController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String pathInfo = request.getPathInfo();
		try {
			if ("/login".equals(pathInfo)) {
				String result = login(request, response);
				out.print(result);
			}
			if ("/adVideo".equals(pathInfo)) {
				String result = adVideo(request, response);
				out.print(result);
			}
			if ("/playAd".equals(pathInfo)) {
				String result = playAd(request, response);
				out.print(result);
			}
			if ("/adPictrue".equals(pathInfo)) {
				String result = adPictrue(request, response);
				out.print(result);
			}
			if ("/hairStyle".equals(pathInfo)) {
				String result = getHairStyle(request, response);
				out.print(result);
			}
			if ("/checkUpdate".equals(pathInfo)) {
				String result = checkUpdate(request, response);
				out.print(result);
			}
			if ("/scrollPicture".equals(pathInfo)) {
				String result = scrollPicture(request, response);
				out.print(result);
			}
			if ("/playScrollPicture".equals(pathInfo)){
				String result = playScrollPicture(request, response);
				out.print(result);
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			DTOMain dto = new DTOMain();
			dto.setStatus_msg("ClassNotFoundException");
			dto.setStatus_code(500);
			out.print(JSON.toJSONString(dto));
		} catch (SQLException e) {
			e.printStackTrace();
			DTOMain dto = new DTOMain();
			dto.setStatus_msg("SQLException");
			dto.setStatus_code(500);
			out.print(JSON.toJSONString(dto));
		}
		out.flush();
		out.close();
	}

	private synchronized String playScrollPicture(HttpServletRequest request,
			HttpServletResponse response) throws ClassNotFoundException, SQLException {
		DTOMain dto = new DTOMain();
		String id = request.getParameter("id");
		AdPictureDAO adPictureDAO = new AdPictureDAO();
		AdPicture adPicture = adPictureDAO.getById(Integer.parseInt(id));
		if (adPicture == null)
			throw new SQLException();
		adPictureDAO.modifyCount(adPicture.getAdPictureCount() + 1,adPicture.getAdPicture_id());

		dto.setStatus_code(200);
		dto.setStatus_msg("成功");
		return JSON.toJSONString(dto);
	}

	private String scrollPicture(HttpServletRequest request,
			HttpServletResponse response) throws ClassNotFoundException,
			SQLException {
		String id = request.getParameter("storeId");
		
		AdPictureManager adPictureManager = new AdPictureManager();
		List<AdPictureVO> ad = adPictureManager.getScollPicture(id);
		ScrollPictureDTO dto = new ScrollPictureDTO();
		dto.setAd(ad);
		
		return JSON.toJSONString(dto);
	}

	private String checkUpdate(HttpServletRequest request,
			HttpServletResponse response) throws ClassNotFoundException,
			SQLException {
		String version = request.getParameter("version");
		VersionDAO dao = new VersionDAO();
		Version v = dao.checkUpdate(version);
		return JSON.toJSONString(v);
	}

	private String getHairStyle(HttpServletRequest request,
			HttpServletResponse response) throws UnsupportedEncodingException,
			NumberFormatException, ClassNotFoundException, SQLException {
		String id = request.getParameter("storeId");
		String area = request.getParameter("area");
		if (area == null)
			area = "";
		String desc = request.getParameter("desc");
		if (desc == null)
			desc = "";
		String height = request.getParameter("height");
		if (height == null)
			height = "";
		String sex = request.getParameter("sex");
		if (sex == null)
			sex = "";
		String pageNow = request.getParameter("page");
		if (pageNow == null)
			pageNow = "1";

		HairStyleDAO hairStyleDAO = new HairStyleDAO();
		List<HairStyle> list = hairStyleDAO.getAllByGroup_LimitByUid(area,
				desc, height, sex, Integer.parseInt(pageNow), 20,
				Integer.valueOf(id));

		HairStyleDTO dto = new HairStyleDTO();
		dto.setHairStyles(list);
		return JSON.toJSONString(dto);
	}

	private String adPictrue(HttpServletRequest request,
			HttpServletResponse response) throws NumberFormatException,
			ClassNotFoundException, SQLException {
		int storeId = Integer.valueOf(request.getParameter("storeId"));
		UsersDAO usersDAO = new UsersDAO();
		List<Users> hairstylist = usersDAO.getUsersByStoreId(storeId);
		AdPictureDAO adPictureDAO = new AdPictureDAO();
		List<AdPicture> list = adPictureDAO.getAllByUid(storeId);
		List<AdPicture> ad1 = new ArrayList<AdPicture>();
		List<AdPicture> ad2 = new ArrayList<AdPicture>();
		List<AdPicture> ad3 = new ArrayList<AdPicture>();
		for (AdPicture adPicture : list) {
			switch (adPicture.getAdPictureGroup_id()) {
			case 1:
				ad1.add(adPicture);
				break;
			case 2:
				ad2.add(adPicture);
				break;
			case 3:
				ad3.add(adPicture);
				break;
			}
		}

		PriceListDTO dto = new PriceListDTO();
		dto.setAd1(ad1);
		dto.setAd2(ad2);
		dto.setAd3(ad3);
		dto.setHairstylist(hairstylist);
		return JSON.toJSONString(dto);
	}

	private String adVideo(HttpServletRequest request,
			HttpServletResponse response) throws NumberFormatException,
			ClassNotFoundException, SQLException {
		AdVideoDTO dto = new AdVideoDTO();
		String agentId = request.getParameter("agentId");
		String storeId = request.getParameter("storeId");
		System.out.println("agentId:"+agentId+",storeId:"+storeId);
		List<AdVideoVO> videos = new AdVideoManager().getAllByUid(Integer.valueOf(agentId),Integer.valueOf(storeId));
		dto.setVideos(videos);

		return JSON.toJSONString(dto);
	}

	private synchronized String playAd(HttpServletRequest request,
			HttpServletResponse response) throws NumberFormatException,
			ClassNotFoundException, SQLException {
		DTOMain dto = new DTOMain();
		String id = request.getParameter("id");
		AdVideoDAO adVideoDAO = new AdVideoDAO();
		AdVideo video = adVideoDAO.getById(Integer.parseInt(id));
		if (video == null)
			throw new SQLException();
		adVideoDAO.modifyCount(video.getAdVideo_count() + 1,
				video.getAdVideo_id());

		dto.setStatus_code(200);
		dto.setStatus_msg("成功");
		return JSON.toJSONString(dto);
	}

	private String login(HttpServletRequest request,
			HttpServletResponse response) throws ClassNotFoundException,
			SQLException {
		String email = request.getParameter("email");
		String pwd = request.getParameter("pwd");
		String imei = request.getParameter("imei");
		UsersDAO usersDAO = new UsersDAO();
		LoginDTO dto = new LoginDTO();
		Users users = usersDAO.findUser(email, pwd, imei);
		if (users != null) {
			if (users.getUserGroup_id() == 4) {
				Users store = usersDAO.getStoreByStylist(users.getUsers_id());
				Users agent = usersDAO.getStoreByStylist(store.getUsers_id());
				dto.setStatus_msg("登录成功");
				dto.setStatus_code(200);
				dto.setHairstylist(users);
				dto.setAgent(agent);
				dto.setStore(store);
			} else {
				dto.setStatus_msg("此用户不是发型师！");
				dto.setStatus_code(500);
			}
		} else {
			dto.setStatus_msg("登录失败");
			dto.setStatus_code(500);
		}
		return JSON.toJSONString(dto);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}

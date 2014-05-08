package com.aishang.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.disk.DiskFileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.util.Streams;

import com.aishang.db.bean.AdPicture;
import com.aishang.db.bean.AdVideo;
import com.aishang.db.bean.HairStyle;
import com.aishang.db.bean.MarkHairStyle;
import com.aishang.db.bean.UserRelation;
import com.aishang.db.bean.Users;
import com.aishang.db.bean.Version;
import com.aishang.db.dao.AdPictureDAO;
import com.aishang.db.dao.AdVideoDAO;
import com.aishang.db.dao.HairStyleDAO;
import com.aishang.db.dao.MarkHairStyleDAO;
import com.aishang.db.dao.UserRelationDAO;
import com.aishang.db.dao.UsersDAO;
import com.aishang.db.dao.VersionDAO;
import com.aishang.exception.MyException;
import com.aishang.manager.FileManager;
import com.aishang.manager.FileManager.Status;
import com.aishang.manager.PermitManager;
import com.common.utils.UUIDUtils;

/**
 * Web端的控制类
 * 
 * @author gavin
 * 
 */
public class AdminController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private String basePath;

	private Users own;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		getBasePath(request);
		own = (Users) request.getSession().getAttribute("USER");
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		response.setDateHeader("Expires", -1);
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		String pathInfo = request.getPathInfo();
		try {
			if ("/login".equals(pathInfo)) {
				login(request, response);
			}
			if ("/logout".equals(pathInfo)) {
				logout(request, response);
			}
			if ("/addUser1".equals(pathInfo)) {
				addUser1(request, response);
				response.sendRedirect(basePath + "admin/users/users_list.jsp");
			}
			if ("/addUser2".equals(pathInfo)) {
				// addUser2(request, response);
				addUser2_2(request, response);
				response.sendRedirect(basePath + "admin/users/users_list.jsp");
			}
			if ("/deleteUser".equals(pathInfo)) {
				deleteUser(request, response);
				response.sendRedirect(basePath + "admin/users/users_list.jsp");
			}
			if ("/modifyUser".equals(pathInfo)) {
				modifyUser(request, response);
				response.sendRedirect(basePath + "admin/users/users_list.jsp");
			}
			if ("/modifyUserFace".equals(pathInfo)) {
				modifyUserFace(request, response);
				response.sendRedirect(basePath + "admin/index.jsp");
			}
			if ("/uploadPicture".equals(pathInfo)) {
				savePicture(request, response);
				response.sendRedirect(basePath
						+ "admin/ad/adPicture_list.jsp?show=" + show);
			}
			if ("/deletePicture".equals(pathInfo)) {
				deletePicture(request, response);
				response.sendRedirect(basePath + "admin/ad/adPicture_list.jsp");
			}
			if ("/uploadVideo".equals(pathInfo)) {
				saveVideo(request, response);
				response.sendRedirect(basePath + "admin/ad/adVideo_list.jsp");
			}
			if ("/deleteVideo".equals(pathInfo)) {
				deleteVideo(request, response);
				response.sendRedirect(basePath + "admin/ad/adVideo_list.jsp");
			}
			if ("/uploadHairStyle".equals(pathInfo)) {
				uploadHairStyle(request, response);
				response.sendRedirect(basePath
						+ "admin/hairstyle/hairstyle_me.jsp");
			}
			if ("/modifyHairStyle".equals(pathInfo)) {
				modifyHairStyle(request, response);
				response.sendRedirect(basePath
						+ "admin/hairstyle/hairstyle_me.jsp");
			}
			if ("/deleteHairStyle".equals(pathInfo)) {
				deleteHairStyle(request, response);
				response.sendRedirect(basePath
						+ "admin/hairstyle/hairstyle_me.jsp");
			}
			if ("/markHairStyle".equals(pathInfo)) {
				markHairStyle(request, response);
				response.sendRedirect(basePath
						+ "admin/hairstyle/hairstyle_mark.jsp");
			}
			if ("/unmarkHairStyle".equals(pathInfo)) {
				unmarkHairStyle(request, response);
				response.sendRedirect(basePath
						+ "admin/hairstyle/hairstyle_mark.jsp");
			}
			if ("/uploadVersion".equals(pathInfo)) {
				uploadVersion(request, response);
				response.sendRedirect(basePath
						+ "admin/version/version_list.jsp");
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (MyException e) {
			request.setAttribute("note", e.getNote());
			request.getRequestDispatcher("/admin/error.jsp").forward(request,
					response);
		} finally {
			out.flush();
			out.close();
		}
	}

	private void uploadVersion(HttpServletRequest request,
			HttpServletResponse response) {
		final Version version = new Version();
		Status status = new Status() {

			@Override
			public void saveDatabase(String path)
					throws ClassNotFoundException, SQLException {
				VersionDAO dao = new VersionDAO();
				version.setPath(path);
				dao.add(version);
			}

			@Override
			public void readData(DiskFileItem item) throws Exception {
				String temp = item.getFieldName();
				if ("version".equals(temp)) {
					String sex = new String(item.getString("UTF-8"));
					version.setVersion(sex);
				}
			}
		};
		String diskPath = this.getServletConfig().getServletContext()
				.getRealPath("");
		diskPath = diskPath.substring(0, diskPath.lastIndexOf("/") + 1);
		String spa = File.separator;
		String path = "upload" + spa + "version" + spa;
		// String diskPath =
		// this.getServletConfig().getServletContext().getRealPath("");
		// String spa = File.separator;
		// String path = "/upload" + spa + "version" + spa;
		FileManager manager = new FileManager(status, diskPath);
		manager.read(request, path);
	}

	private void modifyUserFace(HttpServletRequest request,
			HttpServletResponse response) {
		final int users_id = ((Users) request.getSession().getAttribute("USER"))
				.getUsers_id();
		final Users users = new Users();
		Status status = new Status() {

			@Override
			public void saveDatabase(String path)
					throws ClassNotFoundException, SQLException {
				users.setUsers_face(path);
				UsersDAO dao = new UsersDAO();
				dao.modifyFace(users);
			}

			@Override
			public void readData(DiskFileItem item) throws Exception {
				String temp = item.getFieldName();
				if ("users_id".equals(temp)) {
					String users_id = new String(item.getString("UTF-8"));
					users.setUsers_id(Integer.parseInt(users_id));
				}
			}
		};
		String diskPath = this.getServletConfig().getServletContext()
				.getRealPath("");
		diskPath = diskPath.substring(0, diskPath.lastIndexOf("/") + 1);
		String spa = File.separator;
		String path = "upload" + spa + "users" + spa + users_id + spa;
		FileManager manager = new FileManager(status, diskPath);
		// String diskPath =
		// this.getServletConfig().getServletContext().getRealPath("");
		// String spa = File.separator;
		// String path = "/upload" + spa + "users" + spa + users_id + spa;
		// FileManager manager = new FileManager(status, diskPath);
		manager.read(request, path);
	}

	private void unmarkHairStyle(HttpServletRequest request,
			HttpServletResponse response) throws NumberFormatException,
			ClassNotFoundException, SQLException {
		String hid = request.getParameter("hid");
		MarkHairStyleDAO dao = new MarkHairStyleDAO();
		dao.deleteByHId(Integer.parseInt(hid));
	}

	private void deleteHairStyle(HttpServletRequest request,
			HttpServletResponse response) throws NumberFormatException,
			ClassNotFoundException, SQLException {
		final int users_id = ((Users) request.getSession().getAttribute("USER"))
				.getUsers_id();
		String hairStyle_id = request.getParameter("id");
		MarkHairStyleDAO dao = new MarkHairStyleDAO();
		HairStyleDAO hairStyleDAO = new HairStyleDAO();
		HairStyle hairStyle = hairStyleDAO.getById(Integer
				.parseInt(hairStyle_id));
		if (hairStyle == null)
			return;
		if (hairStyle.getUsers_id() == users_id) {
			hairStyleDAO.delete(hairStyle);
			String diskPath = this.getServletConfig().getServletContext()
					.getRealPath("");
			diskPath = diskPath.substring(0, diskPath.lastIndexOf("/") + 1);
			File file = new File(diskPath + hairStyle.getHairStyle_path());
			// String diskPath =
			// this.getServletConfig().getServletContext().getRealPath("");
			// File file = new File(diskPath + hairStyle.getHairStyle_path());
			file.delete();
			dao.deleteByHId(hairStyle.getHairStyle_id());
		} else {
			System.out.println("没有权限删除发型");
		}
	}

	private void modifyHairStyle(HttpServletRequest request,
			HttpServletResponse response) {

	}

	private void markHairStyle(HttpServletRequest request,
			HttpServletResponse response) throws ClassNotFoundException,
			SQLException {
		final int users_id = ((Users) request.getSession().getAttribute("USER"))
				.getUsers_id();
		final int userGroup_id = ((Users) request.getSession().getAttribute(
				"USER")).getUserGroup_id();
		int hid = Integer.parseInt(request.getParameter("hid"));
		if (userGroup_id == 4) {
			MarkHairStyle markHairStyle = new MarkHairStyle();
			markHairStyle.setHairStyle_id(hid);
			markHairStyle.setUsers_id(users_id);
			MarkHairStyleDAO markHairStyleDAO = new MarkHairStyleDAO();
			markHairStyleDAO.add(markHairStyle);
		}
	}

	private void uploadHairStyle(HttpServletRequest request,
			HttpServletResponse response) {
		final int users_id = ((Users) request.getSession().getAttribute("USER"))
				.getUsers_id();
		final HairStyle hairStyle = new HairStyle();
		Status status = new Status() {

			@Override
			public void saveDatabase(String path)
					throws ClassNotFoundException, SQLException {
				HairStyleDAO dao = new HairStyleDAO();
				hairStyle.setHairStyle_path(path);
				hairStyle.setUsers_id(users_id);
				dao.add(hairStyle);
			}

			@Override
			public void readData(DiskFileItem item) throws Exception {
				String temp = item.getFieldName();
				if ("sex".equals(temp)) {
					String sex = new String(item.getString("UTF-8"));
					hairStyle.setHairStyle_sex(sex);
				}
				if ("area".equals(temp)) {
					String area = new String(item.getString("UTF-8"));
					hairStyle.setHairStyle_area(area);
				}
				if ("desc".equals(temp)) {
					String desc = new String(item.getString("UTF-8"));
					hairStyle.setHairStyle_desc(desc);
				}
				if ("height".equals(temp)) {
					String height = new String(item.getString("UTF-8"));
					hairStyle.setHairStyle_height(height);
				}
			}
		};
		String diskPath = this.getServletConfig().getServletContext()
				.getRealPath("");
		diskPath = diskPath.substring(0, diskPath.lastIndexOf("/") + 1);
		String spa = File.separator;
		System.out.println(diskPath);
		String path = "upload" + spa + "hairstyle" + spa + users_id + spa;
		// String diskPath =
		// this.getServletConfig().getServletContext().getRealPath("");
		// String spa = File.separator;
		// System.out.println(diskPath);
		// String path = "/upload" + spa + "hairstyle" + spa + users_id + spa;
		FileManager manager = new FileManager(status, diskPath);
		manager.read(request, path);
	}

	/**
	 * @param request
	 * @param response
	 * @throws NumberFormatException
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 */
	private void deleteVideo(HttpServletRequest request,
			HttpServletResponse response) throws NumberFormatException,
			ClassNotFoundException, SQLException {
		String id = request.getParameter("id");
		AdVideoDAO dao = new AdVideoDAO();
		String diskPath = this.getServletConfig().getServletContext()
				.getRealPath("");
		diskPath = diskPath.substring(0, diskPath.lastIndexOf("/") + 1);
		AdVideo adVideo = dao.getById(Integer.parseInt(id));
		// String diskPath =
		// this.getServletConfig().getServletContext().getRealPath("");
		// AdVideo adVideo = dao.getById(Integer.parseInt(id));
		File file = new File(diskPath + adVideo.getAdVideo_path());
		if (file.isFile()) {
			file.delete();
		}
		dao.deleteById(Integer.parseInt(id));
	}

	/**
	 * @param request
	 * @param response
	 */
	private void saveVideo(HttpServletRequest request,
			HttpServletResponse response) {
		final int users_id = ((Users) request.getSession().getAttribute("USER"))
				.getUsers_id();
		final AdVideo adVideo = new AdVideo();
		Status status = new Status() {

			@Override
			public void saveDatabase(String path)
					throws ClassNotFoundException, SQLException {
				adVideo.setAdVideo_path(path);
				adVideo.setUsers_id(users_id);
				adVideo.setAdVideo_count(0);
				AdVideoDAO adVideoDAO = new AdVideoDAO();
				adVideoDAO.add(adVideo);
			}

			@Override
			public void readData(DiskFileItem item)
					throws UnsupportedEncodingException {
				String temp = item.getFieldName();
				if ("adVideo_desc".equals(temp)) {
					String adVideo_desc = new String(item.getString("UTF-8"));
					adVideo.setAdVideo_desc(adVideo_desc);
				}
				if ("adVideo_type".equals(temp)) {
					String adVideo_type = new String(item.getString("UTF-8"));
					adVideo.setAdVideo_type(Integer.parseInt(adVideo_type));
				}
			}
		};
		String diskPath = this.getServletConfig().getServletContext()
				.getRealPath("");
		diskPath = diskPath.substring(0, diskPath.lastIndexOf("/") + 1);
		String spa = File.separator;
		String path = "upload" + spa + "ad" + spa + "video" + spa + users_id
				+ spa;
		// String diskPath =
		// this.getServletConfig().getServletContext().getRealPath("");
		// String spa = File.separator;
		// String path = "/upload" + spa + "ad" + spa + "video" + spa + users_id
		// + spa;
		FileManager manager = new FileManager(status, diskPath);
		manager.read(request, path);
	}

	/**
	 * @param request
	 * @param response
	 * @throws NumberFormatException
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 */
	private void deletePicture(HttpServletRequest request,
			HttpServletResponse response) throws NumberFormatException,
			ClassNotFoundException, SQLException {
		String id = request.getParameter("id");
		AdPictureDAO adPictureDAO = new AdPictureDAO();
		adPictureDAO.deleteById(Integer.parseInt(id));
	}

	String show = "1";

	/**
	 * 老的上传图片的方式 新的处理上传使用的 FileManager
	 * 
	 * @param request
	 * @param response
	 */
	@SuppressWarnings("rawtypes")
	private void savePicture(HttpServletRequest request,
			HttpServletResponse response) {
		int users_id = ((Users) request.getSession().getAttribute("USER"))
				.getUsers_id();
		String adPicture_desc = "";
		String adPictureGroup_id = "";
		String saveRelativPath = "upload" + File.separator + "ad"
				+ File.separator + "picture" + File.separator + users_id
				+ File.separator;
		String diskPath = this.getServletConfig().getServletContext()
				.getRealPath("");
		// diskPath = diskPath.substring(0, diskPath.lastIndexOf("/") + 1);
		// String saveRelativPath = "/upload" + File.separator + "ad" +
		// File.separator + "picture" + File.separator
		// + users_id + File.separator;
		// String diskPath =
		// this.getServletConfig().getServletContext().getRealPath("");
		String saveDiskPath = diskPath + saveRelativPath; // 图片保存的目录
		String firstFileName = "";
		String fileRealPath = "";// 文件存放真实地址
		String saveFileName = UUIDUtils.getUUID();
		File file = new File(saveDiskPath);
		if (!file.isDirectory()) {
			file.mkdirs();
		}
		try {
			DiskFileItemFactory fac = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(fac);
			upload.setHeaderEncoding("UTF-8");
			// 获取多个上传文件，也就是多个input的值
			List fileList = upload.parseRequest(request);
			// 遍历上传文件
			Iterator it = fileList.iterator();
			while (it.hasNext()) {
				Object obit = it.next();
				if (obit instanceof DiskFileItem) {
					DiskFileItem item = (DiskFileItem) obit;
					String temp = item.getFieldName();
					if ("adPicture_desc".equals(temp)) {
						adPicture_desc = new String(item.getString("UTF-8"));
					}
					if ("adPictureGroup_id".equals(temp)) {
						adPictureGroup_id = new String(item.getString("UTF-8"));
						show = adPictureGroup_id;
					}
					// 下面为保存图片的代码
					String fileName = item.getName();
					if (fileName != null) {
						firstFileName = item.getName().substring(
								item.getName().lastIndexOf(File.separator) + 1);
						String formatName = firstFileName
								.substring(firstFileName.lastIndexOf("."));// 获取文件后缀名
						fileRealPath = saveDiskPath + saveFileName + formatName;// 文件存放真实地址
						BufferedInputStream in = new BufferedInputStream(
								item.getInputStream());// 获得文件输入流
						BufferedOutputStream outStream = new BufferedOutputStream(
								new FileOutputStream(new File(fileRealPath)));
						// 开始把文件写到你指定的上传文件夹
						Streams.copy(in, outStream, true);
						// 上传成功，则插入数据库
						if (new File(fileRealPath).exists()) {
							String path = FileManager.saveToBCE(new File(
									fileRealPath));
							// String path =
							// fileRealPath.substring(fileRealPath.indexOf("upload")).replace("\\",
							// "/");
							AdPicture picture = new AdPicture();
							picture.setAdPicture_desc(adPicture_desc);
							picture.setAdPicture_path(path);
							picture.setAdPictureGroup_id(Integer
									.parseInt(adPictureGroup_id));
							picture.setUsers_id(users_id);
							AdPictureDAO dao = new AdPictureDAO();
							dao.add(picture);
						}
					}
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			System.out.println("Error: 没有上传文件");
			return;
		}

	}

	/**
	 * @param request
	 * @param response
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 * @throws MyException
	 */
	private void modifyUser(HttpServletRequest request,
			HttpServletResponse response) throws ClassNotFoundException,
			SQLException, MyException {
		String users_name = request.getParameter("users_name");
		String users_email = request.getParameter("users_email");
		String users_password = request.getParameter("users_password");
		String users_IMEI = request.getParameter("users_IMEI");
		String userGroup_id = request.getParameter("userGroup_id");
		String users_id = request.getParameter("users_id");
		Users users = new Users(users_name, users_email, users_password,
				users_IMEI, Integer.parseInt(userGroup_id));
		users.setUsers_id(Integer.parseInt(users_id));

		if (PermitManager.deleteUserPermit(own, users)) {
			UsersDAO dao = new UsersDAO();
			dao.modify(users);
		} else {
			throw new MyException("权限不足");
		}

	}

	/**
	 * @param request
	 * @param response
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 * @throws MyException
	 */
	private void deleteUser(HttpServletRequest request,
			HttpServletResponse response) throws ClassNotFoundException,
			SQLException, MyException {
		String users_id = request.getParameter("uid");
		UsersDAO dao = new UsersDAO();
		Users obj = new Users();
		obj.setUsers_id(Integer.parseInt(users_id));
		// save user
		if (PermitManager.deleteUserPermit(own, obj)) {
			dao.delete(obj);
			deleteUserAboutRelation(obj.getUsers_id());
		} else {
			throw new MyException("权限不足");
		}
	}

	public void deleteUserAboutRelation(int id) throws ClassNotFoundException,
			SQLException {
		UserRelationDAO relationDAO = new UserRelationDAO();
		relationDAO.deleteByUID(id);
		relationDAO.deleteByUID2(id);
	}

	public void deleteUserAboutPicture(int id) throws ClassNotFoundException,
			SQLException {
		AdPictureDAO adPictureDAO = new AdPictureDAO();
		adPictureDAO.deleteByUID(id);
	}

	public void deleteUserAboutVideo(int id) throws ClassNotFoundException,
			SQLException {
		AdVideoDAO adVideoDAO = new AdVideoDAO();
		adVideoDAO.deleteByUID(id);
	}

	/**
	 * @param request
	 * @param response
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 * @throws MyException
	 */
	public void addUser2(HttpServletRequest request,
			HttpServletResponse response) throws ClassNotFoundException,
			SQLException, MyException {
		final int users_id = ((Users) request.getSession().getAttribute("USER"))
				.getUsers_id();
		final Users users = new Users();
		Status status = new Status() {

			@Override
			public void saveDatabase(String path)
					throws ClassNotFoundException, SQLException {
				users.setUsers_face(path);
				UsersDAO dao = new UsersDAO();
				dao.add(users);
				Users u = dao.findUser(users.getUsers_email(),
						users.getUsers_password());
				UserRelationDAO relationDAO = new UserRelationDAO();
				UserRelation relation = new UserRelation();
				relation.setUsers_id(users_id);
				relation.setUsers_id2(u.getUsers_id());
				relationDAO.add(relation);
			}

			@Override
			public void readData(DiskFileItem item) throws Exception {
				String temp = item.getFieldName();
				if ("users_name".equals(temp)) {
					String users_name = new String(item.getString("UTF-8"));
					users.setUsers_name(users_name);
				}
				if ("users_email".equals(temp)) {
					String users_email = new String(item.getString("UTF-8"));
					users.setUsers_email(users_email);
				}
				if ("users_IMEI".equals(temp)) {
					String users_IMEI = new String(item.getString("UTF-8"));
					users.setUsers_IMEI(users_IMEI);
				}
				if ("users_password".equals(temp)) {
					String users_password = new String(item.getString("UTF-8"));
					users.setUsers_password(users_password);
				}
				if ("userGroup_id".equals(temp)) {
					String userGroup_id = new String(item.getString("UTF-8"));
					users.setUserGroup_id(Integer.parseInt(userGroup_id));
				}
			}
		};

		String diskPath = this.getServletConfig().getServletContext()
				.getRealPath("");
		diskPath = diskPath.substring(0, diskPath.lastIndexOf("/") + 1);
		String spa = File.separator;
		String path = "upload" + spa + "users" + spa + users_id + spa;
		// String diskPath =
		// this.getServletConfig().getServletContext().getRealPath("");
		// String spa = File.separator;
		// String path = "/upload" + spa + "users" + spa + users_id + spa;
		FileManager manager = new FileManager(status, diskPath);
		manager.read(request, path);
	}

	private void addUser2_2(HttpServletRequest request,
			HttpServletResponse response) throws ClassNotFoundException,
			SQLException, MyException {
		final int users_id = ((Users) request.getSession().getAttribute("USER"))
				.getUsers_id();

		String users_name = request.getParameter("users_name");
		String users_email = request.getParameter("users_email");
		String users_password = request.getParameter("users_password");
		String users_IMEI = request.getParameter("users_IMEI");
		if (users_IMEI == null) {
			users_IMEI = "null";
		}
		String userGroup_id = request.getParameter("userGroup_id");
		Users users = new Users(users_name, users_email, users_password,
				users_IMEI, Integer.parseInt(userGroup_id));
		users.setUsers_face("null");
		// save user
		if (PermitManager.addUserPermit(own, users)) {
			UsersDAO dao = new UsersDAO();
			if (dao.findEmail(users_email))
				throw new MyException("Email 已经存在");
			dao.add(users);

			Users u = dao.findUser(users.getUsers_email(),
					users.getUsers_password());
			UserRelationDAO relationDAO = new UserRelationDAO();
			UserRelation relation = new UserRelation();
			relation.setUsers_id(users_id);
			relation.setUsers_id2(u.getUsers_id());
			relationDAO.add(relation);

		} else {
			throw new MyException("权限不足");
		}
	}

	/**
	 * @param request
	 * @param response
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 * @throws MyException
	 */
	private void addUser1(HttpServletRequest request,
			HttpServletResponse response) throws ClassNotFoundException,
			SQLException, MyException {
		String users_name = request.getParameter("users_name");
		String users_email = request.getParameter("users_email");
		String users_password = request.getParameter("users_password");
		String users_IMEI = request.getParameter("users_IMEI");
		if (users_IMEI == null) {
			users_IMEI = "null";
		}
		String userGroup_id = request.getParameter("userGroup_id");
		Users users = new Users(users_name, users_email, users_password,
				users_IMEI, Integer.parseInt(userGroup_id));
		users.setUsers_face("null");
		// save user
		if (PermitManager.addUserPermit(own, users)) {
			UsersDAO dao = new UsersDAO();
			if (dao.findEmail(users_email))
				throw new MyException("Email 已经存在");
			dao.add(users);
		} else {
			throw new MyException("权限不足");
		}
	}

	/**
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	private void logout(HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		HttpSession session = request.getSession();
		session.removeAttribute("USER");
		response.sendRedirect(basePath + "login.jsp");
	}

	/**
	 * @param request
	 * @param response
	 * @throws IOException
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 */
	private void login(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ClassNotFoundException, SQLException {
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		UsersDAO dao = new UsersDAO();
		Users users = dao.findUser(email, password);
		HttpSession session = request.getSession();
		session.setAttribute("USER", users);
		response.sendRedirect(basePath + "admin/index.jsp");
	}

	/**
	 * @param request
	 */
	private void getBasePath(HttpServletRequest request) {
		basePath = request.getScheme() + "://" + request.getServerName() + ":"
				+ request.getServerPort() + request.getContextPath() + "/";
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
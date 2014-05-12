package com.aishang.manager;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.disk.DiskFileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.util.Streams;

import com.baidu.inf.iis.bcs.BaiduBCS;
import com.baidu.inf.iis.bcs.auth.BCSCredentials;
import com.baidu.inf.iis.bcs.model.ObjectMetadata;
import com.baidu.inf.iis.bcs.request.PutObjectRequest;
import com.baidu.inf.iis.bcs.response.BaiduBCSResponse;
import com.common.utils.UUIDUtils;

@SuppressWarnings("rawtypes")
public class FileManager {

	private Status status;
	private String diskPath;

	public FileManager(Status status, String diskPath) {
		this.status = status;
		this.diskPath = diskPath;
	}

	public Status getStatus() {
		return status;
	}

	public void setStatus(Status status) {
		this.status = status;
	}

	public String getDiskPath() {
		return diskPath;
	}

	public void setDiskPath(String diskPath) {
		this.diskPath = diskPath;
	}

	public void read(HttpServletRequest request, String relativePath) {
		String saveDiskPath = diskPath + relativePath; // 图片保存的目录
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
					status.readData(item);
					// 下面为保存图片的代码
					String fileName = item.getName();
					if (fileName != null) {
						firstFileName = item.getName().substring(item.getName().lastIndexOf(File.separator) + 1);
						String formatName = firstFileName.substring(firstFileName.lastIndexOf("."));// 获取文件后缀名
						fileRealPath = saveDiskPath + saveFileName + formatName;// 文件存放真实地址
						BufferedInputStream in = new BufferedInputStream(item.getInputStream());// 获得文件输入流
						BufferedOutputStream outStream = new BufferedOutputStream(new FileOutputStream(new File(
								fileRealPath)));
						// 开始把文件写到你指定的上传文件夹
						Streams.copy(in, outStream, true);
						// 上传成功，则插入数据库
						if (new File(fileRealPath).exists()) {
//							String str = saveToBCE(new File(fileRealPath));
//							status.saveDatabase(str);
							fileRealPath = fileRealPath.substring(fileRealPath.indexOf("upload")).replace("\\", "/");
							status.saveDatabase(fileRealPath);
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

	// ============================
	// 以下为百度云存储
	// ============================

	static String host = "bcs.duapp.com";
	static String accessKey = "3rYVogqZ1L85TDkkvPY267LG";
	static String secretKey = "1ZmSK58dXrmX6gGD94b6MykWshOQvKwG";
	static String bucket = "aishangupload";

	public static String saveToBCE(File file) throws IOException {
		String path = file.getAbsolutePath();
		String contentType = Files.probeContentType(Paths.get(path));
		String fileName = path.substring(path.indexOf("upload") + 6);
		System.out.println(fileName);

		BCSCredentials credentials = new BCSCredentials(accessKey, secretKey);
		BaiduBCS baiduBCS = new BaiduBCS(credentials, host);
		PutObjectRequest request = new PutObjectRequest(bucket, fileName, file);
		ObjectMetadata metadata = new ObjectMetadata();
		metadata.setContentType(contentType);
		request.setMetadata(metadata);
		BaiduBCSResponse<ObjectMetadata> response = baiduBCS.putObject(request);
		System.out.println("response id : " + response.getRequestId());
		return fileName;
	}

	public interface Status {

		void saveDatabase(String path) throws ClassNotFoundException, SQLException;

		void readData(DiskFileItem item) throws Exception;

	}
}

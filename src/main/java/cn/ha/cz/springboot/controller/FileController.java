package cn.ha.cz.springboot.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import cn.ha.cz.springboot.bean.EnumFileType;
import cn.ha.cz.springboot.bean.FileAuth;
import cn.ha.cz.springboot.bean.FileBean;
import cn.ha.cz.springboot.bean.UserBean;
import cn.ha.cz.springboot.dao.IFileAuthDao;
import cn.ha.cz.springboot.dao.IFileDao;
import cn.ha.cz.springboot.dao.IUserDao;
import cn.ha.cz.springboot.service.IFileService;
import cn.ha.cz.springboot.service.IUserService;
import cn.ha.cz.springboot.util.FileUtils;

@Controller
@RequestMapping("/file")
public class FileController {

	Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	IFileService fileService;

	@Autowired
	IFileDao fileDao;
	
	@Autowired
	IUserDao userDao;
	
	@Autowired
	IUserService userService;
	
	@Autowired
	IFileAuthDao fileAuthDao;
	
	@Value("${file.staticAccessPath}")
	private String staticAccessPath;
	@Value("${file.uploadFolder}")
	private String uploadFolder;
	
	@ModelAttribute
	public void init(HttpSession session, Model model) {
		model.addAttribute("typeEnums", EnumFileType.values());
	}

	@RequestMapping("uploadlist")
	public String uploadlist(HttpSession session, Model model) {
		UserBean user = (UserBean) session.getAttribute("user");
		logger.info("get session user: {}", user);

		// upload只能看自己上传
		model.addAttribute("filelist", fileService.queryFileList(user));
		model.addAttribute("from", "upload");
		
		model.addAttribute("count", fileDao.count(user.getId()));
		
		if((Boolean)session.getAttribute("isMobile")) {
			logger.info("==========return: filelist_mobile.jsp==========");
			return "filelist_mobile";
		}else {
			return "filelist";
		}
	}

	@RequestMapping("downloadlist")
	public String downloadlist(HttpSession session, Model model) {
		UserBean user = (UserBean) session.getAttribute("user");
		logger.info("get session user: {}", user);
		// download所有文件
		//model.addAttribute("filelist", fileService.queryFileList(null));
		
		//download 分配的权限
		FileAuth param = new FileAuth();
		param.setAuthUserId(user.getId());
		List<FileBean> filelist = fileService.queryAuthFileList(param);
		model.addAttribute("filelist", filelist);
		
		model.addAttribute("count", filelist.size());

		model.addAttribute("from", "download");
		if(session.getAttribute("isMobile")!=null && (Boolean)session.getAttribute("isMobile")) {
			logger.info("==========return: filelist_mobile.jsp==========");
			return "filelist_mobile";
		}else {
			return "filelist";
		}
	}

	/**
	 * 文件查询接口
	 * @param filename
	 * @param filetype
	 * @param from
	 * @param folderId （未使用，目前带folderId调用viewFolder接口）
	 * @param session
	 * @param model
	 * @return
	 */
	@RequestMapping("search")
	public String search(@RequestParam String filename, @RequestParam(value="filetype", required=false) Integer filetype, 
			@RequestParam String from,  @RequestParam(value="folderId", required=false) Integer folderId,
			HttpSession session, Model model, RedirectAttributes attr) {
		logger.info("search params :{},{}", filename, filetype);
		//判断是否是在文件夹中查询
		if(folderId!=null && folderId>0){
			attr.addAttribute("filename", filename);
			attr.addAttribute("filetype", filetype);
			attr.addAttribute("from", from);
			attr.addAttribute("folderId", folderId);
			
			logger.info("===>redirect:/folder/viewFolder, params:{}", attr.asMap());
			return "redirect:/folder/viewFolder";
		}
		
		UserBean user = (UserBean) session.getAttribute("user");
		logger.info("get session user: {}", user);

		List<FileBean> filelist = null;
		if ("upload".equals(from)) {
			
			filelist = fileService.searchFileList(user, filename, filetype, folderId);
			model.addAttribute("filelist", filelist);
		} else {
			//查询所有文件
			//model.addAttribute("filelist", fileService.searchFileList(null, filename, filetype));
			
			//查询可查看文件
			FileAuth param = new FileAuth();
			param.setAuthUserId(user.getId());
			param.setFilename(filename);
			param.setFiletype(filetype==null?-1:filetype);
			filelist = fileService.queryAuthFileList(param);
			model.addAttribute("filelist", filelist);
		}
		
		model.addAttribute("count", filelist!=null?filelist.size():0);

		model.addAttribute("filename", filename);
		model.addAttribute("filetype", filetype);
		model.addAttribute("from", from);

		if(session.getAttribute("isMobile")!=null && (Boolean)session.getAttribute("isMobile")) {
			logger.info("==========filelist_mobile==========");
			return "filelist_mobile";
		}else {
			return "filelist";
		}
	}
	
	/**给文档授权用户查看权限*/
	@RequestMapping("toAuthUser")
	public String toAuthUser(@RequestParam int fileId, Model model) {
		model.addAttribute("file", fileDao.queryById(fileId));
		
		List<UserBean> userlist = userService.queryAuthUserList(fileId);
		model.addAttribute("userlist", userlist);
		logger.info("===>result: {}", userlist);
		return "userauth";
	}
	
	@RequestMapping("authUser")
	@ResponseBody
	public int authUser(@RequestParam Integer[] userIds, @RequestParam int fileId,HttpSession session, Model model) {
		logger.info("===>authUser: {},{}", fileId, userIds);
		int flag = 1;
		if(userIds ==null || userIds.length==0) {
			flag = 2;
		}else {
			UserBean sessionUser = (UserBean) session.getAttribute("user");
			FileAuth params = new FileAuth();
			params.setAuthFileId(fileId);
			fileAuthDao.deleteFileAuth(params);
			
			List<FileAuth> list = new ArrayList<>();
			for(int authUserId: userIds) {
				FileAuth auth = new FileAuth();
				auth.setUserId(sessionUser.getId());
				auth.setAuthFileId(fileId);
				auth.setAuthUserId(authUserId);
				list.add(auth);
			}
			fileAuthDao.insertFileAuth(list);
			flag =1;
		}
		
		return flag;
	}

	@RequestMapping("upload")
	@ResponseBody
	public String upload(@RequestParam("file") MultipartFile file, @RequestParam(value="folderId",required=false) Integer folderId, HttpServletRequest request, HttpSession session) {
		if (!file.isEmpty()) {
			UserBean user = (UserBean) session.getAttribute("user");

			String saveFileName = file.getOriginalFilename();
		    String systemName = request.getHeader("user-agent");
		    logger.info("===>upload: {},{}", systemName, saveFileName);
		    
			String fullPath = uploadFolder + saveFileName;
			logger.info("===>{}", fullPath);
			
			File saveFile = new File(fullPath);
			String filesize= FileUtils.getFileSize(file.getSize());

			String suffix = saveFileName.substring(saveFileName.lastIndexOf(".") + 1);

			if (!saveFile.getParentFile().exists()) {
				saveFile.getParentFile().mkdirs();
			}
			try {

				BufferedOutputStream out = new BufferedOutputStream(new FileOutputStream(saveFile));
				out.write(file.getBytes());
				out.flush();
				out.close();
				logger.info("文件大小：{}KB, 本地存储：{}", saveFile.length() / 1024, saveFile.getAbsoluteFile());

				FileBean fileBean = new FileBean();
				fileBean.setRemark(saveFileName.substring(0, saveFileName.lastIndexOf(".")));
				fileBean.setFilename(saveFileName);
				fileBean.setFilepath(staticAccessPath + saveFileName);
				fileBean.setFullpath(fullPath);
				fileBean.setUploadtime(new Date());
				fileBean.setFlag(1);
				fileBean.setFilesize(filesize);
				if(folderId!=null){
					fileBean.setParentid(folderId);//父文件夹ID
				}
				fileBean.setUserId(user.getId());//上传者ID

				fileBean.setFiletype(EnumFileType.getBySuffix(suffix));
				logger.info("===>插入文件表：{}", fileBean);
				
				//当前文件夹为空代表在根目录上传，
				if(folderId==null || folderId==0){
					fileService.uploadFile(fileBean, user);
				}else{
					//如果在文件夹中上传，则不分配用户权限，只分配文件夹权限就够了，在新建文件夹的时候
					fileDao.insertFile(fileBean);
				}
				

				logger.info("===>上传成功: {}", fileBean);
				return "1";
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return "2";
	}

	@RequestMapping("download")
	public void download(@RequestParam int fileId, HttpServletRequest request, HttpServletResponse response) {
		logger.info("===>下载文件：{}", fileId);
		FileBean fileBean = fileDao.queryById(fileId);
		BufferedInputStream bis = null;
		BufferedOutputStream bos = null;

		if (fileBean != null) {
			try {
				request.setCharacterEncoding("UTF-8");

				File downloadFile = new File(fileBean.getFullpath());
				// 获取文件的长度
				long fileLength = downloadFile.length();
				// 设置文件输出类型
				response.setContentType("application/octet-stream");
				response.setHeader("Content-disposition",
						"attachment; filename=" + new String(fileBean.getFilename().getBytes("utf-8"), "ISO8859-1"));
				// 设置输出长度
				response.setHeader("Content-Length", String.valueOf(fileLength));
				
				/**
				 * org.apache.catalina.connector.ClientAbortException: 
				 * java.io.IOException: 您的主机中的软件中止了一个已建立的连接。
				 */
				response.setHeader("Access-Control-Allow-Origin", "*");
				response.setHeader("Access-Control-Allow-Methods", "POST");
				response.setHeader("Access-Control-Allow-Headers", "x-requested-with,content-type");

				// 获取输入流
				bis = new BufferedInputStream(new FileInputStream(downloadFile));
				// 输出流
				bos = new BufferedOutputStream(response.getOutputStream());
				byte[] buff = new byte[20480];
				int bytesRead;
				while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
					bos.write(buff, 0, bytesRead);
				}
				// 关闭流
				bis.close();
				bos.close();
				logger.info("===>下载成功");
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	@RequestMapping("delete")
	@ResponseBody
	public int delete(@RequestParam int fileId, HttpServletRequest request) {
		logger.info("===>method delete fileId:{}", fileId);
		FileBean f = fileDao.queryById(fileId);
		
		//如果是文件夹，判断是否存在子目录
		if(f!=null && f.getFiletype() == EnumFileType.FOLFER){
			List<FileBean> list = fileDao.searchFileListByFolder(fileId);
			if(list!=null && list.size()>0){
				//删除失败
				return 2;
			}
		}
		
		String newFilepath = staticAccessPath + "deleted/";
		String newFullpath = uploadFolder + "deleted/" + f.getFilename();

		FileBean updateFile = new FileBean();
		updateFile.setId(f.getId());
		updateFile.setFilepath(newFilepath+f.getFilename());
		updateFile.setFullpath(newFullpath);
		updateFile.setFlag(2);

		fileDao.updateFile(updateFile);
		moveFile(f.getFullpath(), newFullpath);
		
		//跳回当前页面
		return 1;
	}

	private void moveFile(String fullPath, String newFullPath) {
		try {
			File startFile = new File(fullPath);
			File tmpFile = new File(newFullPath);// 获取文件夹路径
			if (!tmpFile.getParentFile().exists()) {// 判断文件夹是否创建，没有创建则创建新文件夹
				tmpFile.getParentFile().mkdirs();
			}
			if (startFile.renameTo(new File(newFullPath))) {
				logger.info("文件移动成功！文件名：《{}》 目标路径：{}", startFile.getName(), newFullPath);
			} else {
				logger.warn("文件移动失败！文件名：《{}》 起始路径：{}", startFile.getName(), fullPath);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}

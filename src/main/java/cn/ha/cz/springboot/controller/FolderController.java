package cn.ha.cz.springboot.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.log;

import java.util.Date;

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

import cn.ha.cz.springboot.bean.EnumFileType;
import cn.ha.cz.springboot.bean.FileBean;
import cn.ha.cz.springboot.bean.UserBean;
import cn.ha.cz.springboot.dao.IFileDao;
import cn.ha.cz.springboot.service.IFileService;

@Controller
@RequestMapping("/folder")
public class FolderController {
	Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	IFileService fileService;
	
	@Autowired
	IFileDao fileDao;
	
	@Value("${file.staticAccessPath}")
	private String staticAccessPath;
	@Value("${file.uploadFolder}")
	private String uploadFolder;
	
	@ModelAttribute
	public void init(HttpSession session, Model model) {
		model.addAttribute("typeEnums", EnumFileType.values());
	}
	
	/** 跳转至文件夹 */
	private String toFolderPage(HttpSession session) {
		if((Boolean)session.getAttribute("isMobile")) {
			logger.info("==========return: folder_filelist_mobile.jsp==========");
			return "folder_filelist_mobile";
		}else {
			logger.info("==========return: folder_filelist.jsp==========");
			return "folder_filelist";
		}
	}
	
	@RequestMapping("getFolder")
	@ResponseBody
	public FileBean getFolder(Integer folderId, HttpSession session, Model model) {
		logger.info(">>>getFolder folderId: {}", folderId);
		
		FileBean folder = fileDao.queryById(folderId);
		model.addAttribute("renameFolder", folder);
		return folder;
	}
	@RequestMapping("renameFolder")
	@ResponseBody
	public void renameFolder(Integer folderId, String folderName, HttpSession session, Model model) {
		logger.info(">>>renameFolder folderId: {}, folderName:{}", folderId,folderName);
		FileBean folder = fileDao.queryById(folderId);
		
		if(folder!=null && folder.getFiletype()==EnumFileType.FOLFER){
			FileBean file = new FileBean();
			file.setId(folderId);
			file.setRemark(folderName);
			fileDao.updateName(file);
		}else{
			logger.info("文件不支持重命名");
		}
		
	}
	
	@RequestMapping("createFolder")
	public String createFolder(String folderName, Integer hiddenFolderId, HttpSession session, Model model) {
		logger.info(">>>createFolder folder: {}, hiddenFolderId:{}", folderName,hiddenFolderId);
		
		UserBean user = (UserBean) session.getAttribute("user");
		logger.info("get session：{}", user);
		
		FileBean folder = new FileBean();
		folder.setRemark(folderName);
		folder.setFilename(folderName);
		folder.setFilepath(staticAccessPath + folderName);
		folder.setFullpath(uploadFolder+folderName);
		folder.setUploadtime(new Date());
		folder.setFlag(1);

		folder.setFiletype(EnumFileType.FOLFER);
		
		if(hiddenFolderId!=null){
			folder.setParentid(hiddenFolderId);	
		}
		folder.setUserId(user.getId());
		
		logger.info("===>fileService#uploadFile：{}", folder);
		if(hiddenFolderId==null){
			fileService.uploadFile(folder, user);	
		}else{
			fileDao.insertFile(folder);
		}
		
		
		if((Boolean)session.getAttribute("isMobile")) {
			return "filelist_mobile";
		}else {
			return "filelist";
		}
	}
	
	/**
	 * 查看文件夹，并且支持查询
	 * @param folderId
	 * @param from
	 * @param filename
	 * @param filetype
	 * @param session
	 * @param model
	 * @return
	 */
	@RequestMapping("viewFolder")
	public String viewFolder(Integer folderId, String from, String filename, Integer filetype,
			HttpSession session, Model model) {
		logger.info(">>>viewFolder folderId: {}", folderId);
		
		UserBean user = (UserBean) session.getAttribute("user");
		logger.info("get session：{}", user);
		
		if(folderId!=null){
			FileBean folder = fileDao.queryById(folderId);
			model.addAttribute("folder", folder);//当前文件夹
			model.addAttribute("parentid", folder.getParentid());//父文件夹
			
			FileBean params = new FileBean();
			params.setParentid(folderId);
			params.setFilename(filename);
			if(filetype!=null){
				params.setFiletype(EnumFileType.getById(filetype));	
			}
			model.addAttribute("filelist", fileDao.searchFileListByFolder(params));
			
			//model.addAttribute("filelist", fileDao.searchFileListByFolder(folderId));
			
			//查询条件
			model.addAttribute("filename", filename);
			model.addAttribute("filetype", filetype);
			model.addAttribute("from", from);
		}
		
		model.addAttribute("from", from);
		
		return toFolderPage(session);
	}
}

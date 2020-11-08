package com.minibean.timewizard.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.WebUtils;

import com.minibean.timewizard.model.biz.UploadFileBiz;
import com.minibean.timewizard.model.biz.UserInfoBiz;
import com.minibean.timewizard.model.dto.UploadFileDto;
import com.minibean.timewizard.model.dto.UserInfoDto;

@Controller
public class MypageController {
	
	private Logger logger = LoggerFactory.getLogger(MypageController.class);
	
	@Autowired
	private UserInfoBiz userinfoBiz;
	
	@Autowired
	private UploadFileBiz uploadfileBiz;
	
	@RequestMapping("/mypage")
	public String Mypage() {
		logger.info("[mypage]");
		return "mypage";
	}
	
	@RequestMapping("/userdeletepage")
	public String UserDeletePage(Model model, @RequestParam int user_no) {
		logger.info("[admin role change]");

		model.addAttribute("dto", userinfoBiz.selectOne(user_no));
		
		return "userdeletepage";
	}
	
	@RequestMapping("/userdeleteres")
	public String UserDelete(UserInfoDto dto, HttpSession session, @RequestParam int user_no) {
		logger.info("[user delete Reusult]");
		
		
		UserInfoDto user = (UserInfoDto) session.getAttribute("login");
		String user_pw = user.getUser_pw();
		String new_pw = dto.getUser_pw();
		
		//비밀번호 불일치로 탈퇴 실패
		if(!(user_pw.equals(new_pw))) {
			return "redirect:mypage";
		} else {
		
			int res = userinfoBiz.delete(user_no);
			
			if(res != 0) {
				System.out.println("탈퇴 성공");
			} else {
				System.out.println("탈퇴 실패");
			}
			
			session.invalidate();
			return "redirect:main";
		}
	}
	
	@RequestMapping("/form")
	public String uploadForm() {
		return "upload";
	}
	
	@RequestMapping("/upload")
	public String fileUpload(HttpServletRequest request, Model model, UploadFileDto dto, BindingResult result, UserInfoDto user_no){
		
		uploadfileBiz.validate(dto, result);
		
		if (result.hasErrors()) {
			return "mypage";
		}
		
		MultipartFile file = dto.getProfile();
		String file_title = file.getOriginalFilename();
		
		UploadFileDto fileObj = new UploadFileDto();
		fileObj.setFile_title(file_title);
		
		// upload
		InputStream inputStream = null;
		// download
		OutputStream outputStream = null;
		
		try {
			inputStream = file.getInputStream();
			String path = WebUtils.getRealPath(request.getSession().getServletContext(), "/resources/storage");
			
			System.out.println("업로드 될 실제 경로 : " + path);
			
			File storage = new File(path);
			if (!storage.exists()) {
				storage.mkdir();
			}
			
			File newFile = new File(path + "/" + file_title);
			if (!newFile.exists()) {
				newFile.createNewFile();
			}
			
			outputStream = new FileOutputStream(newFile);
			
			int read = 0;
			byte[] b = new byte[(int)file.getSize()];
			
			while((read=inputStream.read(b)) != -1) {
				outputStream.write(b, 0, read);
			}
			
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				inputStream.close();
				outputStream.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		model.addAttribute("fileObj", fileObj);
		
		logger.info("profile user_no :"+user_no);
		
		return "redirect:mypage?user_no";
	}

}

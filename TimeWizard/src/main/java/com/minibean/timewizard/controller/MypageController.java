package com.minibean.timewizard.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.WebUtils;

import com.minibean.timewizard.model.biz.PayBiz;
import com.minibean.timewizard.model.biz.UploadFileBiz;
import com.minibean.timewizard.model.biz.UserInfoBiz;
import com.minibean.timewizard.model.dto.PayDto;
import com.minibean.timewizard.model.dto.UploadFileDto;
import com.minibean.timewizard.model.dto.UserInfoDto;

@Controller
public class MypageController {
	
	private Logger logger = LoggerFactory.getLogger(MypageController.class);
	
	@Autowired
	private UserInfoBiz userinfoBiz;
	
	@Autowired
	private UploadFileBiz uploadfileBiz;
	

	@Autowired
	private PayBiz payBiz;
	
	@RequestMapping("/mypage")
	public String Mypage(HttpSession session, Model model) {
		logger.info("[mypage]");
		
		UserInfoDto userinfodto = (UserInfoDto)session.getAttribute("login");

			PayDto dto = payBiz.selectOne(userinfodto.getUser_no());
			if(dto==null) {
				logger.info("mypagedd dto : "+dto);
				int res = payBiz.insertPay(new PayDto(userinfodto.getUser_no(),"N",0));
				if (res > 0){
					dto = payBiz.selectOne(userinfodto.getUser_no());
				}
				model.addAttribute("dto",dto);
				logger.info("mypage user_no : " + userinfodto.getUser_no());
				return "mypage";
					}
			return "mypage";
	}
	


	/* 유저 탈퇴 */
	@RequestMapping("/userdeletepage")
	public String UserDeletePage(Model model, @RequestParam int user_no) {
		logger.info("[user delete page]");

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
	
	/* 비밀번호 변경 */
	@RequestMapping("/userpwchange")
	public String UserPwChange(Model model, @RequestParam int user_no) {
		logger.info("[user password change]");

		model.addAttribute("dto", userinfoBiz.selectOne(user_no));
		
		return "userpwchange";
		
	}
	
	@RequestMapping("/userpwchangeres")
	public String UserPwChangeRes(UserInfoDto dto, HttpSession session, @RequestParam int user_no) {
		logger.info("[user pw change Reusult]");
		
		UserInfoDto user = (UserInfoDto) session.getAttribute("login");
		String user_pw = user.getUser_pw();
		String new_pw = dto.getUser_pw();
	
		int res = userinfoBiz.update(dto);
		  
		if(res != 0) {
			System.out.println("암호 변경 성공");
		} else {
			System.out.println("암호 변경 실패");
		}
		 
		return "redirect:mypage?user_no="+dto.getUser_pw();
		
	}
	
	/* 프로필 사진 업로드 */
	@RequestMapping(value="/form")
	public String uploadForm() {
		return "mypage";
	}
	
	@RequestMapping(value="/upload")
	public String fileUpload(HttpServletRequest request, Model model, UploadFileDto dto, BindingResult result) {
		
		uploadfileBiz.validate(dto, result);
		
		if (result.hasErrors()) {
			return "mypage";
		}
		
		MultipartFile file = dto.getProfile();
		String file_title = file.getOriginalFilename();
		
		UploadFileDto fileObj = new UploadFileDto();
		fileObj.setFile_title(file_title);
		fileObj.setUser_no(dto.getUser_no());
		
		// upload
		InputStream inputStream = null;
		// download
		OutputStream outputStream = null;
		
		try {
			inputStream = file.getInputStream();
			String path = WebUtils.getRealPath(request.getSession().getServletContext(), "/resources/profileview");
			
			System.out.println("업로드 될 실제 경로 : " + path);
			
			File profileview = new File(path);
			if (!profileview.exists()) {
				profileview.mkdir();
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
		
		return "mypage";
	}
	
	//pay
	@RequestMapping("/pay")
	public String pay(int user_no, String price, String pay_name) {
		logger.info("[pay controller]");
		
		PayDto dto = payBiz.selectOne(user_no);
		
		//멤버쉽결제
		if(pay_name.equals("membership")) {
			logger.info("pay_name01010101 : "+pay_name);
			int res = payBiz.updateMembership(new PayDto(user_no,"Y",0));
			logger.info("res : "+res);
			logger.info("price : "+price);
			logger.info("pay_name : "+pay_name);
			if(res > 0) {
				return "redirect:mypage";
			}else {
				return "mypage";
			}
			
		}else {  //timelapse결제
			logger.info("pay_name020202 : "+pay_name);
			if(price.equals("1000")) {
				logger.info("price01 : "+price);
				int res = payBiz.updateTimelapse(new PayDto(user_no, null, dto.getTimelapse()+1));
				logger.info("res : "+res);
				if(res > 0) {
					return "redirect:mypage";
				}
			}else if(price.equals("5000")) {
				logger.info("price02 : "+price);
				int res = payBiz.updateTimelapse(new PayDto(user_no, null, dto.getTimelapse()+5));
				if(res > 0) {
					return "redirect:mypage";
				}

			}else {
				logger.info("price03 : "+price);
				int res = payBiz.updateTimelapse(new PayDto(user_no, null, dto.getTimelapse()+10));
				if(res > 0) {
					return "redirect:mypage";
				}
			}
			
			return "";
		}
	
		
	}

}

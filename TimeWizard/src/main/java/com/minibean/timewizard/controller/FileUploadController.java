package com.minibean.timewizard.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.WebUtils;

import com.minibean.timewizard.model.biz.FileUploadBiz;
import com.minibean.timewizard.model.dto.FileUploadDto;
import com.minibean.timewizard.model.dto.UserInfoDto;
import com.minibean.timewizard.utils.file.FileUploadUtils;
import com.minibean.timewizard.utils.file.FileValidator;

@RestController
@RequestMapping(value="/file")
public class FileUploadController {
	
	@Autowired
	private FileValidator fileValidator;
	@Autowired
	private FileUploadUtils fileUploadUtils;
	@Autowired
	private FileUploadBiz fileUploadBiz;
	
	private String uploadPath;
	private Logger logger = LoggerFactory.getLogger(FileUploadController.class);

	@PostMapping(value="/list/{user_no}")
	public List<FileUploadDto> download(HttpSession session, @PathVariable int user_no) {
		List<FileUploadDto> list = fileUploadBiz.selectList(user_no);
		return list;
	}

	@PostMapping(value="/upload")
	public Map<String, Boolean> fileUpload(HttpServletRequest request, FileUploadDto uploadFile, BindingResult result) {
		
		Map<String, Boolean> answer = new HashMap<String, Boolean>();
		
		fileValidator.validate(uploadFile, result);
		if (result.hasErrors()) {
			answer.put("result",false);
			return answer;
		}
		
		MultipartFile file = uploadFile.getFile();
		String fileExtension = FilenameUtils.getExtension(file.getOriginalFilename());
		String uploadedName = fileUploadUtils.makeRandomName() + "." + fileExtension;
		
		FileUploadDto fileObj = new FileUploadDto();
		fileObj.setFile_name(uploadedName);
		
		InputStream inputStream = null;
		OutputStream outputStream = null;
		
		try {
			
			inputStream = file.getInputStream();
			uploadPath = WebUtils.getRealPath(request.getSession().getServletContext(), "/resources/image");
			// TODO : change path
			logger.info("\n* uploaded file path : " + uploadPath 
					+ "\n* file original name : " + file.getOriginalFilename());
			
			File storage = new File(uploadPath);
			if (!storage.exists()) {
				storage.mkdir();
			}
			File newFile = new File(uploadPath + "/" + uploadedName);
			if (!newFile.exists()) {
				newFile.createNewFile();
			}
			outputStream = new FileOutputStream(newFile);
			
			int read = 0;
			byte[] b = new byte[(int)file.getSize()];
			
			while((read=inputStream.read(b)) != -1) {
				outputStream.write(b, 0, read);
			}
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
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
		answer.put("result",true);
		
		FileUploadDto dto = new FileUploadDto();
		dto.setUser_no(((UserInfoDto)request.getSession().getAttribute("login")).getUser_no());
		dto.setFile_name(uploadedName);
		if (fileExtension.equalsIgnoreCase("jpg") || fileExtension.equalsIgnoreCase("jpeg") 
			|| fileExtension.equalsIgnoreCase("png") || fileExtension.equalsIgnoreCase("gif")) {
			dto.setFile_type("P");
			dto.setFile_size((int)file.getSize());
		} else if (fileExtension.equalsIgnoreCase("mp4")) {
			dto.setFile_type("V");
		} else {
			dto.setFile_type("T"); // 빼야함!
		}
		
		int res = fileUploadBiz.insert(dto);
		logger.info(">> [CONTROLLER-FILEUPLOAD] success?: " + ((res == 1)?"yes":"no"));
		
		return answer;
	} 
	
	@RequestMapping(value="/download/{file_no}")
	public byte[] fileDownload(HttpServletRequest request, HttpServletResponse response, @PathVariable int file_no) {
		
		FileUploadDto dto = fileUploadBiz.selectOne(file_no);
		
		byte[] down = null;
		
		try {
			uploadPath = WebUtils.getRealPath(request.getSession().getServletContext(), "/resources/image");
			// TODO: change upload path
			// upload 경로와 동일한 실제 경로 부여
			File file = new File(uploadPath + "/" + dto.getFile_name());
			
			down = FileCopyUtils.copyToByteArray(file);
			// FileCopyUtils : 파일과 stream 복사에 사용되는 간단한 유틸리티 메서드
			// copyToByteArray(file) : 주어진 입력 파일의 컨텐트를 새로운 바이트 배열로 복사
			String filename = new String(file.getName().getBytes(), "8859_1");
			
			response.setHeader("Content-Disposition", "attachment; filename=\""+filename +"\"");
			// HTTP 응답에서 컨텐츠가 브라우저에서
			// 1. inline (기본값, 웹페이지 내부 또는 웹페이지로 표시될 수 있음)
			// 2. attachment (다운로드해야 함)
			// 알려주는 헤더
			response.setContentLength(down.length);
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return down;
		
	}
	
}

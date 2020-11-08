package com.minibean.timewizard.model.biz;

import org.springframework.stereotype.Service;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.minibean.timewizard.model.dto.UploadFileDto;

@Service
public class UploadFileBiz implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return false;
	}
	
	@Override
	public void validate(Object target, Errors errors) {
		UploadFileDto file = (UploadFileDto) target;
		
		if(file.getProfile().getSize() == 0) {
			errors.rejectValue("profile", "fileNPE", "Please select a file");
		}
	}
}

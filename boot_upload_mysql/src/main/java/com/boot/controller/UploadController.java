package com.boot.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.boot.dto.BoardAttachDTO;
import com.boot.dto.BoardDTO;
import com.boot.dto.CommentDTO;
import com.boot.service.CommentService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class UploadController {
//	@Autowired
//	private CommentService service;

	@RequestMapping("/uploadAjaxAction")
	public ResponseEntity<List<BoardAttachDTO>> uploadAjaxPost(MultipartFile[] uploadFile) {
		log.info("@# uploadAjaxPost");

		List<BoardAttachDTO> list = new ArrayList<BoardAttachDTO>();
//		String uploadFolder ="C:\\Users\\user\\Desktop\\springboot\\study_springboot";
		String uploadFolder = "C:\\develop\\upload";

//		날짜별 폴더처리
		String uploadFolderPath = getFolder();
		File uploadPath = new File(uploadFolder, uploadFolderPath);
		log.info("@#uploadPath=>" + uploadPath);
		
		if(uploadPath.exists() == false){
			// make yyyy/MM/dd folder
			uploadPath.mkdirs();
		}
		return null;
	}

//	날짜별 폴더 생성
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		log.info("@# str => " + str);

		return str;
	}
}

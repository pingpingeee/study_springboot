package com.boot.controller;

import com.boot.dto.BoardDTO;
import com.boot.dto.CriteriaDTO;
import com.boot.dto.PageDTO;
import com.boot.service.PageService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.ArrayList;

@Controller
@Slf4j
//@RequestMapping("/comment")
public class PageController {
	@Autowired
	private PageService service;

	@RequestMapping("/list")
	public String list(CriteriaDTO criteriaDTO, Model model) {
		log.info("@# list()");
		log.info("@# criteriaDTO => " + criteriaDTO);

		ArrayList<BoardDTO> list = service.listWithPaging(criteriaDTO);
		int total = service.getTotalCount(criteriaDTO);

		model.addAttribute("list", list);
		model.addAttribute("pageMaker", new PageDTO(total, criteriaDTO));

		return "list";
	}
	
}








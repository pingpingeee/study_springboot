package com.boot.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.boot.dto.MemDTO;
import com.boot.service.MemService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MemController {
	@Autowired
	private MemService service;

//	로그인 화면 이동
	@RequestMapping("/login")
	public String login(Model model) {
		log.info("@# login()");

		return "login";
	}

//	로그인화면->로그인 여부 판단
	@RequestMapping("/login_yn")
	public String loginYn(HttpServletRequest request, @RequestParam HashMap<String, String> param) {
		log.info("@# loginYn()");

//		MemDAO dao=sqlSession.getMapper(MemDAO.class);

		ArrayList<MemDTO> dtos = service.loginYn(param);

		if (dtos.isEmpty()) {
			return "redirect:login";
		} else {
			if (request.getParameter("mem_pwd").equals(dtos.get(0).getMem_pwd())) {
				return "redirect:login_ok";
			}
			return "redirect:login";
		}
	}

//	로그인 성공시 이동
	@RequestMapping("/login_ok")
	public String login_ok() {
		log.info("@# login_ok()");

		return "login_ok";
	}

	@RequestMapping("/register")
	public String register() {
		log.info("@# register()");

		return "register";
	}

	@RequestMapping("/registerOk")
	public String registerOk(HttpServletRequest request, @RequestParam HashMap<String, String> param) {
		log.info("@# registerOk()");

//		MemDAO dao = sqlSession.getMapper(MemDAO.class);
		service.write(param);

		return "redirect:login";
	}

}

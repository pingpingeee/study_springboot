package com.boot.controller;

import com.mylib.paging.dto.CriteriaDTO;
import com.mylib.paging.dto.PageDTO;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.boot.dto.BoardDTO;
import com.boot.service.BoardService;
import com.mylib.paging.component.PagingComponent;

@Controller
public class BoardController {
    
    @Autowired
    private BoardService boardService;
    
    @Autowired
    private PagingComponent pagingComponent; // 라이브러리의 컴포넌트 주입
    
    @GetMapping("/list")
    public String list(
            @RequestParam(defaultValue = "1") int pageNum, 
            @RequestParam(defaultValue = "10") int amount,
            Model model) {
        
        // 라이브러리의 DTO 사용
        CriteriaDTO criteria = new CriteriaDTO(pageNum, amount);
        
        // list(criteria) 대신 listWithPaging(criteria) 사용
        List<BoardDTO> boardList = boardService.listWithPaging(criteria);
        int total = boardService.getTotalCount();
        
        // 라이브러리의 페이징 컴포넌트 사용
        pagingComponent.setupPaging(model, criteria, total);
        model.addAttribute("boardList", boardList);
        
        return "board/list";
    }
}

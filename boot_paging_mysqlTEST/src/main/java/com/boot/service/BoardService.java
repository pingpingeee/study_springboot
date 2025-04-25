package com.boot.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.boot.dto.BoardDTO;
import com.mylib.paging.service.PagingService;

// BoardService를 인터페이스로 변경하고 PagingService를 상속
public interface BoardService extends PagingService<BoardDTO> {
    // 기존 메서드 선언
    public ArrayList<BoardDTO> list();
    public void write(BoardDTO boardDTO);
    public BoardDTO contentView(HashMap<String, String> param);
    public void modify(HashMap<String, String> param);
    public void delete(HashMap<String, String> param);
}
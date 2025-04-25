package com.boot.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

//import com.boot.dao.BoardAttachDAO;
import com.boot.dao.BoardDAO;
import com.boot.dto.BoardDTO;
import com.mylib.paging.dto.CriteriaDTO;
import com.mylib.paging.service.PagingServiceImpl;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("BoardService")
public class BoardServiceImpl extends PagingServiceImpl<BoardDTO, BoardDAO> implements BoardService {
    @Autowired
    private SqlSession sqlSession;
    
    // 기존 메서드 구현 유지
    @Override
    public ArrayList<BoardDTO> list() {
        BoardDAO dao = sqlSession.getMapper(BoardDAO.class);
        ArrayList<BoardDTO> list = dao.list();
        return list;
    }

    @Override
    public void write(BoardDTO boardDTO) {
        log.info("@# BoardServiceImpl boardDTO=>" + boardDTO);
        
        BoardDAO dao = sqlSession.getMapper(BoardDAO.class);
//        BoardAttachDAO adao = sqlSession.getMapper(BoardAttachDAO.class);
        
        dao.write(boardDTO);
        
//        // 첨부파일 있는지 체크
//        log.info("@# getAttachList=>" + boardDTO.getAttachList());
//        if (boardDTO.getAttachList() == null || boardDTO.getAttachList().size() == 0) {
//            log.info("@# null");
//            return;
//        }
        
        // 첨부파일이 있는 경우 처리
//        boardDTO.getAttachList().forEach(attach -> {
//            attach.setBoardNo(boardDTO.getBoardNo());
//            adao.insertFile(attach);
//        });
    }
    
    @Override
    public BoardDTO contentView(HashMap<String, String> param) {
        BoardDAO dao = sqlSession.getMapper(BoardDAO.class);
        BoardDTO dto = dao.contentView(param);
        
        return dto;
    }

    @Override
    public void modify(HashMap<String, String> param) {
        BoardDAO dao = sqlSession.getMapper(BoardDAO.class);
        dao.modify(param);
    }

    @Override
    public void delete(HashMap<String, String> param) {
        BoardDAO dao = sqlSession.getMapper(BoardDAO.class);
//        BoardAttachDAO attachDao = sqlSession.getMapper(BoardAttachDAO.class);
        
        dao.delete(param);
//        attachDao.deleteFile(param.get("boardNo"));
    }
    
    // PagingService 인터페이스의 메서드 구현
    // 이미 PagingServiceImpl에서 기본 구현을 제공하지만, 
    // SqlSession을 사용하는 현재 구조에 맞게 오버라이드
    
    @Override
    public List<BoardDTO> listWithPaging(CriteriaDTO criteriaDTO) {
        BoardDAO dao = sqlSession.getMapper(BoardDAO.class);
        return dao.listWithPaging(criteriaDTO);
    }
    
    @Override
    public int getTotalCount() {
        BoardDAO dao = sqlSession.getMapper(BoardDAO.class);
        return dao.getTotalCount();
    }
    
    @Override
    public List<BoardDTO> searchWithPaging(CriteriaDTO criteriaDTO, String searchType, String keyword) {
        BoardDAO dao = sqlSession.getMapper(BoardDAO.class);
        return dao.searchWithPaging(criteriaDTO, searchType, keyword);
    }
    
    @Override
    public int getSearchTotalCount(String searchType, String keyword) {
        BoardDAO dao = sqlSession.getMapper(BoardDAO.class);
        return dao.getSearchTotalCount(searchType, keyword);
    }
}
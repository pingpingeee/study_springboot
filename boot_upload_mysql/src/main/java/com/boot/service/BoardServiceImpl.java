package com.boot.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.boot.dto.BoardAttachDTO;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boot.dao.BoardDAO;
import com.boot.dto.BoardDTO;

@Service("BoardService")
@Slf4j
public class BoardServiceImpl implements BoardService {
    @Autowired
    private SqlSession sqlSession;

    @Override
    public ArrayList<BoardDTO> list() {
        BoardDAO dao = sqlSession.getMapper(BoardDAO.class);
        ArrayList<BoardDTO> list = dao.list();
        return list;
    }

    @Override
    public void write(BoardDTO boardDTO) {
        log.info("@# BoardSerivceImpl boardDTO => " + boardDTO);
        BoardDAO dao = sqlSession.getMapper(BoardDAO.class);
        BoardAttachDAO adao = sqlSession.getMapper(BoardAttachDAO.class);

        dao.write(boardDTO);

        log.info("@# getAttachList => " + boardDTO.getAttachList());
        if (boardDTO.getAttachList() == null || boardDTO.getAttachList().size() == 0) {
            log.info("@# null");
            return;
        }

//        첨부파일이 있는 경우 처리
        boardDTO.getAttachList().forEach(attach -> {
            attach.setBoardNo(boardDTO.getBoardNo());
            adao.inserFile(attach);
        });
    }

    @Override
    public BoardDTO contentView(HashMap<String, String> param) {
        BoardDAO dao = sqlSession.getMapper(BoardDAO.class);
        return dao.contentView(param);
    }

    @Override
    public void modify(HashMap<String, String> param) {
        BoardDAO dao = sqlSession.getMapper(BoardDAO.class);
        dao.modify(param);

    }

    @Override
    public void delete(HashMap<String, String> param) {
        BoardDAO dao = sqlSession.getMapper(BoardDAO.class);
        dao.delete(param);
    }
}
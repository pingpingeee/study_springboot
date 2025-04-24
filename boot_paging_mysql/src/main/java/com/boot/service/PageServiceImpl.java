package com.boot.service;

import com.boot.dao.CommentDAO;
import com.boot.dao.PageDAO;
import com.boot.dto.BoardDTO;
import com.boot.dto.CommentDTO;
import com.boot.dto.CriteriaDTO;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;

@Slf4j
@Service("PageService")
public class PageServiceImpl implements PageService {
    @Autowired
    private SqlSession sqlSession;

    @Override
    public ArrayList<BoardDTO> listWithPaging(CriteriaDTO criteriaDTO) {
        log.info("@# PageServiceImpl listWithPaging");
        log.info("@# cri => " + criteriaDTO);

        PageDAO dao = sqlSession.getMapper(PageDAO.class);
        ArrayList<BoardDTO> list = dao.listWithPaging(criteriaDTO);

        return list;
    }
}

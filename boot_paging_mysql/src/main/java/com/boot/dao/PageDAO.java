package com.boot.dao;

import com.boot.dto.BoardDTO;
import com.boot.dto.CriteriaDTO;

import java.util.ArrayList;
import java.util.HashMap;

public interface PageDAO {
//    Criteria 객체를 이용해서 페이징처리
    public ArrayList<BoardDTO> listWithPaging(CriteriaDTO criteriaDTO);
}

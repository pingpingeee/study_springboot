package com.boot.service;

import com.boot.dto.BoardDTO;
import com.boot.dto.CriteriaDTO;

import java.util.ArrayList;

public interface PageService {
    public ArrayList<BoardDTO> listWithPaging(CriteriaDTO criteriaDTO);
}

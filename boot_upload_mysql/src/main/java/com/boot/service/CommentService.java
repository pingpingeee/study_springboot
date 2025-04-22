package com.boot.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.boot.dto.BoardDTO;
import com.boot.dto.CommentDTO;

public interface CommentService {
	public void save(HashMap<String, String> param);
	public ArrayList<CommentDTO> findall(HashMap<String, String> param);
}
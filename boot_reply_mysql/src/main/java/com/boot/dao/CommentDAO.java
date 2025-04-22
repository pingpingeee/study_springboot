package com.boot.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.boot.dto.CommentDTO;

public interface CommentDAO {

	public void save(HashMap<String, String> param);
	public ArrayList<CommentDTO> findall(HashMap<String, String> param);
}

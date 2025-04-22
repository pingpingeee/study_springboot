package com.boot.dto;

import java.sql.Timestamp;

import com.boot.controller.CommentController;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CommentDTO {
	private int commentNo;
	private String commentWriter;
	private String commentContent;
	private int boardNo;
	private Timestamp commentCreatedTime;
}

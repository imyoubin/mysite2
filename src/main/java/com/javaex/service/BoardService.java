package com.javaex.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaex.repository.BoardRepository;
import com.javaex.vo.BoardVO;

@Service
public class BoardService {

	//필드
	@Autowired
	private BoardRepository boardRepository;
	
	//메소드일반
	//--게시판 전체리스트
	public List<BoardVO> exeList() {
		System.out.println("BoardService.exeList()");
	
		List<BoardVO> boardList =boardRepository.boardSelectList();
	
		return boardList;
	}
	
	
	
}

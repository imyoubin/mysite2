package com.javaex.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.BoardVO;

@Repository
public class BoardRepository {

	//필드
	@Autowired
	private SqlSession sqlSession;
	
	//메소드일반
	//--전체리스트 가져오기(게시판리스트)
	public List<BoardVO> boardSelectList() {
		System.out.println("BoardRepository.boardSelectList()");
		
		List<BoardVO> boardList = sqlSession.selectList("board.selectList");
		
		return boardList;
	}
	
	
	//--전체리스트 가져오기2(페이징)
	public List<BoardVO> boardSelectList2(Map<String, Integer> limitMap) {
		System.out.println("BoardRepository.boardSelectList2()");
		
		List<BoardVO> boardList =sqlSession.selectList("board.selectList2", limitMap);
		
		return boardList;
	}
	
	
	//--전체리스트 가져오기3(페이징+검색)
	public List<BoardVO> boardSelectList3(Map<String, Object> limitMap) {
		System.out.println("BoardRepository.boardSelectList3()");
		
		List<BoardVO> boardList =sqlSession.selectList("board.selectList3", limitMap);
		
		return boardList;
	}
	
	
	//--전체글갯수(페이징)
	public int selectTotalCount() {
		System.out.println("BoardRepository.selectTotalCount()");
		
		int totalCount = sqlSession.selectOne("board.selectTotalCount");
		
		return totalCount;
	}
	
	//--전체글갯수(페이징+검색)
	public int selectTotalCountByKwd(String kwd) {
		System.out.println("BoardRepository.selectTotalCountByKwd()");
		
		int totalCount = sqlSession.selectOne("board.selectTotalCountByKwd", kwd);
		
		return totalCount;
	}
	
	
}
















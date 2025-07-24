package com.javaex.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.GuestbookVO;

@Repository
public class GuestbookRepository {

	// 필드
	@Autowired
	private SqlSession sqlSession;
	
	
	// 전체데이터 가져오기
	public List<GuestbookVO> guestbookSelect() {
		System.out.println("GuestbookRepository.guestbookSelect()");
		
		List<GuestbookVO> guestbookList = sqlSession.selectList("guestbook.selectList");
		
		return guestbookList;
	}
	

	// 저장하기
	public int guestbookInsert(GuestbookVO guestbookVO) {
		System.out.println("GuestbookRepository.guestbookInsert()");
		
		int count = sqlSession.insert("guestbook.insert", guestbookVO);
		
		return count;
	}

	
	// 삭제하기
	public int guestbookDelete(GuestbookVO guestbookVO) {
		System.out.println("GuestbookRepository.guestbookDelete()");
		
		int count = sqlSession.delete("guestbook.delete", guestbookVO);
		
		return count;
	}

	
	//저장하고 키가져오기(ajax)
	public int guestbookInsertKey(GuestbookVO guestbookVO) {
		System.out.println("GuestbookRepository.guestbookInsertKey()");
			
		int count = sqlSession.insert("guestbook.insertkey", guestbookVO);
		
		return guestbookVO.getNo();
	} 
	
	
	//글1개 가져오기
	public GuestbookVO guestbookSelectOne(int no) {
		System.out.println("GuestbookRepository.guestbookSelectOne()");
		
		GuestbookVO guestbookVO = sqlSession.selectOne("guestbook.selectOne", no);
		
		return guestbookVO;

	}
	
}
package com.javaex.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	

	//--게시판 전체리스트2(페이징)
	public List<BoardVO> exeList2(int crtPage) {
		System.out.println("BoardService.exeList2()");
		
		////////////////////////////////////////////////////////
		///리스트 가져오기
		////////////////////////////////////////////////////////
		//한페이지의 출력갯수
		int listCnt = 10;
		
		//시작번호
		/*
		 1->(1,10),  2->(11,20), 3->(21,30)  사람
		 1->(0,10),  2->(10,10), 3->(20,10)  mysql
		 startRowNo = (crtPage-1)*listCnt
		 */
		int startRowNo = (crtPage-1)*listCnt;
		
		//두개의 데이터를 묶는다 -->Map사용
		Map<String, Integer> limitMap = new HashMap<String, Integer>();
		limitMap.put("startRowNo", startRowNo);
		limitMap.put("listCnt", listCnt);
		
		//레파이토리에 보낸다
		List<BoardVO> boardList = boardRepository.boardSelectList2(limitMap);
		
		////////////////////////////////////////////////////////
		///페이징버튼 (하단 버튼)
		////////////////////////////////////////////////////////
		
		//페이지당 버튼갯수
		int pageBtnCount = 5;
		
		//마지막 버튼 번호 endPageBtnNo
		/*
		 1  2  3  4  5  >
		 1->(1, 5)
		 2->(1, 5)
		 3->(1, 5)
		 4->(1, 5)
		 5->(1, 5)
		 6->(6, 10)
		 7->(6, 10)
		 ...
		 10->(6, 10)
		 11->(11, 15)	
		 
		 1->  올림(1/5)5  --> 0.2(1)*5  -->5
		 2->  올림(2/5)5  --> 0.4(1)*5  -->5
		 3->  올림(3/5)5  --> 0.6(1)*5  -->5
		 4->  올림(4/5)5  --> 0.8(1)*5  -->5
		 5->  올림(5/5)5  --> 1.0(1)*5  -->5
		 6->  올림(6/5)5  --> 1.2(2)*5  -->10
		 11-> 올림(11/5)5 --> 2.2(3)*5  -->15
		*/
		

		int endPageBtnNo = ((int)Math.ceil(crtPage/((double)pageBtnCount)))*pageBtnCount;
		                
		
		
		/*
		prev
		next

		startPageBtnNo
		*/

		
		
		return boardList;
	}
	
	
	
	
	
}

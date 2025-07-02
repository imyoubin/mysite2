package com.javaex.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.javaex.service.BoardService;
import com.javaex.vo.BoardVO;

@Controller
@RequestMapping(value="/board")
public class BoardController {

	//필드
	@Autowired
	private BoardService boardService;
	
	//메소드일반
	
	//--게시판 전체 리스트
	@RequestMapping(value="/list", method= {RequestMethod.GET, RequestMethod.POST})
	public String list(Model model) {
		System.out.println("BoardController.list()");
		
		List<BoardVO> boardList = boardService.exeList();
		System.out.println(boardList);
		
		model.addAttribute("boardList", boardList);
		
		return "board/list";
	}
	
	//--게시판 전체 리스트2(페이징)
	@RequestMapping(value="/list2", method= {RequestMethod.GET, RequestMethod.POST})
	public String list2(@RequestParam(value="crtpage", required = false, defaultValue = "1") int crtPage, 
						Model model ) {
		System.out.println("BoardController.list2()");
		
		Map<String, Object> pMap = boardService.exeList2(crtPage);
		
		model.addAttribute("pMap", pMap);
		System.out.println(pMap);
		
		
		return "board/list2";
	}
	
	//--게시판 전체 리스트3(페이징+검색)
	@RequestMapping(value="/list3", method= {RequestMethod.GET, RequestMethod.POST})
	public String list3(@RequestParam(value="crtpage", required = false, defaultValue = "1") int crtPage, 
						@RequestParam(value="kwd", required = false, defaultValue = "") String kwd,
						Model model ) {
		System.out.println("BoardController.list3()");
		
		Map<String, Object> pMap = boardService.exeList3(crtPage, kwd);
		System.out.println("-------------------------------");
		System.out.println(pMap);
		System.out.println("-------------------------------");
		
		
		model.addAttribute("pMap", pMap);
		
		return "board/list3";
	}
	
	
	//--글쓰기폼
	
	
	//--글쓰기
	
	
	//--수정폼
	
	
	//--수정
	
	
	//--삭제
	
	
	
	
	
	
}

package com.javaex.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.javaex.service.GuestbookService;
import com.javaex.vo.GuestbookVO;

//데이타로 응답하는 애들
@Controller
public class GuestbookApiController {

	//필드
	@Autowired
	private GuestbookService guestbookService;
	
	//메소드
	//--전체리스트
	@ResponseBody
	@GetMapping("/api/guestbooks")
//	@GetMapping(value="/api/guestbooks")
//	@RequestMapping(value="/api/guestbooks", method= RequestMethod.GET)
	public List<GuestbookVO> list() {
		System.out.println("GuestbookApiController.list()");
		
		List<GuestbookVO> guestbookList = guestbookService.exeGetGuestbookList();
		System.out.println(guestbookList);
		
		return guestbookList;
	}
	
	//--방명록저장
	@ResponseBody
	@PostMapping(value="/api/guestbooks")
	//@RequestMapping(value="/api/guestbooks", method= RequestMethod.POST)
	public GuestbookVO add(@ModelAttribute GuestbookVO guestbookVO) {
		System.out.println("GuestbookApiController.add()");
		
		//guestbookVO(3) --> gVO(4, 출력용)
		GuestbookVO gVO= guestbookService.exeGuestbookAddKey(guestbookVO);
	
		return gVO;
		
	}
	
	//--방명록삭제
	@ResponseBody
	@DeleteMapping(value="/api/guestbooks/{no}")
	//@RequestMapping(value="/api/guestbooks/{no}", method= RequestMethod.DELETE)
	public int remove(@ModelAttribute GuestbookVO guestbookVO, 
					  @PathVariable(value="no") int no
			) {
		System.out.println("GuestbookApiController.remove()");
		//guestbookVO 는 패스워드 값만 있다
		System.out.println(guestbookVO);
		System.out.println("패스배리어블로 받은 값: " + no);
		
		//guestbookVO 에 no 값을 넣어준다
		guestbookVO.setNo(no);
		System.out.println(guestbookVO);
		
		
		int count = guestbookService.exeGuestbookRemove(guestbookVO);
		
		return count;
	}
	
	
	
	
	
	
	
	
	
	
	
}

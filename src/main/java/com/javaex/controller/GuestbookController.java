package com.javaex.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.javaex.service.GuestbookService;
import com.javaex.vo.GuestbookVO;

@Controller
@RequestMapping(value="/guestbook")
public class GuestbookController {

	//필드
	@Autowired
	private GuestbookService guestbookService;
	
	
	//생성자
	
	//메소드gs
	
	//메소드일반
	//-방명록 전체 리스트 가져오기
	@RequestMapping(value={"", "/", "/list"}, method= {RequestMethod.GET, RequestMethod.POST})
	public String list(Model model) {
		System.out.println("GuestbookController.list()");
		
		List<GuestbookVO> guestbookList = guestbookService.exeGetGuestbookList();
		
		model.addAttribute("gList", guestbookList);
		
		return "guestbook/addList";
		
	}
	
	
	//-방명록 글 저장
	@RequestMapping(value="/add", method= {RequestMethod.GET, RequestMethod.POST})
	public String add(@ModelAttribute GuestbookVO guestbookVO) {
		System.out.println("GuestbookController.add()");	
		
		guestbookService.exeGuestbookAdd(guestbookVO);
		
		return "redirect:/guestbook/list";
	}
	
	
	//삭제폼(삭제랑 헷갈리지 말자)  폼만 보여주면 됨
	@RequestMapping(value="/rform", method = {RequestMethod.GET, RequestMethod.POST})
	public String removeForm() {
		System.out.println("GuestbookController.removeForm()");
		
		return "guestbook/removeForm";
	}
	
	//삭제
	@RequestMapping(value="/remove", method= {RequestMethod.GET, RequestMethod.POST})
	public String remove(@ModelAttribute GuestbookVO guestbooVO) {
		System.out.println("GuestbookController.remove()");
		
		guestbookService.exeGuestbookRemove(guestbooVO);

		return "redirect:/guestbook/list";
	}
	
}
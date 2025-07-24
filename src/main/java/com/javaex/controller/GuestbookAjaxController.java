package com.javaex.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class GuestbookAjaxController {

	
	//ajax용 메인화면
	@RequestMapping(value="/ajaxguestbook", method= {RequestMethod.GET, RequestMethod.POST})
	public String ajaxindex() {
		System.out.println("GuestbookController.ajaxindex()");
		
		return "ajaxguestbook/index";
	}
	
}
package com.javaex.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import com.javaex.service.BoardService;
import com.javaex.service.GuestbookService;
import com.javaex.util.JsonResult;
import com.javaex.vo.GuestbookVO;

//데이타로 응답하는 애들
@RestController //@Controller + @ResponseBody
public class GuestbookApiController {

    private final BoardService boardService;

	//필드
	@Autowired
	private GuestbookService guestbookService;

    GuestbookApiController(BoardService boardService) {
        this.boardService = boardService;
    }
	
	//메소드
	//--전체리스트
	//@ResponseBody
	@GetMapping("/api/guestbooks")
//	@GetMapping(value="/api/guestbooks")
//	@RequestMapping(value="/api/guestbooks", method= RequestMethod.GET)
	public JsonResult list() {
		System.out.println("GuestbookApiController.list()");
		
		List<GuestbookVO> guestbookList = guestbookService.exeGetGuestbookList();
		System.out.println(guestbookList);
		
		if(guestbookList != null) {
			return JsonResult.success(guestbookList);
		}else {
			return JsonResult.fail("알수없는 오류");
		}
		
	}
	
	//--방명록저장
	//@ResponseBody
	@PostMapping(value="/api/guestbooks")
	//@RequestMapping(value="/api/guestbooks", method= RequestMethod.POST)
	public JsonResult add(@ModelAttribute GuestbookVO guestbookVO) {
		System.out.println("GuestbookApiController.add()");
		
		//guestbookVO(3) --> gVO(4, 출력용)
		GuestbookVO gVO= guestbookService.exeGuestbookAddKey(guestbookVO);
		
		if(gVO != null) {
			return JsonResult.success(gVO);
		
		}else {
			return JsonResult.fail("저장에 실패");
		}
		
	}
	
	//--방명록삭제
	//@ResponseBody
	@DeleteMapping(value="/api/guestbooks/{no}")
	//@RequestMapping(value="/api/guestbooks/{no}", method= RequestMethod.DELETE)
	public JsonResult remove(@ModelAttribute GuestbookVO guestbookVO, 
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
		
		if(count == 1) {
			return JsonResult.success(count);
		}else {
			return JsonResult.fail("패스워드 틀림");
		}
		
		
	}
	
}
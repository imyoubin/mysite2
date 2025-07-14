package com.javaex.repository;

import static org.assertj.core.api.Assertions.assertThat;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.javaex.vo.GuestbookVO;

@SpringBootTest
public class GuestbookRepositoryTest {

	@Autowired
	private GuestbookRepository guestbookRepository;
	
	@Test
	public void selectAll() {
		List<GuestbookVO> guestbookList = guestbookRepository.guestbookSelect();
		
		System.out.println("---------------------------");
		System.out.println(guestbookList);
		System.out.println("---------------------------");
		
		assertThat(guestbookList).isNotNull();
	}
	
	@Test
	public void delete() {
		GuestbookVO guestbookVO = new GuestbookVO();
		guestbookVO.setNo(42);
		guestbookVO.setPassword("123");
		System.out.println(guestbookVO);
		
		int count = guestbookRepository.guestbookDelete(guestbookVO);
		assertThat(count).isEqualTo(0);

	}
	
	
	@Test
	public void insert() {
		GuestbookVO guestbookVO = new GuestbookVO("정우성", "123", "다녀갑니다.");
		int count = guestbookRepository.guestbookInsert(guestbookVO);
		System.out.println(count);
		
		assertThat(count).isEqualTo(1);
	}
	
	
	
	
	
	
	
	
}

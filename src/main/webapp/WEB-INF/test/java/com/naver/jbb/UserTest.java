package com.naver.jbb;

import static org.junit.Assert.assertTrue;

import java.util.Calendar;
import java.util.Date;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.naver.jbb.dao.UserDao;
import com.naver.jbb.domain.UserDto;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})  // 테스트에 사용할 설정 파일 지정
public class UserTest {
	
		@Autowired
		UserDao userDao;
		
		@Test
		public void insertTest() throws Exception{
			
			//birth 뒤에 시,분,초 없애고, 날짜만 나오게!
			 Calendar cal = Calendar.getInstance();
			 cal.clear();
			 cal.set(2021, 1, 1);
			 
			UserDto userdto = new UserDto("asdf2", "1234", "aaa", "asdf@naver.com", "010-1234-1234",new Date(cal.getTimeInMillis()));
			assertTrue(userDao.insert(userdto)==1);
		}
		
		@Test
		public void selectTest() throws Exception{
			UserDto userdto = new UserDto("asdf3", "1234", "aaa", "asdf@naver.com", "010-1234-1234", new Date());
			int rowCnt = userDao.insert(userdto);
			UserDto userdto2 = userDao.select("asdf3");
			
			assertTrue(userdto.getId().equals("asdf3"));
		}
}



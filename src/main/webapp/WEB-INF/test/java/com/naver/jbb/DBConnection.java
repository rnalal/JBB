package com.naver.jbb;

import java.sql.Connection;

import javax.sql.DataSource;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;

public class DBConnection {
	public static void main(String[] args) throws Exception {
		
		// root-context.xml에 db연결 코드 주고, getBean으로 얻어오기
		ApplicationContext ac = new GenericXmlApplicationContext("file:src/main/webapp/WEB-INF/spring/**/root-context.xml");
		DataSource ds = ac.getBean(DataSource.class);
		
		Connection conn = ds.getConnection(); // 데이터베이스의 연결을 얻는다.
		
		System.out.println("conn = " + conn);
	}
}

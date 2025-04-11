package com.naver.jbb.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

public class AuthInterceptor implements HandlerInterceptor {
	
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession(false);

        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html; charset=utf-8");
        PrintWriter out = response.getWriter();
        
        String path = request.getRequestURI();

        if (session == null || session.getAttribute("id") == null) {
        	if (path.startsWith("/admin")) {
                out.println("<script>alert('관리자 로그인 후 이용해주세요');");
                out.println("location.href='" + request.getContextPath() + "/adminlogin';</script>");
            } else {
                out.println("<script>alert('로그인 후 이용해주세요');");
                out.println("location.href='" + request.getContextPath() + "/user/login';</script>");
            }
            out.close();
            return false;
        }

        return true;
    }
}

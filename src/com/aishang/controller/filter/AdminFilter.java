package com.aishang.controller.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.aishang.db.bean.Users;

public class AdminFilter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain filterChain) throws IOException,
			ServletException {
		HttpServletRequest httpServletRequest = (HttpServletRequest) request;
		HttpServletResponse httpServletResponse = (HttpServletResponse) response;
		HttpSession session = httpServletRequest.getSession();
		String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
				+ httpServletRequest.getContextPath() + "/";
		String pathInfo = httpServletRequest.getPathInfo();
		System.out.println(httpServletRequest.getRequestURI());
		if ("/login".equals(pathInfo)) {
			filterChain.doFilter(request, response);
			return;
		}
		Users user = (Users) session.getAttribute("USER");
		if (user != null) {
			filterChain.doFilter(request, response);
		} else {
			httpServletResponse.sendRedirect(basePath + "login.html");
		}

	}

	@Override
	public void destroy() {

	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {

	}

}
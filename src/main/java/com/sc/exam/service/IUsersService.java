package com.sc.exam.service;

import com.sc.exam.pojo.RegUser;
import com.sc.exam.vo.ViewMsg;

import javax.servlet.http.HttpSession;

public interface IUsersService {
    String regUser(RegUser regUser);
    ViewMsg userLogin(String account, String password, HttpSession session);

}

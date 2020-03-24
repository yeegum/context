package com.sc.exam.service;

import com.github.pagehelper.PageInfo;
import com.sc.exam.pojo.User;

public interface IUpdateService {
   String updateUser(User user);
   User show(String account);
   PageInfo<User> getList(int page, int limit);

}
